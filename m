From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Mon, 24 Jun 2013 08:58:23 +0200
Message-ID: <CALKQrgfAT9GhD-_tZHr9wRA6R6g7ttDWTsmUQXdWUhG-gwNBqQ@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 08:58:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur0jR-0005yu-EY
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 08:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536Ab3FXG63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 02:58:29 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:61878 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab3FXG62 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 02:58:28 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur0jL-000Len-8v
	for git@vger.kernel.org; Mon, 24 Jun 2013 08:58:27 +0200
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Uqzci-0008PP-A0
	for git@vger.kernel.org; Mon, 24 Jun 2013 07:47:32 +0200
Received: by mail-ob0-f174.google.com with SMTP id wd20so10430491obb.19
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 23:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tELL/S+k+u3jnxI5ra8sy2iyrF8CKFWR4lWZv/4D4xY=;
        b=SPfaTxLxGZGKyWELQciVEYoHeWFkAubVjyhTJQlq0TkyoDqTDtM7ysUTIGSvsJnG2I
         vczUJ82TEUyQ2Xs15ZKNBva6nu7K8r5DMAUq2sYRwFYtl3LE6FY9XKSZleo9TdXNKnky
         LxfCYmoBASHY14qPxdCpA1m9Z7CZRDx/9XgSNctpTNhLNLAnMlSyS1nIfcE1PEJEQfSo
         yMc2NbC2JI5mpKLVN8a6+4HNcBHjqDlOwXJmOTxJt+dbfxZnW+DZME8oE38MbDjnDvwu
         eIAdbQX3bPBCJxviOmvZ4uLfyswJ58S2S+/6EpImmDDzp75Jc2/HC0Wauym40HLar38E
         c0Og==
X-Received: by 10.182.92.225 with SMTP id cp1mr7497672obb.97.1372057103408;
 Sun, 23 Jun 2013 23:58:23 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Sun, 23 Jun 2013 23:58:23 -0700 (PDT)
In-Reply-To: <1372048388-16742-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228777>

On Mon, Jun 24, 2013 at 6:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> From: Ramkumar Ramachandra <artagnon@gmail.com>
>
> When remote.pushdefault or branch.<name>.pushremote is set (a triangular
> workflow feature), master@{u} != origin, and push.default is set to
> `upstream` or `simple`:
>
>   $ git push
>   fatal: You are pushing to remote 'origin', which is not the upstream of
>   your current branch 'master', without telling me what to push
>   to update which remote branch.
>
> The very name of "upstream" indicates that it is only suitable for
> use in central workflows; let us not even attempt to give it a new
> meaning in triangular workflows, and error out as usual.
>
> However, the `simple` does not have this problem: it is poised to be
> the default for Git 2.0, and we would definitely like it to do
> something sensible in triangular workflows.
>
> Redefine "simple" as "safer upstream" for centralized workflow as
> before, but work as "current" for triangular workflow.
>
> An earlier round of this change by mistake broke the safety for
> "simple" mode we have had since day 1 of that mode to make sure that
> the branch in the repository we update is set to be the one we fetch
> and integrate with, but it has been fixed.

Shouldn't there be an acompanying test to demonstrate this mistake being fixed?

