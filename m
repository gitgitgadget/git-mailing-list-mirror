Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38DEC433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C52206D4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+91z7cD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgESKyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 06:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgESKyL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 06:54:11 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF3DC061A0C
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:10 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z18so10720079qto.2
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jtuAkcfDmDSbHP/5WO9DgFn9H/4+SUQrLnYdaLDFANQ=;
        b=o+91z7cDq6/s/XnG8YFIKAUEZ5vU6OBt/TKELB7yAQQ4NZ0iBF1bQHde+Uzt14yBDU
         WzKv6pQGSyx4lBoRZIjnaQRLw/4h4m40Rfaw5kmmHYsaPBGv1KvP0zzX2EUrItwa0t5t
         s+35cusEwuQjeNP589TX3PH9Jr1JOM+prOoAgWIZCI6Ohcz+OnLXzhnizJERB0lHCAkW
         ar5fjVhg2mYizwsVLSYphlPyLuiheiovNRP3ZhVDQGHu2O06rRJKN/ZH7SzWP28xdl4F
         clnrPSPKrqfbjGSsAZhm6OJHInz7nf2cEURV5UI0QYO0iUpr9g1wpQhDqtH6IadgE7+1
         gs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtuAkcfDmDSbHP/5WO9DgFn9H/4+SUQrLnYdaLDFANQ=;
        b=srBYjtVx8+mnxfa8zU6EGrXeWDh/k39FphKnc8GPHhlblUiypGeUcfix2nWbxhNIGR
         Y06Oe+6L42ffzRpwHsJNUZJM7Iq6yQLHwCZBDHgv8G+1MOpkvNrygbNwDlyCZFSnG1fp
         5VQ+8IQHHG3Ow5/PrEd5IWX7x6cYG4Ara8+uc1412pFHWGijlwN/XymSY38Ec1o00GLC
         9kapSo8DHJz54CM6N5nAkIh9Uj407FqlXeP11M+LVjU3Xl0Y7QTrH05x6LYayvuLvFyE
         6DbivcF+U83+HAfgcoCJPP8EPoJgzatBH9JDoSFtlbcKhUxHqbYYTEnN/eckrAeZkhly
         vZpA==
X-Gm-Message-State: AOAM5316PjrI5MYkPpq/6YlWu040GXKQASgIJEnNHkdTfCYGgMX9bLnJ
        E7Ly9KBchg5hsFO6DWRFHXAQUtlM
X-Google-Smtp-Source: ABdhPJyDBLcaTn1sxMEnyUmDuA+GAaN1IVYySeyZPscLk7EwoCrRf+z6dm7AZDWWknQMbJ9OqakJRg==
X-Received: by 2002:ac8:302e:: with SMTP id f43mr22320531qte.366.1589885649743;
        Tue, 19 May 2020 03:54:09 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c63sm10177775qkf.131.2020.05.19.03.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:54:08 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/7] remote-curl: fix deadlocks when remote server disconnects
Date:   Tue, 19 May 2020 06:53:53 -0400
Message-Id: <cover.1589885479.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589816718.git.liu.denton@gmail.com>
References: <cover.1589816718.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following command hangs forever:

	$ git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=20151012
	Cloning into 'git'...

This occurs because the --shallow-since arg is incorrect and the server
dies early. However, remote-curl does not realise that the server
errored out and just faithfully forwards the packets to fetch-pack
before waiting on more input from fetch-pack. Meanwhile, fetch-pack
keeps reading as it still expects more input. As a result, the processes
deadlock. Original analysis by Peff:
https://lore.kernel.org/git/20200328154936.GA1217052@coredump.intra.peff.net/

Changes since v2:

* Use if-else tower in "transport: extract common fetch_pack() call"

* Rename to `lenbuf_hex` and remove null-terminator sentence in
  "pkt-line: extern packet_length()"

* Fix "a a" typo in "remote-curl: error on incomplete packet"

* Don't send flush packet after response end packet

