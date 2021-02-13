Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B32C433E6
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F8764E9A
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhBMAKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 19:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhBMAKj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 19:10:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715CAC061788
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so1410673wrz.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=icm2w+4C0GUs3PVERRiQoVk8ADETy4pfaQXsjS7Kjv0=;
        b=AYg6We3hqAlsBMyp3B9xJgn1q1UiiDajOvIpqYWGKesI+AZTpgCr8wgz/1ZqWG/53g
         /ND9Lt/fqOGnMg2WDmhVqoSu4oqrcnUw9XLLw5265xmTka7CQ5ALPdky2SC527cT0ns3
         +4YDZZGjEzncmmBDL7Pzk7FiXHxo+FwXi5zGpjliHK0i2fP+QKaU0Wm5Gp7fZSHSdgJb
         D54H/LLC9GDuh+Zt63dTNeJCaubG6ChZfLe+W+cuiorU5MMlPm0AflrELcG4DUPbAgC3
         eWwULhxY2vLIzKaLaCatZyZAbzY6sGsUyNmRE2Sqyuoms2+XPsLHzj44aAPGpgmXXfXQ
         r3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=icm2w+4C0GUs3PVERRiQoVk8ADETy4pfaQXsjS7Kjv0=;
        b=dvMIPDh2Nn0COyDOXopG3L3ShEwjw1xYoe6ed2BTLLebAsGN1JDIUolTmWtiUo+PNm
         yeGBtYxt9K3Fi1e531kVZbYdociRKX2lThrqIrNCq6hAwCpU06wj28QQvEJGcXlYA6FX
         BAt9oa+VDQrjZNYBx+KjR5NAjEJAyBB6gGN0P63dYGyvMpGEGcKdivFVI5oq28+qKRY1
         MXAptKb+BISBreJSoS+nTvQSXSS3159f+AeKyu5CEqP2yiG0m+9f9auygazOaeHowyWm
         lFULaK19GZgCgyr+UBKu/zMDDPuheCG9DgKsPsunW5OwDPlvoCEcJRv9GyOg+r/MLZBQ
         MoLw==
X-Gm-Message-State: AOAM5321eELmN37U6xQLYEvtjRCmL1w+IcoKPjVwRp7puqzxE5AxoAUU
        TgM258zJMQYO2YeuTjq0bArPrUujoqE=
X-Google-Smtp-Source: ABdhPJzFUafiwT8jymQ6W8P9caEtVJm2whyFKUMyLEKdRzp75l2909LaYFt4xNpyONegFm1rO60riA==
X-Received: by 2002:adf:fd89:: with SMTP id d9mr6181259wrr.255.1613174956144;
        Fri, 12 Feb 2021 16:09:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm8627621wrw.46.2021.02.12.16.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 16:09:15 -0800 (PST)
Message-Id: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 00:09:01 +0000
Subject: [PATCH v3 00/12] Simple IPC Mechanism
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is version 3 of my "Simple IPC" series. It addresses the following
review comments from V2:

[1] Convert packet_write_gently() to write the header length and then the
actual buffer using 2 syscalls and avoid the need for a static or stack
buffer and update callers.

[2] Added buffer argument to write_packetized_from_fd() to force (the one
caller) to provide a buffer and avoid the same thread issues discussed
earlier.

[3] Remove the implicit pkt-flush from write_packetized_from_buf(). (V2
added a flag to make it optional and I removed that too.) Updated the
existing callers to call packet_flush_gently() as desired. Renamed
write_packetized_*() functions to have ..._no_flush() suffix to prevent
future accidents with new (more limited) functionality.

[4] Removed the "force_unlink" flag to the unix-socket options that I added
in V1/V2.

[5] Created a new unix_stream_server__listen_with_lock() wrapper function to
safely create a Unix domain socket while holding a lockfile and (hopefully)
eliminate the previously discussed race conditions. Added a little helper
struct and related routines to help manage the life of the socket.

[6] Added test-tool simple-ipc start-daemon to launch a background instance
of test-tool simple-ipc run-daemon and wait for the server to become ready
before exiting. And updated t0052 to use it and avoid the problematic sleep
1 in V1/V2. (There was discussion on the mailing list about using a FIFO in
the test like lib-git-daemon.sh, but there are issues with FIFO support on
Windows that I didn't want to step into. (And I want to use the same "run"
and "start" technique with the FSMonitor layer, so lets me explore that
here.)

[7] Rebased onto v2.30.1 to get rid of a copy of Junio's "brew cask" commit
(3831132ace) that I included in earlier versions of this series.

