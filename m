From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] builtin/remote: improve readability via strbuf_set()
Date: Thu, 12 Jun 2014 04:19:44 -0400
Message-ID: <CAPig+cR2x_nzRPzcOx+_8-+JZB_TegRaPrZUWXTOXBH27MnkMw@mail.gmail.com>
References: <cover.1402557437.git.jmmahler@gmail.com>
	<82aec34d46552c590e952af1e17614b9606ea3ef.1402557437.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 10:19:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv0Ei-0002f5-6E
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 10:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876AbaFLITs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 04:19:48 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:53010 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727AbaFLITp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 04:19:45 -0400
Received: by mail-yh0-f53.google.com with SMTP id b6so703218yha.26
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iu20Xj4jGlmOVlPoSWD+YiDFLhuBa6+jHCgyEqbkG9o=;
        b=0wCTYemzodaOmtXaD8n0uZWyYrSocr8vMEO7vzs1QoAMUvYT/vanhkjz/nYOP01LkA
         O35v8jjKXx/doZQdKIsH3YBYaWvZ7OfhSMUM0RtlCI2g8bYMR4EcDqdBJvV36tDzoR7H
         N9Cmi0fMfElYcheBXdz6sJb0K7inQzC5rA6HWZE/UTvb5DU51XFlvqdsum7nUCSW6ykT
         EajLviZUjAuMeaTOgOw2REAFp5XPopOfuaM9qbRIgsH5nUXi/DKgzax3NglThKz3392s
         PGXdDdeWoYZB2hscB6lyKGzdZEtBK/54xpVn8ndumGxINDVNbjGCg5OUHEtjYdTM/Ewc
         BcLQ==
X-Received: by 10.236.66.139 with SMTP id h11mr13487528yhd.30.1402561184598;
 Thu, 12 Jun 2014 01:19:44 -0700 (PDT)
Received: by 10.170.36.19 with HTTP; Thu, 12 Jun 2014 01:19:44 -0700 (PDT)
In-Reply-To: <82aec34d46552c590e952af1e17614b9606ea3ef.1402557437.git.jmmahler@gmail.com>
X-Google-Sender-Auth: 8X46Yal85H_QEO9IE_ujrYYqfJo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251402>