* Move stateless delimiter checks closer to where message processing
  happens in do_fetch_pack_v2()

Changes since v1:

* Remove fallthrough in switch in favour of just extracting the common
  call out of the switch in patch 3

* Add more detail in function comment and use `const char linelen[4]` in
  patch 4

* Implement most of Peff's suggestions[0] in patch 5

* Only operate on stateless_connect() in patch 5

* Add tests in patch 5

* Drop "remote-curl: ensure last packet is a flush" in favour of
  "stateless-connect: send response end packet"

[0]: https://lore.kernel.org/git/20200515213844.GD115445@coredump.intra.peff.net/

Denton Liu (7):
  remote-curl: fix typo
  remote-curl: remove label indentation
  transport: extract common fetch_pack() call
  pkt-line: extern packet_length()
  remote-curl: error on incomplete packet
  pkt-line: define PACKET_READ_RESPONSE_END
  stateless-connect: send response end packet

 Documentation/gitremote-helpers.txt           |  4 +-
 Documentation/technical/protocol-v2.txt       |  2 +
 builtin/fetch-pack.c                          |  2 +-
 connect.c                                     | 18 ++++-
 connect.h                                     |  4 ++
 fetch-pack.c                                  | 13 ++++
 pkt-line.c                                    | 17 ++++-
 pkt-line.h                                    | 11 +++
 remote-curl.c                                 | 70 +++++++++++++++++--
 remote.h                                      |  3 +-
 serve.c                                       |  2 +
 t/helper/test-pkt-line.c                      |  4 ++
 t/lib-httpd.sh                                |  2 +
 t/lib-httpd/apache.conf                       |  8 +++
 .../incomplete-body-upload-pack-v2-http.sh    |  3 +
 .../incomplete-length-upload-pack-v2-http.sh  |  3 +
 t/t5702-protocol-v2.sh                        | 47 +++++++++++++
 transport.c                                   | 28 +++-----
 18 files changed, 211 insertions(+), 30 deletions(-)
 create mode 100644 t/lib-httpd/incomplete-body-upload-pack-v2-http.sh
 create mode 100644 t/lib-httpd/incomplete-length-upload-pack-v2-http.sh

