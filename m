Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CA0EB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 22:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGTWhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 18:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjGTWhs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 18:37:48 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91302E65
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 15:37:47 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-565f3881cbeso905304eaf.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 15:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689892667; x=1690497467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwTdL6R9nB5ujd4aPaKqETclsHXrdHY1dtw39MQ2Cwc=;
        b=E4R3KCZV7KCixwq8fKtUv0/GfN/CgO25C9qR1/O/Q0LxX4sMbG0rHMgYVT3mrgCh4V
         2sO3RmYlfs4mfVmNVRHLbP+0/BUJBcdEsiOwDifnc+VkXwF7Cn2ebNjeVTnW/fkwGI0e
         3CecTbhMK982bdDmI/tAEEd/FW7SC176E6xO7FqUmk0M5dx9Y+Jktx3mioEWfRLZaNEu
         e5Q9uOAtMcZbDb9Fv5KVN7o5QBAgOxE1uIk0MlWnq0za3RPLnoOuwyAsUoLV/QJT17z1
         o87GweajRmmrwV6kfN5sFh+IF6ERQeZDJqpzK3UL12mhG3bN2elcbWP/jnYPJ/KXqt1G
         4A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689892667; x=1690497467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwTdL6R9nB5ujd4aPaKqETclsHXrdHY1dtw39MQ2Cwc=;
        b=XBZRMZq/TWhyc9UjgjiUNWhgj+++JZbXSysw6DmLp7jkSyoJ55W6/EhGHyrhaG7edJ
         GvbRiPCm7ZDadv9pzmRBWT4xdkYUS0wZNIY6H3F/L7GYXNxW+ab8yZwl2ZRyRrGHscSl
         Kn2KP7QojpIZDYlP0TNpTmQXiuzaOcBMmdBk2NlGfO5rcYPzN4xkgp0UJ9QKRrflkPK5
         LhsWWlsft7H32XUCaO1fQLo13KuZTAthmljeVQrq2Dp+F4OgHm2j5pHysT66R4Y5sZie
         FKSYnBu+p6uDYwlUXa37dyVWcIZaD7650pB67yYFap1Z13LtwHkDSATnJZsDtsBZ20FV
         aBpw==
X-Gm-Message-State: ABy/qLa9CDsB8+jY9M3aY+A6zNZTUpSNz95w9Lv0cifGJzfJv+osOVJf
        e5kswMDyeTOUWvNaIrTKUCk/Z4b7qvrR8WEUutE=
X-Google-Smtp-Source: APBJJlG+5xTsocXe4kbSI9Tb3bTjz/Ra2CnQf/uGnxoSaDdkQYPKVZzwvfzYpFHJyF7Ai4sxRh61YDS9Ede771k+hrU=
X-Received: by 2002:a4a:6c1b:0:b0:565:97f9:d2fb with SMTP id
 q27-20020a4a6c1b000000b0056597f9d2fbmr195455ooc.3.1689892666605; Thu, 20 Jul
 2023 15:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230719144339.447852-1-alexhenrie24@gmail.com> <395274b4-37a9-8c95-203f-94178c99772a@gmail.com>
In-Reply-To: <395274b4-37a9-8c95-203f-94178c99772a@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 20 Jul 2023 16:37:00 -0600
Message-ID: <CAMMLpeSN_M1HW1D3HyuY+S+GwUrQ_4dP9qoSQ72hbQv3pwK5kg@mail.gmail.com>
Subject: Re: [PATCH] sequencer: finish parsing the todo list despite an
 invalid first line
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2023 at 3:42=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:

> On 19/07/2023 15:43, Alex Henrie wrote:
> > ddb81e5072 (rebase-interactive: use todo_list_write_to_file() in
> > edit_todo_list(), 2019-03-05) made edit_todo_list more efficient by
> > replacing transform_todo_file with todo_list_parse_insn_buffer.
> > Unfortunately, that innocuous change caused a regression because
> > todo_list_parse_insn_buffer would stop parsing after encountering an
> > invalid 'fixup' line. If the user accidentally made the first line a
> > 'fixup' and tried to recover from their mistake with `git rebase
> > --edit-todo`, all of the commands after the first would be lost.
>
> I found this description a little confusing as transform_todo_file()
> also called todo_list_parse_insn_buffer(). transform_todo_file() does
> not exist anymore but it looked like
>
> static int transform_todo_file(unsigned flags)
> {
>          const char *todo_file =3D rebase_path_todo();
>          struct todo_list todo_list =3D TODO_LIST_INIT;
>          int res;
>
>          if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>                  return error_errno(_("could not read '%s'."), todo_file)=
;
>
>          if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.bu=
f,
>                                          &todo_list)) {
>                  todo_list_release(&todo_list);
>                  return error(_("unusable todo list: '%s'"), todo_file);
>          }
>
>          res =3D todo_list_write_to_file(the_repository, &todo_list,
> todo_file,
>                                        NULL, NULL, -1, flags);
>          todo_list_release(&todo_list);
>
>          if (res)
>                  return error_errno(_("could not write '%s'."), todo_file=
);
>          return 0;
> }
>
> If it could not parse the todo list it did not try and write it to disc.
> After ddb81e5072 this changed as edit_todo_list() tries to shorten the
> OIDs in the todo list before it is edited even if it cannot be parsed.
> The fix below works around that by making sure we always try and parse
> the whole todo list even if the the first line is a fixup command. That
> is a worthwhile improvement because it means we notify the user of all
> the errors we find rather than just the first one and is in keeping with
> the way we handle other invalid lines. It does not however fix the root
> cause of this regression which is the change in behavior in
> edit_todo_list().
>
> After the user edits the todo file we do not try to transform the OIDs
> if it cannot be parsed or has missing commits. Therefore it still
> contains the shortened OIDs and editing hints and there is no need for
> edit_todo_list() to call write_todo_list() when "incorrect" is true.

