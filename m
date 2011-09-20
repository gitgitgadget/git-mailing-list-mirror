From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Tue, 20 Sep 2011 16:45:40 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109201254020.12564@debian>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com> <7v1uvta97o.fsf@alter.siamese.dyndns.org> <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com> <4E676F6A.3060906@drmicha.warpmail.net>
 <CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com> <7vk49k48q4.fsf@alter.siamese.dyndns.org> <CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com> <alpine.DEB.2.00.1109080753460.12564@debian>
 <CAC9WiBiMYUfaPtrXyW=W7qaZnJqLeFO-B3od7X4u8wUrb8hfUA@mail.gmail.com> <alpine.DEB.2.00.1109082123300.12564@debian> <CAC9WiBhApjEr-NYm9NkyXaZPNCivoJ65c=xx2bg5Li60kfZMTQ@mail.gmail.com> <alpine.DEB.2.00.1109090900301.12564@debian> <alpine.DEB.2.00.1109122139110.12564@debian>
 <7vwrdaqxpk.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1109151956040.12564@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 22:45:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R67CX-0004KF-47
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 22:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab1ITUpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 16:45:46 -0400
Received: from mail-vw0-f52.google.com ([209.85.212.52]:65174 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab1ITUpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 16:45:44 -0400
Received: by vws10 with SMTP id 10so1361139vws.11
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=gbuO2p6kr09wLICR6hlKuAis+ytNUPBI46ilYPin/t0=;
        b=iD7uvY0C/kVTd1/dO2wTp3AMjtKJx1ORRzRAhcbAwntf61iiMIs5Pgr6j3iXSKdWWF
         9zqwqYutxPnO8hzSw5FFc/lyDgaiIYMJNzYGcxlsii65Ud9h5FOckqNE+GBrhNAyXWAh
         wDmsTxwoQukRnlyz3KnwwF/I1dTkkl9swsllQ=
Received: by 10.52.19.198 with SMTP id h6mr1198508vde.292.1316551544025;
        Tue, 20 Sep 2011 13:45:44 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca. [24.37.77.94])
        by mx.google.com with ESMTPS id jo8sm1956027vdb.20.2011.09.20.13.45.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Sep 2011 13:45:42 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.2.00.1109151956040.12564@debian>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181795>

On Thu, 15 Sep 2011, Martin von Zweigbergk wrote:

[CC'ing Ramkunar regarding the footnote]

> [...] With your
> patch, we would also get the patch body from the commit. The only
> thing remaining after that is the commit log message, correct?

It turns out the commit log message have been taken from the commit
for ages. Sorry about not checking the code first.

I have started implementing the changes to git-am.sh now. I have made
it not use mailinfo when in $rebasing mode, as you suggested. So now
git-am works even if only a list of

  From $sha1 Mon Sep 17 00:00:00 2001

lines are fed to it. Since only the $sha1 is needed, we should
probably make --rebasing imply a patch-format is just a simple list of
revisions. Since the --rebasing flag is only for internal use, this
should be safe when it comes to backwards compatibility. [1]

Now the question is how to generate such lines, without the overhead
of a full format-patch call. We still want the --ignore-if-in-upstream
functionality, so we can not use plain rev-list. We also want it to
work with --root, so we can not use git-cherry. Finally, we can not
use 'git rev-list --cherry-pick --right-only' since it seems to be
inherently for symmetric ranges and therefore does not support
git-cherry's <limit> parameter.

If I'm not mistaken, we would have to teach some new option to some
command, but which one?

It doesn't feel right to teach format-patch a --commit-name-only,
simply because it would then no longer be a patch.

It's probably easiest to teach git-cherry a --root flag. Does that
sound like the right solution to people? I think it makes sense for
such an option to exist.

More involved would be to teach rev-list --cherry-pick also for
asymmetric ranges. I would imagine that "--cherry-pick $branch --not
$newbase $oldbase" could be defined as "all commits in $branch that
are not patch-equivalent to any commits in $newbase or $oldbase". Just
s/patch-equivalent/identical/ and you have the regular definition of
the rev-list, right? There is of course no need to actually calculate
the patch-id for any commits are not in "$branch --not $newbase
$oldbase" (identical => patch-equivalent).

I would go for teaching git-cherry --root, unless the "rev-list
--cherry-pick for asymmetric ranges" option would be useful
elsewhere. Either way, teaching git-cherry --root would not be a bad
thing, I think.


Martin


 [1] Long term, would it make sense to teach 'git cherry-pick' a '-2'
     option instead of using the '-3' option to 'git am'? (Where 'git
     cherry-pick -2' would try "apply && write-tree && commit-tree"
     before falling back to merging.)
