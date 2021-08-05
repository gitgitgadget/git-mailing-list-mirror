Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1759C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBCA2610A8
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbhHEB0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhHEB0B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:26:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30411C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:25:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id x17so2254790wmc.5
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCgBb3Oi/YYRgsuBERpY+liO827dlBdbbzitceDJ5jo=;
        b=O3E/F7eqRISTlehn1eNqvkaxN/6SFjsRaArtyqF6TSfSZ0c3obE/TNemD8mBQvPiOX
         LiWR8QqO0KSjUHYVZknBmsm1lCys59U5YtpLhcW1QBsMhqILcHTD4ES5nKmdeiCR4wlB
         ApjbhD7w/Zt0J6Dik+hFWiKxe6xTL8O7MB9w7HTqvn4bX22bByzs2JP5v4lOiR/gXX0V
         R/KJ/LcgfhWQhrLf1rsDkulk6Pp8DF4Ic3+ft6b48k9IIHdYyEgUbL7NdcfuyCJbA0w3
         LV236ahuCsUfFMXNXlo91TPdrVArByY0PiFADqw+6HlfDvO+ohOk1bZLe5laQypGAW1E
         4cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCgBb3Oi/YYRgsuBERpY+liO827dlBdbbzitceDJ5jo=;
        b=nfvePpISITwj0ROolYbZHwfMAJdWVBlW4G/En7ide736ltZDpqIi6H154ka1zko3+8
         25yD1KTiVkAPNsaGTdA9KD9RiZupIgzn2QndlbKg7JOvFVktndCcWcU92alCHVTOGZr9
         zikY+F3QLIa5MTgFNuBvTwgWQDlIFu4YjpwSEy39XscVszpKIERnac2wmV7q5j28I9I8
         c3A7lZN3lgSkdD0uF4toaivRmnXSGN51HRXRucpiTTTSlo9ErqcYbUvxkCp6pTOwE7jJ
         H/MTWQUD6a8IXV9U/CeuSK1DHfvAgqhUqTbUVpXgr4Kxz8yuLm/+wP8Tsb5DeejBGtXW
         QxQg==
X-Gm-Message-State: AOAM53366JnZxJ85mZI5wMd559UDI+dsK4yDlUw1kcuqfu+aC21opi9g
        IjWyaDp83w+c1JuOPzcpeqrGvMQgpYxaeg==
X-Google-Smtp-Source: ABdhPJxSYNBIpSVabvbx4po3JyftbTYdwNjOd3xxy8f3MOes4tn13220JXXLNPZpb8XgovNGOlR3NQ==
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr2144743wmc.41.1628126745557;
        Wed, 04 Aug 2021 18:25:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm4120176wru.50.2021.08.04.18.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:25:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/10] serve.[ch]: general API cleanup + --advertise-refs cleanup
Date:   Thu,  5 Aug 2021 03:25:33 +0200
Message-Id: <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a general API cleanup and simplifiction of of serve.[ch] and
its interaction with "upload-pack --advertise-refs".

Previous rounds of this series had a way to define "startup config"
for commands hanging off the v2 server. That's now entirely gone,
along with prep work required for it.

For v3, see :
https://lore.kernel.org/git/cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com/

The fixup for the missing test shebang has also been squashed in,
thanks Carlo!:
https://lore.kernel.org/git/20210803060005.18151-1-carenas@gmail.com/

Despite the overall diffstat this is a net deletion of code in any
meaningful sense of reducing complexity, i.e. it goes into the plus on
the diffstat due to the addition of previously missing tests, and the
use of designated initializers.

