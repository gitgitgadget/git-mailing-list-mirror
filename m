From: Blind <stoycho.sleptsov@gmail.com>
Subject: Re: [RFC/PATCH] Introduce branch.<name>.pushremote
Date: Mon, 11 Feb 2013 08:16:50 +0200
Message-ID: <CAGL0X-rKnWBy-Ff=YmEdqgo8RFb40FXTxvUM5X77YaQvhAGHYg@mail.gmail.com>
References: <1360307982-20027-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 07:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4mhX-0008TL-Ta
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 07:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab3BKGQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 01:16:52 -0500
Received: from mail-ve0-f175.google.com ([209.85.128.175]:60404 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab3BKGQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 01:16:52 -0500
Received: by mail-ve0-f175.google.com with SMTP id cy12so4854930veb.34
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 22:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=lKTHqewmJMBazl4pbFeG+T5IliEiIrjheVOdm0l60nw=;
        b=KWOHLAD/AgktVL8lPydrppgA8VhFXDule1IVJGE1QDOwf3Z+5JdhiWARVOJhfAGd6M
         zEjrAE29hpJIAOEzWvwtBwJNi9th+0nb9FlzGAtq37mzpGw+Xh7MJL5zWNagsbyxnLi+
         oQ/L8gav8yNVRMBDqzSelCW5G1am1Or2i/fV3dHU8b3Pm6TQSZqQ6QAiy3y6ag+j6dOr
         p6xoRyJGe0lYs9rJ8fYd7noQeJFnBhQM583e7ZZopfA+r2xGunMliPtp+R7hcHNvaYiC
         VhSHOH99IsIgFbpRFRxurTRAZqgclf0pNRwTB5LcCNEnoS5crgqW3h06rI2qZm4JhUHG
         uHSw==
X-Received: by 10.52.90.243 with SMTP id bz19mr14895069vdb.112.1360563411018;
 Sun, 10 Feb 2013 22:16:51 -0800 (PST)
Received: by 10.58.55.228 with HTTP; Sun, 10 Feb 2013 22:16:50 -0800 (PST)
In-Reply-To: <1360307982-20027-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216003>

If I understand correctly,
in your scenario the branches with branch.<name>.pushremote
will be still included in the $git push <remote> --all?
Are you considering some way to exclude a branch from "push --all"
(branch.<name>.push = always, explicit, never... for example)?
Or maybe, if the branch is already marked as special
with branch.<name>.pushremote,
then it could be logical to push it only when is explicitly specified
on the command line (excluded from --all)?

Thanks,
Blind.

2013/2/8 Ramkumar Ramachandra <artagnon@gmail.com>:
> This new configuration variable overrides the remote in
> `branch.<name>.remote` for pushes.  It is useful in the typical
> scenario, where the remote I'm pulling from is not the remote I'm
> pushing to.  Although `remote.<name>.pushurl` is similar, it does not
> serve the purpose as the URL would lack corresponding remote tracking
> branches.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  This is a first cut.  There's code duplication at the moment, but I'm
>  currently trying to figure out which other remote_get() calls to
>  replace with pushremote_get().  Comments are welcome.
>
>  I will leave it to future patches to do the following things:
>  1. Fix the status output to be more meaningful when pushremote is
>  set.  At the moment, I'm thinking statuses like [pull: 4 behind,
>  push: 3 ahead] will make sense.
>  2. Introduce a remote.pushDefault (peff)
>  3. Introduce a remote.default (peff)
>
>  Documentation/config.txt |  6 ++++++
>  builtin/push.c           |  2 +-
>  remote.c                 | 41 +++++++++++++++++++++++++++++++++++++++++
>  remote.h                 |  2 ++
>  4 files changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 9b11597..0b3b1f8 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -727,6 +727,12 @@ branch.<name>.remote::
>         remote to fetch from/push to.  It defaults to `origin` if no remote is
>         configured. `origin` is also used if you are not on any branch.
>
> +branch.<name>.pushremote::
> +       When in branch <name>, it tells 'git push' which remote to
> +       push to.  It falls back to `branch.<name>.remote`, and
> +       defaults to `origin` if no remote is configured. `origin` is
> +       also used if you are not on any branch.
> +
>  branch.<name>.merge::
>         Defines, together with branch.<name>.remote, the upstream branch
>         for the given branch. It tells 'git fetch'/'git pull'/'git rebase' which
> diff --git a/builtin/push.c b/builtin/push.c
> index 42b129d..d447a80 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -322,7 +322,7 @@ static int push_with_options(struct transport *transport, int flags)
>  static int do_push(const char *repo, int flags)
>  {
>         int i, errs;
> -       struct remote *remote = remote_get(repo);
> +       struct remote *remote = pushremote_get(repo);
>         const char **url;
>         int url_nr;
>
> diff --git a/remote.c b/remote.c
> index e53a6eb..d6fcfc0 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -48,6 +48,7 @@ static int branches_nr;
>
>  static struct branch *current_branch;
>  static const char *default_remote_name;
> +static const char *pushremote_name;
>  static int explicit_default_remote_name;
>
>  static struct rewrites rewrites;
> @@ -363,6 +364,12 @@ static int handle_config(const char *key, const char *value, void *cb)
>                                 default_remote_name = branch->remote_name;
>                                 explicit_default_remote_name = 1;
>                         }
> +               } else if (!strcmp(subkey, ".pushremote")) {
> +                       if (!value)
> +                               return config_error_nonbool(key);
> +                       branch->pushremote_name = xstrdup(value);
> +                       if (branch == current_branch)
> +                               pushremote_name = branch->pushremote_name;
>                 } else if (!strcmp(subkey, ".merge")) {
>                         if (!value)
>                                 return config_error_nonbool(key);
> @@ -700,6 +707,40 @@ struct remote *remote_get(const char *name)
>         return ret;
>  }
>
> +struct remote *pushremote_get(const char *name)
> +{
> +       struct remote *ret;
> +       int name_given = 0;
> +
> +       read_config();
> +       if (name)
> +               name_given = 1;
> +       else {
> +               if (pushremote_name) {
> +                       name = pushremote_name;
> +                       name_given = 1;
> +               } else {
> +                       name = default_remote_name;
> +                       name_given = explicit_default_remote_name;
> +               }
> +       }
> +
> +       ret = make_remote(name, 0);
> +       if (valid_remote_nick(name)) {
> +               if (!valid_remote(ret))
> +                       read_remotes_file(ret);
> +               if (!valid_remote(ret))
> +                       read_branches_file(ret);
> +       }
> +       if (name_given && !valid_remote(ret))
> +               add_url_alias(ret, name);
> +       if (!valid_remote(ret))
> +               return NULL;
> +       ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr, ret->fetch_refspec);
> +       ret->push = parse_push_refspec(ret->push_refspec_nr, ret->push_refspec);
> +       return ret;
> +}
> +
>  int remote_is_configured(const char *name)
>  {
>         int i;
> diff --git a/remote.h b/remote.h
> index 251d8fd..aa42ff5 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -51,6 +51,7 @@ struct remote {
>  };
>
>  struct remote *remote_get(const char *name);
> +struct remote *pushremote_get(const char *name);
>  int remote_is_configured(const char *name);
>
>  typedef int each_remote_fn(struct remote *remote, void *priv);
> @@ -130,6 +131,7 @@ struct branch {
>         const char *refname;
>
>         const char *remote_name;
> +       const char *pushremote_name;
>         struct remote *remote;
>
>         const char **merge_name;
> --
> 1.8.1.2.545.g2f19ada.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
