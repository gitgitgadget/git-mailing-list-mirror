From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Tue, 7 Jun 2016 20:25:17 +0530
Message-ID: <CAFZEwPOZSU315oCJSdawtacPmgZobCnkkguTnSy1_V7x_n09kw@mail.gmail.com>
References: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com> <20160524191950.21889-1-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 16:55:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAIQ2-000070-7C
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 16:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815AbcFGOz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 10:55:27 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36269 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbcFGOzX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 10:55:23 -0400
Received: by mail-yw0-f195.google.com with SMTP id l126so23185151ywe.3
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JGBK3xI3eaN05svRK1AUCTfk0A4DAnrseLEl25mjxsY=;
        b=UtfQUJWhn8hddUNkY4x+3TaTO16WrgMz84NrLKVcTe0bWqnF67loh1daWhuKtknhRm
         eyf3XIuAmCzwOZfCNInldpnvHIIuwU/jkMmDp5MzHUUVP+Dqd3hQt5EfiCVCNy2VcI+k
         8Np3nlrsovxgOo4vBDveT+eSNUkx1gM7Epotgcez50Z45Z6ihhpaiBo8mymzaCd5Txy+
         +OlbPOwuP4XaMxfh9k3+qXFFnWMgyTEzekNeiOmnDBfa8TD/8kYTh7xDvFM0mD6F1vK+
         e0WrSY9fvVucy5JJrP54nW4oZfcQK/CYPEGI34/IGfPlBLPDpnVE7XnBIGh9ZaT+wVTV
         AsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JGBK3xI3eaN05svRK1AUCTfk0A4DAnrseLEl25mjxsY=;
        b=b+pAozxU/wUxx2KDLtQMblW2bBVaLlp7UQObzErnLCsEL9x5CV/tZL0n6lIi+rejY8
         OXvENKn4aLXdNRYToPTG2TUGnGGQmlQgpPnclGsk9orzH10fVJVsBbA1cm+Y7B/ka5KI
         l+85pMiLvRitUGwk40y/LQ7EiIKmLO5mZI+EDHYy6ayOdx1l05nhPxKrK3SvzR+3Up3Y
         lbQ6BUipS5YPup+TNlaVKpzF4IDiYjDwLa3D2dXOQgzEGcvOkG5+0woyk05zWE9UzSCU
         kg7bKPFElWqB0m1+01Ns/mL+r+v3pjmoievawOB9JloyPBTeWpIpRrpPEQD8o59tPKlR
         qzkA==
X-Gm-Message-State: ALyK8tJ4843BNszCSKBAixkSZCaYA3kczJrvyhuJLwrsMqSc1Cfjz3TeVUMO6Ezxi+GfE7x7ZcsGPNssfg2aAw==
X-Received: by 10.37.57.143 with SMTP id g137mr14361121yba.131.1465311318031;
 Tue, 07 Jun 2016 07:55:18 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Tue, 7 Jun 2016 07:55:17 -0700 (PDT)
In-Reply-To: <20160524191950.21889-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296688>

On Wed, May 25, 2016 at 12:49 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> This is a follow up commit for f932729c (memoize common git-path
> "constant" files, 10-Aug-2015).
>
> The many function calls to git_path() are replaced by
> git_path_commit_editmsg() and which thus eliminates the need to repeatedly
> compute the location of "COMMIT_EDITMSG".
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> Link for v1[1].
>
> Changes wrt v1:
>
>  * Remove the call to git_path_commit_editmsg() which would directly assign
>    the value to the string.
>  * Remove the string commit_editmsg[] as it is redundant now.
>  * Call git_path_commit_editmsg() everytime when it is needed.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/295345
>
>  builtin/commit.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 391126e..01b921f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -92,8 +92,9 @@ N_("If you wish to skip this commit, use:\n"
>  "Then \"git cherry-pick --continue\" will resume cherry-picking\n"
>  "the remaining commits.\n");
>
> +static GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
> +
>  static const char *use_message_buffer;
> -static const char commit_editmsg[] = "COMMIT_EDITMSG";
>  static struct lock_file index_lock; /* real index */
>  static struct lock_file false_lock; /* used only for partial commits */
>  static enum {
> @@ -771,9 +772,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>                 hook_arg2 = "";
>         }
>
> -       s->fp = fopen_for_writing(git_path(commit_editmsg));
> +       s->fp = fopen_for_writing(git_path_commit_editmsg());
>         if (s->fp == NULL)
> -               die_errno(_("could not open '%s'"), git_path(commit_editmsg));
> +               die_errno(_("could not open '%s'"), git_path_commit_editmsg());
>
>         /* Ignore status.displayCommentPrefix: we do need comments in COMMIT_EDITMSG. */
>         old_display_comment_prefix = s->display_comment_prefix;
> @@ -950,7 +951,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>         }
>
>         if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
> -                           git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
> +                           git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
>                 return 0;
>
>         if (use_editor) {
> @@ -958,7 +959,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>                 const char *env[2] = { NULL };
>                 env[0] =  index;
>                 snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> -               if (launch_editor(git_path(commit_editmsg), NULL, env)) {
> +               if (launch_editor(git_path_commit_editmsg(), NULL, env)) {
>                         fprintf(stderr,
>                         _("Please supply the message using either -m or -F option.\n"));
>                         exit(1);
> @@ -966,7 +967,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>         }
>
>         if (!no_verify &&
> -           run_commit_hook(use_editor, index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
> +           run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
>                 return 0;
>         }
>
> @@ -1728,7 +1729,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>
>         /* Finally, get the commit message */
>         strbuf_reset(&sb);
> -       if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
> +       if (strbuf_read_file(&sb, git_path_commit_editmsg(), 0) < 0) {
>                 int saved_errno = errno;
>                 rollback_index_files();
>                 die(_("could not read commit message: %s"), strerror(saved_errno));
> --
> 2.8.3
>

Anyone any comments?

Regards,
Pranit Bauva
