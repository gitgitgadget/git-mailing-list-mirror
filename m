Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACEB31F424
	for <e@80x24.org>; Sun, 22 Apr 2018 15:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753922AbeDVPcf (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 11:32:35 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:17352 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754918AbeDVPcW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 11:32:22 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id AGyRf24UL4ZqzAGyRflP1v; Sun, 22 Apr 2018 16:32:21 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=xtxXYLxNAAAA:8
 a=FZMEZzhCIBRuA2dCDVsA:9 a=wPNLvfGTeEIA:10 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <AE53F7B8907A4FE3BFDC8806B5C21AB3@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Git List" <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Dan Jacques" <dnj@google.com>
References: <cover.1524211375.git.johannes.schindelin@gmx.de> <d134afdd22c9cdfd763213b37efac4ef0399a374.1524211375.git.johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Avoid multiple PREFIX definitions
Date:   Sun, 22 Apr 2018 16:32:24 +0100
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
X-Antivirus: AVG (VPS 180422-0, 22/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfA0J72UR3S7HPPyuLJE2u81j8VXGZ4/kiaNyTCQkhOQfGxLnJcYjsUb6QYqzrF5oifSZmmqV1stbVCDh8Gaf8JgQZB9CJ1e2CfOMUbtxzJvDH58zgM7C
 FxNFfLWdMKZ2Lm3YDNmTSRzWN+kEo2WXCwBUeJ/9OQi7Sxzg7+Qsl8rJYgoieoEEJ+DqUSP5AXKvuwk+l+MsBbmoIyoOQdZ76nuSzbGTDdgqYO79uFnWUYq6
 OIAcmfAnGV7HvVxOXV58Bg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> From: Philip Oakley <philipoakley@iee.org>
>
> The short and sweet PREFIX can be confused when used in many places.
>
> Rename both usages to better describe their purpose. EXEC_CMD_PREFIX is
> used in full to disambiguate it from the nearby GIT_EXEC_PATH.

@dcsho; Thanks for keeping up with this and all your work. LGTM Philip.

>
> The PREFIX in sideband.c, while nominally independant of the exec_cmd
> PREFIX, does reside within libgit[1], so the definitions would clash
> when taken together with a PREFIX given on the command line for use by
> exec_cmd.c.
>
> Noticed when compiling Git for Windows using MSVC/Visual Studio [1] which
> reports the conflict beteeen the command line definition and the
> definition in sideband.c within the libgit project.
>
> [1] the libgit functions are brought into a single sub-project
> within the Visual Studio construction script provided in contrib,
> and hence uses a single command for both exec_cmd.c and sideband.c.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Makefile   |  2 +-
> exec-cmd.c |  4 ++--
> sideband.c | 10 +++++-----
> 3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 111e93d3bea..49cec672242 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2271,7 +2271,7 @@ exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS =
> \
>  '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
>  '-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
>  '-DBINDIR="$(bindir_relative_SQ)"' \
> - '-DPREFIX="$(prefix_SQ)"'
> + '-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
>
> builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
> builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
> diff --git a/exec-cmd.c b/exec-cmd.c
> index 3b0a039083a..02d31ee8971 100644
> --- a/exec-cmd.c
> +++ b/exec-cmd.c
> @@ -48,7 +48,7 @@ static const char *system_prefix(void)
>      !(prefix = strip_path_suffix(executable_dirname, GIT_EXEC_PATH)) &&
>      !(prefix = strip_path_suffix(executable_dirname, BINDIR)) &&
>      !(prefix = strip_path_suffix(executable_dirname, "git"))) {
> - prefix = PREFIX;
> + prefix = FALLBACK_RUNTIME_PREFIX;
>  trace_printf("RUNTIME_PREFIX requested, "
>  "but prefix computation failed.  "
>  "Using static fallback '%s'.\n", prefix);
> @@ -243,7 +243,7 @@ void git_resolve_executable_dir(const char *argv0)
>  */
> static const char *system_prefix(void)
> {
> - return PREFIX;
> + return FALLBACK_RUNTIME_PREFIX;
> }
>
> /*
> diff --git a/sideband.c b/sideband.c
> index 6d7f943e438..325bf0e974a 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -13,7 +13,7 @@
>  * the remote died unexpectedly.  A flush() concludes the stream.
>  */
>
> -#define PREFIX "remote: "
> +#define DISPLAY_PREFIX "remote: "
>
> #define ANSI_SUFFIX "\033[K"
> #define DUMB_SUFFIX "        "
> @@ -49,7 +49,7 @@ int recv_sideband(const char *me, int in_stream, int
> out)
>  switch (band) {
>  case 3:
>  strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
> -     PREFIX, buf + 1);
> +     DISPLAY_PREFIX, buf + 1);
>  retval = SIDEBAND_REMOTE_ERROR;
>  break;
>  case 2:
> @@ -67,7 +67,7 @@ int recv_sideband(const char *me, int in_stream, int
> out)
>  int linelen = brk - b;
>
>  if (!outbuf.len)
> - strbuf_addstr(&outbuf, PREFIX);
> + strbuf_addstr(&outbuf, DISPLAY_PREFIX);
>  if (linelen > 0) {
>  strbuf_addf(&outbuf, "%.*s%s%c",
>      linelen, b, suffix, *brk);
> @@ -81,8 +81,8 @@ int recv_sideband(const char *me, int in_stream, int
> out)
>  }
>
>  if (*b)
> - strbuf_addf(&outbuf, "%s%s",
> -     outbuf.len ? "" : PREFIX, b);
> + strbuf_addf(&outbuf, "%s%s", outbuf.len ?
> +     "" : DISPLAY_PREFIX, b);
>  break;
>  case 1:
>  write_or_die(out, buf + 1, len);
> -- 
> 2.17.0.windows.1.15.gaa56ade3205
>

