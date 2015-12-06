From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/5] config.c: move worktree-specific variables to .git/worktrees/...
Date: Sun, 6 Dec 2015 02:47:27 -0500
Message-ID: <CAPig+cST=UGG8VAG94qb9M8vcOXfmWAhLoP65yWJGywR9R84LA@mail.gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
	<1449083626-20075-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 08:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5U34-0003Ds-CO
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 08:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbbLFHrn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2015 02:47:43 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34762 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbbLFHr2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2015 02:47:28 -0500
Received: by vkbs1 with SMTP id s1so87259389vkb.1
        for <git@vger.kernel.org>; Sat, 05 Dec 2015 23:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=PiSQiy4kkiO0b+sKPvIBa71O2dpVUI54khWpxwn98hg=;
        b=n12ND4oShFpkHr6HRGGm0ZyGuI/iRAW9R/nKZ+910F7k+nyBYO8ChlmogdkJ6eSCt5
         g+MgJjtabJJbT2PnRpepfdqLn7dkfmiCCXlkoVDWA4lyCTIcgr4THu2dQAZk/DnUJcYI
         ZgD291vl6RNqjRZ59bnD9w2R2jm69LqxljUH19LGSEU68bkHtJF78jKFQA7ltOJwrEB0
         8yjhPwIBTjSGs22QRCua2oxKwnaWBCQQyrO1SkfGJWPpb7rCUKA4+s4XVtVUbly4vg3N
         925ZfpVoMjJV5sDe1mhe3SgOBJzcf37jJMstlUZcd9Jdolad4bf3txNc62aT7V2qxeyo
         Yeng==
X-Received: by 10.31.58.142 with SMTP id h136mr16760352vka.115.1449388047240;
 Sat, 05 Dec 2015 23:47:27 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 5 Dec 2015 23:47:27 -0800 (PST)
In-Reply-To: <1449083626-20075-3-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: RgCyY3pEIcOYA4-9rRPtx5hOPBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282044>

On Wed, Dec 2, 2015 at 2:13 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> .git/info/config.worktree is a pattern list that splits .git/config i=
n
> to sets: the worktree set matches the patterns, the commmon set does
> not.
>
> In normal worktrees, both sets are stored in .git/config. The
> config.worktree has no effect. Nothing is changed.
>
> In linked worktrees, the common and worktree sets are read from and
> saved to .git/config and .git/config.worktree respectively. Config
> keys in .git/config that belong to the worktree set is ignored. Those
> are for the main worktree only. Similarly, keys not matching the
> patterns come from .git/config, duplicate keys from
> .git/config.worktree are ignored.
>
> The effect is similar to the $GIT_DIR/$GIT_COMMON_DIR split, we can
> define that some vars can be shared and some cannot. And as a result
> of the $GIT_DIR/$GIT_COMMON_DIR split, config.worktree is actually
> found at .git/worktrees/<id>/config.worktree.

Why does this worktree-specific file need/have a .worktree suffix?

> Throwing the exclude mechanism into this means reading config files
> will be slower. But unless somebody reads thousands of keys, it shoul=
d
> not be noticable. The nice thing is we don't have to introduce yet
> another pattern syntax.
>
> In future, we might want to have a shared config file to contain
> common worktree-specific settings, so that we have some good defaults=
,
> but still allow customization. Or we could twist the above logic a
> bit: for linked worktrees, read _all_ variables in config.worktree
> regardless of the patterns. But let's wait and see..
>
> Helped-by: Max Kirillov <max@max630.net>
> Helped-by: Jens Lehmann <Jens.Lehmann@web.de>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/config.c b/config.c
> @@ -89,6 +91,73 @@ static long config_buf_ftell(struct config_source =
*conf)
> +static void load_info_config_worktree(void)
> +{
> +       struct exclude_list *el =3D &config_local;
> +       struct strbuf sb =3D STRBUF_INIT;
> +       int i, lineno =3D 1;
> +       char *buf, *entry;
> +       size_t size;
> +
> +       clear_exclude_list(el);
> +
> +       if (strbuf_read_file(&sb,
> +                            git_path("info/config.worktree"),
> +                            128) <=3D 0) {
> +               strbuf_release(&sb);
> +               return;
> +       }
> +       strbuf_addch(&sb, '\n');
> +       el->filebuf =3D buf =3D strbuf_detach(&sb, &size);
> +
> +       for (i =3D 0; i < size; i++)
> +               if (buf[i] =3D=3D '.')
> +                       buf[i] =3D '/';
> +               else
> +                       buf[i] =3D tolower(buf[i]);
> +
> +       entry =3D buf;
> +       for (i =3D 0; i < size; i++) {
> +               if (buf[i] =3D=3D '\n') {
> +                       if (entry !=3D buf + i && entry[0] !=3D '#') =
{
> +                               buf[i - (i && buf[i-1] =3D=3D '\r')] =
=3D 0;
> +                               trim_trailing_spaces(entry);
> +                               add_exclude(entry, "", 0, el, lineno)=
;
> +                       }
> +                       lineno++;
> +                       entry =3D buf + i + 1;
> +               }
> +       }
> +
> +       /*
> +        * avoid base name matching because it may confusion in

s/may/may cause/

> +        * non-directory context.
> +        */
> +       for (i =3D 0; i < el->nr; i++)
> +               el->excludes[i]->flags &=3D ~EXC_FLAG_NODIR;
> +}
> +
> +static int is_config_local(const char *key_)
> +{
> +       static struct strbuf key =3D STRBUF_INIT;
> +       int i, dtype;
> +
> +       if (!config_local.nr)
> +               return 0;
> +
> +       strbuf_reset(&key);
> +       strbuf_addstr(&key, key_);

Why does 'key' need to be static considering that it is overwritten on
each call and its value is never accessed after the function returns?

> +       for (i =3D 0; i < key.len; i++) {
> +               if (key.buf[i] =3D=3D '.')
> +                       key.buf[i] =3D '/';
> +               else
> +                       key.buf[i] =3D tolower(key.buf[i]);
> +       }
> +       dtype =3D DT_REG;
> +       return is_excluded_from_list(key.buf, key.len, "", &dtype,
> +                                    &config_local) > 0;
> +}
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> @@ -198,4 +198,30 @@ test_expect_success 'local clone from linked che=
ckout' '
> +test_expect_success 'setting worktree.foo goes to config.worktree' '
> +       echo worKtree.Foo >> .git/info/config.worktree &&

Perhaps? s/>> />/

> +       git worktree add wt.foo HEAD &&
> +       git config woRKtree.FOO barrrr &&
> +       git --git-dir=3Dwt.foo/.git config woRKtree.FOO bar &&
> +       cat >expect <<\EOF &&
> +[woRKtree]
> +       FOO =3D bar
> +EOF
> +       test_cmp expect .git/worktrees/wt.foo/config.worktree &&
> +       git --git-dir=3Dwt.foo/.git config woRktree.foo >actual2 &&
> +       echo bar >expect2 &&
> +       test_cmp expect2 actual2 &&
> +       test_path_is_missing .git/config.worktree &&
> +       git config WORKTREE.FOO >actual3 &&
> +       echo barrrr >expect3 &&
> +       test_cmp expect3 actual3
> +'
> +
> +test_expect_success 'shared config still goes to config' '
> +       git config random.key randomValue &&
> +       git --git-dir=3Dwt.foo/.git config random.key >actual &&

What about also testing the opposite scenario?

    git --git-dir=3Dwt.foo/.git  config random.key randomValue &&
    git config random.key >actual &&

> +       echo randomValue >expect &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.2.0.513.g477eb31
