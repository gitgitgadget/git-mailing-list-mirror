Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8670C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjBBJpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjBBJo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:44:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0A1875A8
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:44:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m7so1114314wru.8
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6H9m0xkZxj0Ejk8VndLdjAI1RJzyBovERfbQCVKpQ84=;
        b=BhXnOCtK35KruPPUa/+gThueTJNGn+5ebfBmDrPmrxjY012T5KCQtlv9k1ZvDIV7ZE
         7lhMbWb/4hU5gCJuXlGOS7fgdR/mcFXd9R3pP7xpWoJdxIj7gM198wd+DUP8aXr9nsbv
         Ieh5wTFXS1Gp3JKlTCKFNXe+0+q9YbpRd5BQe25XJbZWA6dAf0hlMet8bGXQ0pOjJlD+
         wmzEiehPjwoANdONlxOy4mmjptxsQ8lA5fTgzLKNheIi4+6ri/SJaVVOxXMIObD/IiAP
         VlIk6hoajyGY/BrAADwo4K5QxvvwRPDPJ6b9zdTl9D8WvrMx+ftbiFLFGKfC2jp+5teY
         ea8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6H9m0xkZxj0Ejk8VndLdjAI1RJzyBovERfbQCVKpQ84=;
        b=6lt3MSWnuTxb0eGJeGSKzkaHIGZT896f16kl9wDMZgr7iGWy22251appNoJQ3kzt0i
         IhufIWBUUXDWZGZ2YDbMhLxbPVhqoq11XfZVR2OwO1Wzy8wW/23m1NA2943ZkqulPjdD
         CUQajHhAXhqqXVo5FVMNzhIV1GJB6Q4hgIZ2otn60Wbu9plYkDys9QyFf6EP9ZYgSaNM
         eFvZcKteNhnOAJP2gmNAe9ONIVGW7Nwt00ZnYyAWKhTtzncWwe0ZbpXeWDCbN1nvJM15
         f946XGcQ5cf/OzMQ3Md9WW+I6uVF9DS+Ii48jw2mugM51eeA+48mYdiY9i/LNGmLIrL7
         lvvg==
X-Gm-Message-State: AO0yUKXSSUmVPMAmkYSiDjyHCEblvojPlzTVNaovtIzWPHABAO/yKsKx
        gC2rVwMW6vb0XgrNb+Uqjib8PDLOT9JtkPAS
X-Google-Smtp-Source: AK7set8Y3IqZnd5dQoyJdxixO1nm42DckQIKn/gjyIg8zDwXTBPumds3QnLwwUMkr+6+cYvGoozFkA==
X-Received: by 2002:adf:dc01:0:b0:2bd:edd6:ca3e with SMTP id t1-20020adfdc01000000b002bdedd6ca3emr4355054wri.2.1675331062963;
        Thu, 02 Feb 2023 01:44:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0029e1aa67fd2sm19487938wrx.115.2023.02.02.01.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:44:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] imap-send: replace auto-probe libcurl with hard dependency
Date:   Thu,  2 Feb 2023 10:44:11 +0100
Message-Id: <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A polished-up v2 of [1]. I started by splitting out the "imap-send:
make --curl no-optional" per Junio's comment, but then noticed that we
actually can delete quite a bit of code in imap-send.c as a result of
this change.

Comments on indivdiual patches below:

1. https://lore.kernel.org/git/xmqqlelhx973.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (6):
  imap-send: note "auth_method", not "host" on auth method failure
  imap-send doc: the imap.sslVerify is used with imap.tunnel

Both existing issues, but we'll end up changing adjacent code & these
docs later.

  imap-send: replace auto-probe libcurl with hard dependency
  imap-send: make --curl no-optional

The previous patch, but now split into two...

  imap-send: remove old --no-curl codepath

...or three, if we're counting this larger code deletion. This could
have been squashed into the above, but I thought in this case that
this refactoring was easier to reason about when split off from the
functional change.

  imap-send: correctly report "host" when using "tunnel"

An existing issue, but one that's now easy to fix with the
above. Previously the reporting for the OpenSSL codepath had to deal
with both "host" and "tunnel", now that it only handles "tunnel" we
can correct and simplify it.

This is split from the above because there's a functional bugfix
change here, unlike the pure code deletion in the preceding commit.