Ævar Arnfjörð Bjarmason (10):
  serve: mark has_capability() as static
  transport: rename "fetch" in transport_vtable to "fetch_refs"
  transport: use designated initializers
  serve: use designated initializers
  serve.[ch]: don't pass "struct strvec *keys" to commands
  serve: move transfer.advertiseSID check into session_id_advertise()
  serve.c: move version line to advertise_capabilities()
  {upload,receive}-pack tests: add --advertise-refs tests
  serve.[ch]: remove "serve_options", split up --advertise-refs code
  upload-pack: document and rename --advertise-refs

 Documentation/git-receive-pack.txt        |   5 +
 Documentation/git-upload-pack.txt         |  12 +-
 Documentation/technical/http-protocol.txt |   3 +
 Documentation/technical/protocol-v2.txt   |   3 +
 builtin/receive-pack.c                    |   3 +-
 builtin/upload-pack.c                     |  28 ++--
 http-backend.c                            |   2 +-
 ls-refs.c                                 |   3 +-
 ls-refs.h                                 |   4 +-
 protocol-caps.c                           |   3 +-
 protocol-caps.h                           |   4 +-
 serve.c                                   |  82 ++++++-----
 serve.h                                   |  12 +-
 t/helper/test-serve-v2.c                  |  14 +-
 t/t5555-http-smart-common.sh              | 161 ++++++++++++++++++++++
 transport-helper.c                        |  18 +--
 transport-internal.h                      |   2 +-
 transport.c                               |  32 ++---
 upload-pack.c                             |  21 +--
 upload-pack.h                             |  14 +-
 20 files changed, 298 insertions(+), 128 deletions(-)
 create mode 100755 t/t5555-http-smart-common.sh

Range-diff against v3:
 1:  192fb64ef82 =  1:  13bb1a06078 serve: mark has_capability() as static
 2:  d716bd3c537 =  2:  162f717436f transport: rename "fetch" in transport_vtable to "fetch_refs"
 3:  d31690614af =  3:  d3d5818adda transport: use designated initializers
 4:  13f1a8d8325 =  4:  8da15c373cc serve: use designated initializers
 5:  99eeff6f890 <  -:  ----------- serve.c: add call_{advertise,command}() indirection
 6:  be719dc3dc1 <  -:  ----------- serve: add support for a "startup" git_config() callback
