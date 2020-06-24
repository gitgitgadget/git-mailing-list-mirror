Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ABBC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 21:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69BE20836
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 21:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390723AbgFXVxo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 24 Jun 2020 17:53:44 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43455 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390681AbgFXVxo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 17:53:44 -0400
Received: by mail-wr1-f49.google.com with SMTP id j4so1286903wrp.10
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 14:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a4V1MOn8T+guldUdSFCUHOcKatuv4nCQFUjoQ5ylC04=;
        b=U+uexMdV5OoC8KFCJRSMSC1+5pSsdRfMrlw+A+K3tDHhczRZ4smhxCLy1rDyWFuPM2
         q4rz9YsvLTiez+qn+VXfNaMflApphYBCQc5pu0t10+/uvlIHP95Yduw/7V8mZUWHQU5a
         +nI6LtC3H3pOvuSx+w2J4JKanR7Ph6cV4BuhCaDDqG4B1bF8Otn7lgjqinjz4qibwkHp
         Jtzl9YxpnixI4S6rWdxCixJ24PIn9OO/Ti5aqw3D95DiqTu5Gk6yacXTIZzJH6iN3zQ1
         Lhfh5/V+ZKY5BCrKeD1ibxgl9OT8dIFS+bSSeiEV7HfEEXnKdTRUmUMidpwzlYJkeLgJ
         HeKg==
X-Gm-Message-State: AOAM533KZxwb5mUhwV/5Wc4URxKfE7yKSEH8R7FdK9HeGpX+v516QVaA
        9eeqC3vkzoG29Mr+WKA4BKjk9QpV2gmrLxGTqWA=
X-Google-Smtp-Source: ABdhPJx10/xDE3vEm5H2aJDqgHHmx1xgyvr1gJp73C7b2Bhmr0WXKG4BRP/4LlIvaoNqF2OZqQ4ISA+HBH63LBY7O/Q=
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr10903626wrr.226.1593035619928;
 Wed, 24 Jun 2020 14:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <35DF1103-EF57-446A-985F-051B2D3057BD@me.com>
In-Reply-To: <35DF1103-EF57-446A-985F-051B2D3057BD@me.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Jun 2020 17:53:28 -0400
Message-ID: <CAPig+cR3Y62ff_L_ofg0wvro1idHeL9TE-E5eTsLzNqhLFdspA@mail.gmail.com>
Subject: Re: [PATCH] haiku: add Haiku support
To:     =?UTF-8?Q?Emir_Y=C3=A2sin_SARI?= <bitigchi@me.com>
Cc:     Git List <git@vger.kernel.org>,
        Adrien Destugues <pulkomandy@pulkomandy.tk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 21, 2020 at 2:47 PM Emir Yâsin SARI <bitigchi@me.com> wrote:
> Below you can find the current Haiku patches for upstream approval.

Thanks for volunteering to upstream Haiku-specific fixes. Please note
that it is unlikely that these changes will be accepted as-is, and
will require a fair bit of re-work to get them into shape for merging
into this project. If you're interested in pursuing this further, see
my comments below. Rather than submitting a single patch, when you
re-roll, you will almost certainly end up submitting a multi-patch
series.

> Currently Haiku is built with this [1] make configuration. Therefore
> it’s not possible to build the Haiku version with just ‘make’ yet.
> I need help in adapting this configuration to the current Git
> Makefile, I don’t have much experience in Makefiles.  Or if it’s
> trivial, any quick-fix help is appreciated :).

These sort of 'make' tweaks are normally handled by adjusting Git's
config.mak.uname file. So, you will want to add a new section to
config.mak.uname which looks something like this:

    ifeq ($(uname_S),Haiku)
        PTHREAD_LIBS =
        USE_LIBPCRE2 = YesPlease
        NO_D_TYPE_IN_DIRENT = YesPlease
        NO_MEMMEM = YesPlease
        NEEDS_LIBICONV = YesPlease
        GNU_ROFF = YesPlease
        PERL_PATH = /bin/perl
        NO_PYTHON = YesPlease
        NO_TCLTK = YesPlease
        OBJECT_CREATION_USES_RENAMES = YesPlease
        NO_CROSS_DIRECTORY_HARDLINKS = YesPlease
        NO_INSTALL_HARDLINKS = YesPlease
        HAVE_DEV_TTY = YesPlease
        DEFAULT_EDITOR = nano
        DEFAULT_HELP_FORMAT = web
        BASIC_LDFLAGS = -lnetwork -lbsd
    endif

> In the meantime, please find the patchset below for review.