When the user first runs `git rebase`, the commit template contains
the following message:

# However, if you remove everything, the rebase will be aborted.

When running `git rebase --edit-todo`, that message is replaced with:

# You are editing the todo file of an ongoing interactive rebase.
# To continue rebase after editing, run:
#     git rebase --continue

The second message is indeed more accurate after the rebase has
started: Deleting all of the lines in `git rebase --edit-todo` drops
all of the commits; it does not abort the rebase.

It would be nice to preserve as much of the user's original input as
possible, but that's not a project that I'm going to tackle. As far as
a minimal fix for the regression, we can either leave the todo file
untouched and display inaccurate advice during `git rebase
--edit-todo`, or we can lose any long commit IDs that the user entered
and display equivalent short hex IDs instead. I would prefer the
latter.

> > +test_expect_success 'the first command cannot be a fixup' '
> > +     # When using `git rebase --edit-todo` to recover from this error,=
 ensure
> > +     # that none of the original todo list is lost
> > +     rebase_setup_and_clean fixup-first &&
> > +     (
> > +             set_fake_editor &&
> > +             test_must_fail env FAKE_LINES=3D"fixup 1 2 3 4 5" \
> > +                            git rebase -i --root 2>actual &&
>
> Thanks for taking the time to add a test. It is not worth a re-roll on
> its own, but there is no need to use "--root" here. It is confusing as
> it is not clear if we're refusing "fixup" as the first command because
> we're rewriting the root commit or if we always refuse to have "fixup"
> as the first command.

Good point. I used --root because I copied and pasted from the
preceding test, but HEAD~4 would make the intent of the test more
clear. That change and the grep change that Junio suggested are
probably worth a v2.

> > +             test_i18ngrep "cannot .fixup. without a previous commit" =
\
> > +                             actual &&
> > +             test_i18ngrep "You can fix this with .git rebase --edit-t=
odo.." \
> > +                             actual &&
> > +             grep -v "^#" .git/rebase-merge/git-rebase-todo >orig &&
> > +             test_must_fail git rebase --edit-todo &&
> > +             grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
> > +             test_cmp orig actual
>
> We check that the uncommitted lines after running "git rebase
> --edit-todo" match the uncommitted lines after the initial edit. That's
> fine to detect if the second edit truncates the file but it will still
> pass if the initial edit starts truncating the todo list as well. As we
> expect that git should not change an incorrect todo list we do not need
> to filter out the lines beginning with "#".
>
> To ensure we detect a regression where the first edit truncates the todo
> list we could do something like
>
>         test_when_finished "git rebase --abort" &&
>         cat >todo <<-EOF &&
>         fixup $(git log -1 --format=3D"%h %s" B)
>         pick $(git log -1 --format=3D"%h %s" C)
>         EOF
>
>         (
>                 set_replace_editor todo &&
>                 test_must_fail git rebase -i A 2>actual
>         ) &&
>         test_i18ngrep "cannot .fixup. without a previous commit" actual &=
&
>         test_i18ngrep "You can fix this with .git rebase --edit-todo.." a=
ctual &&
>         # check initial edit has not truncated todo list
>         grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
>         test_cmp todo actual &&
>         cat .git/rebase-merge/git-rebase-todo >expect &&
>         test_must_fail git rebase --edit-todo &&
>         # check the list is unchanged by --edit-todo
>         test_cmp expect .git/rebase-merge/git-rebase-todo

To me it seems pretty far-fetched that a future bug would cause the
_initial_ commit template to be missing anything. But if you're
concerned about it, would you like to send a follow-up patch to revise
the test as you see fit?

> We could perhaps check the error message from "git rebase --edit-todo"
> as well.

That sounds like another good change for v2.

Thanks for the feedback,

-Alex