CI & branch for this at:
https://github.com/avar/git/tree/avar/git-imap-send-curl-only-2

 Documentation/config/imap.txt   |   8 +-
 Documentation/git-imap-send.txt |  11 --
 INSTALL                         |   8 +-
 Makefile                        |  18 +---
 imap-send.c                     | 182 +++++---------------------------
 5 files changed, 41 insertions(+), 186 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  3187a643035 imap-send: note "auth_method", not "host" on auth method failure
-:  ----------- > 2:  1dfee9bf08e imap-send doc: the imap.sslVerify is used with imap.tunnel
1:  3bea1312322 ! 3:  354b6a65a78 imap-send: replace auto-probe libcurl with hard dependency
    @@ Commit message
         before this it had an optional dependency on both libcurl and OpenSSL,
         now only the OpenSSL dependency is optional.
     
    -    This simplifies our dependency matrix my getting rid of yet another
    +    This simplifies our dependency matrix by getting rid of yet another
         special-case. Given the prevalence of libcurl and portability of
         libcurl it seems reasonable to say that "git imap-send" cannot be used
         without libcurl, almost everyone building git needs to be able to push
    @@ Commit message
     
         So let's remove the previous "USE_CURL_FOR_IMAP_SEND" knob. Whether we
         build git-imap-send or not is now controlled by the "NO_CURL"
    -    knob. Let's also hide the old --curl and --no-curl options, and die if
    -    "--no-curl" is provided.
    +    knob.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## Documentation/config/imap.txt ##
    +@@ Documentation/config/imap.txt: imap.preformattedHTML::
    + 
    + imap.authMethod::
    + 	Specify authenticate method for authentication with IMAP server.
    +-	If Git was built with the NO_CURL option, or if your curl version is older
    +-	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
    ++	If you're running git-imap-send with the `--no-curl`
    + 	option, the only supported method is 'CRAM-MD5'. If this is not set
    + 	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
    +
      ## Documentation/git-imap-send.txt ##
     @@ Documentation/git-imap-send.txt: OPTIONS
    - --quiet::
    - 	Be quiet.
      
    ----curl::
    --	Use libcurl to communicate with the IMAP server, unless tunneling
    --	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
    --	option set.
    --
    ----no-curl::
    --	Talk to the IMAP server using git's own IMAP routines instead of
    + --no-curl::
    + 	Talk to the IMAP server using git's own IMAP routines instead of
     -	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
     -	set.
    --
    ++	using libcurl.
    + 
      
      CONFIGURATION
    - -------------
     
      ## INSTALL ##
     @@ INSTALL: Issues of note:
    @@ imap-send.c
      
      static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
      
    - static struct option imap_send_options[] = {
    - 	OPT__VERBOSITY(&verbosity),
    --	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
    -+	OPT_HIDDEN_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
    - 	OPT_END()
    - };
    - 
     @@ imap-send.c: static int append_msgs_to_imap(struct imap_server_conf *server,
      	return 0;
      }
    @@ imap-send.c: int cmd_main(int argc, const char **argv)
     -		use_curl = 0;
     -	}
     -#elif defined(NO_OPENSSL)
    --	if (!use_curl) {
    --		warning("--no-curl not supported in this build");
    --		use_curl = 1;
    --	}
    --#endif
    -+	if (!use_curl)
    -+		die(_("the --no-curl option to imap-send has been deprecated"));
    - 
    - 	if (!server.port)
    - 		server.port = server.use_ssl ? 993 : 143;
    ++#if defined(NO_OPENSSL)
    + 	if (!use_curl) {
    + 		warning("--no-curl not supported in this build");
    + 		use_curl = 1;
     @@ imap-send.c: int cmd_main(int argc, const char **argv)
      	if (server.tunnel)
      		return append_msgs_to_imap(&server, &all_msgs, total);
      
     -#ifdef USE_CURL_FOR_IMAP_SEND
    --	if (use_curl)
    --		return curl_append_msgs_to_imap(&server, &all_msgs, total);
    + 	if (use_curl)
    + 		return curl_append_msgs_to_imap(&server, &all_msgs, total);
     -#endif
    --
    --	return append_msgs_to_imap(&server, &all_msgs, total);
    -+	return curl_append_msgs_to_imap(&server, &all_msgs, total);
    + 
    + 	return append_msgs_to_imap(&server, &all_msgs, total);
      }
-:  ----------- > 4:  e9cc9bbed1e imap-send: make --curl no-optional
-:  ----------- > 5:  17c75e6381a imap-send: remove old --no-curl codepath
-:  ----------- > 6:  686febb8cdc imap-send: correctly report "host" when using "tunnel"
-- 
2.39.1.1392.g63e6d408230

