Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D412C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 09:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F3824658
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 09:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="esLjQgR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfLLJjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:39:09 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40991 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbfLLJjI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:08 -0500
Received: by mail-vk1-f196.google.com with SMTP id p191so213614vkf.8
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 01:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVf/3r4gnAN/LLjGWiXF8CMVWuvrhsoa9qtySoK+M90=;
        b=esLjQgR5vE2DPEgLl5z/Uiffc7IfoOswraJ0VlmW9vDz0UG+noZad9AxMVlnBam9lk
         Uh08oeMLBqCYaKXJo8skdjtjiQWBL8ZAdmlfav0ge6xV6+cWUx9e7Fm7pU7os2Tuky78
         tWEZhqKiDWRAbL/oYpYZT7yFdZt5xF0HuYQn+tphE6zbOzAQV+2j9LYH2Wxf1+62k6HM
         1rLiWBc+4hw+bpj7xZAWhK9bDE86QWhYvMjYDSUNc2lNQ5oPrHAH4CNI47FF2zH2p42K
         R+VpvIYu5X8fFcYZJc1T5Gs5q9tx3fAGEJqbOiUku7mea4/AsuHHrYyvKE5Xom4UBBhM
         zjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVf/3r4gnAN/LLjGWiXF8CMVWuvrhsoa9qtySoK+M90=;
        b=nrATQeSEhsgUTdnqpDWPvmzV8xxedFoVK/szdIeyeqZ1rPe7N+DkkaPNAsBqCF8oVC
         CZNG4PCYmZFFDmSglgiQKFe316JCwksJp2r0tBWmDt0MqjnRxwbm4quZ5ULskobGobFZ
         vKWHxkRA9PPcHe4yMBLiHFQFWF8l+D34IIDB0u4X2Fc8mscCzlsKfJ0tQPgm0NHL9Zkp
         thGfC+a04DSmvk3LEMi25MW7XMRp427XhkApo2Bu3pVt2Uy9GXZfZVnHnM7Q4Fn9XQhk
         oCuDEguIOFFWwAQn0cOpyspmU7THNDxhnVl+66IUaVKeYSCUSayT5jSclk6g6J813glL
         vW+A==
X-Gm-Message-State: APjAAAUXr/Nv1yE/1WEAHh3lNU586+z8pcWG/E2mdXJtyxN27IlZXxNG
        YjOSMH/l5Zsu308/1znNP5b0EbdaVqhq/bDtFJpTOLfg
X-Google-Smtp-Source: APXvYqxLvZCq3XyVA/Qc7AMxUsQINLIlElM+KFiDWc0E8G6k4ypPkh/fWHL7OWTQ4JhkwmF/gRhJbpEV2oK4o3ashdA=
X-Received: by 2002:a1f:6ac3:: with SMTP id f186mr7827998vkc.23.1576143547218;
 Thu, 12 Dec 2019 01:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com> <20191210023335.49987-4-emilyshaffer@google.com>