12:  e4eb31b5b8e !  5:  7714f81d62c serve.[ch]: don't pass "struct strvec *keys" to commands
    @@ Commit message
         2018-03-15) was passing in the raw capabilities "keys", but nothing
         downstream of it ever used them.
     
    -    Let's remove that code because it's not needed, and because if and
    -    when we need to pass data about the advertisement (I have some WIP
    -    patches for that), it makes much more sense to have the serve.c parse
    -    the capabilities, and then pass specific information we need down than
    -    expecting its API users to re-do their own parsing of the raw data.
    +    Let's remove that code because it's not needed. If we do end up
    +    needing to pass information about the advertisement in the future
    +    it'll make more sense to have serve.c parse the capabilities keys and
    +    pass the result of its parsing, rather than expecting expecting its
    +    API users to parse the same keys again.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ ls-refs.h
     -int ls_refs(struct repository *r, struct strvec *keys,
     -	    struct packet_reader *request);
     +int ls_refs(struct repository *r, struct packet_reader *request);
    - int ls_refs_startup_config(const char *var, const char *value, void *data);
      int ls_refs_advertise(struct repository *r, struct strbuf *value);
      
    + #endif /* LS_REFS_H */
     
      ## protocol-caps.c ##
     @@ protocol-caps.c: static void send_info(struct repository *r, struct packet_writer *writer,
    - 	strbuf_release(&send_buffer);
    + 	}
      }
      
     -int cap_object_info(struct repository *r, struct strvec *keys,
    @@ protocol-caps.h
      #endif /* PROTOCOL_CAPS_H */
     
      ## serve.c ##
    -@@ serve.c: static int session_id_advertise(struct repository *r, struct strbuf *value)
    - }
    - 
    - typedef int (*advertise_fn_t)(struct repository *r, struct strbuf *value);
    --typedef int (*command_fn_t)(struct repository *r, struct strvec *keys,
    -+typedef int (*command_fn_t)(struct repository *r,
    - 			    struct packet_reader *request);
    - 
    - struct protocol_capability {
     @@ serve.c: struct protocol_capability {
      
      	/*
    @@ serve.c: struct protocol_capability {
      	 * use to read the command specific part of the request.  Every command
      	 * MUST read until a flush packet is seen before sending a response.
      	 *
    -@@ serve.c: static int call_command(struct protocol_capability *command,
    + 	 * This field should be NULL for capabilities which are not commands.
    + 	 */
    +-	int (*command)(struct repository *r,
    +-		       struct strvec *keys,
    +-		       struct packet_reader *request);
    ++	int (*command)(struct repository *r, struct packet_reader *request);
    + };
      
    - 	read_startup_config(command);
    + static struct protocol_capability capabilities[] = {
    +@@ serve.c: static int process_request(void)
    + 	if (has_capability(&keys, "session-id", &client_sid))
    + 		trace2_data_string("transfer", NULL, "client-sid", client_sid);
      
    --	return command->command(r, keys, request);
    -+	return command->command(r, request);
    - }
    +-	command->command(the_repository, &keys, &reader);
    ++	command->command(the_repository, &reader);
      
    - void protocol_v2_advertise_capabilities(void)
    + 	strvec_clear(&keys);
    + 	return 0;
     
      ## upload-pack.c ##
     @@ upload-pack.c: enum fetch_state {
    @@ upload-pack.c: enum fetch_state {
      	struct upload_pack_data data;
     
      ## upload-pack.h ##
    -@@ upload-pack.h: void upload_pack(const int advertise_refs, const int stateless_rpc,
    - 		 const int timeout);
    +@@ upload-pack.h: struct upload_pack_options {
    + void upload_pack(struct upload_pack_options *options);
      
      struct repository;
     -struct strvec;
 -:  ----------- >  6:  33db6b7cf53 serve: move transfer.advertiseSID check into session_id_advertise()
 7:  b7928ddbe9b !  7:  9828e08cbad serve.c: move version line to advertise_capabilities()
    @@ Commit message
         serve.c: move version line to advertise_capabilities()
     
         The advertise_capabilities() is only called from serve() and we always
    -    emit this version line before it, it makes more sense to consider the
    -    capabilities part of a "header" that has the version, so let's move
    -    the writing of the version there.
    +    emit this version line before it. In a subsequent commit I'll make
    +    builtin/upload-pack.c sometimes call advertise_capabilities()
    +    directly, so it'll make sense to have this line emitted by
    +    advertise_capabilities(), not serve() itself.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 9:  beafe9811c1 !  8:  fd58abb7420 {upload,receive}-pack tests: add --advertise-refs tests
    @@ Commit message
     
      ## t/t5555-http-smart-common.sh (new) ##
     @@
    ++#!/bin/sh
    ++
     +test_description='test functionality common to smart fetch & push'
     +
     +. ./test-lib.sh
 8:  fb80f152713 !  9:  c9a35868933 serve.[ch]: remove "serve_options", split up --advertise-refs code
    @@ http-backend.c: static void get_info_refs(struct strbuf *hdr, char *arg)
      
     
      ## serve.c ##
    -@@ serve.c: static int call_command(struct protocol_capability *command,
    - 	return command->command(r, keys, request);
    - }
    +@@ serve.c: static struct protocol_capability capabilities[] = {
    + 	},
    + };
      
     -static void advertise_capabilities(void)
     +void protocol_v2_advertise_capabilities(void)
    @@ upload-pack.h
     +		 const int timeout);
      
      struct repository;
    - struct strvec;
    + struct packet_reader;
10:  c6870b5f18a = 10:  2006cb234b6 upload-pack: document and rename --advertise-refs
11:  2d4c3d0d463 <  -:  ----------- upload-pack.c: convert to new serve.c "startup" config cb
-- 
2.33.0.rc0.597.gc569a812f0a