[8] In response Gábor's comments about a CI test failure on "quit works"
(https://lore.kernel.org/git/20210205193847.GG2091@szeder.dev/) I added a
generous sleep and comments. I'm not completely happy with this solution,
but I'm not sure of a better solution right now.

[9] In response to Taylor's comment on read_packetized_to_strbuf()
(https://lore.kernel.org/git/YCSN260gqNV+DyTI@nand.local/), I've moved
PACKET_READ_GENTLE_ON_EOF flag to all the callers as suggested.

cc: Ævar Arnfjörð Bjarmason avarab@gmail.com cc: Jeff Hostetler
git@jeffhostetler.com cc: Jeff King peff@peff.net cc: Chris Torek
chris.torek@gmail.com

Jeff Hostetler (9):
  pkt-line: eliminate the need for static buffer in
    packet_write_gently()
  simple-ipc: design documentation for new IPC mechanism
  simple-ipc: add win32 implementation
  unix-socket: elimiate static unix_stream_socket() helper function
  unix-socket: add backlog size option to unix_stream_listen()
  unix-socket: disallow chdir() when creating unix domain sockets
  unix-socket: create `unix_stream_server__listen_with_lock()`
  simple-ipc: add Unix domain socket implementation
  t0052: add simple-ipc tests and t/helper/test-simple-ipc tool

Johannes Schindelin (3):
  pkt-line: do not issue flush packets in write_packetized_*()
  pkt-line: (optionally) libify the packet readers
  pkt-line: add options argument to read_packetized_to_strbuf()

 Documentation/technical/api-simple-ipc.txt |  34 +
 Makefile                                   |   8 +
 builtin/credential-cache--daemon.c         |   3 +-
 builtin/credential-cache.c                 |   2 +-
 compat/simple-ipc/ipc-shared.c             |  28 +
 compat/simple-ipc/ipc-unix-socket.c        | 979 +++++++++++++++++++++
 compat/simple-ipc/ipc-win32.c              | 749 ++++++++++++++++
 config.mak.uname                           |   2 +
 contrib/buildsystems/CMakeLists.txt        |   6 +
 convert.c                                  |  16 +-
 pkt-line.c                                 |  57 +-
 pkt-line.h                                 |  20 +-
 simple-ipc.h                               | 235 +++++
 t/helper/test-simple-ipc.c                 | 713 +++++++++++++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/t0052-simple-ipc.sh                      | 134 +++
 unix-socket.c                              | 168 +++-
 unix-socket.h                              |  47 +-
 19 files changed, 3150 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/technical/api-simple-ipc.txt
 create mode 100644 compat/simple-ipc/ipc-shared.c
 create mode 100644 compat/simple-ipc/ipc-unix-socket.c
 create mode 100644 compat/simple-ipc/ipc-win32.c
 create mode 100644 simple-ipc.h
 create mode 100644 t/helper/test-simple-ipc.c
 create mode 100755 t/t0052-simple-ipc.sh


base-commit: 773e25afc41b1b6533fa9ae2cd825d0b4a697fad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-766%2Fjeffhostetler%2Fsimple-ipc-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-766/jeffhostetler/simple-ipc-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/766

Range-diff vs v2:

  1:  4c6766d41834 <  -:  ------------ ci/install-depends: attempt to fix "brew cask" stuff
  2:  3b03a8ff7a72 !  1:  2d6858b1625a pkt-line: promote static buffer in packet_write_gently() to callers
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    pkt-line: promote static buffer in packet_write_gently() to callers
     +    pkt-line: eliminate the need for static buffer in packet_write_gently()
      
     -    Move the static buffer used in `packet_write_gently()` to its callers.
     -    This is a first step to make packet writing more thread-safe.
     +    Teach `packet_write_gently()` to write the pkt-line header and the actual
     +    buffer in 2 separate calls to `write_in_full()` and avoid the need for a
     +    static buffer, thread-safe scratch space, or an excessively large stack
     +    buffer.
     +
     +    Change the API of `write_packetized_from_fd()` to accept a scratch space
     +    argument from its caller to avoid similar issues here.
     +
     +    These changes are intended to make it easier to use pkt-line routines in
     +    a multi-threaded context with multiple concurrent writers writing to
     +    different streams.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     + ## convert.c ##
     +@@ convert.c: static int apply_multi_file_filter(const char *path, const char *src, size_t len
     + 	if (err)
     + 		goto done;
     + 
     +-	if (fd >= 0)
     +-		err = write_packetized_from_fd(fd, process->in);
     +-	else
     ++	if (fd >= 0) {
     ++		struct packet_scratch_space scratch;
     ++		err = write_packetized_from_fd(fd, process->in, &scratch);
     ++	} else
     + 		err = write_packetized_from_buf(src, len, process->in);
     + 	if (err)
     + 		goto done;
     +
       ## pkt-line.c ##
      @@ pkt-line.c: int packet_write_fmt_gently(int fd, const char *fmt, ...)
     - 	return status;
     - }
       
     --static int packet_write_gently(const int fd_out, const char *buf, size_t size)
     -+/*
     -+ * Use the provided scratch space to build a combined <hdr><buf> buffer
     -+ * and write it to the file descriptor (in one write if possible).
     -+ */
     -+static int packet_write_gently(const int fd_out, const char *buf, size_t size,
     -+			       struct packet_scratch_space *scratch)
     + static int packet_write_gently(const int fd_out, const char *buf, size_t size)
       {
      -	static char packet_write_buffer[LARGE_PACKET_MAX];
     ++	char header[4];
       	size_t packet_size;
       
      -	if (size > sizeof(packet_write_buffer) - 4)
     -+	if (size > sizeof(scratch->buffer) - 4)
     ++	if (size > LARGE_PACKET_DATA_MAX)
       		return error(_("packet write failed - data exceeds max packet size"));
       
       	packet_trace(buf, size, 1);
     @@ pkt-line.c: int packet_write_fmt_gently(int fd, const char *fmt, ...)
      -	memcpy(packet_write_buffer + 4, buf, size);
      -	if (write_in_full(fd_out, packet_write_buffer, packet_size) < 0)
      +
     -+	set_packet_header(scratch->buffer, packet_size);
     -+	memcpy(scratch->buffer + 4, buf, size);
     ++	set_packet_header(header, packet_size);
      +
     -+	if (write_in_full(fd_out, scratch->buffer, packet_size) < 0)
     ++	/*
     ++	 * Write the header and the buffer in 2 parts so that we do not need
     ++	 * to allocate a buffer or rely on a static buffer.  This avoids perf
     ++	 * and multi-threading issues.
     ++	 */
     ++
     ++	if (write_in_full(fd_out, header, 4) < 0 ||
     ++	    write_in_full(fd_out, buf, size) < 0)
       		return error(_("packet write failed"));
       	return 0;
       }
     - 
     - void packet_write(int fd_out, const char *buf, size_t size)
     - {
     --	if (packet_write_gently(fd_out, buf, size))
     -+	static struct packet_scratch_space scratch;
     -+
     -+	if (packet_write_gently(fd_out, buf, size, &scratch))
     - 		die_errno(_("packet write failed"));
     - }
     - 
      @@ pkt-line.c: void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
     + 	packet_trace(data, len, 1);
     + }
       
     - int write_packetized_from_fd(int fd_in, int fd_out)
     +-int write_packetized_from_fd(int fd_in, int fd_out)
     ++int write_packetized_from_fd(int fd_in, int fd_out,
     ++			     struct packet_scratch_space *scratch)
       {
     -+	/*
     -+	 * TODO We could save a memcpy() if we essentially inline
     -+	 * TODO packet_write_gently() here and change the xread()
     -+	 * TODO to pass &buf[4].
     -+	 */
     -+	static struct packet_scratch_space scratch;
     - 	static char buf[LARGE_PACKET_DATA_MAX];
     +-	static char buf[LARGE_PACKET_DATA_MAX];
       	int err = 0;
       	ssize_t bytes_to_write;
     -@@ pkt-line.c: int write_packetized_from_fd(int fd_in, int fd_out)
     + 
     + 	while (!err) {
     +-		bytes_to_write = xread(fd_in, buf, sizeof(buf));
     ++		bytes_to_write = xread(fd_in, scratch->buffer,
     ++				       sizeof(scratch->buffer));
     + 		if (bytes_to_write < 0)
       			return COPY_READ_ERROR;
       		if (bytes_to_write == 0)
       			break;
      -		err = packet_write_gently(fd_out, buf, bytes_to_write);
     -+		err = packet_write_gently(fd_out, buf, bytes_to_write, &scratch);
     ++		err = packet_write_gently(fd_out, scratch->buffer,
     ++					  bytes_to_write);
       	}
       	if (!err)
       		err = packet_flush_gently(fd_out);
     -@@ pkt-line.c: int write_packetized_from_fd(int fd_in, int fd_out)
     - 
     - int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
     - {
     -+	static struct packet_scratch_space scratch;
     - 	int err = 0;
     - 	size_t bytes_written = 0;
     - 	size_t bytes_to_write;
     -@@ pkt-line.c: int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
     - 			bytes_to_write = len - bytes_written;
     - 		if (bytes_to_write == 0)
     - 			break;
     --		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
     -+		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write, &scratch);
     - 		bytes_written += bytes_to_write;
     - 	}
     - 	if (!err)
      
       ## pkt-line.h ##
      @@
     @@ pkt-line.h
      +#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
      +
      +struct packet_scratch_space {
     -+	char buffer[LARGE_PACKET_MAX];
     ++	char buffer[LARGE_PACKET_DATA_MAX]; /* does not include header bytes */
      +};
      +
       /*
        * Write a packetized stream, where each line is preceded by
        * its length (including the header) as a 4-byte hex number.
     +@@ pkt-line.h: void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
     + void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
     + int packet_flush_gently(int fd);
     + int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
     +-int write_packetized_from_fd(int fd_in, int fd_out);
     ++int write_packetized_from_fd(int fd_in, int fd_out, struct packet_scratch_space *scratch);
     + int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
     + 
     + /*
      @@ pkt-line.h: enum packet_read_status packet_reader_read(struct packet_reader *reader);
       enum packet_read_status packet_reader_peek(struct packet_reader *reader);
       
  3:  e671894b4c04 <  -:  ------------ pkt-line: add write_packetized_from_buf2() that takes scratch buffer
  4:  0832f7d324da !  2:  91a9f63d6692 pkt-line: optionally skip the flush packet in write_packetized_from_buf()
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    pkt-line: optionally skip the flush packet in write_packetized_from_buf()
     +    pkt-line: do not issue flush packets in write_packetized_*()
      
     -    This function currently has only one caller: `apply_multi_file_filter()`
     -    in `convert.c`. That caller wants a flush packet to be written after
     -    writing the payload.
     +    Remove the `packet_flush_gently()` call in `write_packetized_from_buf() and
     +    `write_packetized_from_fd()` and require the caller to call it if desired.
     +    Rename both functions to `write_packetized_from_*_no_flush()` to prevent
     +    later merge accidents.
      
     -    However, we are about to introduce a user that wants to write many
     -    packets before a final flush packet, so let's extend this function to
     -    prepare for that scenario.
     +    `write_packetized_from_buf()` currently only has one caller:
     +    `apply_multi_file_filter()` in `convert.c`.  It always wants a flush packet
     +    to be written after writing the payload.
     +
     +    However, we are about to introduce a caller that wants to write many
     +    packets before a final flush packet, so let's make the caller responsible
     +    for emitting the flush packet.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## convert.c ##
      @@ convert.c: static int apply_multi_file_filter(const char *path, const char *src, size_t len
     - 	if (fd >= 0)
     - 		err = write_packetized_from_fd(fd, process->in);
     - 	else
     + 
     + 	if (fd >= 0) {
     + 		struct packet_scratch_space scratch;
     +-		err = write_packetized_from_fd(fd, process->in, &scratch);
     ++		err = write_packetized_from_fd_no_flush(fd, process->in, &scratch);
     + 	} else
      -		err = write_packetized_from_buf(src, len, process->in);
     -+		err = write_packetized_from_buf(src, len, process->in, 1);
     ++		err = write_packetized_from_buf_no_flush(src, len, process->in);
     ++	if (err)
     ++		goto done;
     ++
     ++	err = packet_flush_gently(process->in);
       	if (err)
       		goto done;
       
      
       ## pkt-line.c ##
     -@@ pkt-line.c: int write_packetized_from_fd(int fd_in, int fd_out)
     - 	return err;
     +@@ pkt-line.c: void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
     + 	packet_trace(data, len, 1);
       }
       
     --int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
     -+int write_packetized_from_buf(const char *src_in, size_t len, int fd_out,
     -+			      int flush_at_end)
     +-int write_packetized_from_fd(int fd_in, int fd_out,
     +-			     struct packet_scratch_space *scratch)
     ++int write_packetized_from_fd_no_flush(int fd_in, int fd_out,
     ++				      struct packet_scratch_space *scratch)
       {
     - 	static struct packet_scratch_space scratch;
     - 
     --	return write_packetized_from_buf2(src_in, len, fd_out, &scratch);
     -+	return write_packetized_from_buf2(src_in, len, fd_out,
     -+					  flush_at_end, &scratch);
     + 	int err = 0;
     + 	ssize_t bytes_to_write;
     +@@ pkt-line.c: int write_packetized_from_fd(int fd_in, int fd_out,
     + 		err = packet_write_gently(fd_out, scratch->buffer,
     + 					  bytes_to_write);
     + 	}
     +-	if (!err)
     +-		err = packet_flush_gently(fd_out);
     + 	return err;
       }
       
     - int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
     -+			       int flush_at_end,
     - 			       struct packet_scratch_space *scratch)
     +-int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
     ++int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out)
       {
       	int err = 0;
     -@@ pkt-line.c: int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
     - 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write, scratch);
     + 	size_t bytes_written = 0;
     +@@ pkt-line.c: int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
     + 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
       		bytes_written += bytes_to_write;
       	}
      -	if (!err)
     -+	if (!err && flush_at_end)
     - 		err = packet_flush_gently(fd_out);
     +-		err = packet_flush_gently(fd_out);
       	return err;
       }
     + 
      
       ## pkt-line.h ##
     -@@ pkt-line.h: void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
     +@@ pkt-line.h: void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
     + void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
       int packet_flush_gently(int fd);
       int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
     - int write_packetized_from_fd(int fd_in, int fd_out);
     +-int write_packetized_from_fd(int fd_in, int fd_out, struct packet_scratch_space *scratch);
      -int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
     -+int write_packetized_from_buf(const char *src_in, size_t len, int fd_out,
     -+			      int flush_at_end);
     - int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
     -+			       int flush_at_end,
     - 			       struct packet_scratch_space *scratch);
     ++int write_packetized_from_fd_no_flush(int fd_in, int fd_out, struct packet_scratch_space *scratch);
     ++int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out);
       
       /*
     +  * Read a packetized line into the buffer, which must be at least size bytes
  5:  43bc4a26b790 !  3:  e05467def4e1 pkt-line: (optionally) libify the packet readers
     @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_b
       		*pktlen = -1;
      
       ## pkt-line.h ##
     -@@ pkt-line.h: int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
     +@@ pkt-line.h: int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_ou
        *
        * If options contains PACKET_READ_DIE_ON_ERR_PACKET, it dies when it sees an
        * ERR packet.
  6:  6a389a353351 !  4:  81e14bed955c pkt-line: accept additional options in read_packetized_to_strbuf()
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    pkt-line: accept additional options in read_packetized_to_strbuf()
     +    pkt-line: add options argument to read_packetized_to_strbuf()
      
     -    The `read_packetized_to_strbuf()` function reads packets into a strbuf
     -    until a flush packet has been received. So far, it has only one caller:
     -    `apply_multi_file_filter()` in `convert.c`. This caller really only
     -    needs the `PACKET_READ_GENTLE_ON_EOF` option to be passed to
     -    `packet_read()` (which makes sense in the scenario where packets should
     -    be read until a flush packet is received).
     +    Update the calling sequence of `read_packetized_to_strbuf()` to take
     +    an options argument and not assume a fixed set of options.  Update the
     +    only existing caller accordingly to explicitly pass the
     +    formerly-assumed flags.
      
     -    We are about to introduce a caller that wants to pass other options
     -    through to `packet_read()`, so let's extend the function signature
     -    accordingly.
     +    The `read_packetized_to_strbuf()` function calls `packet_read()` with
     +    a fixed set of assumed options (`PACKET_READ_GENTLE_ON_EOF`).  This
     +    assumption has been fine for the single existing caller
     +    `apply_multi_file_filter()` in `convert.c`.
     +
     +    In a later commit we would like to add other callers to
     +    `read_packetized_to_strbuf()` that need a different set of options.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## convert.c ##
      @@ convert.c: static int apply_multi_file_filter(const char *path, const char *src, size_t len
     @@ convert.c: static int apply_multi_file_filter(const char *path, const char *src,
       			goto done;
       
      -		err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
     -+		err = read_packetized_to_strbuf(process->out, &nbuf, 0) < 0;
     ++		err = read_packetized_to_strbuf(process->out, &nbuf,
     ++						PACKET_READ_GENTLE_ON_EOF) < 0;
       		if (err)
       			goto done;
       
     @@ pkt-line.c: ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
       			 */
       			sb_out->buf + sb_out->len, LARGE_PACKET_DATA_MAX+1,
      -			PACKET_READ_GENTLE_ON_EOF);
     -+			options | PACKET_READ_GENTLE_ON_EOF);
     ++			options);
       		if (packet_len <= 0)
       			break;
       		sb_out->len += packet_len;
      
       ## pkt-line.h ##
      @@ pkt-line.h: char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
     - 
       /*
        * Reads a stream of variable sized packets until a flush packet is detected.
     -+ *
     -+ * The options are augmented by PACKET_READ_GENTLE_ON_EOF and passed to
     -+ * packet_read.
        */
      -ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
     -+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out,
     -+				  int options);
     ++ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out, int options);
       
       /*
        * Receive multiplexed output stream over git native protocol.
  7:  a7275b4bdc2a =  5:  22eec60761a8 simple-ipc: design documentation for new IPC mechanism
  8:  388366913d41 !  6:  171ec43ecfa4 simple-ipc: add win32 implementation
     @@ compat/simple-ipc/ipc-win32.c (new)
      +
      +	trace2_region_enter("ipc-client", "send-command", NULL);
      +
     -+	if (write_packetized_from_buf2(message, strlen(message),
     -+				       connection->fd, 1,
     -+				       &connection->scratch_write_buffer) < 0) {
     ++	if (write_packetized_from_buf_no_flush(message, strlen(message),
     ++					       connection->fd) < 0 ||
     ++	    packet_flush_gently(connection->fd) < 0) {
      +		ret = error(_("could not send IPC command"));
      +		goto done;
      +	}
      +
      +	FlushFileBuffers((HANDLE)_get_osfhandle(connection->fd));
      +
     -+	if (read_packetized_to_strbuf(connection->fd, answer,
     -+				      PACKET_READ_NEVER_DIE) < 0) {
     ++	if (read_packetized_to_strbuf(
     ++		    connection->fd, answer,
     ++		    PACKET_READ_GENTLE_ON_EOF | PACKET_READ_NEVER_DIE) < 0) {
      +		ret = error(_("could not read IPC response"));
      +		goto done;
      +	}
     @@ compat/simple-ipc/ipc-win32.c (new)
      +	struct ipc_server_data *server_data;
      +	pthread_t pthread_id;
      +	HANDLE hPipe;
     -+	struct packet_scratch_space scratch_write_buffer;
      +};
      +
      +/*
     @@ compat/simple-ipc/ipc-win32.c (new)
      +static int do_io_reply_callback(struct ipc_server_reply_data *reply_data,
      +		       const char *response, size_t response_len)
      +{
     -+	struct packet_scratch_space *scratch =
     -+		&reply_data->server_thread_data->scratch_write_buffer;
     -+
      +	if (reply_data->magic != MAGIC_SERVER_REPLY_DATA)
      +		BUG("reply_cb called with wrong instance data");
      +
     -+	return write_packetized_from_buf2(response, response_len,
     -+					  reply_data->fd, 0, scratch);
     ++	return write_packetized_from_buf_no_flush(response, response_len,
     ++						  reply_data->fd);
      +}
      +
      +/*
     @@ compat/simple-ipc/ipc-win32.c (new)
      +		return error(_("could not create fd from pipe for '%s'"),
      +			     server_thread_data->server_data->buf_path.buf);
      +
     -+	ret = read_packetized_to_strbuf(reply_data.fd, &buf,
     -+					PACKET_READ_NEVER_DIE);
     ++	ret = read_packetized_to_strbuf(
     ++		reply_data.fd, &buf,
     ++		PACKET_READ_GENTLE_ON_EOF | PACKET_READ_NEVER_DIE);
      +	if (ret >= 0) {
      +		ret = server_thread_data->server_data->application_cb(
      +			server_thread_data->server_data->application_data,
     @@ simple-ipc.h (new)
      +
      +struct ipc_client_connection {
      +	int fd;
     -+	struct packet_scratch_space scratch_write_buffer;
      +};
      +
      +/*
 10:  f5d5445cf42e !  7:  b368318e6a23 unix-socket: elimiate static unix_stream_socket() helper function
     @@ Metadata
       ## Commit message ##
          unix-socket: elimiate static unix_stream_socket() helper function
      
     -    The static helper function `unix_stream_socket()` calls `die()`.  This is not
     -    appropriate for all callers.  Eliminate the wrapper function and move the
     -    existing error handling to the callers in preparation for adapting specific
     -    callers.
     +    The static helper function `unix_stream_socket()` calls `die()`.  This
     +    is not appropriate for all callers.  Eliminate the wrapper function
     +    and make the callers propagate the error.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ unix-socket.c
       static int chdir_len(const char *orig, int len)
       {
       	char *path = xmemdupz(orig, len);
     -@@ unix-socket.c: int unix_stream_connect(const char *path)
     +@@ unix-socket.c: static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
     + 
     + int unix_stream_connect(const char *path)
     + {
     +-	int fd, saved_errno;
     ++	int fd = -1, saved_errno;
     + 	struct sockaddr_un sa;
     + 	struct unix_sockaddr_context ctx;
       
       	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
       		return -1;
      -	fd = unix_stream_socket();
      +	fd = socket(AF_UNIX, SOCK_STREAM, 0);
      +	if (fd < 0)
     -+		die_errno("unable to create socket");
     ++		goto fail;
      +
       	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
       		goto fail;
       	unix_sockaddr_cleanup(&ctx);
     +@@ unix-socket.c: int unix_stream_connect(const char *path)
     + 
     + fail:
     + 	saved_errno = errno;
     ++	if (fd != -1)
     ++		close(fd);
     + 	unix_sockaddr_cleanup(&ctx);
     +-	close(fd);
     + 	errno = saved_errno;
     + 	return -1;
     + }
     + 
     + int unix_stream_listen(const char *path)
     + {
     +-	int fd, saved_errno;
     ++	int fd = -1, saved_errno;
     + 	struct sockaddr_un sa;
     + 	struct unix_sockaddr_context ctx;
     + 
      @@ unix-socket.c: int unix_stream_listen(const char *path)
       
       	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
     @@ unix-socket.c: int unix_stream_listen(const char *path)
      -	fd = unix_stream_socket();
      +	fd = socket(AF_UNIX, SOCK_STREAM, 0);
      +	if (fd < 0)
     -+		die_errno("unable to create socket");
     ++		goto fail;
       
       	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
       		goto fail;
     +@@ unix-socket.c: int unix_stream_listen(const char *path)
     + 
     + fail:
     + 	saved_errno = errno;
     ++	if (fd != -1)
     ++		close(fd);
     + 	unix_sockaddr_cleanup(&ctx);
     +-	close(fd);
     + 	errno = saved_errno;
     + 	return -1;
     + }
 11:  7a6a69dfc20c !  8:  985b2e02b2df unix-socket: add options to unix_stream_listen()
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    unix-socket: add options to unix_stream_listen()
     +    unix-socket: add backlog size option to unix_stream_listen()
      
          Update `unix_stream_listen()` to take an options structure to override
     -    default behaviors.  This includes the size of the `listen()` backlog
     -    and whether it should always unlink the socket file before trying to
     -    create a new one.  Also eliminate calls to `die()` if it cannot create
     -    a socket.
     -
     -    Normally, `unix_stream_listen()` always tries to `unlink()` the
     -    socket-path before calling `bind()`.  If there is an existing
     -    server/daemon already bound and listening on that socket-path, our
     -    `unlink()` would have the effect of disassociating the existing
     -    server's bound-socket-fd from the socket-path without notifying the
     -    existing server.  The existing server could continue to service
     -    existing connections (accepted-socket-fd's), but would not receive any
     -    futher new connections (since clients rendezvous via the socket-path).
     -    The existing server would effectively be offline but yet appear to be
     -    active.
     -
     -    Furthermore, `unix_stream_listen()` creates an opportunity for a brief
     -    race condition for connecting clients if they try to connect in the
     -    interval between the forced `unlink()` and the subsequent `bind()` (which
     -    recreates the socket-path that is bound to a new socket-fd in the current
     -    process).
     +    default behaviors.  This commit includes the size of the `listen()` backlog.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ unix-socket.c: int unix_stream_connect(const char *path)
      +int unix_stream_listen(const char *path,
      +		       const struct unix_stream_listen_opts *opts)
       {
     --	int fd, saved_errno;
     -+	int fd = -1;
     -+	int saved_errno;
     -+	int bind_successful = 0;
     + 	int fd = -1, saved_errno;
      +	int backlog;
       	struct sockaddr_un sa;
       	struct unix_sockaddr_context ctx;
       
     --	unlink(path);
     --
     - 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
     - 		return -1;
     -+
     - 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
     - 	if (fd < 0)
     --		die_errno("unable to create socket");
     -+		goto fail;
     -+
     -+	if (opts->force_unlink_before_bind)
     -+		unlink(path);
     - 
     +@@ unix-socket.c: int unix_stream_listen(const char *path)
       	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
       		goto fail;
     -+	bind_successful = 1;
       
      -	if (listen(fd, 5) < 0)
     -+	if (opts->listen_backlog_size > 0)
     -+		backlog = opts->listen_backlog_size;
     -+	else
     -+		backlog = 5;
     ++	backlog = opts->listen_backlog_size;
     ++	if (backlog <= 0)
     ++		backlog = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG;
      +	if (listen(fd, backlog) < 0)
       		goto fail;
       
       	unix_sockaddr_cleanup(&ctx);
     -@@ unix-socket.c: int unix_stream_listen(const char *path)
     - fail:
     - 	saved_errno = errno;
     - 	unix_sockaddr_cleanup(&ctx);
     --	close(fd);
     -+	if (fd != -1)
     -+		close(fd);
     -+	if (bind_successful)
     -+		unlink(path);
     - 	errno = saved_errno;
     - 	return -1;
     - }
      
       ## unix-socket.h ##
      @@
     @@ unix-socket.h
       
      +struct unix_stream_listen_opts {
      +	int listen_backlog_size;
     -+	unsigned int force_unlink_before_bind:1;
      +};
      +
     ++#define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
     ++
      +#define UNIX_STREAM_LISTEN_OPTS_INIT \
      +{ \
     -+	.listen_backlog_size = 5, \
     -+	.force_unlink_before_bind = 1, \
     ++	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
      +}
      +
       int unix_stream_connect(const char *path);
 12:  745b6d5fb746 !  9:  1bfa36409d07 unix-socket: add no-chdir option to unix_stream_listen()
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    unix-socket: add no-chdir option to unix_stream_listen()
     +    unix-socket: disallow chdir() when creating unix domain sockets
      
          Calls to `chdir()` are dangerous in a multi-threaded context.  If
     -    `unix_stream_listen()` is given a socket pathname that is too big to
     -    fit in a `sockaddr_un` structure, it will `chdir()` to the parent
     -    directory of the requested socket pathname, create the socket using a
     -    relative pathname, and then `chdir()` back.  This is not thread-safe.
     +    `unix_stream_listen()` or `unix_stream_connect()` is given a socket
     +    pathname that is too long to fit in a `sockaddr_un` structure, it will
     +    `chdir()` to the parent directory of the requested socket pathname,
     +    create the socket using a relative pathname, and then `chdir()` back.
     +    This is not thread-safe.
      
     -    Add `disallow_chdir` flag to `struct unix_sockaddr_context` and change
     -    all callers to pass an initialized context structure.
     -
     -    Teach `unix_sockaddr_init()` to not allow calls to `chdir()` when flag
     -    is set.
     +    Teach `unix_sockaddr_init()` to not allow calls to `chdir()` when this
     +    flag is set.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     - ## unix-socket.c ##
     -@@ unix-socket.c: static int chdir_len(const char *orig, int len)
     + ## builtin/credential-cache.c ##
     +@@
     + static int send_request(const char *socket, const struct strbuf *out)
     + {
     + 	int got_data = 0;
     +-	int fd = unix_stream_connect(socket);
     ++	int fd = unix_stream_connect(socket, 0);
       
     - struct unix_sockaddr_context {
     - 	char *orig_dir;
     -+	unsigned int disallow_chdir:1;
     - };
     + 	if (fd < 0)
     + 		return -1;
     +
     + ## unix-socket.c ##
     +@@ unix-socket.c: static void unix_sockaddr_cleanup(struct unix_sockaddr_context *ctx)
     + }
       
     -+#define UNIX_SOCKADDR_CONTEXT_INIT \
     -+{ \
     -+	.orig_dir=NULL, \
     -+	.disallow_chdir=0, \
     -+}
     -+
     - static void unix_sockaddr_cleanup(struct unix_sockaddr_context *ctx)
     - {
     - 	if (!ctx->orig_dir)
     -@@ unix-socket.c: static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
     + static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
     +-			      struct unix_sockaddr_context *ctx)
     ++			      struct unix_sockaddr_context *ctx,
     ++			      int disallow_chdir)
       {
       	int size = strlen(path) + 1;
       
     --	ctx->orig_dir = NULL;
     -+	if (ctx->disallow_chdir && size > sizeof(sa->sun_path)) {
     -+		errno = ENAMETOOLONG;
     -+		return -1;
     -+	}
     -+
     + 	ctx->orig_dir = NULL;
       	if (size > sizeof(sa->sun_path)) {
     - 		const char *slash = find_last_dir_sep(path);
     +-		const char *slash = find_last_dir_sep(path);
     ++		const char *slash;
       		const char *dir;
     -@@ unix-socket.c: int unix_stream_connect(const char *path)
     + 		struct strbuf cwd = STRBUF_INIT;
     + 
     ++		if (disallow_chdir) {
     ++			errno = ENAMETOOLONG;
     ++			return -1;
     ++		}
     ++
     ++		slash = find_last_dir_sep(path);
     + 		if (!slash) {
     + 			errno = ENAMETOOLONG;
     + 			return -1;
     +@@ unix-socket.c: static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
     + 	return 0;
     + }
     + 
     +-int unix_stream_connect(const char *path)
     ++int unix_stream_connect(const char *path, int disallow_chdir)
       {
     - 	int fd, saved_errno;
     + 	int fd = -1, saved_errno;
       	struct sockaddr_un sa;
     --	struct unix_sockaddr_context ctx;
     -+	struct unix_sockaddr_context ctx = UNIX_SOCKADDR_CONTEXT_INIT;
     + 	struct unix_sockaddr_context ctx;
       
     - 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
     +-	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
     ++	if (unix_sockaddr_init(&sa, path, &ctx, disallow_chdir) < 0)
       		return -1;
     + 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
     + 	if (fd < 0)
      @@ unix-socket.c: int unix_stream_listen(const char *path,
     - 	int bind_successful = 0;
     - 	int backlog;
     - 	struct sockaddr_un sa;
     --	struct unix_sockaddr_context ctx;
     -+	struct unix_sockaddr_context ctx = UNIX_SOCKADDR_CONTEXT_INIT;
     -+
     -+	ctx.disallow_chdir = opts->disallow_chdir;
       
     - 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
     + 	unlink(path);
     + 
     +-	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
     ++	if (unix_sockaddr_init(&sa, path, &ctx, opts->disallow_chdir) < 0)
       		return -1;
     + 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
     + 	if (fd < 0)
      
       ## unix-socket.h ##
      @@
     + 
       struct unix_stream_listen_opts {
       	int listen_backlog_size;
     - 	unsigned int force_unlink_before_bind:1;
      +	unsigned int disallow_chdir:1;
       };
       
     + #define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
     +@@ unix-socket.h: struct unix_stream_listen_opts {
       #define UNIX_STREAM_LISTEN_OPTS_INIT \
       { \
     - 	.listen_backlog_size = 5, \
     - 	.force_unlink_before_bind = 1, \
     + 	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
      +	.disallow_chdir = 0, \
       }
       
     - int unix_stream_connect(const char *path);
     +-int unix_stream_connect(const char *path);
     ++int unix_stream_connect(const char *path, int disallow_chdir);
     + int unix_stream_listen(const char *path,
     + 		       const struct unix_stream_listen_opts *opts);
     + 
  -:  ------------ > 10:  b443e11ac32f unix-socket: create `unix_stream_server__listen_with_lock()`
 14:  72c1c209c380 ! 11:  43c8db9a4468 simple-ipc: add Unix domain socket implementation
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	*pfd = -1;
      +
      +	for (k = 0; k < timeout_ms; k += wait_ms) {
     -+		int fd = unix_stream_connect(path);
     ++		int fd = unix_stream_connect(path, options->uds_disallow_chdir);
      +
      +		if (fd != -1) {
      +			*pfd = fd;
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +
      +	trace2_region_enter("ipc-client", "send-command", NULL);
      +
     -+	if (write_packetized_from_buf2(message, strlen(message),
     -+				       connection->fd, 1,
     -+				       &connection->scratch_write_buffer) < 0) {
     ++	if (write_packetized_from_buf_no_flush(message, strlen(message),
     ++					       connection->fd) < 0 ||
     ++	    packet_flush_gently(connection->fd) < 0) {
      +		ret = error(_("could not send IPC command"));
      +		goto done;
      +	}
      +
     -+	if (read_packetized_to_strbuf(connection->fd, answer,
     -+				      PACKET_READ_NEVER_DIE) < 0) {
     ++	if (read_packetized_to_strbuf(
     ++		    connection->fd, answer,
     ++		    PACKET_READ_GENTLE_ON_EOF | PACKET_READ_NEVER_DIE) < 0) {
      +		ret = error(_("could not read IPC response"));
      +		goto done;
      +	}
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	struct ipc_worker_thread_data *next_thread;
      +	struct ipc_server_data *server_data;
      +	pthread_t pthread_id;
     -+	struct packet_scratch_space scratch_write_buffer;
      +};
      +
      +struct ipc_accept_thread_data {
      +	enum magic magic;
      +	struct ipc_server_data *server_data;
      +
     -+	int fd_listen;
     -+	struct stat st_listen;
     ++	struct unix_stream_server_socket *server_socket;
      +
      +	int fd_send_shutdown;
      +	int fd_wait_shutdown;
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +static int do_io_reply_callback(struct ipc_server_reply_data *reply_data,
      +		       const char *response, size_t response_len)
      +{
     -+	struct packet_scratch_space *scratch =
     -+		&reply_data->worker_thread_data->scratch_write_buffer;
     -+
      +	if (reply_data->magic != MAGIC_SERVER_REPLY_DATA)
      +		BUG("reply_cb called with wrong instance data");
      +
     -+	return write_packetized_from_buf2(response, response_len,
     -+					  reply_data->fd, 0, scratch);
     ++	return write_packetized_from_buf_no_flush(response, response_len,
     ++						  reply_data->fd);
      +}
      +
      +/* A randomly chosen value. */
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +
      +	reply_data.fd = fd;
      +
     -+	ret = read_packetized_to_strbuf(reply_data.fd, &buf,
     -+					PACKET_READ_NEVER_DIE);
     ++	ret = read_packetized_to_strbuf(
     ++		reply_data.fd, &buf,
     ++		PACKET_READ_GENTLE_ON_EOF | PACKET_READ_NEVER_DIE);
      +	if (ret >= 0) {
      +		ret = worker_thread_data->server_data->application_cb(
      +			worker_thread_data->server_data->application_data,
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +		if (ret == SIMPLE_IPC_QUIT) {
      +			trace2_data_string("ipc-worker", NULL, "queue_stop_async",
      +					   "application_quit");
     -+			/* The application told us to shutdown. */
     ++			/*
     ++			 * The application layer is telling the ipc-server
     ++			 * layer to shutdown.
     ++			 *
     ++			 * We DO NOT have a response to send to the client.
     ++			 *
     ++			 * Queue an async stop (to stop the other threads) and
     ++			 * allow this worker thread to exit now (no sense waiting
     ++			 * for the thread-pool shutdown signal).
     ++			 *
     ++			 * Other non-idle worker threads are allowed to finish
     ++			 * responding to their current clients.
     ++			 */
      +			ipc_server_stop_async(server_data);
      +			break;
      +		}
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	return NULL;
      +}
      +
     -+/*
     -+ * Return 1 if someone deleted or stole the on-disk socket from us.
     -+ */
     -+static int socket_was_stolen(struct ipc_accept_thread_data *accept_thread_data)
     -+{
     -+	struct stat st;
     -+	struct stat *ref_st = &accept_thread_data->st_listen;
     -+
     -+	if (lstat(accept_thread_data->server_data->buf_path.buf, &st) == -1)
     -+		return 1;
     -+
     -+	if (st.st_ino != ref_st->st_ino)
     -+		return 1;
     -+
     -+	/* We might also consider the creation time on some platforms. */
     -+
     -+	return 0;
     -+}
     -+
      +/* A randomly chosen value. */
      +#define MY_ACCEPT_POLL_TIMEOUT_MS (60 * 1000)
      +
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +		pollfd[0].fd = accept_thread_data->fd_wait_shutdown;
      +		pollfd[0].events = POLLIN;
      +
     -+		pollfd[1].fd = accept_thread_data->fd_listen;
     ++		pollfd[1].fd = accept_thread_data->server_socket->fd_socket;
      +		pollfd[1].events = POLLIN;
      +
      +		result = poll(pollfd, 2, MY_ACCEPT_POLL_TIMEOUT_MS);
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +
      +			/*
      +			 * If someone deletes or force-creates a new unix
     -+			 * domain socket at out path, all future clients
     ++			 * domain socket at our path, all future clients
      +			 * will be routed elsewhere and we silently starve.
      +			 * If that happens, just queue a shutdown.
      +			 */
     -+			if (socket_was_stolen(
     -+				    accept_thread_data)) {
     ++			if (unix_stream_server__was_stolen(
     ++				    accept_thread_data->server_socket)) {
      +				trace2_data_string("ipc-accept", NULL,
      +						   "queue_stop_async",
      +						   "socket_stolen");
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +		}
      +
      +		if (pollfd[1].revents & POLLIN) {
     -+			/* a connection is available on fd_listen */
     ++			/* a connection is available on server_socket */
      +
     -+			int client_fd = accept(accept_thread_data->fd_listen,
     -+					       NULL, NULL);
     ++			int client_fd =
     ++				accept(accept_thread_data->server_socket->fd_socket,
     ++				       NULL, NULL);
      +			if (client_fd >= 0)
      +				return client_fd;
      +
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      + */
      +#define LISTEN_BACKLOG (50)
      +
     -+/*
     -+ * Create a unix domain socket at the given path to listen for
     -+ * client connections.  The resulting socket will then appear
     -+ * in the filesystem as an inode with S_IFSOCK.  The inode is
     -+ * itself created as part of the `bind(2)` operation.
     -+ *
     -+ * The term "socket" is ambiguous in this context.  We want to open a
     -+ * "socket-fd" that is bound to a "socket-inode" (path) on disk.  We
     -+ * listen on "socket-fd" for new connections and clients try to
     -+ * open/connect using the "socket-inode" pathname.
     -+ *
     -+ * Unix domain sockets have a fundamental design flaw because the
     -+ * "socket-inode" persists until the pathname is deleted; closing the
     -+ * listening "socket-fd" only closes the socket handle/descriptor, it
     -+ * does not delete the inode/pathname.
     -+ *
     -+ * Well-behaving service daemons are expected to also delete the inode
     -+ * before shutdown.  If a service crashes (or forgets) it can leave
     -+ * the (now stale) inode in the filesystem.  This behaves like a stale
     -+ * ".lock" file and may prevent future service instances from starting
     -+ * up correctly.  (Because they won't be able to bind.)
     -+ *
     -+ * When future service instances try to create the listener socket,
     -+ * `bind(2)` will fail with EADDRINUSE -- because the inode already
     -+ * exists.  However, the new instance cannot tell if it is a stale
     -+ * inode *or* another service instance is already running.
     -+ *
     -+ * One possible solution is to blindly unlink the inode before
     -+ * attempting to bind a new socket-fd and thus create a new
     -+ * socket-inode.  Then `bind(2)` should always succeed.  However, if
     -+ * there is an existing service instance, it would be orphaned -- it
     -+ * would still be listening on a socket-fd that is still bound to an
     -+ * (unlinked) socket-inode, but that socket-inode is no longer
     -+ * associated with the pathname.  New client connections will arrive
     -+ * at OUR new socket-inode -- rather than the existing server's
     -+ * socket.  (I suppose it is up to the existing server to detect that
     -+ * its socket-inode has been stolen and shutdown.)
     -+ *
     -+ * Another possible solution is to try to use the ".lock" trick, but
     -+ * bind() does not have a exclusive-create use bit like open() does,
     -+ * so we cannot have multiple servers fighting/racing to create the
     -+ * same file name without having losers lose without knowing that they
     -+ * lost.
     -+ *
     -+ * We try to avoid such stealing and would rather fail to run than
     -+ * steal an existing socket-inode (because we assume that the
     -+ * existing server has more context and value to the clients than a
     -+ * freshly started server).  However, if multiple servers are racing
     -+ * to start, we don't care which one wins -- none of them have any
     -+ * state information yet worth fighting for.
     -+ *
     -+ * Create a "unique" socket-inode (with our PID in it (and assume that
     -+ * we can force-delete an existing socket with that name)).  Stat it
     -+ * to get the inode number and ctime -- so that we can identify it as
     -+ * the one we created.  Then use the atomic-rename trick to install it
     -+ * in the real location.  (This will unlink an existing socket with
     -+ * that pathname -- and thereby steal the real socket-inode from an
     -+ * existing server.)
     -+ *
     -+ * Elsewhere, our thread will periodically poll the socket-inode to
     -+ * see if someone else steals ours.
     -+ */
     -+static int create_listener_socket(const char *path,
     -+				  const struct ipc_server_opts *ipc_opts,
     -+				  struct stat *st_socket)
     ++static struct unix_stream_server_socket *create_listener_socket(
     ++	const char *path,
     ++	const struct ipc_server_opts *ipc_opts)
      +{
     -+	struct stat st;
     -+	struct strbuf buf_uniq = STRBUF_INIT;
     -+	int fd_listen;
     ++	struct unix_stream_server_socket *server_socket = NULL;
      +	struct unix_stream_listen_opts uslg_opts = UNIX_STREAM_LISTEN_OPTS_INIT;
      +
     -+	if (!lstat(path, &st) && S_ISSOCK(st.st_mode)) {
     -+		int fd_client;
     -+		/*
     -+		 * A socket-inode at `path` exists on disk, but we
     -+		 * don't know whether it belongs to an active server
     -+		 * or if the last server died without cleaning up.
     -+		 *
     -+		 * Poke it with a trivial connection to try to find out.
     -+		 */
     -+		trace2_data_string("ipc-server", NULL, "try-detect-server",
     -+				   path);
     -+		fd_client = unix_stream_connect(path);
     -+		if (fd_client >= 0) {
     -+			close(fd_client);
     -+			errno = EADDRINUSE;
     -+			return error_errno(_("socket already in use '%s'"),
     -+					   path);
     -+		}
     -+	}
     -+
     -+	/*
     -+	 * Create pathname to our "unique" socket and set it up for
     -+	 * business.
     -+	 */
     -+	strbuf_addf(&buf_uniq, "%s.%d", path, getpid());
     -+
      +	uslg_opts.listen_backlog_size = LISTEN_BACKLOG;
     -+	uslg_opts.force_unlink_before_bind = 1;
      +	uslg_opts.disallow_chdir = ipc_opts->uds_disallow_chdir;
     -+	fd_listen = unix_stream_listen(buf_uniq.buf, &uslg_opts);
     -+	if (fd_listen < 0) {
     -+		int saved_errno = errno;
     -+		error_errno(_("could not create listener socket '%s'"),
     -+			    buf_uniq.buf);
     -+		strbuf_release(&buf_uniq);
     -+		errno = saved_errno;
     -+		return -1;
     -+	}
      +
     -+	if (lstat(buf_uniq.buf, st_socket)) {
     -+		int saved_errno = errno;
     -+		error_errno(_("could not stat listener socket '%s'"),
     -+			    buf_uniq.buf);
     -+		close(fd_listen);
     -+		unlink(buf_uniq.buf);
     -+		strbuf_release(&buf_uniq);
     -+		errno = saved_errno;
     -+		return -1;
     -+	}
     ++	server_socket = unix_stream_server__listen_with_lock(path, &uslg_opts);
     ++	if (!server_socket)
     ++		return NULL;
      +
     -+	if (set_socket_blocking_flag(fd_listen, 1)) {
     ++	if (set_socket_blocking_flag(server_socket->fd_socket, 1)) {
      +		int saved_errno = errno;
      +		error_errno(_("could not set listener socket nonblocking '%s'"),
     -+			    buf_uniq.buf);
     -+		close(fd_listen);
     -+		unlink(buf_uniq.buf);
     -+		strbuf_release(&buf_uniq);
     -+		errno = saved_errno;
     -+		return -1;
     -+	}
     -+
     -+	/*
     -+	 * Install it as the "real" socket so that clients will starting
     -+	 * connecting to our socket.
     -+	 */
     -+	if (rename(buf_uniq.buf, path)) {
     -+		int saved_errno = errno;
     -+		error_errno(_("could not create listener socket '%s'"), path);
     -+		close(fd_listen);
     -+		unlink(buf_uniq.buf);
     -+		strbuf_release(&buf_uniq);
     ++			    path);
     ++		unix_stream_server__free(server_socket);
      +		errno = saved_errno;
     -+		return -1;
     ++		return NULL;
      +	}
      +
     -+	strbuf_release(&buf_uniq);
     -+	trace2_data_string("ipc-server", NULL, "try-listen", path);
     -+	return fd_listen;
     ++	trace2_data_string("ipc-server", NULL, "listen-with-lock", path);
     ++	return server_socket;
      +}
      +
     -+static int setup_listener_socket(const char *path, struct stat *st_socket,
     -+				 const struct ipc_server_opts *ipc_opts)
     ++static struct unix_stream_server_socket *setup_listener_socket(
     ++	const char *path,
     ++	const struct ipc_server_opts *ipc_opts)
      +{
     -+	int fd_listen;
     ++	struct unix_stream_server_socket *server_socket;
      +
      +	trace2_region_enter("ipc-server", "create-listener_socket", NULL);
     -+	fd_listen = create_listener_socket(path, ipc_opts, st_socket);
     ++	server_socket = create_listener_socket(path, ipc_opts);
      +	trace2_region_leave("ipc-server", "create-listener_socket", NULL);
      +
     -+	return fd_listen;
     ++	return server_socket;
      +}
      +
      +/*
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +			 ipc_server_application_cb *application_cb,
      +			 void *application_data)
      +{
     ++	struct unix_stream_server_socket *server_socket = NULL;
      +	struct ipc_server_data *server_data;
     -+	int fd_listen;
     -+	struct stat st_listen;
      +	int sv[2];
      +	int k;
      +	int nr_threads = opts->nr_threads;
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +				   path);
      +	}
      +
     -+	fd_listen = setup_listener_socket(path, &st_listen, opts);
     -+	if (fd_listen < 0) {
     ++	server_socket = setup_listener_socket(path, opts);
     ++	if (!server_socket) {
      +		int saved_errno = errno;
      +		close(sv[0]);
      +		close(sv[1]);
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +		xcalloc(1, sizeof(*server_data->accept_thread));
      +	server_data->accept_thread->magic = MAGIC_ACCEPT_THREAD_DATA;
      +	server_data->accept_thread->server_data = server_data;
     -+	server_data->accept_thread->fd_listen = fd_listen;
     -+	server_data->accept_thread->st_listen = st_listen;
     ++	server_data->accept_thread->server_socket = server_socket;
      +	server_data->accept_thread->fd_send_shutdown = sv[0];
      +	server_data->accept_thread->fd_wait_shutdown = sv[1];
      +
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +
      +	accept_thread_data = server_data->accept_thread;
      +	if (accept_thread_data) {
     -+		if (accept_thread_data->fd_listen != -1) {
     -+			/*
     -+			 * Only unlink the unix domain socket if we
     -+			 * created it.  That is, if another daemon
     -+			 * process force-created a new socket at this
     -+			 * path, and effectively steals our path
     -+			 * (which prevents us from receiving any
     -+			 * future clients), we don't want to do the
     -+			 * same thing to them.
     -+			 */
     -+			if (!socket_was_stolen(
     -+				    accept_thread_data))
     -+				unlink(server_data->buf_path.buf);
     ++		unix_stream_server__free(accept_thread_data->server_socket);
      +
     -+			close(accept_thread_data->fd_listen);
     -+		}
      +		if (accept_thread_data->fd_send_shutdown != -1)
      +			close(accept_thread_data->fd_send_shutdown);
      +		if (accept_thread_data->fd_wait_shutdown != -1)
     @@ simple-ipc.h
       #define SUPPORTS_SIMPLE_IPC
       #endif
       
     +@@ simple-ipc.h: struct ipc_client_connect_options {
     + 	 * the service and need to wait for it to become ready.
     + 	 */
     + 	unsigned int wait_if_not_found:1;
     ++
     ++	/*
     ++	 * Disallow chdir() when creating a Unix domain socket.
     ++	 */
     ++	unsigned int uds_disallow_chdir:1;
     + };
     + 
     + #define IPC_CLIENT_CONNECT_OPTIONS_INIT { \
     + 	.wait_if_busy = 0, \
     + 	.wait_if_not_found = 0, \
     ++	.uds_disallow_chdir = 0, \
     + }
     + 
     + /*
      @@ simple-ipc.h: struct ipc_server_data;
       struct ipc_server_opts
       {
  9:  f0bebf1cdb31 ! 12:  1e5c856ade85 simple-ipc: add t/helper/test-simple-ipc and t0052
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    simple-ipc: add t/helper/test-simple-ipc and t0052
     +    t0052: add simple-ipc tests and t/helper/test-simple-ipc tool
      
     -    Create unit tests for "simple-ipc".  These are currently only enabled
     -    on Windows.
     +    Create t0052-simple-ipc.sh with unit tests for the "simple-ipc" mechanism.
     +
     +    Create t/helper/test-simple-ipc test tool to exercise the "simple-ipc"
     +    functions.
     +
     +    When the tool is invoked with "run-daemon", it runs a server to listen
     +    for "simple-ipc" connections on a test socket or named pipe and
     +    responds to a set of commands to exercise/stress the communication
     +    setup.
     +
     +    When the tool is invoked with "start-daemon", it spawns a "run-daemon"
     +    command in the background and waits for the server to become ready
     +    before exiting.  (This helps make unit tests in t0052 more predictable
     +    and avoids the need for arbitrary sleeps in the test script.)
     +
     +    The tool also has a series of client "send" commands to send commands
     +    and data to a server instance.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ t/helper/test-simple-ipc.c (new)
      +#include "simple-ipc.h"
      +#include "parse-options.h"
      +#include "thread-utils.h"
     ++#include "strvec.h"
      +
      +#ifndef SUPPORTS_SIMPLE_IPC
      +int cmd__simple_ipc(int argc, const char **argv)
     @@ t/helper/test-simple-ipc.c (new)
      +
      +	if (!strcmp(command, "quit")) {
      +		/*
     -+		 * Tell ipc-server to hangup with an empty reply.
     ++		 * The client sent a "quit" command.  This is an async
     ++		 * request for the server to shutdown.
     ++		 *
     ++		 * We DO NOT send the client a response message
     ++		 * (because we have nothing to say and the other
     ++		 * server threads have not yet stopped).
     ++		 *
     ++		 * Tell the ipc-server layer to start shutting down.
     ++		 * This includes: stop listening for new connections
     ++		 * on the socket/pipe and telling all worker threads
     ++		 * to finish/drain their outgoing responses to other
     ++		 * clients.
     ++		 *
     ++		 * This DOES NOT force an immediate sync shutdown.
      +		 */
      +		return SIMPLE_IPC_QUIT;
      +	}
     @@ t/helper/test-simple-ipc.c (new)
      +	};
      +
      +	const char * const daemon_usage[] = {
     -+		N_("test-helper simple-ipc daemon [<options>"),
     ++		N_("test-helper simple-ipc run-daemon [<options>"),
      +		NULL
      +	};
      +	struct option daemon_options[] = {
     @@ t/helper/test-simple-ipc.c (new)
      +	return ipc_server_run(path, &opts, test_app_cb, (void*)&my_app_data);
      +}
      +
     ++#ifndef GIT_WINDOWS_NATIVE
     ++/*
     ++ * This is adapted from `daemonize()`.  Use `fork()` to directly create and
     ++ * run the daemon in a child process.
     ++ */
     ++static int spawn_server(const char *path,
     ++			const struct ipc_server_opts *opts,
     ++			pid_t *pid)
     ++{
     ++	*pid = fork();
     ++
     ++	switch (*pid) {
     ++	case 0:
     ++		if (setsid() == -1)
     ++			error_errno(_("setsid failed"));
     ++		close(0);
     ++		close(1);
     ++		close(2);
     ++		sanitize_stdfds();
     ++
     ++		return ipc_server_run(path, opts, test_app_cb, (void*)&my_app_data);
     ++
     ++	case -1:
     ++		return error_errno(_("could not spawn daemon in the background"));
     ++
     ++	default:
     ++		return 0;
     ++	}
     ++}
     ++#else
     ++/*
     ++ * Conceptually like `daemonize()` but different because Windows does not
     ++ * have `fork(2)`.  Spawn a normal Windows child process but without the
     ++ * limitations of `start_command()` and `finish_command()`.
     ++ */
     ++static int spawn_server(const char *path,
     ++			const struct ipc_server_opts *opts,
     ++			pid_t *pid)
     ++{
     ++	char test_tool_exe[MAX_PATH];
     ++	struct strvec args = STRVEC_INIT;
     ++	int in, out;
     ++
     ++	GetModuleFileNameA(NULL, test_tool_exe, MAX_PATH);
     ++
     ++	in = open("/dev/null", O_RDONLY);
     ++	out = open("/dev/null", O_WRONLY);
     ++
     ++	strvec_push(&args, test_tool_exe);
     ++	strvec_push(&args, "simple-ipc");
     ++	strvec_push(&args, "run-daemon");
     ++	strvec_pushf(&args, "--threads=%d", opts->nr_threads);
     ++
     ++	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
     ++	close(in);
     ++	close(out);
     ++
     ++	strvec_clear(&args);
     ++
     ++	if (*pid < 0)
     ++		return error(_("could not spawn daemon in the background"));
     ++
     ++	return 0;
     ++}
     ++#endif
     ++
     ++/*
     ++ * This is adapted from `wait_or_whine()`.  Watch the child process and
     ++ * let it get started and begin listening for requests on the socket
     ++ * before reporting our success.
     ++ */
     ++static int wait_for_server_startup(const char * path, pid_t pid_child,
     ++				   int max_wait_sec)
     ++{
     ++	int status;
     ++	pid_t pid_seen;
     ++	enum ipc_active_state s;
     ++	time_t time_limit, now;
     ++
     ++	time(&time_limit);
     ++	time_limit += max_wait_sec;
     ++
     ++	for (;;) {
     ++		pid_seen = waitpid(pid_child, &status, WNOHANG);
     ++
     ++		if (pid_seen == -1)
     ++			return error_errno(_("waitpid failed"));
     ++
     ++		else if (pid_seen == 0) {
     ++			/*
     ++			 * The child is still running (this should be
     ++			 * the normal case).  Try to connect to it on
     ++			 * the socket and see if it is ready for
     ++			 * business.
     ++			 *
     ++			 * If there is another daemon already running,
     ++			 * our child will fail to start (possibly
     ++			 * after a timeout on the lock), but we don't
     ++			 * care (who responds) if the socket is live.
     ++			 */
     ++			s = ipc_get_active_state(path);
     ++			if (s == IPC_STATE__LISTENING)
     ++				return 0;
     ++
     ++			time(&now);
     ++			if (now > time_limit)
     ++				return error(_("daemon not online yet"));
     ++
     ++			continue;
     ++		}
     ++
     ++		else if (pid_seen == pid_child) {
     ++			/*
     ++			 * The new child daemon process shutdown while
     ++			 * it was starting up, so it is not listening
     ++			 * on the socket.
     ++			 *
     ++			 * Try to ping the socket in the odd chance
     ++			 * that another daemon started (or was already
     ++			 * running) while our child was starting.
     ++			 *
     ++			 * Again, we don't care who services the socket.
     ++			 */
     ++			s = ipc_get_active_state(path);
     ++			if (s == IPC_STATE__LISTENING)
     ++				return 0;
     ++
     ++			/*
     ++			 * We don't care about the WEXITSTATUS() nor
     ++			 * any of the WIF*(status) values because
     ++			 * `cmd__simple_ipc()` does the `!!result`
     ++			 * trick on all function return values.
     ++			 *
     ++			 * So it is sufficient to just report the
     ++			 * early shutdown as an error.
     ++			 */
     ++			return error(_("daemon failed to start"));
     ++		}
     ++
     ++		else
     ++			return error(_("waitpid is confused"));
     ++	}
     ++}
     ++
     ++/*
     ++ * This process will start a simple-ipc server in a background process and
     ++ * wait for it to become ready.  This is like `daemonize()` but gives us
     ++ * more control and better error reporting (and makes it easier to write
     ++ * unit tests).
     ++ */
     ++static int daemon__start_server(const char *path, int argc, const char **argv)
     ++{
     ++	pid_t pid_child;
     ++	int ret;
     ++	int max_wait_sec = 60;
     ++	struct ipc_server_opts opts = {
     ++		.nr_threads = 5
     ++	};
     ++
     ++	const char * const daemon_usage[] = {
     ++		N_("test-helper simple-ipc start-daemon [<options>"),
     ++		NULL
     ++	};
     ++
     ++	struct option daemon_options[] = {
     ++		OPT_INTEGER(0, "max-wait", &max_wait_sec,
     ++			    N_("seconds to wait for daemon to startup")),
     ++		OPT_INTEGER(0, "threads", &opts.nr_threads,
     ++			    N_("number of threads in server thread pool")),
     ++		OPT_END()
     ++	};
     ++
     ++	argc = parse_options(argc, argv, NULL, daemon_options, daemon_usage, 0);
     ++
     ++	if (max_wait_sec < 0)
     ++		max_wait_sec = 0;
     ++	if (opts.nr_threads < 1)
     ++		opts.nr_threads = 1;
     ++
     ++	/*
     ++	 * Run the actual daemon in a background process.
     ++	 */
     ++	ret = spawn_server(path, &opts, &pid_child);
     ++	if (pid_child <= 0)
     ++		return ret;
     ++
     ++	/*
     ++	 * Let the parent wait for the child process to get started
     ++	 * and begin listening for requests on the socket.
     ++	 */
     ++	ret = wait_for_server_startup(path, pid_child, max_wait_sec);
     ++
     ++	return ret;
     ++}
     ++
      +/*
      + * This process will run a quick probe to see if a simple-ipc server
      + * is active on this path.
     @@ t/helper/test-simple-ipc.c (new)
      +	options.wait_if_not_found = 0;
      +
      +	if (!ipc_client_send_command(path, &options, command, &buf)) {
     -+		printf("%s\n", buf.buf);
     -+		fflush(stdout);
     ++		if (buf.len) {
     ++			printf("%s\n", buf.buf);
     ++			fflush(stdout);
     ++		}
      +		strbuf_release(&buf);
      +
      +		return 0;
     @@ t/helper/test-simple-ipc.c (new)
      + * message can be sent and that the kernel or pkt-line layers will
      + * properly chunk it and that the daemon receives the entire message.
      + */
     -+static int do_sendbytes(int bytecount, char byte, const char *path)
     ++static int do_sendbytes(int bytecount, char byte, const char *path,
     ++			const struct ipc_client_connect_options *options)
      +{
      +	struct strbuf buf_send = STRBUF_INIT;
      +	struct strbuf buf_resp = STRBUF_INIT;
     -+	struct ipc_client_connect_options options
     -+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
     -+
     -+	options.wait_if_busy = 1;
     -+	options.wait_if_not_found = 0;
      +
      +	strbuf_addstr(&buf_send, "sendbytes ");
      +	strbuf_addchars(&buf_send, byte, bytecount);
      +
     -+	if (!ipc_client_send_command(path, &options, buf_send.buf, &buf_resp)) {
     ++	if (!ipc_client_send_command(path, options, buf_send.buf, &buf_resp)) {
      +		strbuf_rtrim(&buf_resp);
      +		printf("sent:%c%08d %s\n", byte, bytecount, buf_resp.buf);
      +		fflush(stdout);
     @@ t/helper/test-simple-ipc.c (new)
      +		OPT_STRING(0, "byte", &string, N_("byte"), N_("ballast")),
      +		OPT_END()
      +	};
     ++	struct ipc_client_connect_options options
     ++		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
     ++
     ++	options.wait_if_busy = 1;
     ++	options.wait_if_not_found = 0;
     ++	options.uds_disallow_chdir = 0;
      +
      +	argc = parse_options(argc, argv, NULL, sendbytes_options, sendbytes_usage, 0);
      +
     -+	return do_sendbytes(bytecount, string[0], path);
     ++	return do_sendbytes(bytecount, string[0], path, &options);
      +}
      +
      +struct multiple_thread_data {
     @@ t/helper/test-simple-ipc.c (new)
      +{
      +	struct multiple_thread_data *d = _multiple_thread_data;
      +	int k;
     ++	struct ipc_client_connect_options options
     ++		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
     ++
     ++	options.wait_if_busy = 1;
     ++	options.wait_if_not_found = 0;
     ++	/*
     ++	 * A multi-threaded client should not be randomly calling chdir().
     ++	 * The test will pass without this restriction because the test is
     ++	 * not otherwise accessing the filesystem, but it makes us honest.
     ++	 */
     ++	options.uds_disallow_chdir = 1;
      +
      +	trace2_thread_start("multiple");
      +
      +	for (k = 0; k < d->batchsize; k++) {
     -+		if (do_sendbytes(d->bytecount + k, d->letter, d->path))
     ++		if (do_sendbytes(d->bytecount + k, d->letter, d->path, &options))
      +			d->sum_errors++;
      +		else
      +			d->sum_good++;
     @@ t/helper/test-simple-ipc.c (new)
      +	if (argc == 2 && !strcmp(argv[1], "SUPPORTS_SIMPLE_IPC"))
      +		return 0;
      +
     -+	/* Use '!!' on all dispatch functions to map from `error()` style
     -+	 * (returns -1) style to `test_must_fail` style (expects 1) and
     -+	 * get less confusing shell error messages.
     ++	/*
     ++	 * Use '!!' on all dispatch functions to map from `error()` style
     ++	 * (returns -1) style to `test_must_fail` style (expects 1).  This
     ++	 * makes shell error messages less confusing.
      +	 */
      +
      +	if (argc == 2 && !strcmp(argv[1], "is-active"))
      +		return !!client__probe_server(path);
      +
     -+	if (argc >= 2 && !strcmp(argv[1], "daemon"))
     ++	if (argc >= 2 && !strcmp(argv[1], "run-daemon"))
      +		return !!daemon__run_server(path, argc, argv);
      +
     ++	if (argc >= 2 && !strcmp(argv[1], "start-daemon"))
     ++		return !!daemon__start_server(path, argc, argv);
     ++
      +	/*
      +	 * Client commands follow.  Ensure a server is running before
      +	 * going any further.
     @@ t/t0052-simple-ipc.sh (new)
      +}
      +
      +stop_simple_IPC_server () {
     -+	test -n "$SIMPLE_IPC_PID" || return 0
     -+
     -+	kill "$SIMPLE_IPC_PID" &&
     -+	SIMPLE_IPC_PID=
     ++	test-tool simple-ipc send quit
      +}
      +
      +test_expect_success 'start simple command server' '
     -+	{ test-tool simple-ipc daemon --threads=8 & } &&
     -+	SIMPLE_IPC_PID=$! &&
      +	test_atexit stop_simple_IPC_server &&
     -+
     -+	sleep 1 &&
     -+
     ++	test-tool simple-ipc start-daemon --threads=8 &&
      +	test-tool simple-ipc is-active
      +'
      +
     @@ t/t0052-simple-ipc.sh (new)
      +'
      +
      +test_expect_success 'servers cannot share the same path' '
     -+	test_must_fail test-tool simple-ipc daemon &&
     ++	test_must_fail test-tool simple-ipc run-daemon &&
      +	test-tool simple-ipc is-active
      +'
      +
     @@ t/t0052-simple-ipc.sh (new)
      +	test_cmp expect_a actual_a
      +'
      +
     ++# Sending a "quit" message to the server causes it to start an "async
     ++# shutdown" -- queuing shutdown events to all socket/pipe thread-pool
     ++# threads.  Each thread will process that event after finishing
     ++# (draining) any in-progress IO with other clients.  So when the "send
     ++# quit" client command exits, the ipc-server may still be running (but
     ++# it should be cleaning up).
     ++#
     ++# So, insert a generous sleep here to give the server time to shutdown.
     ++#
      +test_expect_success '`quit` works' '
      +	test-tool simple-ipc send quit &&
     ++
     ++	sleep 5 &&
     ++
      +	test_must_fail test-tool simple-ipc is-active &&
      +	test_must_fail test-tool simple-ipc send ping
      +'
 13:  2cca15a10ece <  -:  ------------ unix-socket: do not call die in unix_stream_connect()

-- 
gitgitgadget
