From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] diff: don't read index when --no-index is given
Date: Mon, 09 Dec 2013 18:27:22 +0100
Message-ID: <52A5FD7A.9030801@web.de>
References: <1386590745-4412-1-git-send-email-t.gummerer@gmail.com> <20131209151609.GA14841@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexey Borzenkov <snaury@gmail.com>,
	Ren?? Scharfe <l.s.r@web.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bobby Powers <bobbypowers@gmail.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 18:27:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq4cH-00017A-P2
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 18:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab3LIR13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 12:27:29 -0500
Received: from mout.web.de ([212.227.15.4]:64019 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab3LIR12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 12:27:28 -0500
Received: from [192.168.178.41] ([84.132.175.50]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lr2Dz-1VLOgw3tid-00egTZ for <git@vger.kernel.org>;
 Mon, 09 Dec 2013 18:27:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131209151609.GA14841@google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:XYAboEAGp+4hj6CEO79X3QtkzlwoSJlkCkIhjdOwK5QrPcfSI6g
 W6y7EtjPF8Lnkm7eSoQQSX3rgD2YxyN8jDNaEZZJD9vqWfXMuShOUa7IZLx1dQIULbISaI4
 Yl+eaDwwZ/AAuDBchHwC/w5sJ+c6qQBAG8Ow5+sp2UCN1d46pbm7/M/Ce/ixSIc9ydGgo7/
 VKXs14bnOLM+CHX6Hz4Ow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239071>

Am 09.12.2013 16:16, schrieb Jonathan Nieder:
> Thomas Gummerer wrote:
> 
>> git diff --no-index ... currently reads the index, during setup, when
>> calling gitmodules_config().  In the usual case this gives us some
>> performance drawbacks,
> 
> Makes sense.

Hmm, but this will disable the submodule specific ignore configuration
options defined in the .gitmodules file, no? (E.g. when diffing two
directories containing submodules)

>>                        but it's especially annoying if there is a broken
>> index file.
>
> Is this really a normal case?  It makes sense that as a side-effect it
> is easier to use "git diff --no-index" as a general-purpose tool while
> investigating a broken repo, but I would have thought that quickly
> learning a repo is broken is a good thing in any case.

But I agree that dying with "index file corrupt" is a bit strange when
calling diff with --no-index. Wouldn't adding a "gently" option (which
could then warn instead of dying) to gitmodules_config() be a better
solution here?
