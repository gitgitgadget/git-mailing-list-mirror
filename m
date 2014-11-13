From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore
 submodules
Date: Thu, 13 Nov 2014 11:29:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de> <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
 <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com> <xmqq389qam25.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info> <xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 11:29:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoreN-0004Hc-Qq
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 11:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbaKMK3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 05:29:12 -0500
Received: from mout.gmx.net ([212.227.15.18]:56428 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932254AbaKMK3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 05:29:11 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0M3RVA-1Y6OSu2436-00qzR7;
 Thu, 13 Nov 2014 11:29:04 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:UNO6rKYqYzfYPx752ujXCWX7Sjo0wb8bA4H7NTZe59+UkdjNIXj
 pWcAz4X+ShicIFdr/CUfv3fod+l0tKU3kDN9NXPutBlvyCJR7w8VIUlM8YwgWKcyuuODqWr
 zV0VC62dEqyDSQZB8CEXPiis6xJU28cLqd/EzMjRjxsaQdVGDaxiziMKgJiIiScGH9zpgFI
 vbcvBEy+Ehtcen4zA6UNA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 12 Nov 2014, Junio C Hamano wrote:

> Instead of running "update-index --refresh; read-tree -m -u", using
> "reset --keep" may be a better implementation of what you are trying to
> do here.

I do not think that `reset --keep` is what I want. I really want to update
only if the working directory is clean. So I guess I will have to bite the
bullet and test the output of `update-index --refresh`, `diff-index
--quiet --cached HEAD --`.

In my case, the lacking test whether there are staged changes did not
matter, just because I pretty much never leave staged changes around.

What did matter, however, was to make sure that I did not update the
working directory carelessly. In one case, that `update-index --refresh`
test really helped me out because I was about to push  into a working
directory with uncommitted changes inside some web space. That push would
have broken the web application because of the local changes, so I was
really, really happy that I decided to be quite strict in the
implementation of `updateInstead`.

Due to that experience, the documentation also states pretty clearly that
`updateInstead` succeeds only in updating the current branch if the
working directory is clean.

Ciao,
Johannes
