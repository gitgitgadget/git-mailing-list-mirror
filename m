Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1563F1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 11:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbcHOLZp (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 07:25:45 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:17774 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbcHOLZn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 07:25:43 -0400
Received: from PhilipOakley ([92.22.3.79])
	by smtp.talktalk.net with SMTP
	id ZG1Ub4x7ncpskZG1UbCLqS; Mon, 15 Aug 2016 12:25:41 +0100
X-Originating-IP: [92.22.3.79]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=LkKjIWfvQdKNf3TZC4q4CQ==:117
 a=LkKjIWfvQdKNf3TZC4q4CQ==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=5rxgeBVgAAAA:8 a=xtxXYLxNAAAA:8 a=VwQbUJbxAAAA:8 a=UY-fgOT5wOLaZiEi0McA:9
 a=x8gzFH9gYPwA:10 a=6kGIvZw6iX1k4Y-7sg4_:22 a=PwKx63F5tFurRwaNxrlG:22
 a=xts0dhWdiJbonKbuqhAr:22 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <D954CB3E6C3445AF9358C6941362B69D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Ralf Thielow" <ralf.thielow@gmail.com>, <git@vger.kernel.org>
Cc:	<gitster@pobox.com>, <larsxschneider@gmail.com>, <me@jnm2.com>,
	"Ralf Thielow" <ralf.thielow@gmail.com>
References: <20160812201011.20233-1-ralf.thielow@gmail.com> <20160815053628.3793-1-ralf.thielow@gmail.com>
Subject: Re: [PATCH v2] help: make option --help open man pages only for Git commands
Date:	Mon, 15 Aug 2016 12:25:40 +0100
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
X-CMAE-Envelope: MS4wfE9ZM18TgGTsg8HzZjiAM1SojefbaHY+upVhYmg7jc2ivJ/jtjMoTdiKUV9NsKp20eTO3yZaQWsVEHWV/LtuuaTXYbu6hTNv/A8zgBq2eUNg0pwgNKJ8
 5PAjiamf/tjm3BjCmj21OSvYyhVZ/8pSzVOq+vFaQLvq9RgxbWnP9i/yt1rHUSC7laSUMyK+zaZpPo/Z9SLh5bYnKsVle4FMwGYF11dCOA1OosqSrBy7Ukxo
 4WR4EmRGaN16D4MrnSMZQtjiinepbaoVgp0itjyN7hfP65r5L62Qc2xR7Rr/6yUry0ji7cDbieAP4DaNK9YPZQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Ralf Thielow" <ralf.thielow@gmail.com>
> If option --help is passed to a Git command, we try to open
> the man page of that command. However, we do it even for commands
> we don't know.  Make sure the command is known to Git before try
> to open the man page.  If we don't know the command, give the
> usual advice.

I'm still not sure this is enough. One of the problems back when I 
introduced the --guides option (65f9835 (builtin/help.c: add --guide option, 
2013-04-02)) was that we had no easy way of determining what guides were 
available, especially given the *nix/Windows split where the help defaults 
are different (--man/--html).

At the time[1] we (I) punted on trying to determine which guides were 
actually installed, and just created a short list of the important guides, 
which I believe you now check. However the less common guides are still 
there (gitcvs-migration?), and others may be added locally.

One option may be to report that "no command or common guide found, will 
search for other guide (may fail)", which at least allows you to check the 
command list first, and then the common guide list, and only then warn 
(option?), and finally go on the rabbit hunt (possibly fruitless) for the 
missing guide (we've already decided it can't be a command!)

--
Philip

[1] 
https://public-inbox.org/git/1364942392-576-1-git-send-email-philipoakley@iee.org/ 
(V3) plus previous discussions
https://public-inbox.org/git/1362342072-1412-1-git-send-email-philipoakley@iee.org/ 
(V2) see note
Patch 6 - 13:
All dropped.
Drop the separate guide list.txt and extraction script, which was
copied from the common command list and script. If the guide usage
list is useful, extend the command-list.txt and generate-cmdlist.sh
at a later 
datehttps://public-inbox.org/git/1361660761-1932-1-git-send-email-philipoakley@iee.org/#t 
(V1) the original series

>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> Changes in v2:
> - not only check for commands but also for guides
> - use the command assumed by "help_unknown_cmd"
>
> builtin/help.c  | 34 +++++++++++++++++++++++++++-------
> t/t0012-help.sh | 15 +++++++++++++++
> 2 files changed, 42 insertions(+), 7 deletions(-)
> create mode 100755 t/t0012-help.sh
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 8848013..7d2110e 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -433,10 +433,35 @@ static void list_common_guides_help(void)
>  putchar('\n');
> }
>
> +static int is_common_guide(const char* cmd)
> +{
> + int i;
> +
> + for (i = 0; i < ARRAY_SIZE(common_guides); i++)
> + if (!strcmp(cmd, common_guides[i].name))
> + return 1;
> + return 0;
> +}
> +
> +static const char* check_git_cmd(const char* cmd)
> +{
> + char *alias;
> +
> + if (is_git_command(cmd) || is_common_guide(cmd))
> + return cmd;
> +
> + alias = alias_lookup(cmd);
> + if (alias) {
> + printf_ln(_("`git %s' is aliased to `%s'"), cmd, alias);
> + free(alias);
> + exit(0);
> + } else
> + return help_unknown_cmd(cmd);
> +}
> +
> int cmd_help(int argc, const char **argv, const char *prefix)
> {
>  int nongit;
> - char *alias;
>  enum help_format parsed_help_format;
>
>  argc = parse_options(argc, argv, prefix, builtin_help_options,
> @@ -476,12 +501,7 @@ int cmd_help(int argc, const char **argv, const char 
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
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> new file mode 100755
> index 0000000..0dab88d
> --- /dev/null
> +++ b/t/t0012-help.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +
> +test_description='help'
> +
> +. ./test-lib.sh
> +
> +test_expect_success "pass --help to unknown command" "
> + cat <<-EOF >expected &&
> + git: '123' is not a git command. See 'git --help'.
> + EOF
> + (git 123 --help 2>actual || true) &&
> + test_i18ncmp expected actual
> +"
> +
> +test_done
> -- 
> 2.9.2.912.g51c4565.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

