Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95FC11F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 03:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754632AbcHSDqJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 23:46:09 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:44180 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754211AbcHSDpz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 23:45:55 -0400
Received: from PhilipOakley ([92.22.49.211])
        by smtp.talktalk.net with SMTP
        id aV9dbFLqdgKstaV9eb3w5L; Thu, 18 Aug 2016 22:47:15 +0100
X-Originating-IP: [92.22.49.211]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=B3SST7NGJ7PH11RcegKDxA==:117
 a=B3SST7NGJ7PH11RcegKDxA==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=MwJLVz9loxMBghC5MCoA:9 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <743A8D8FFE434E08B34F9AF8C21E54AE@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Ralf Thielow" <ralf.thielow@gmail.com>, <git@vger.kernel.org>
Cc:     <gitster@pobox.com>, <larsxschneider@gmail.com>, <me@jnm2.com>,
        <john@keeping.me.uk>, "Ralf Thielow" <ralf.thielow@gmail.com>
References: <20160816162030.27754-1-ralf.thielow@gmail.com> <20160818185719.4909-1-ralf.thielow@gmail.com> <20160818185719.4909-2-ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] help: introduce option --command-only
Date:   Thu, 18 Aug 2016 22:47:14 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfPljtwZpdsF3mUU3wYuoxaiJgM9DS1mffvecySOZ6u8QRt2nq/ffGcmuiza6Y+v41O82gLPpFrsglo/siQTDLiUBeb1BrD4WSfyoeYsfudwyPyqJVloe
 au9mcSq8aw505DyKsYCAndXEvqA3emVxZvfysWJTDlPpje3m0YGRgs+mdCaYRdEzH97V/VOC3lBx96493ioPHqi/9tOYZeQ7VwsCxFfpBxrbKGaojm16PtTV
 LaBQGDyTFmzTzDFuT2r1W5VIcdrvBP++qfxQIR8JavW8pdFZjndH71LnP+BW3x7+ptHOyf+vNOEv5PGe25rdVa6u7N0rlaOJ8GnPQd7SSBgNUAuiFQrgNqgN
 fTsbN2EW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Ralf Thielow" <ralf.thielow@gmail.com>
> Introduce option --command-only to the help command.  With this option
> being passed, "git help" will open man pages only for commands.
>
> Since we know it is a command, we can use function help_unknown_command
> to give the user advice on typos.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> I am not sure about the first test case, but I think it'd have
> prevented me from making earlier mistakes of this change. That's
> why I added it.
> Just calling a git command that succeeds in a test isn't really
> a check, so ... I dunno

Do the tests work on both *nix and Windows, given that Windows uses 
the --web option by default, so is likely to fire up a browser instead of 
the man pages? Otherwise it sounds to be a reasonable check.

>
> Documentation/git-help.txt             | 11 ++++++++---
> builtin/help.c                         | 30 +++++++++++++++++++++++-------
> contrib/completion/git-completion.bash |  2 +-
> t/t0012-help.sh                        | 21 +++++++++++++++++++++
> 4 files changed, 53 insertions(+), 11 deletions(-)
> create mode 100755 t/t0012-help.sh
>
> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index 40d328a..cf6a414 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -8,7 +8,7 @@ git-help - Display help information about Git
> SYNOPSIS
> --------
> [verse]
> -'git help' [-a|--all] [-g|--guide]
> +'git help' [-a|--all] [-c|--command-only] [-g|--guide]
>     [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
>
> DESCRIPTION
> @@ -29,8 +29,9 @@ guide is brought up. The 'man' program is used by 
> default for this
> purpose, but this can be overridden by other options or configuration
> variables.
>
> -Note that `git --help ...` is identical to `git help ...` because the
> -former is internally converted into the latter.
> +Note that `git --help ...` is almost identical to `git help ...` because
> +the former is internally converted into the latter with 
> option --command-only
> +being added.
>
> To display the linkgit:git[1] man page, use `git help git`.
>
> @@ -43,6 +44,10 @@ OPTIONS
>  Prints all the available commands on the standard output. This
>  option overrides any given command or guide name.
>
> +-c::
> +--command-only::
> + Display help information only for commands.

s/commands/known commands/ ?

> +
> -g::
> --guides::
>  Prints a list of useful guides on the standard output. This
> diff --git a/builtin/help.c b/builtin/help.c
> index 8848013..2249a67 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -37,8 +37,10 @@ static int show_all = 0;
> static int show_guides = 0;
> static unsigned int colopts;
> static enum help_format help_format = HELP_FORMAT_NONE;
> +static int cmd_only;
> static struct option builtin_help_options[] = {
>  OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
> + OPT_BOOL('c', "command-only", &cmd_only, N_("show help only for 
> commands")),

s/commands/known commands/ ?

>  OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
>  OPT_SET_INT('m', "man", &help_format, N_("show man page"), 
> HELP_FORMAT_MAN),
>  OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
> @@ -433,10 +435,29 @@ static void list_common_guides_help(void)
>  putchar('\n');
> }
>
> +static const char *check_git_cmd(const char* cmd)
> +{
> + char *alias;
> +
> + if (is_git_command(cmd))
> + return cmd;
> +
> + alias = alias_lookup(cmd);
> + if (alias) {
> + printf_ln(_("`git %s' is aliased to `%s'"), cmd, alias);
> + free(alias);
> + exit(0);
> + }
> +
> + if (cmd_only)
> + return help_unknown_cmd(cmd);
> +
> + return cmd;
> +}
> +
> int cmd_help(int argc, const char **argv, const char *prefix)
> {
>  int nongit;
> - char *alias;
>  enum help_format parsed_help_format;
>
>  argc = parse_options(argc, argv, prefix, builtin_help_options,
> @@ -476,12 +497,7 @@ int cmd_help(int argc, const char **argv, const char 
> *prefix)
>  if (help_format == HELP_FORMAT_NONE)
>  help_format = parse_help_format(DEFAULT_HELP_FORMAT);
>
> - alias = alias_lookup(argv[0]);
> - if (alias && !is_git_command(argv[0])) {
> - printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
> - free(alias);
> - return 0;
> - }
> + argv[0] = check_git_cmd(argv[0]);
>
>  switch (help_format) {
>  case HELP_FORMAT_NONE:
> diff --git a/contrib/completion/git-completion.bash 
> b/contrib/completion/git-completion.bash
> index c1b2135..354afe5 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1393,7 +1393,7 @@ _git_help ()
> {
>  case "$cur" in
>  --*)
> - __gitcomp "--all --guides --info --man --web"
> + __gitcomp "--all --command-only --guides --info --man --web"
>  return
>  ;;
>  esac
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> new file mode 100755
> index 0000000..e20f907
> --- /dev/null
> +++ b/t/t0012-help.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +
> +test_description='help'
> +
> +. ./test-lib.sh
> +
> +test_expect_success "works for commands and guides by default" "
> + git help status &&
> + git help revisions
> +"
> +
> +test_expect_success "--command-only does not work for guides" "
> + git help --command-only status &&
> + cat <<-EOF >expected &&
> + git: 'revisions' is not a git command. See 'git --help'.
> + EOF
> + (git help --command-only revisions 2>actual || true) &&
> + test_i18ncmp expected actual
> +"
> +
> +test_done
> -- 
> 2.9.2.912.gd0c0e83
>
>
--
Philip 