Right here is where your email commentary ends and the patch proper
begins. To allow "git am" to automatically pluck out the actual patch
portion out of the email, you should insert a "--- >8 ---" (scissors)
line here.

> From 2ac0c135d7c12a2581fe70ed1c8ffb4809950b55 Mon Sep 17 00:00:00 2001
> From: Emir Sarı <bitigchi@me.com>
> Date: Sun, 21 Jun 2020 21:02:23 +0300
> Subject: [PATCH] haiku: add Haiku support
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

Except for From: and Subject:, all the other header lines are just
noise and of no interest to the project when submitting patches, thus
should not be included. (Better yet, if possible, use "git send-email"
or GitGitGadget" to send patches, as those tools will ensure the
correct headers are present.)

> This commit is a collection of minor patches previously applied as a
> Haikuports patchset at github.com/haikuports/haikuports repository for
> Git Haiku port.
>
> Patchset history:
>
> From 56acac1a903dcbdd37c3b57fc168ad20179596b1 Mon Sep 17 00:00:00 2001
> From: Ingo Weinhold <ingo_weinhold@gmx.de>
> Date: Tue, 13 Aug 2013 08:07:25 +0200
> Subject: git-web--browse.sh: use "open" on Haiku

A few comments...

Drop the "From <hexstring> <date>" header; it is not of particular
interest in this context.

It probably would be a good idea to indent the entire header block
here as a precaution against it confusing tools which automate patch
application or which otherwise perform some sort of automated patch
processing.

I'm almost tempted to suggest submitting each of these changes as
separate patches in order to retain attribution of each of the
authors. On the other hand, to get these changes accepted into this
project, you almost certainly will end up rewriting them so
significantly that they may no longer resemble the changes from the
original authors. If that's the case, it might make more sense for you
to reference the original authors via "Based on a patch by..." in each
of your new patches.

> Signed-off-by: Emir Sarı <bitigchi@me.com>
> ---
> diff --git a/builtin/config.c b/builtin/config.c
> @@ -645,6 +645,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>         char *user_config = expand_user_path("~/.gitconfig", 0);
>         char *xdg_config = xdg_config_home("config");
>
> +        #ifdef __HAIKU__
> +        if (!xdg_config) {
> +            given_config_source.file = user_config;
> +        } else {
> +            given_config_source.file = xdg_config;
> +            if (user_config) free(user_config);
> +        }
> +        #else

This project frowns heavily on introducing platform-specific
conditional compilation like this. As such, this `#ifdef __HAIKU__`
will prevent this change from being accepted as-is. (It's true that
some such code exists already, but we want to avoid adding more.)

The commit[1] from which you derived this change doesn't explain why
the change was made, but rather only what it changes: specifically, it
forces use of XDG even if the XDG directory is missing rather than
falling back to ~/.gitconfig. This particular behavior change isn't
something that need be specific to Haiku -- it might make sense on any
platform -- so it doesn't make sense to bundle it inside an `#ifdef
__HAIKU__` conditional. The only way this sort of behavior change is
likely to be accepted into the project is if it re-worked to be
applicable to any platform _and_ if it can be properly justified to
convince people that it makes sense. Moreover, it probably would
require some sort of transition plan or mechanism.

Additionally, the change looks outright broken because it neglects to
do:

    given_config_source.scope = CONFIG_SCOPE_GLOBAL;

like the code in the #else arm.

[1]: https://github.com/haikuports/haikuports/blob/02adc9b2c68a0ad51bc4db5699b46adc15c24c5c/dev-vcs/git/patches/git-2.27.0.patchset#L132

> diff --git a/config.c b/config.c
> @@ -2761,6 +2762,12 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
>     if (!config_filename)
>         config_filename = filename_buf = git_pathdup("config");
>
> +    config_dir = xstrdup(config_filename);
> +    * find_last_dir_sep(config_dir) = '\0';
> +    if (access(config_dir, F_OK) != 0)
> +        mkdir(config_dir, 0755);
> +    free(config_dir);

This change comes from [2], which explains the change as:

    Ensure config-directory exists before using it.

But what it fails to say is under what circumstances the directory
wouldn't exist. When would this code kick in? This is the sort of
thing which needs to be properly explained in the commit message for a
change like this to be accepted. Such a change would almost certainly
also be accompanied by a new test, perhaps added to t/t1300-config.sh.

There are other problems with this change, as well. For instance, why
is this "fix" made only to git_config_set_multivar_in_file_gently(),
but not to git_config_copy_or_rename_section_in_file() which almost
certainly suffers the same problem?

Moreover, this code:

    * find_last_dir_sep(config_dir) = '\0';

is just outright dangerous considering that find_last_dir_sep() is
documented as possibly returning NULL. (A minor additional point is
that it violates project style convention by having a space after the
'*'.)

[2]: https://github.com/haikuports/haikuports/blob/02adc9b2c68a0ad51bc4db5699b46adc15c24c5c/dev-vcs/git/patches/git-2.27.0.patchset#L73

> diff --git a/credential-cache.c b/credential-cache.c
> @@ -87,7 +87,11 @@ static char *get_socket_path(void)
> {
> +    #ifdef __HAIKU__
> +    old_dir = xdg_config_home("credential-cache");
> +    #else
>     old_dir = expand_user_path("~/.git-credential-cache", 0);
> +    #endif

This change comes from [3] which justifies it as:

    Move credential cache to the config directory.

    Do not clutter the home dir.

The same comments from above apply...

* don't insert platform-specific conditionals

* there is nothing Haiku-specific about this change, thus protecting
  it inside a `#ifdef __HAIKU__` makes no sense