Range-diff against v2:
1:  b390875f87 = 1:  b390875f87 remote-curl: fix typo
2:  a2b28c0b28 = 2:  a2b28c0b28 remote-curl: remove label indentation
3:  3a42575bd5 < -:  ---------- transport: extract common fetch_pack() call
-:  ---------- > 3:  c118baa5a2 transport: extract common fetch_pack() call
4:  c2b9d033bb ! 4:  36885943b2 pkt-line: extern packet_length()
    @@ Commit message
         need to access the length header. In order to simplify this, extern
         packet_length() so that the logic can be reused.
     
    -    Change the function parameter from a `const char *` to
    -    `const char linelen[4]`. Even though these two types behave identically
    -    as function parameters, use the array notation to semantically indicate
    -    exactly what this function is expecting as an argument.
    +    Change the function parameter from `const char *linelen` to
    +    `const char lenbuf_hex[4]`. Even though these two types behave
    +    identically as function parameters, use the array notation to
    +    semantically indicate exactly what this function is expecting as an
    +    argument. Also, rename it from linelen to lenbuf_hex as the former
    +    sounds like it should be an integral type which is misleading.
     
      ## pkt-line.c ##
     @@ pkt-line.c: static int get_packet_data(int fd, char **src_buf, size_t *src_size,
    @@ pkt-line.c: static int get_packet_data(int fd, char **src_buf, size_t *src_size,
      }
      
     -static int packet_length(const char *linelen)
    -+int packet_length(const char linelen[4])
    ++int packet_length(const char lenbuf_hex[4])
      {
    - 	int val = hex2chr(linelen);
    - 	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
    +-	int val = hex2chr(linelen);
    +-	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
    ++	int val = hex2chr(lenbuf_hex);
    ++	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
    + }
    + 
    + enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
     
      ## pkt-line.h ##
     @@ pkt-line.h: int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
    @@ pkt-line.h: int write_packetized_from_buf(const char *src_in, size_t len, int fd
      
     +/*
     + * Convert a four hex digit packet line length header into its numeric
    -+ * representation. linelen should not be null-terminated.
    ++ * representation.
     + *
     + * If linelen contains non-hex characters, return -1. Otherwise, return the
     + * numeric value of the length header.
     + */
    -+int packet_length(const char linelen[4]);
    ++int packet_length(const char lenbuf_hex[4]);
     +
      /*
       * Read a packetized line into a buffer like the 'packet_read()' function but
5:  52ce5fdffd ! 5:  91d330620a remote-curl: error on incomplete packet
    @@ Commit message
         results in a deadlock between the two processes.
     
         For a stateless connection, inspect packets before sending them and
    -    error out if a a packet line packet is incomplete.
    +    error out if a packet line packet is incomplete.
     
         Helped-by: Jeff King <peff@peff.net>
     
6:  744b078324 ! 6:  ff83344e9e pkt-line: PACKET_READ_RESPONSE_END
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    pkt-line: PACKET_READ_RESPONSE_END
    +    pkt-line: define PACKET_READ_RESPONSE_END
     
         In a future commit, we will use PACKET_READ_RESPONSE_END to separate
         messages proxied by remote-curl. To prepare for this, add the
7:  4b079bcd83 ! 7:  c26e160fbc stateless-connect: send response end packet
    @@ Commit message
                 Cloning into 'git'...
                 fatal: the remote end hung up unexpectedly
     
    -    Instead of blindly forwarding packets, make remote-curl insert response
    -    end and flush packets after proxying the responses from the remote
    -    server when using stateless_connect(). On the RPC client side, ensure
    -    that each response ends as described.
    +    Instead of blindly forwarding packets, make remote-curl insert a
    +    response end packet after proxying the responses from the remote server
    +    when using stateless_connect(). On the RPC client side, ensure that each
    +    response ends as described.
     
         A separate control packet is chosen because we need to be able to
         differentiate between what the remote server sends and remote-curl's
    @@ Documentation/gitremote-helpers.txt: Supported if the helper has the "connect" c
      	(both request and response) must consist of zero or more
     -	PKT-LINEs, terminating in a flush packet. The client must not
     +	PKT-LINEs, terminating in a flush packet. Response messages will
    -+	have a response end packet before the flush packet to indicate
    -+	the end of a response.  The client must not
    ++	then have a response end packet after the flush packet to
    ++	indicate the end of a response.  The client must not
      	expect the server to store any state in between request-response
      	pairs.  After the connection ends, the remote helper exits.
      +
    @@ builtin/fetch-pack.c: int cmd_fetch_pack(int argc, const char **argv, const char
     
      ## connect.c ##
     @@ connect.c: static int process_ref_v2(const char *line, struct ref ***list)
    + 	return ret;
    + }
    + 
    ++void check_stateless_delimiter(int stateless_rpc,
    ++			      struct packet_reader *reader,
    ++			      const char *error)
    ++{
    ++	if (!stateless_rpc)
    ++		return; /* not in stateless mode, no delimiter expected */
    ++	if (packet_reader_read(reader) != PACKET_READ_RESPONSE_END)
    ++		die("%s", error);
    ++}
    ++
      struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
      			     struct ref **list, int for_push,
      			     const struct argv_array *ref_prefixes,
    @@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader
      	if (reader->status != PACKET_READ_FLUSH)
      		die(_("expected flush after ref listing"));
      
    -+	if (stateless_rpc) {
    -+		if (packet_reader_read(reader) != PACKET_READ_RESPONSE_END)
    -+			die(_("expected response end packet after ref listing"));
    -+		if (packet_reader_read(reader) != PACKET_READ_FLUSH)
    -+			die(_("expected flush packet after response end"));
    -+	}
    ++	check_stateless_delimiter(stateless_rpc, reader,
    ++				  _("expected response end packet after ref listing"));
     +
      	return list;
      }
      
     
    - ## fetch-pack.c ##
    -@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    - 	struct fetch_negotiator negotiator_alloc;
    - 	struct fetch_negotiator *negotiator;
    - 	int seen_ack = 0;
    -+	int check_http_delimiter;
    + ## connect.h ##
    +@@ connect.h: int server_supports_v2(const char *c, int die_on_error);
    + int server_supports_feature(const char *c, const char *feature,
    + 			    int die_on_error);
      
    - 	if (args->no_dependents) {
    - 		negotiator = NULL;
    -@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    - 	}
    - 
    - 	while (state != FETCH_DONE) {
    -+		check_http_delimiter = 0;
    ++void check_stateless_delimiter(int stateless_rpc,
    ++			       struct packet_reader *reader,
    ++			       const char *error);
     +
    - 		switch (state) {
    - 		case FETCH_CHECK_LOCAL:
    - 			sort_ref_list(&ref, ref_compare_name);
    + #endif
    +
    + ## fetch-pack.c ##
    +@@ fetch-pack.c: enum fetch_state {
    + 	FETCH_DONE,
    + };
    + 
    ++static void do_check_stateless_delimiter(const struct fetch_pack_args *args,
    ++					 struct packet_reader *reader)
    ++{
    ++	check_stateless_delimiter(args->stateless_rpc, reader,
    ++				  _("git fetch-pack: expected response end packet"));
    ++}
    ++
    + static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    + 				    int fd[2],
    + 				    const struct ref *orig_ref,
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    + 			/* Process ACKs/NAKs */
    + 			switch (process_acks(negotiator, &reader, &common)) {
    + 			case READY:
    ++				/*
    ++				 * Don't check for response delimiter; get_pack() will
    ++				 * read the rest of this response.
    ++				 */
    + 				state = FETCH_GET_PACK;
    + 				break;
    + 			case COMMON_FOUND:
    +@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    + 				seen_ack = 1;
      				/* fallthrough */
      			case NO_COMMON_FOUND:
    ++				do_check_stateless_delimiter(args, &reader);
      				state = FETCH_SEND_REQUEST;
    -+				check_http_delimiter = 1;
      				break;
      			}
    - 			break;
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    + 			process_section_header(&reader, "packfile", 0);
    + 			if (get_pack(args, fd, pack_lockfile, sought, nr_sought))
      				die(_("git fetch-pack: fetch failed."));
    ++			do_check_stateless_delimiter(args, &reader);
      
      			state = FETCH_DONE;
    -+			check_http_delimiter = 1;
      			break;
    - 		case FETCH_DONE:
    - 			continue;
    - 		}
    -+
    -+		if (args->stateless_rpc && check_http_delimiter) {
    -+			if (packet_reader_read(&reader) != PACKET_READ_RESPONSE_END)
    -+				die(_("git fetch-pack: expected response end packet"));
    -+			if (packet_reader_read(&reader) != PACKET_READ_FLUSH)
    -+				die(_("git fetch-pack: expected flush packet"));
    -+		}
    - 	}
    - 
    - 	if (negotiator)
     
      ## remote-curl.c ##
     @@ remote-curl.c: static void check_pktline(struct check_pktline_state *state, const char *ptr, si
    @@ remote-curl.c: static int post_rpc(struct rpc_state *rpc, int stateless_connect,
      	if (rpc_in_data.pktline_state.remaining)
      		err = error(_("%d bytes of body are still expected"), rpc_in_data.pktline_state.remaining);
      
    -+	if (stateless_connect) {
    ++	if (stateless_connect)
     +		packet_response_end(rpc->in);
    -+		packet_flush(rpc->in);
    -+	}
     +
      	curl_slist_free_all(headers);
      	free(gzip_body);
-- 
2.26.2.706.g87896c9627

