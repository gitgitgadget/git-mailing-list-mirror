From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What happened to having to recover from upstream
 =?UTF-8?Q?rebase=3F?=
Date: Wed, 13 May 2015 11:37:18 +0200
Organization: gmx
Message-ID: <b1686e402e9459e58acc7700a12f377d@www.dscho.org>
References: <555107F7.1040906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Phil Susi <phillsusi@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 11:37:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsT6Y-0006fc-99
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933623AbbEMJh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:37:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:53126 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933470AbbEMJhV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:37:21 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MGWR2-1Ywsxj1iIi-00DIWB; Wed, 13 May 2015 11:37:19
 +0200
In-Reply-To: <555107F7.1040906@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Yi1WlCZ+hpqTAH5sV0CtVkFtlCOaEhK+tqPbdTYUKz7nBJtK25J
 uXS+THx19P7zWrKNL4exG5rf/KramJ6Iu/CqmgdySzSBM/hkIpLPgC5dAXsYicpM0RlTL/u
 p4qEto9W+hPuc7hfGFzUxzDdUmLRjhmomcDF52pEZPcJjOgPijgT/wI87Du1pUxh/a/YsWf
 bua6B8ai9tmkgSZG+YHJA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268965>

Hi Phil,

On 2015-05-11 21:50, Phil Susi wrote:
> So it used to be that when upstream rebased, you'd get an error when
> you tried to pull again

Not necessarily. You would get this error *only* if there was a merge conflict between the revisions (one revision being your remote-tracking branch *before* the pull, the other revision being your remote-tracking branch *after* the fetch implied by the pull).

> and have to fix things up with some git reset
> or rebase hackery.  Trying to demo this today I found that the pull
> *worked*, using an automatic recursive merge.
> 
> Am I crazy in thinking this used to error, and if not, when did it change?

You are not crazy, but I believe it might be a misunderstanding how the rebased upstream and the pull interact. When an upstream branch is rebased after you merge it, you have essentially two disagreeing versions of upstream.

My reading is that you mistook the error Git showed when trying to merge two disagreeing versions of upstream for an error produced by pull *directly* when it detects that upstream has been rebased. There is no such test in `git pull`, though. And when the upstream is rewritten in a way that does *not* cause merge conflicts [*1*], your workflow simply does not work.

The easy way out is to use `git pull --rebase` which figures out from the previously fetched revisions of the upstream branch what commits were dropped/rewritten and does not attempt to merge them. Note: Your local commits on top of upstream are also rebased which possibly leads to conflicts using this method.

Ciao,
Johannes

Footnote *1*: It is very easy to rewrite a branch in such a way: just amend the commit message and you end up with two disagreeing histories, where the *working directories* corresponding to the disagreeing revisions are identical and therefore merged in the most trivial manner. 