On Thu, Jun 12, 2014 at 3:29 AM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> builtin/remote.c has many cases where a strbuf was being set to a new
> value.  Improve its readability by using strbuf_set() operations instead
> of reset + add.
>
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  builtin/remote.c | 63 +++++++++++++++++++++-----------------------------------
>  1 file changed, 23 insertions(+), 40 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index c9b67ff..94f03e2 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -184,17 +184,16 @@ static int add(int argc, const char **argv)
>                         remote->fetch_refspec_nr))
>                 die(_("remote %s already exists."), name);
>
> -       strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
> +       strbuf_setf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
>         if (!valid_fetch_refspec(buf2.buf))
>                 die(_("'%s' is not a valid remote name"), name);
>
> -       strbuf_addf(&buf, "remote.%s.url", name);
> +       strbuf_setf(&buf, "remote.%s.url", name);
>         if (git_config_set(buf.buf, url))
>                 return 1;
>
>         if (!mirror || mirror & MIRROR_FETCH) {
> -               strbuf_reset(&buf);
> -               strbuf_addf(&buf, "remote.%s.fetch", name);
> +               strbuf_setf(&buf, "remote.%s.fetch", name);

This hunk nicely illustrates an important maintenance benefit of
strbuf_set() not mentioned as justification in patch 1/2. The original
programmer knew that 'buf' and 'buf2' had not yet been used, even
though their declarations are quite distant from this bit of code, so
he omitted the call to strbuf_reset(). Although the omission is valid,
it also is potentially dangerous and a maintenance burden. The person
who next inserts code which uses 'buf' or 'buf2' between here and the
declarations must remember or know to add strbuf_reset()s here, but
that's easily overlooked. strbuf_set() eliminates that burden.

This is the strongest argument I've thus far seen in favor of
strbuf_set() (though I'm not, in any way, suggesting you reroll the
series merely to mention this).

>                 if (track.nr == 0)
>                         string_list_append(&track, "*");
>                 for (i = 0; i < track.nr; i++) {
> @@ -205,15 +204,13 @@ static int add(int argc, const char **argv)
>         }
>
>         if (mirror & MIRROR_PUSH) {
> -               strbuf_reset(&buf);
> -               strbuf_addf(&buf, "remote.%s.mirror", name);
> +               strbuf_setf(&buf, "remote.%s.mirror", name);
>                 if (git_config_set(buf.buf, "true"))
>                         return 1;
>         }
>
>         if (fetch_tags != TAGS_DEFAULT) {
> -               strbuf_reset(&buf);
> -               strbuf_addf(&buf, "remote.%s.tagopt", name);
> +               strbuf_setf(&buf, "remote.%s.tagopt", name);
>                 if (git_config_set(buf.buf,
>                         fetch_tags == TAGS_SET ? "--tags" : "--no-tags"))
>                         return 1;
> @@ -223,11 +220,9 @@ static int add(int argc, const char **argv)
>                 return 1;
>
>         if (master) {
> -               strbuf_reset(&buf);
> -               strbuf_addf(&buf, "refs/remotes/%s/HEAD", name);
> +               strbuf_setf(&buf, "refs/remotes/%s/HEAD", name);
>
> -               strbuf_reset(&buf2);
> -               strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
> +               strbuf_setf(&buf2, "refs/remotes/%s/%s", name, master);
>
>                 if (create_symref(buf.buf, buf2.buf, "remote add"))
>                         return error(_("Could not setup master '%s'"), master);
> @@ -584,19 +579,17 @@ static int migrate_file(struct remote *remote)
>         int i;
>         const char *path = NULL;
>
> -       strbuf_addf(&buf, "remote.%s.url", remote->name);
> +       strbuf_setf(&buf, "remote.%s.url", remote->name);
>         for (i = 0; i < remote->url_nr; i++)
>                 if (git_config_set_multivar(buf.buf, remote->url[i], "^$", 0))
>                         return error(_("Could not append '%s' to '%s'"),
>                                         remote->url[i], buf.buf);
> -       strbuf_reset(&buf);
> -       strbuf_addf(&buf, "remote.%s.push", remote->name);
> +       strbuf_setf(&buf, "remote.%s.push", remote->name);
>         for (i = 0; i < remote->push_refspec_nr; i++)
>                 if (git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0))
>                         return error(_("Could not append '%s' to '%s'"),
>                                         remote->push_refspec[i], buf.buf);
> -       strbuf_reset(&buf);
> -       strbuf_addf(&buf, "remote.%s.fetch", remote->name);
> +       strbuf_setf(&buf, "remote.%s.fetch", remote->name);
>         for (i = 0; i < remote->fetch_refspec_nr; i++)
>                 if (git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0))
>                         return error(_("Could not append '%s' to '%s'"),
> @@ -640,27 +633,24 @@ static int mv(int argc, const char **argv)
>         if (newremote && (newremote->url_nr > 1 || newremote->fetch_refspec_nr))
>                 die(_("remote %s already exists."), rename.new);
>
> -       strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new);
> +       strbuf_setf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new);
>         if (!valid_fetch_refspec(buf.buf))
>                 die(_("'%s' is not a valid remote name"), rename.new);
>
> -       strbuf_reset(&buf);
> -       strbuf_addf(&buf, "remote.%s", rename.old);
> -       strbuf_addf(&buf2, "remote.%s", rename.new);
> +       strbuf_setf(&buf, "remote.%s", rename.old);
> +       strbuf_setf(&buf2, "remote.%s", rename.new);
>         if (git_config_rename_section(buf.buf, buf2.buf) < 1)
>                 return error(_("Could not rename config section '%s' to '%s'"),
>                                 buf.buf, buf2.buf);
>
> -       strbuf_reset(&buf);
> -       strbuf_addf(&buf, "remote.%s.fetch", rename.new);
> +       strbuf_setf(&buf, "remote.%s.fetch", rename.new);
>         if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
>                 return error(_("Could not remove config section '%s'"), buf.buf);
> -       strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
> +       strbuf_setf(&old_remote_context, ":refs/remotes/%s/", rename.old);
>         for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
>                 char *ptr;
>
> -               strbuf_reset(&buf2);
> -               strbuf_addstr(&buf2, oldremote->fetch_refspec[i]);
> +               strbuf_setstr(&buf2, oldremote->fetch_refspec[i]);
>                 ptr = strstr(buf2.buf, old_remote_context.buf);
>                 if (ptr) {
>                         refspec_updated = 1;
> @@ -683,8 +673,7 @@ static int mv(int argc, const char **argv)
>                 struct string_list_item *item = branch_list.items + i;
>                 struct branch_info *info = item->util;
>                 if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
> -                       strbuf_reset(&buf);
> -                       strbuf_addf(&buf, "branch.%s.remote", item->string);
> +                       strbuf_setf(&buf, "branch.%s.remote", item->string);
>                         if (git_config_set(buf.buf, rename.new)) {
>                                 return error(_("Could not set '%s'"), buf.buf);
>                         }
> @@ -715,12 +704,10 @@ static int mv(int argc, const char **argv)
>
>                 if (item->util)
>                         continue;
> -               strbuf_reset(&buf);
> -               strbuf_addstr(&buf, item->string);
> +               strbuf_setstr(&buf, item->string);
>                 strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
>                                 rename.new, strlen(rename.new));
> -               strbuf_reset(&buf2);
> -               strbuf_addf(&buf2, "remote: renamed %s to %s",
> +               strbuf_setf(&buf2, "remote: renamed %s to %s",
>                                 item->string, buf.buf);
>                 if (rename_ref(item->string, buf.buf, buf2.buf))
>                         die(_("renaming '%s' failed"), item->string);
> @@ -730,16 +717,13 @@ static int mv(int argc, const char **argv)
>
>                 if (!item->util)
>                         continue;
> -               strbuf_reset(&buf);
> -               strbuf_addstr(&buf, item->string);
> +               strbuf_setstr(&buf, item->string);
>                 strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
>                                 rename.new, strlen(rename.new));
> -               strbuf_reset(&buf2);
> -               strbuf_addstr(&buf2, item->util);
> +               strbuf_setstr(&buf2, item->util);
>                 strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old),
>                                 rename.new, strlen(rename.new));
> -               strbuf_reset(&buf3);
> -               strbuf_addf(&buf3, "remote: renamed %s to %s",
> +               strbuf_setf(&buf3, "remote: renamed %s to %s",
>                                 item->string, buf.buf);
>                 if (create_symref(buf.buf, buf2.buf, buf3.buf))
>                         die(_("creating '%s' failed"), buf.buf);
> @@ -804,8 +788,7 @@ static int rm(int argc, const char **argv)
>                 if (info->remote_name && !strcmp(info->remote_name, remote->name)) {
>                         const char *keys[] = { "remote", "merge", NULL }, **k;
>                         for (k = keys; *k; k++) {
> -                               strbuf_reset(&buf);
> -                               strbuf_addf(&buf, "branch.%s.%s",
> +                               strbuf_setf(&buf, "branch.%s.%s",
>                                                 item->string, *k);
>                                 if (git_config_set(buf.buf, NULL)) {
>                                         strbuf_release(&buf);
> --
> 2.0.0
>
