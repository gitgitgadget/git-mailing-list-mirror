From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 20:21:48 +0100
Message-ID: <4F0F32CC.8040404@kdbg.org>
References: <20120111173101.GQ30469@goldbirke> <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com> <20120112144409.GV30469@goldbirke> <20120112165329.GA17173@sigill.intra.peff.net> <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 20:22:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlQE7-0004Bx-Jz
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 20:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab2ALTWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 14:22:15 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:53120 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752926Ab2ALTWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 14:22:14 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.105])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 6CB12CE197
	for <git@vger.kernel.org>; Thu, 12 Jan 2012 20:23:10 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2EB982C4005;
	Thu, 12 Jan 2012 20:22:48 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E999519F620;
	Thu, 12 Jan 2012 20:21:48 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188472>

Am 12.01.2012 18:09, schrieb Ramkumar Ramachandra:
> @@ -2054,7 +2054,10 @@ int prepare_revision_walk(struct rev_info *revs)
>                 if (commit) {
>                         if (!(commit->object.flags & SEEN)) {
>                                 commit->object.flags |= SEEN;
> -                               commit_list_insert_by_date(commit,
> &revs->commits
> +                               if (revs->literal_order)
> +                                       commit_list_insert(commit,
> &revs->commits
> +                               else
> +
> commit_list_insert_by_date(commit, &revs-

Why do we need a new flag?

  git show origin/master origin/maint
  git show origin/maint origin/master

show the revisions in different order, in particular, in the order
requested on the command line. Shoudn't cherry-pick be able to do the
same without new hacks?

-- Hannes