> Reported-by: Leandro Lucarella <leandro.lucarella@sociomantic.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config.txt | 10 +++++++---
>  builtin/push.c           | 43 +++++++++++++++++++++++++++++++------------
>  2 files changed, 38 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5d8ff1a..cae6870 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1848,9 +1848,13 @@ push.default::
>    pushing to the same repository you would normally pull from
>    (i.e. central workflow).
>
> -* `simple` - like `upstream`, but refuses to push if the upstream
> -  branch's name is different from the local one. This is the safest
> -  option and is well-suited for beginners.
> +* `simple` - in centralized workflow, work like `upstream` with an
> +  added safety to refuse to push if the upstream branch's name is
> +  different from the local one.
> ++
> +When pushing to a remote that is different from the remote you normally
> +pull from, work as `current`.  This is the safest option and is suited
> +for beginners.
>  +
>  This mode will become the default in Git 2.0.
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 2d84d10..f6c8047 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -120,10 +120,11 @@ static const char message_detached_head_die[] =
>            "\n"
>            "    git push %s HEAD:<name-of-remote-branch>\n");
>
> -static void setup_push_upstream(struct remote *remote, int simple)
> +static void setup_push_upstream(struct remote *remote, struct branch *branch,
> +                               int triangular)
>  {
>         struct strbuf refspec = STRBUF_INIT;
> -       struct branch *branch = branch_get(NULL);
> +
>         if (!branch)
>                 die(_(message_detached_head_die), remote->name);
>         if (!branch->merge_nr || !branch->merge || !branch->remote_name)
> @@ -137,18 +138,29 @@ static void setup_push_upstream(struct remote *remote, int simple)
>         if (branch->merge_nr != 1)
>                 die(_("The current branch %s has multiple upstream branches, "
>                     "refusing to push."), branch->name);
> -       if (strcmp(branch->remote_name, remote->name))
> +       if (triangular)
>                 die(_("You are pushing to remote '%s', which is not the upstream of\n"
>                       "your current branch '%s', without telling me what to push\n"
>                       "to update which remote branch."),
>                     remote->name, branch->name);
> -       if (simple && strcmp(branch->refname, branch->merge[0]->src))
> -               die_push_simple(branch, remote);
> +
> +       if (push_default == PUSH_DEFAULT_SIMPLE) {
> +               /* Additional safety */
> +               if (strcmp(branch->refname, branch->merge[0]->src))
> +                       die_push_simple(branch, remote);
> +       }
>
>         strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
>         add_refspec(refspec.buf);
>  }
>
> +static void setup_push_current(struct remote *remote, struct branch *branch)
> +{
> +       if (!branch)
> +               die(_(message_detached_head_die), remote->name);
> +       add_refspec(branch->name);

Here (and above) we add a refspec to tell Git exactly what to push
from the local end, and into what on the remote end. Is it possible to
end up with multiple simultaneous refspecs matching the same local
ref, but mapping to different remote refs? If so, which will win, and
does that make sense?

> +}
> +
>  static char warn_unspecified_push_default_msg[] =
>  N_("push.default is unset; its implicit value is changing in\n"
>     "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
> @@ -173,9 +185,16 @@ static void warn_unspecified_push_default_configuration(void)
>         warning("%s\n", _(warn_unspecified_push_default_msg));
>  }
>
> +static int is_workflow_triagular(struct remote *remote)

s/triagular/triangular/

> +{
> +       struct remote *fetch_remote = remote_get(NULL);
> +       return (fetch_remote && fetch_remote != remote);

This changed from a strcmp() to a pointer compare. That might be safe,
depending on the sources of the two struct remote *, but I'm not sure.

> +}
> +
>  static void setup_default_push_refspecs(struct remote *remote)
>  {
> -       struct branch *branch;
> +       struct branch *branch = branch_get(NULL);
> +       int triangular = is_workflow_triagular(remote);
>
>         switch (push_default) {
>         default:
> @@ -188,18 +207,18 @@ static void setup_default_push_refspecs(struct remote *remote)
>                 break;
>
>         case PUSH_DEFAULT_SIMPLE:
> -               setup_push_upstream(remote, 1);
> +               if (triangular)
> +                       setup_push_current(remote, branch);
> +               else
> +                       setup_push_upstream(remote, branch, triangular);
>                 break;
>
>         case PUSH_DEFAULT_UPSTREAM:
> -               setup_push_upstream(remote, 0);
> +               setup_push_upstream(remote, branch, triangular);
>                 break;
>
>         case PUSH_DEFAULT_CURRENT:
> -               branch = branch_get(NULL);
> -               if (!branch)
> -                       die(_(message_detached_head_die), remote->name);
> -               add_refspec(branch->name);
> +               setup_push_current(remote, branch);
>                 break;
>
>         case PUSH_DEFAULT_NOTHING:

Otherwise, this looks good to me.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
