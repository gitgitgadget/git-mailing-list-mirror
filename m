From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Sat, 15 Jun 2013 13:32:51 +0530
Message-ID: <CALkWK0mCK_-bUapAvcrwtNgGnT1=x1d=+J9RO1GK6ssHWP2ztA@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-6-git-send-email-artagnon@gmail.com> <7vvc5hubox.fsf@alter.siamese.dyndns.org>
 <CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
 <7vd2rpu3kf.fsf@alter.siamese.dyndns.org> <CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
 <7vppvosstl.fsf@alter.siamese.dyndns.org> <CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
 <7v38sksq14.fsf@alter.siamese.dyndns.org> <CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
 <7vsj0kpsb0.fsf@alter.siamese.dyndns.org> <CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
 <7v7ghwmi9x.fsf@alter.siamese.dyndns.org> <7v38skmgu8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 10:04:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnlSr-0007yL-44
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 10:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab3FOIDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 04:03:36 -0400
Received: from mail-bk0-f47.google.com ([209.85.214.47]:58776 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121Ab3FOIDd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 04:03:33 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg1so560061bkc.34
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 01:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SUbnwBSM5xt8mAAZOu6Jf/e5Pbr6QlQZiIJLcUYZWXU=;
        b=KoZLJZsFe0y9CdUPh5ZS4DuAyKhBWz28tYI+s/L+XWzr76jutol8DAlEERpH4CglM+
         4Es+QkskEAxscTdTYsr3Cmnb3Rqmy8tS7NYLJ3xFLB7vTQWZRm/VrzO6eXlgY5oo8p7q
         DV4rVqSmdwu4FgvUyfe8plspFdtNA74aBNB8PLFyE+kJMk81qXVEf829lXaFTAsoPdCK
         3WSVkhldfdafNrFsEhNkzKSmvgxbwr1/jlCbCyTa73KACqmCnmMQg+tPK/0O5h46QCAg
         2FA2u7rnWtMUWOwMosT69YU8XVxDScsJ9YTWS8PX+6E0yETuFFEYreb5X/3U3KEK8OKO
         wyyg==
X-Received: by 10.204.69.12 with SMTP id x12mr823196bki.14.1371283412083; Sat,
 15 Jun 2013 01:03:32 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Sat, 15 Jun 2013 01:02:51 -0700 (PDT)
In-Reply-To: <7v38skmgu8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227935>

Junio C Hamano wrote:
>  wt-status.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index bf84a86..403d48d 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1176,7 +1176,11 @@ void wt_status_print(struct wt_status *s)
>                         branch_name += 11;
>                 else if (!strcmp(branch_name, "HEAD")) {
>                         branch_status_color = color(WT_STATUS_NOBRANCH, s);
> -                       if (state.detached_from) {
> +
> +                       if (state.rebase_in_progress) {
> +                               on_what = _("HEAD detached at ");
> +                               branch_name = state.onto;
> +                       } else if (state.detached_from) {
>                                 unsigned char sha1[20];
>                                 branch_name = state.detached_from;

Good.  You have proposed a solution to the problem.  However, it is
wrong for the following reasons:

1. It shows a pseudo "HEAD detached at" message.  Everywhere else,
when the user sees a "HEAD detached at $committish" message, git
rev-parse $committish = git rev-parse HEAD.  A rebase-in-progress
seems to be the only exception, and the user has no idea this is
happened.

2. The following no longer updates status:

  # in the middle of a rebase
  $ git reset @~2

The constant "HEAD detached at $onto" message is misleading and Bad.
Besides, wasn't this the primary usecase you wanted?

You previously wrote:
> *1* One thing I could think of is to start sightseeing or (more
>     realistically) manually bisecting at a given release point,
>     reset the detached HEAD around several times, and then want to
>     be reminded where the session started from.  I do not think it
>     is particularly a very good example, though.

Whether the HEAD is detached by bisect or rebase is irrelevant.

3. The problem is not unique to rebase at all; yet you have
special-cased it.  If this isn't a band-aid, what is?  The larger
problem, as I have stated previously, is that 'git status' output
depends on the _implementations_ of various commands (do they write a
"checkout: " message to the reflog or not?).  Therefore, a future
contributor who updates a command to write more sensible reflog
messages will have to apply a similar band-aid.

If you want to take the band-aid approach, I think this is the right
way to do it:

diff --git a/wt-status.c b/wt-status.c
index bf84a86..99c55e3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1182,7 +1182,7 @@ void wt_status_print(struct wt_status *s)
 				if (!get_sha1("HEAD", sha1) &&
 				    !hashcmp(sha1, state.detached_sha1))
 					on_what = _("HEAD detached at ");
-				else
+				else if (!state.rebase_in_progress)
 					on_what = _("HEAD detached from ");
 			} else {
 				branch_name = "";

You have already mentioned that there is a topic cooking to improve
this first-line in the case of rebase, so this regression from a
senseless message isn't a problem.

The problem with this bad-aid, as with all band aids, is that this
will soon explode to become else if(!state.rebase_in_progress &&
!state.bisect_in_progress && ....) when people update those scripts.
If you don't want to go with the band-aid, I have no choice but to
smudge the first-line.