* if this sort of behavior change is indeed desirable, then it should
  be implemented in a generic way with some sort of transition plan
  from old to new behavior

[3]: https://github.com/haikuports/haikuports/blob/02adc9b2c68a0ad51bc4db5699b46adc15c24c5c/dev-vcs/git/patches/git-2.27.0.patchset#L108

> diff --git a/git-web--browse.sh b/git-web--browse.sh
> @@ -133,6 +133,11 @@ if test -z "$browser" ; then
> +    # BEINCLUDES indicates Haiku
> +    if test -f $BEINCLUDES; then
> +        browser_candidates="open $browser_candidates"
> +    fi

Haiku support was originally added to git-web--browse.sh by [4] which
triggered this conditional off existence of file
/boot/system/haiku_loader, however, that ended up being unreliable, so
[5] changed it to look for environment variable BEINCLUDES.

However, it feels somewhat fragile to depend upon an environment
variable which might or might not exist in the development environment
(even if it is present by default). A more robust alternative would be
to check against something not likely to be overridden by the user.
For instance:

    if test "$(uname)" = Haiku; then

(Also note that placing 'then' on the same line as 'if' goes against
style in this project, however, this particular portion of
git-web--browse.sh already breaks style in that regard, so it's hard
to fault it here.)

[4]: https://github.com/haikuports/haikuports/blob/02adc9b2c68a0ad51bc4db5699b46adc15c24c5c/dev-vcs/git/patches/git-2.27.0.patchset#L1
[5]: https://github.com/haikuports/haikuports/blob/02adc9b2c68a0ad51bc4db5699b46adc15c24c5c/dev-vcs/git/patches/git-2.27.0.patchset#L175

> diff --git a/path.c b/path.c
> @@ -12,6 +12,10 @@
> +#ifdef __HAIKU__
> +#include <FindDirectory.h>
> +#include <StorageDefs.h>
> +#endif
> @@ -1500,16 +1504,22 @@ int looks_like_command_line_option(const char *str)
> char *xdg_config_home(const char *filename)
> {
> +    #ifdef __HAIKU__
> +    char settingsPath[B_PATH_NAME_LENGTH];
> +    assert(filename);
> +    if (find_directory(B_USER_SETTINGS_DIRECTORY, -1, true, settingsPath,
> +        sizeof(settingsPath)) == B_OK)
> +        return mkpathdup("%s/git/%s", settingsPath, filename);
> +    #else

As noted earlier, don't introduce platform-specific compilation
sections like this. The way this is normally handled is to place
platform-specific implementation in a file in the compat/ directory
(perhaps "compat/haiku.c", for instance), and then add a #define to
git-compat-util.h to cause the platform-specific implementation to be
invoked in place of the generic implementation. See compat/mingw.[ch]
and git-compat-util.h for examples of how this is done.

To actually make that work, you might need to do a bit of preparation
to make it possible to swap in a different implementation of
xdg_config_home(), though.

A bit of commentary on the code itself: In this project, the variable
would be named "settings_path", not "settingsPath". That's something
to keep in mind when writing code for generic parts of the system. If
you're placing this code in a platform-specific compat/haiku.c file,
on the other hand, you may be able to get away with breaking style and
going with "settingsPath" (though if there is no strong need to break
style, then why bother?).

>     const char *home, *config_home;
> -
>     assert(filename);
>     config_home = getenv("XDG_CONFIG_HOME");
>     if (config_home && *config_home)
>         return mkpathdup("%s/git/%s", config_home, filename);
> -
>     home = getenv("HOME");

Don't make arbitrary changes like this unrelated to the purpose of a
patch. Doing so gives reviewers extra work with no benefit.