In-Reply-To: <20191210023335.49987-4-emilyshaffer@google.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 12 Dec 2019 10:38:55 +0100
Message-ID: <CAKPyHN04hEK7PKZQvF7LkGPkbBnV2jccBAxJSiukrXb=4g4g_Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] hook: add --list mode
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 3:34 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> Teach 'git hook --list <hookname>', which checks the known configs in
> order to create an ordered list of hooks to run on a given hook event.
>
> The hook config format is "hook.<hookname> = <order>:<path-to-hook>".
> This paves the way for multiple hook support; hooks should be run in the
> order specified by the user in the config, and in the case of an order
> number collision, configuration order should be used (e.g. global hook
> 004 will run before repo hook 004).
>
> For example:
>
>   $ grep -A2 "\[hook\]" ~/.gitconfig
>   [hook]
>           pre-commit = 001:~/test.sh
>           pre-commit = 999:~/baz.sh
>
>   $ grep -A1 "\[hook\]" ~/git/.git/config
>   [hook]
>           pre-commit = 900:~/bar.sh
>
>   $ ./bin-wrappers/git hook --list pre-commit
>   001     global  ~/test.sh
>   900     repo    ~/bar.sh
>   999     global  ~/baz.sh
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/git-hook.txt    | 17 +++++++-
>  Makefile                      |  1 +
>  builtin/hook.c                | 54 ++++++++++++++++++++++-
>  hook.c                        | 81 +++++++++++++++++++++++++++++++++++
>  hook.h                        | 14 ++++++
>  t/t1360-config-based-hooks.sh | 43 ++++++++++++++++++-
>  6 files changed, 206 insertions(+), 4 deletions(-)
>  create mode 100644 hook.c
>  create mode 100644 hook.h
>
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> index 2d50c414cc..a141884239 100644
> --- a/Documentation/git-hook.txt
> +++ b/Documentation/git-hook.txt
> @@ -8,12 +8,27 @@ git-hook - Manage configured hooks
>  SYNOPSIS
>  --------
>  [verse]
> -'git hook'
> +'git hook' -l | --list <hook-name>
>
>  DESCRIPTION
>  -----------
>  You can list, add, and modify hooks with this command.
>
> +This command parses the default configuration files for lines which look like
> +"hook.<hook-name> = <order number>:<hook command>", e.g. "hook.pre-commit =
> +010:/path/to/script.sh". In this way, multiple scripts can be run during a
> +single hook. Hooks are sorted in ascending order by order number; in the event
> +of an order number conflict, they are sorted in configuration order.
> +
> +OPTIONS
> +-------
> +
> +-l::
> +--list::
> +       List the hooks which have been configured for <hook-name>. Hooks appear
> +       in the order they should be run. Output of this command follows the
> +       format '<order number> <origin config> <hook command>'.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index 83263505c0..21b3a82208 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -892,6 +892,7 @@ LIB_OBJS += hashmap.o
>  LIB_OBJS += linear-assignment.o
>  LIB_OBJS += help.o
>  LIB_OBJS += hex.o
> +LIB_OBJS += hook.o
>  LIB_OBJS += ident.o
>  LIB_OBJS += interdiff.o
>  LIB_OBJS += json-writer.o
> diff --git a/builtin/hook.c b/builtin/hook.c
> index b2bbc84d4d..8261302b27 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -1,21 +1,73 @@
>  #include "cache.h"
>
>  #include "builtin.h"
> +#include "config.h"
> +#include "hook.h"
>  #include "parse-options.h"
> +#include "strbuf.h"
>
>  static const char * const builtin_hook_usage[] = {
> -       N_("git hook"),
> +       N_("git hook --list <hookname>"),

Its "<hook-name>" in Documentation/git-hook.txt

>         NULL
>  };
>
> +enum hook_command {
> +       HOOK_NO_COMMAND = 0,
> +       HOOK_LIST,
> +};
> +
> +static int print_hook_list(const struct strbuf *hookname)
> +{
> +       struct list_head *head, *pos;
> +       struct hook *item;
> +
> +       head = hook_list(hookname);
> +
> +       list_for_each(pos, head) {
> +               item = list_entry(pos, struct hook, list);
> +               if (item)
> +                       printf("%.3d\t%s\t%s\n", item->order,
> +                              config_scope_to_string(item->origin),
> +                              item->command.buf);
> +       }
> +
> +       return 0;
> +}
> +
>  int cmd_hook(int argc, const char **argv, const char *prefix)
>  {
> +       enum hook_command command = 0;
> +       struct strbuf hookname = STRBUF_INIT;
> +
>         struct option builtin_hook_options[] = {
> +               OPT_CMDMODE('l', "list", &command,
> +                           N_("list scripts which will be run for <hookname>"),


Its "<hook-name>" in Documentation/git-hook.txt
> +                           HOOK_LIST),
>                 OPT_END(),
>         };
>
>         argc = parse_options(argc, argv, prefix, builtin_hook_options,
>                              builtin_hook_usage, 0);
>
> +       if (argc < 1) {
> +               usage_msg_opt("a hookname must be provided to operate on.",
> +                             builtin_hook_usage, builtin_hook_options);
> +       }
> +
> +       strbuf_addstr(&hookname, "hook.");
> +       strbuf_addstr(&hookname, argv[0]);

The arg is never checked, if this is a valid/known hook.

Bert

> +
> +       switch(command) {
> +               case HOOK_LIST:
> +                       return print_hook_list(&hookname);
> +                       break;
> +               default:
> +                       usage_msg_opt("no command given.", builtin_hook_usage,
> +                                     builtin_hook_options);
> +       }
> +
> +       clear_hook_list();
> +       strbuf_release(&hookname);
> +
>         return 0;
>  }
> diff --git a/hook.c b/hook.c
> new file mode 100644
> index 0000000000..f8d1109084
> --- /dev/null
> +++ b/hook.c
> @@ -0,0 +1,81 @@
> +#include "cache.h"
> +
> +#include "hook.h"
> +#include "config.h"
> +
> +static LIST_HEAD(hook_head);
> +
> +void free_hook(struct hook *ptr)
> +{
> +       if (ptr) {
> +               strbuf_release(&ptr->command);
> +               free(ptr);
> +       }
> +}
> +
> +static void emplace_hook(struct list_head *pos, int order, const char *command)
> +{
> +       struct hook *to_add = malloc(sizeof(struct hook));
> +       to_add->order = order;
> +       to_add->origin = current_config_scope();
> +       strbuf_init(&to_add->command, 0);
> +       strbuf_addstr(&to_add->command, command);
> +
> +       list_add_tail(&to_add->list, pos);
> +}
> +
> +static void remove_hook(struct list_head *to_remove)
> +{
> +       struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
> +       list_del(to_remove);
> +       free_hook(hook_to_remove);
> +}
> +
> +void clear_hook_list()
> +{
> +       struct list_head *pos, *tmp;
> +       list_for_each_safe(pos, tmp, &hook_head)
> +               remove_hook(pos);
> +}
> +
> +static int check_config_for_hooks(const char *var, const char *value, void *hookname)
> +{
> +       struct list_head *pos, *p;
> +       struct hook *item;
> +       const struct strbuf *hookname_strbuf = hookname;
> +
> +       if (!strcmp(var, hookname_strbuf->buf)) {
> +               int order = 0;
> +               // TODO this is bad - open to overflows
> +               char command[256];
> +               int added = 0;
> +               if (!sscanf(value, "%d:%s", &order, command))
> +                       die(_("hook config '%s' doesn't match expected format"),
> +                           value);
> +
> +               list_for_each_safe(pos, p, &hook_head) {
> +                       item = list_entry(pos, struct hook, list);
> +
> +                       /*
> +                        * the new entry should go just before the first entry
> +                        * which has a higher order number than it.
> +                        */
> +                       if (item->order > order && !added) {
> +                               emplace_hook(pos, order, command);
> +                               added = 1;
> +                       }
> +               }
> +
> +               if (!added)
> +                       emplace_hook(pos, order, command);
> +       }
> +
> +       return 0;
> +}
> +
> +struct list_head* hook_list(const struct strbuf* hookname)
> +{
> +       git_config(check_config_for_hooks, (void*)hookname);
> +
> +       return &hook_head;
> +}
> diff --git a/hook.h b/hook.h
> new file mode 100644
> index 0000000000..104df4c088
> --- /dev/null
> +++ b/hook.h
> @@ -0,0 +1,14 @@
> +#include "config.h"
> +
> +struct hook
> +{
> +       struct list_head list;
> +       int order;
> +       enum config_scope origin;
> +       struct strbuf command;
> +};
> +
> +struct list_head* hook_list(const struct strbuf *hookname);
> +
> +void free_hook(struct hook *ptr);
> +void clear_hook_list();
> diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
> index 34b0df5216..1434051db3 100755
> --- a/t/t1360-config-based-hooks.sh
> +++ b/t/t1360-config-based-hooks.sh
> @@ -4,8 +4,47 @@ test_description='config-managed multihooks, including git-hook command'
>
>  . ./test-lib.sh
>
> -test_expect_success 'git hook command does not crash' '
> -       git hook
> +test_expect_success 'git hook rejects commands without a mode' '
> +       test_must_fail git hook pre-commit
> +'
> +
> +
> +test_expect_success 'git hook rejects commands without a hookname' '
> +       test_must_fail git hook --list
> +'
> +
> +test_expect_success 'setup hooks in system, global, and local' '
> +       git config --add --global hook.pre-commit "010:/path/def" &&
> +       git config --add --global hook.pre-commit "999:/path/uvw" &&
> +
> +       git config --add --local hook.pre-commit "100:/path/ghi" &&
> +       git config --add --local hook.pre-commit "990:/path/rst"
> +'
> +
> +test_expect_success 'git hook --list orders by order number' '
> +       cat >expected <<-\EOF &&
> +       010     global  /path/def
> +       100     repo    /path/ghi
> +       990     repo    /path/rst
> +       999     global  /path/uvw
> +       EOF
> +
> +       git hook --list pre-commit >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'order number collisions resolved in config order' '
> +       cat >expected <<-\EOF &&
> +       010     global  /path/def
> +       010     repo    /path/abc
> +       100     repo    /path/ghi
> +       990     repo    /path/rst
> +       999     global  /path/uvw
> +       EOF
> +
> +       git config --add --local hook.pre-commit "010:/path/abc" &&
> +       git hook --list pre-commit >actual &&
> +       test_cmp expected actual
>  '
>
>  test_done
> --
> 2.24.0.393.g34dc348eaf-goog
>
