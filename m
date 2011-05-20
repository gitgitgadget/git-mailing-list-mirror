From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [BUG] merge-recursive triggered "BUG"
Date: Thu, 19 May 2011 21:14:53 -0400
Message-ID: <BANLkTimNnRrJ_2UJUSWWd1QS=e0YH2p=_Q@mail.gmail.com>
References: <7v4o7260no.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 03:15:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNEIt-0006se-Se
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 03:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934589Ab1ETBOz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 21:14:55 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46057 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933379Ab1ETBOy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 21:14:54 -0400
Received: by pwi15 with SMTP id 15so1482632pwi.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 18:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EHQF4TjPj70udcs8I9J35MSqM7GzGjQkTlpIZwd+dOA=;
        b=oyiHVBnNVri2Xs5WKnAMnlPah1A2mFFB6HJJ2SVC+Udp/2qx1+ehSno+EQ0csFjf8P
         1zgOZCKQpn2VZr/RMeEnliOfywK2+FNuBEh1QVWHSkj9gFqEfJ/bE2ctyd8gusml8htZ
         PaP636MsDbUwaARGldVWzZESkD6btCYnRAlRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k/yyrIL0lPB4qareLSd/90sv2JJ/yzK75LFmG+tgILkSk7cj073uamPQUOvcEFVsdX
         yXlg+QOPE2R23aDG3n4fibNr0l7IzpDODJKyKkXrRgn2wR/G+VtAjJjzMTUEV/c1yc0X
         P/fpnyXlhqWc2Vp4fBx7Is6z2dn5X+7qgIb8E=
Received: by 10.142.147.10 with SMTP id u10mr2394912wfd.112.1305854093885;
 Thu, 19 May 2011 18:14:53 -0700 (PDT)
Received: by 10.142.13.8 with HTTP; Thu, 19 May 2011 18:14:53 -0700 (PDT)
In-Reply-To: <7v4o7260no.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174030>

On Wed, Mar 16, 2011 at 8:39 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> As a part of my today's merge, I used 'next' that contains b2c8c0a
> (merge-recursive: When we detect we can skip an update, actually skip=
 it,
> 2011-02-28) to merge 'maint' into 'master' to propagate older release=
s up.
>
> It triggered a "BUG" per merged path, and I bisected this breakage do=
wn to
> the said commit. Luckily 'master' is not contaminated with the breaka=
ge,
> so I used it to finish today's work.

I just ran into this. It's not in a repo I can share however. But, why
did b2c8c0a make it into master with this known issue?

j.

> When I push out the result from today, you can reproduce it with
>
> =C2=A0 =C2=A0git checkout 0631623 ;# master to acquire changes from m=
aint
> =C2=A0 =C2=A0git merge [-s recursive] fbcda3c
>
> I suspect that the new codepath introduced by b2c8c0a needs to pay
> attention to the merge depth (for example, does it make any sense at =
all
> to run lstat() when you are doing recursive common parent synthesis?)=
, but
> I didn't dig into it.
>
> The command fails with this output:
>
> error: addinfo_cache failed for path 'builtin/add.c'
> error: addinfo_cache failed for path 'builtin/apply.c'
> error: addinfo_cache failed for path 'builtin/branch.c'
> error: addinfo_cache failed for path 'builtin/checkout.c'
> error: addinfo_cache failed for path 'builtin/commit.c'
> error: addinfo_cache failed for path 'builtin/config.c'
> error: addinfo_cache failed for path 'builtin/diff-files.c'
> error: addinfo_cache failed for path 'builtin/diff.c'
> error: addinfo_cache failed for path 'builtin/fast-export.c'
> error: addinfo_cache failed for path 'builtin/grep.c'
> error: addinfo_cache failed for path 'builtin/hash-object.c'
> error: addinfo_cache failed for path 'builtin/init-db.c'
> error: addinfo_cache failed for path 'builtin/log.c'
> error: addinfo_cache failed for path 'builtin/merge.c'
> error: addinfo_cache failed for path 'builtin/push.c'
> error: addinfo_cache failed for path 'builtin/rerere.c'
> error: addinfo_cache failed for path 'builtin/update-index.c'
> error: addinfo_cache failed for path 't/t7810-grep.sh'
> BUG: There are unmerged index entries:
> BUG: 1 builtin/add.cBUG: 2 builtin/add.cBUG: 3 builtin/add.cBUG: 1 bu=
iltin/apply.cBUG: 2 builtin/apply.cBUG: 3 builtin/apply.cBUG: 1 builtin=
/branch.cBUG: 2 builtin/branch.cBUG: 3 builtin/branch.cBUG: 1 builtin/c=
heckout.cBUG: 2 builtin/checkout.cBUG: 3 builtin/checkout.cBUG: 1 built=
in/commit.cBUG: 2 builtin/commit.cBUG: 3 builtin/commit.cBUG: 1 builtin=
/config.cBUG: 2 builtin/config.cBUG: 3 builtin/config.cBUG: 1 builtin/d=
iff-files.cBUG: 2 builtin/diff-files.cBUG: 3 builtin/diff-files.cBUG: 1=
 builtin/diff.cBUG: 2 builtin/diff.cBUG: 3 builtin/diff.cBUG: 1 builtin=
/fast-export.cBUG: 2 builtin/fast-export.cBUG: 3 builtin/fast-export.cB=
UG: 1 builtin/grep.cBUG: 2 builtin/grep.cBUG: 3 builtin/grep.cBUG: 1 bu=
iltin/hash-object.cBUG: 2 builtin/hash-object.cBUG: 3 builtin/hash-obje=
ct.cBUG: 1 builtin/init-db.cBUG: 2 builtin/init-db.cBUG: 3 builtin/init=
-db.cBUG: 1 builtin/log.cBUG: 2 builtin/log.cBUG: 3 builtin/log.cBUG: 1=
 builtin/merge.cBUG: 2 builtin/merge.cBUG: 3 builtin/merge.cBUG: 1 buil=
tin/push.cBUG: 2 builtin/push.cBUG: 3 builtin/push.cBUG: 1 builtin/rere=
re.cBUG: 2 builtin/rerere.cBUG: 3 builtin/rerere.cBUG: 1 builtin/update=
-index.cBUG: 2 builtin/update-index.cBUG: 3 builtin/update-index.cBUG: =
1 t/t7810-grep.shBUG: 2 t/t7810-grep.shBUG: 3 t/t7810-grep.shfatal: Bug=
 in merge-recursive.c
>
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
