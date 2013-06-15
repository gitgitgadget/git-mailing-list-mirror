From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Sat, 15 Jun 2013 17:38:39 +0530
Message-ID: <CALkWK0=R8h0_FUYMUFQ_qGC1Lf_Xvu84qigznYUK5MtzP8usPQ@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-6-git-send-email-artagnon@gmail.com> <7vvc5hubox.fsf@alter.siamese.dyndns.org>
 <CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
 <7vd2rpu3kf.fsf@alter.siamese.dyndns.org> <CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
 <7vppvosstl.fsf@alter.siamese.dyndns.org> <CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
 <7v38sksq14.fsf@alter.siamese.dyndns.org> <CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
 <7vsj0kpsb0.fsf@alter.siamese.dyndns.org> <CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
 <7v7ghwmi9x.fsf@alter.siamese.dyndns.org> <CALkWK0nDwqqiAq044wwj__1XzAuFDBUG59_0zHRMNzQ6ARsiww@mail.gmail.com>
 <7vsj0jln23.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 14:09:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnpIM-00009j-SW
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 14:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab3FOMJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 08:09:23 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:60885 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab3FOMJV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 08:09:21 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so3303082iet.23
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Jb9NPy62RZzpj3SnuIy6aalPgYp7eFE3DalnGrucuFw=;
        b=Gu1w7MRCSujo9bMLUbZyhi0rJ2+m8FUDlNsbSTSL0c7rL7E5BEuAcD0tHyo3tWJkvS
         gY6Ej8PDwgg2J8nPsfg0MwLh5MfxX1yDh6AtxniIiokIn1PeG/mzdhHcjfisEWsKksP8
         GU6GmKpPbsmxCJ5OqvtJ0fp0UP6stgbB/rysFHk7KU+3XNnIxeAIBVXig1zemVoTCYCA
         T2Gy70/Me4lmobi+RfikvY2h0XLvd5PcZGKkrfugPrJ13DVWDbsKidxOo3Q9eYQ/RNeH
         Y3DwzEpLruAcbgDEdq0Sj21MRy+y9YVf5sdL7vCQDzICo8e5+CO1wLReLt45GSqvogdt
         znBw==
X-Received: by 10.50.79.231 with SMTP id m7mr936657igx.40.1371298160731; Sat,
 15 Jun 2013 05:09:20 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 15 Jun 2013 05:08:39 -0700 (PDT)
In-Reply-To: <7vsj0jln23.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227943>

Junio C Hamano wrote:
> Two possibilities:
>
>  (1) Assume that the other thread will produce a more reasonable
>      semantics when finished; perhaps the first line will go away
>      entirely, or maybe it would say something like "# Rebasing;
>      head at $commit".
>
>      Your topic does not _care_ what it would say, so you tweak the
>      "status" test that is done during "rebase" so that they
>      ignore the first lines; or

You said you didn't want to regress to show senseless information, and
I agreed with that.  What is wrong with the patch I showed in the
previous email?  Smudging is a bad hack, and must only be used as a
last resort: when an another topics updates status to say something
sensible, it will have to unsmudge the tests.

diff --git a/wt-status.c b/wt-status.c
index bf84a86..99c55e3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1182,7 +1182,7 @@ void wt_status_print(struct wt_status *s)
                                if (!get_sha1("HEAD", sha1) &&
                                    !hashcmp(sha1, state.detached_sha1))
                                        on_what = _("HEAD detached at ");
-                               else
+                               else if (!state.rebase_in_progress)
                                        on_what = _("HEAD detached from ");
                        } else {
                                branch_name = "";

>  (2) Starting from the same assumption as above, but try to minimize
>      the semantics change to user-visible behaviour this series
>      makes.

The "try to minimize" is a somewhat admirable goal, but I have shown
that your midway solution is wrong.  Either dedicate a lot of time and
effort towards improving status for rebase, or don't attempt it.

>      That means that even though the _primary_ thing you want to do
>      is to tweak "rebase" and its internal use of "checkout" in such
>      a way that reflog will not record the implementation-detail
>      checkout (because that will affect the next "checkout -"), make
>      sure that "status" while doing "rebase" reports where the
>      internal "checkout" of $ONTO detached HEAD from/at.

Unless we change the first line drastically to say: "rebase in
progress: rebasing onto $ONTO" (or something), I don't think this
makes sense.  And if we were to do that, why not do it properly like
"rebase ($N/$M): onto $ONTO, upstream $UPSTREAM, branch $BRANCH"?
Other people on a different thread are already handling that, and I am
not interested.

So, you have three simple choices now:

1. Accept the simple patch I proposed above.
2. Propose an alternative patch quickly.  *Patch*.  No more English.
3. Reject all patches, and leave me no choice but to smudge.

Which one is it going to be?
