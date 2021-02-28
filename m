Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65295C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 12:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3D464E07
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 12:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhB1MiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 07:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhB1MiW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 07:38:22 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36AC061786
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 04:37:42 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id mj10so2917864ejb.5
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 04:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jdnmQKdiYPRtGvxjXPXc+Okk59aGlXdPfRhO1SVMUqo=;
        b=KOHenP9pH/kmoiDxOzF8AuPtujrGbloRuj3iLotyO0N3NUK4qaHxGI+s2ZcCxOMY17
         7XsXjxesXTX6p/86BTcSNEErWVnP7gU+Bdoea/nMEmgRAhyhm5Y6jgfSLX0CO3YUgOHy
         F1u9113hR1cA034AmQLxgvg7BvKFE79YzRXPwW9EWLRsoQ70fmOAh95lJSNekpRNteOe
         eDDWr8LV0sjbhkmylcE+PfKQD5AEIJ43mBJ3Q8yKfbP5jJeLyzqLc4f88VKJyh/RcexG
         DS95gv3jdZwbu7sUcdE/5xNDfw5k3DNI2rb913a7LBk97ACpedxTTUTwYLZ4LEFxA/ne
         YMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jdnmQKdiYPRtGvxjXPXc+Okk59aGlXdPfRhO1SVMUqo=;
        b=I4yU9AhwN2zgupvFb358qoeuTieG1dIaTnCBQDeInmo5XvHbeaps11fF6JeNJUbwFV
         okS7wdaP/5YsWB2z5LNnV68fTgFYu8lJvJiOmK7e5ABf1LlyvGE1zuGhe6VxWPzcUILz
         DCDACnbNSuC7cscXo04tkJml6S5x2x2pz2dZfOGu+EEBVOuAnn9JNdnw9fcWki3GdpB0
         f27PQ2MqfCCt5QldZufUZR582rWWVduy06jXz50OjXMdY/7m62Dwt6+TvhaV2MnLANDa
         sKE7ZxmJ3a4Lph2ytdfkPFRx6qfx9hRRbHLVVaG5j+7yWG7Fpj+xehYJpLcvvO0IPWkF
         ELfA==
X-Gm-Message-State: AOAM531rsKsFzjfLcl5EHX8P2IN7pYNaiAuunhmcs0um8XQcYxQAIl8H
        SARakTHrIGwTXaWWE2fKkb4=
X-Google-Smtp-Source: ABdhPJx3dGCrYvfhUPxiFo8iyC4S+Z9daYoIIDGnOFXlHqfzvm6JTRH2R/LkdhG246FurO9m7Ea6Gw==
X-Received: by 2002:a17:906:c0cd:: with SMTP id bn13mr11253376ejb.368.1614515860781;
        Sun, 28 Feb 2021 04:37:40 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i6sm5668407ejz.95.2021.02.28.04.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 04:37:40 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] docs: add a FAQ section on push and fetch problems
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
 <20210227191813.96148-4-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210227191813.96148-4-sandals@crustytoothpaste.net>
Date:   Sun, 28 Feb 2021 13:37:39 +0100
Message-ID: <87k0qsl65o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 27 2021, brian m. carlson wrote:

> There are a lot of questions on the Internet about common problems with
> fetching and pushing.  Roughly, the vast majority of these problems are
> when using HTTP and involve HTTP/2 streams, certain HTTP errors, or
> connections which are interrupted.  This latter case is especially
> common on Windows where non-default antivirus and firewall software
> frequently tampers with connections in undesirable ways.
>
> Let's add some FAQ entries explaining what is happening and how to
> troubleshoot and solve these problems.  When discussing network
> connection issues, explicitly call out TLS man-in-the-middle devices,
> proxies, antivirus programs, and firewall applications, which are the
> cause of most of these problems, and encourage users to report these
> programs as broken.  Since many sites offer both HTTPS and SSH, suggest
> using SSH, which is often not intercepted, as a good way to work around
> these problems.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/gitfaq.txt | 100 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index a132f66032..fde54d2664 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -185,6 +185,106 @@ Then, you can adjust your push URL to use `git@example_author` or
>  `git@example_committer` instead of `git@example.org` (e.g., `git remote set-url
>  git@example_author:org1/project1.git`).
>  
> +Problems Fetching and Pushing
> +-----------------------------
> +
> +[[remote-connection-http-2-stream-error]]
> +Why do I get an error about an HTTP/2 stream not being closed cleanly?::
> +	Sometimes when pushing or fetching over HTTP, users see a message such as "RPC
> +	failed; curl 92 HTTP/2 stream 0 was not closed cleanly".  This message
> +	indicates that Git is using HTTP/2, a recent version of the HTTP protocol, and
> +	that the remote server, or a middlebox, such as a proxy, TLS middlebox,
> +	antivirus, or firewall, failed to speak the protocol correctly and thus the
> +	connection was interrupted.
> ++
> +In such a case, the software causing the problem is buggy and will likely be
> +broken with a wide variety of web browsers and other HTTP-using applications.
> +The best thing to do is contact the responsible party to get the software fixed.
> ++
> +If that isn't possible, you can set the `http.version` option to `HTTP/1.1`,
> +which will force the use of an older version of HTTP.  This should allow Git to
> +function with this broken software or device.  If the remote server supports
> +SSH, you may wish to try switching to SSH instead.
> +
> +[[remote-connection-http-411]]
> +Why do I get an error about an HTTP 411 status?::
> +	Sometimes users see error messages when pushing that refer to HTTP status 411,
> +	such as "RPC failed; result=22, HTTP code = 411."  This status means that the
> +	server or a machine in the middle, such as a proxy, TLS middlebox, antivirus,
> +	firewall, or other middlebox, refuses to accept a streaming data connection.
> ++
> +When pushing or fetching over HTTP, Git normally uses a small buffer and, if the
> +data is large, uses HTTP 1.1 chunked transfer encoding or HTTP 2 streaming to
> +send the data without a defined size.  This is useful because it allows a push
> +or fetch to start much faster and therefore complete much faster.  This type of
> +streaming has been standardized since 1999 and is well understood, and all
> +modern software should be capable of supporting it.
> ++
> +However, in this case, the remote server or middlebox is misconfigured and does
> +not correctly support this.  The best thing to do is contact the responsible
> +party and ask them to fix the server or middlebox, since this misconfiguration
> +can affect many pieces of software, some of which will simply not function at
> +all in this environment.
> ++
> +If the remote server supports SSH, you may wish to try using SSH instead.  If
> +that is not possible, you can set `http.postBuffer` to a larger value as a
> +workaround.  This is one of the few times when that option is useful, but note
> +<<http-postbuffer,as outlined in the answer above>> that doing so will increase
> +the memory usage for every push, no matter how small, and will not be able to
> +handle pushes of arbitrary sizes, so fixing the broken server or device or
> +switching to SSH is preferable in almost all cases.
> +
> +[[remote-connection-reset]]
> +Why do I get errors that the connection was reset?::
> +	When pushing or fetching, sometimes users see problems where the connection
> +	was reset.  Common symptoms of this problem include (but are not limited to)
> +	messages like the following:
> ++
> +* RPC failed; curl 56 OpenSSL SSL_read: Connection was reset, errno 10054
> +* RPC failed; curl 55 SSL_write() returned SYSCALL, errno = 10053
> +* RPC failed; curl 56 LibreSSL SSL_read: SSL_ERROR_SYSCALL, errno 60
> +* RPC failed; result=56, HTTP code = 200
> +* RPC failed; curl 56 GnuTLS recv error (-110): The TLS connection was non-properly terminated.

I haven't looked in details at the content of the FAQ itself being added
here (as far as proposed solutions etc. go), but I wonder if this
wouldn't be 10x more useful to users if we cross-linked these errors
with the docs, e.g.:

diff --git a/remote-curl.c b/remote-curl.c
index 0290b04891..ffb1001703 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -829,7 +829,7 @@ static int run_slot(struct active_request_slot *slot,
                                strbuf_addstr(&msg, curl_errorstr);
                        }
                }
-               error(_("RPC failed; %s"), msg.buf);
+               error(_("RPC failed (see 'git help faq'); %s"), msg.buf);
                strbuf_release(&msg);
        }


> +These messages, and almost every message with a libcurl error code of 55 or 56,
> +essentially mean that the network connection between Git and the remote server
> +was terminated unexpectedly.  This can be caused by any sort of generic network
> +problem, such as packet loss or an unstable connection.  Sometimes users also
> +see it when connected to a VPN if the connection over the VPN is unstable.  In
> +such a case, disabling the VPN or switching to a different connection may help
> +the problem, or sending or receiving less data may work around the problem.
> ++
> +This may also be caused by devices or software in the middle of the connection
> +which attempt to inspect the data.  For example, if you're on a network which
> +uses a TLS middlebox or a proxy, these devices may attempt to inspect the data
> +and terminate the connection if the data is too large for them to handle or if
> +they mistakenly think it is malicious, offensive, inappropriate, or otherwise
> +unacceptable.  To test if this is the problem, try using a different network
> +where these devices are not enabled, or contact your network administrator and
> +report the problem to them.
> ++
> +On Windows, and to a lesser extent on other platforms, antivirus, firewall, or
> +network monitoring software that is not the default (on Windows, something other
> +than Windows Defender and Windows Firewall) can intercept network connections
> +and cause the same problems as the devices mentioned above.  This may also
> +happen when using Git under the Windows Subsystem for Linux with such software.
> +To test if this is the problem, remove the non-default software completely and
> +restart your computer.  Some such software does not disable the broken
> +functionality properly when it is set to disabled and so removing the software
> +is the only way to perform the test.  If this is the problem, use the default
> +software instead, report the problem to the software vendor, or contact your
> +network administrator and report the problem to them.
> ++
> +If you are using HTTPS and the remote server supports SSH, you may wish to try
> +using SSH instead.
> ++
> +Note that in all these cases, this is not a problem in Git, but a problem with
> +the network or the devices and software managing it.  Some parties mistakenly
> +recommend adjusting the `http.postBuffer` setting to work around this, but
> +<<http-postbuffer,see the above answer>> for why that usually doesn't work, and
> +even when it does work, indicates a defect in the network or software such as
> +one mentioned above in this answer.
> +
>  Common Issues
>  -------------
>  

