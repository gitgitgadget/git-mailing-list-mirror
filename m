Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF34C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12203652AD
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhCIPCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhCIPCq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB83C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 07:02:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f12so16237291wrx.8
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C6igxb8JqAOQvGtR3dA/iKRPadX6DDWDdbFKzQMBbX0=;
        b=iHicnXFlODEoxy08gqEnmterzRYOX5dnpVmnHgne050tJr7j8GGpVvv8489OvW57rY
         2eGIRwYCGshHWd+DU6m4iOGpPig9prglaBoiRFLSsK54FJmuQ8doAZG1BLtpoR4p7gv2
         Cgik/cTtoyp3Rwric1yGHsC6yxMaXOBMfetOMHyHvm/5dYFPIdzEu43hrA7uSY8Jv+LH
         qWbwdoHpD9uUFOWQF1MDDNmxVy12iW8jn0kxMNpW7pXw/G++pnnh9/E0mi5LMO8OWCtI
         7zlWQf4nY1gCdwkpZGgdJbfVqlgaflXdpNvkOq5t8F5cTXlatYjH4jWaYE9PGK/DDQbU
         w9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C6igxb8JqAOQvGtR3dA/iKRPadX6DDWDdbFKzQMBbX0=;
        b=Ks1PVogHNAv5qsN9+lJFRb9vcuD/nYFt6zJd0gF9HpxRi7oMEacbBe+QihlqnzeV70
         6HRUtObkU89ckmW0gBmARG1FjL7MWyZ/iZMVKepUxw9EYBFNwMYrtizuVteytnQyVtEB
         g96LXhkmvRiyHI71RKOqL3K25JixbcNmhEQz/TSg3o/C3GBZA5FIiK2UMJpTiCT/KvvA
         omwX5ghyYUTiX7n7mK0icEZuHwf0+UWkjjCt4mczGjbZFfdvJ3eSpMR55vp+2haq4Y30
         OrM/Gni4mtpb5D7vU10/CM8RxFs2MFDZc2/ccqmLy+1d+uHnb+48gKYdD/WM9RKMtqhJ
         lPCA==
X-Gm-Message-State: AOAM530w5Vyad5KOS33hPSUldrVVqQdepEU5CEdiLHz3UO40ZoEL4t0h
        IiQ8ZUSGj4pU0aqQ5iRqjdmiGvKk+vw=
X-Google-Smtp-Source: ABdhPJzAkElLMlwPzIZYSnO1YP91DD6bMIU0dsMRHKaJtdW5R3lsbVATq3SUZfTGdJTOVUe/SR6bDw==
X-Received: by 2002:a5d:4485:: with SMTP id j5mr27961412wrq.339.1615302158991;
        Tue, 09 Mar 2021 07:02:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm22931992wrx.5.2021.03.09.07.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:02:38 -0800 (PST)
Message-Id: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:02:25 +0000
Subject: [PATCH v5 00/12] Simple IPC Mechanism
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V5 of my "Simple IPC" series. This version is a reiteration of the
series and combines the original "Simple IPC Mechanism V4" series [1] and
the "Simple IPC Cleanups V1" series [2]. It squashes them together and then
includes responses to last minute comments received on both.

These include: (a) Rename PACKET_READ_NEVER_DIE to
PACKET_READ_GENTLE_ON_READ_ERROR. (b) Accept zero length timeout in
unix_stream_socket__conect(). Only supply the default timeout when a
negative value is passed. Make the default timeout value private to the .c
file.

I apologize for rerolling something that is in "next". I think the combined
result is better long term than preserving them as two sequential series.
Given where we are in the release cycle, I thought it best to have a cleaned
up series for consideration post v2.31.

[1] Upstream in jh/simple-ipc via
https://github.com/gitgitgadget/git/pull/766 (and in "next" relative to
v2.30.1)
https://lore.kernel.org/git/pull.766.v4.git.1613598529.gitgitgadget@gmail.com/T/#mbd1da5ff93ef273049090f697aeab68c74f698f1

[2] Upstream in `jh/simple-ipc-cleanups via
https://github.com/gitgitgadget/git/pull/893
https://lore.kernel.org/git/8ea6401c-6ee6-94cb-4e33-9dfffaf466e8@jeffhostetler.com/T/#t

Jeff Hostetler (9):
  pkt-line: eliminate the need for static buffer in
    packet_write_gently()
  simple-ipc: design documentation for new IPC mechanism
  simple-ipc: add win32 implementation
  unix-socket: eliminate static unix_stream_socket() helper function
  unix-socket: add backlog size option to unix_stream_listen()
  unix-socket: disallow chdir() when creating unix domain sockets
  unix-stream-server: create unix domain socket under lock
  simple-ipc: add Unix domain socket implementation
  t0052: add simple-ipc tests and t/helper/test-simple-ipc tool

Johannes Schindelin (3):
  pkt-line: do not issue flush packets in write_packetized_*()
  pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR option
  pkt-line: add options argument to read_packetized_to_strbuf()

 Documentation/technical/api-simple-ipc.txt | 105 +++
 Makefile                                   |   9 +
 builtin/credential-cache--daemon.c         |   3 +-
 builtin/credential-cache.c                 |   2 +-
 compat/simple-ipc/ipc-shared.c             |  28 +
 compat/simple-ipc/ipc-unix-socket.c        | 986 +++++++++++++++++++++
 compat/simple-ipc/ipc-win32.c              | 751 ++++++++++++++++
 config.mak.uname                           |   2 +
 contrib/buildsystems/CMakeLists.txt        |   8 +-
 convert.c                                  |  11 +-
 pkt-line.c                                 |  58 +-
 pkt-line.h                                 |  17 +-
 simple-ipc.h                               | 239 +++++
 t/helper/test-simple-ipc.c                 | 787 ++++++++++++++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/t0052-simple-ipc.sh                      | 122 +++
 unix-socket.c                              |  53 +-
 unix-socket.h                              |  12 +-
 unix-stream-server.c                       | 128 +++
 unix-stream-server.h                       |  36 +
 21 files changed, 3307 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/technical/api-simple-ipc.txt
 create mode 100644 compat/simple-ipc/ipc-shared.c
 create mode 100644 compat/simple-ipc/ipc-unix-socket.c
 create mode 100644 compat/simple-ipc/ipc-win32.c
 create mode 100644 simple-ipc.h
 create mode 100644 t/helper/test-simple-ipc.c
 create mode 100755 t/t0052-simple-ipc.sh
 create mode 100644 unix-stream-server.c
 create mode 100644 unix-stream-server.h


base-commit: f01623b2c9d14207e497b21ebc6b3ec4afaf4b46
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-766%2Fjeffhostetler%2Fsimple-ipc-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-766/jeffhostetler/simple-ipc-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/766

Range-diff vs v4:

  1:  2d6858b1625a !  1:  311ea4a5cd71 pkt-line: eliminate the need for static buffer in packet_write_gently()
     @@ Commit message
          static buffer, thread-safe scratch space, or an excessively large stack
          buffer.
      
     -    Change the API of `write_packetized_from_fd()` to accept a scratch space
     -    argument from its caller to avoid similar issues here.
     +    Change `write_packetized_from_fd()` to allocate a temporary buffer rather
     +    than using a static buffer to avoid similar issues here.
      
          These changes are intended to make it easier to use pkt-line routines in
          a multi-threaded context with multiple concurrent writers writing to
     @@ Commit message
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     - ## convert.c ##
     -@@ convert.c: static int apply_multi_file_filter(const char *path, const char *src, size_t len
     - 	if (err)
     - 		goto done;
     - 
     --	if (fd >= 0)
     --		err = write_packetized_from_fd(fd, process->in);
     --	else
     -+	if (fd >= 0) {
     -+		struct packet_scratch_space scratch;
     -+		err = write_packetized_from_fd(fd, process->in, &scratch);
     -+	} else
     - 		err = write_packetized_from_buf(src, len, process->in);
     - 	if (err)
     - 		goto done;
     -
       ## pkt-line.c ##
      @@ pkt-line.c: int packet_write_fmt_gently(int fd, const char *fmt, ...)
       
     @@ pkt-line.c: int packet_write_fmt_gently(int fd, const char *fmt, ...)
       	return 0;
       }
      @@ pkt-line.c: void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
     - 	packet_trace(data, len, 1);
     - }
       
     --int write_packetized_from_fd(int fd_in, int fd_out)
     -+int write_packetized_from_fd(int fd_in, int fd_out,
     -+			     struct packet_scratch_space *scratch)
     + int write_packetized_from_fd(int fd_in, int fd_out)
       {
      -	static char buf[LARGE_PACKET_DATA_MAX];
     ++	char *buf = xmalloc(LARGE_PACKET_DATA_MAX);
       	int err = 0;
       	ssize_t bytes_to_write;
       
       	while (!err) {
      -		bytes_to_write = xread(fd_in, buf, sizeof(buf));
     -+		bytes_to_write = xread(fd_in, scratch->buffer,
     -+				       sizeof(scratch->buffer));
     - 		if (bytes_to_write < 0)
     +-		if (bytes_to_write < 0)
     ++		bytes_to_write = xread(fd_in, buf, LARGE_PACKET_DATA_MAX);
     ++		if (bytes_to_write < 0) {
     ++			free(buf);
       			return COPY_READ_ERROR;
     ++		}
       		if (bytes_to_write == 0)
       			break;
     --		err = packet_write_gently(fd_out, buf, bytes_to_write);
     -+		err = packet_write_gently(fd_out, scratch->buffer,
     -+					  bytes_to_write);
     + 		err = packet_write_gently(fd_out, buf, bytes_to_write);
       	}
       	if (!err)
       		err = packet_flush_gently(fd_out);
     -
     - ## pkt-line.h ##
     -@@
     - #include "strbuf.h"
     - #include "sideband.h"
     - 
     -+#define LARGE_PACKET_MAX 65520
     -+#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
     -+
     -+struct packet_scratch_space {
     -+	char buffer[LARGE_PACKET_DATA_MAX]; /* does not include header bytes */
     -+};
     -+
     - /*
     -  * Write a packetized stream, where each line is preceded by
     -  * its length (including the header) as a 4-byte hex number.
     -@@ pkt-line.h: void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
     - void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
     - int packet_flush_gently(int fd);
     - int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
     --int write_packetized_from_fd(int fd_in, int fd_out);
     -+int write_packetized_from_fd(int fd_in, int fd_out, struct packet_scratch_space *scratch);
     - int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
     - 
     - /*
     -@@ pkt-line.h: enum packet_read_status packet_reader_read(struct packet_reader *reader);
     - enum packet_read_status packet_reader_peek(struct packet_reader *reader);
     - 
     - #define DEFAULT_PACKET_MAX 1000
     --#define LARGE_PACKET_MAX 65520
     --#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
     -+
     - extern char packet_buffer[LARGE_PACKET_MAX];
     ++	free(buf);
     + 	return err;
     + }
       
     - struct packet_writer {
  2:  91a9f63d6692 !  2:  25157c1f4873 pkt-line: do not issue flush packets in write_packetized_*()
     @@ Commit message
      
       ## convert.c ##
      @@ convert.c: static int apply_multi_file_filter(const char *path, const char *src, size_t len
     + 		goto done;
       
     - 	if (fd >= 0) {
     - 		struct packet_scratch_space scratch;
     --		err = write_packetized_from_fd(fd, process->in, &scratch);
     -+		err = write_packetized_from_fd_no_flush(fd, process->in, &scratch);
     - 	} else
     + 	if (fd >= 0)
     +-		err = write_packetized_from_fd(fd, process->in);
     ++		err = write_packetized_from_fd_no_flush(fd, process->in);
     + 	else
      -		err = write_packetized_from_buf(src, len, process->in);
      +		err = write_packetized_from_buf_no_flush(src, len, process->in);
      +	if (err)
     @@ pkt-line.c: void packet_buf_write_len(struct strbuf *buf, const char *data, size
       	packet_trace(data, len, 1);
       }
       
     --int write_packetized_from_fd(int fd_in, int fd_out,
     --			     struct packet_scratch_space *scratch)
     -+int write_packetized_from_fd_no_flush(int fd_in, int fd_out,
     -+				      struct packet_scratch_space *scratch)
     +-int write_packetized_from_fd(int fd_in, int fd_out)
     ++int write_packetized_from_fd_no_flush(int fd_in, int fd_out)
       {
     + 	char *buf = xmalloc(LARGE_PACKET_DATA_MAX);
       	int err = 0;
     - 	ssize_t bytes_to_write;
     -@@ pkt-line.c: int write_packetized_from_fd(int fd_in, int fd_out,
     - 		err = packet_write_gently(fd_out, scratch->buffer,
     - 					  bytes_to_write);
     +@@ pkt-line.c: int write_packetized_from_fd(int fd_in, int fd_out)
     + 			break;
     + 		err = packet_write_gently(fd_out, buf, bytes_to_write);
       	}
      -	if (!err)
      -		err = packet_flush_gently(fd_out);
     + 	free(buf);
       	return err;
       }
       
     @@ pkt-line.h: void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __at
       void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
       int packet_flush_gently(int fd);
       int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
     --int write_packetized_from_fd(int fd_in, int fd_out, struct packet_scratch_space *scratch);
     +-int write_packetized_from_fd(int fd_in, int fd_out);
      -int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
     -+int write_packetized_from_fd_no_flush(int fd_in, int fd_out, struct packet_scratch_space *scratch);
     ++int write_packetized_from_fd_no_flush(int fd_in, int fd_out);
      +int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out);
       
       /*
  3:  e05467def4e1 !  3:  af3d13113bc9 pkt-line: (optionally) libify the packet readers
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    pkt-line: (optionally) libify the packet readers
     +    pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR option
     +
     +    Introduce PACKET_READ_GENTLE_ON_READ_ERROR option to help libify the
     +    packet readers.
      
          So far, the (possibly indirect) callers of `get_packet_data()` can ask
          that function to return an error instead of `die()`ing upon end-of-file.
          However, random read errors will still cause the process to die.
      
          So let's introduce an explicit option to tell the packet reader
     -    machinery to please be nice and only return an error.
     +    machinery to please be nice and only return an error on read errors.
      
          This change prepares pkt-line for use by long-running daemon processes.
          Such processes should be able to serve multiple concurrent clients and
     @@ Commit message
          a daemon should be able to drop that connection and continue serving
          existing and future connections.
      
     -    This ability will be used by a Git-aware "Internal FSMonitor" feature
     +    This ability will be used by a Git-aware "Builtin FSMonitor" feature
          in a later patch series.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## pkt-line.c ##
      @@ pkt-line.c: static int get_packet_data(int fd, char **src_buf, size_t *src_size,
     @@ pkt-line.c: static int get_packet_data(int fd, char **src_buf, size_t *src_size,
       		ret = read_in_full(fd, dst, size);
      -		if (ret < 0)
      +		if (ret < 0) {
     -+			if (options & PACKET_READ_NEVER_DIE)
     ++			if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
      +				return error_errno(_("read error"));
       			die_errno(_("read error"));
      +		}
     @@ pkt-line.c: static int get_packet_data(int fd, char **src_buf, size_t *src_size,
       		if (options & PACKET_READ_GENTLE_ON_EOF)
       			return -1;
       
     -+		if (options & PACKET_READ_NEVER_DIE)
     ++		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
      +			return error(_("the remote end hung up unexpectedly"));
       		die(_("the remote end hung up unexpectedly"));
       	}
     @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_b
       	len = packet_length(linelen);
       
       	if (len < 0) {
     -+		if (options & PACKET_READ_NEVER_DIE)
     ++		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
      +			return error(_("protocol error: bad line length "
      +				       "character: %.4s"), linelen);
       		die(_("protocol error: bad line length character: %.4s"), linelen);
     @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_b
       		*pktlen = 0;
       		return PACKET_READ_RESPONSE_END;
       	} else if (len < 4) {
     -+		if (options & PACKET_READ_NEVER_DIE)
     ++		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
      +			return error(_("protocol error: bad line length %d"),
      +				     len);
       		die(_("protocol error: bad line length %d"), len);
     @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_b
       	len -= 4;
      -	if ((unsigned)len >= size)
      +	if ((unsigned)len >= size) {
     -+		if (options & PACKET_READ_NEVER_DIE)
     ++		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
      +			return error(_("protocol error: bad line length %d"),
      +				     len);
       		die(_("protocol error: bad line length %d"), len);
     @@ pkt-line.h: int write_packetized_from_buf_no_flush(const char *src_in, size_t le
        * If options contains PACKET_READ_DIE_ON_ERR_PACKET, it dies when it sees an
        * ERR packet.
      + *
     -+ * With `PACKET_READ_NEVER_DIE`, no errors are allowed to trigger die() (except
     -+ * an ERR packet, when `PACKET_READ_DIE_ON_ERR_PACKET` is in effect).
     ++ * If options contains PACKET_READ_GENTLE_ON_READ_ERROR, we will not die
     ++ * on read errors, but instead return -1.  However, we may still die on an
     ++ * ERR packet (if requested).
        */
     - #define PACKET_READ_GENTLE_ON_EOF     (1u<<0)
     - #define PACKET_READ_CHOMP_NEWLINE     (1u<<1)
     - #define PACKET_READ_DIE_ON_ERR_PACKET (1u<<2)
     -+#define PACKET_READ_NEVER_DIE         (1u<<3)
     +-#define PACKET_READ_GENTLE_ON_EOF     (1u<<0)
     +-#define PACKET_READ_CHOMP_NEWLINE     (1u<<1)
     +-#define PACKET_READ_DIE_ON_ERR_PACKET (1u<<2)
     ++#define PACKET_READ_GENTLE_ON_EOF        (1u<<0)
     ++#define PACKET_READ_CHOMP_NEWLINE        (1u<<1)
     ++#define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
     ++#define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
       int packet_read(int fd, char **src_buffer, size_t *src_len, char
       		*buffer, unsigned size, int options);
       
  4:  81e14bed955c =  4:  b73e66a69b61 pkt-line: add options argument to read_packetized_to_strbuf()
  5:  22eec60761a8 <  -:  ------------ simple-ipc: design documentation for new IPC mechanism
  -:  ------------ >  5:  1ae99d824a21 simple-ipc: design documentation for new IPC mechanism
  6:  171ec43ecfa4 !  6:  8b3ce40e4538 simple-ipc: add win32 implementation
     @@ compat/simple-ipc/ipc-win32.c (new)
      +
      +	if (read_packetized_to_strbuf(
      +		    connection->fd, answer,
     -+		    PACKET_READ_GENTLE_ON_EOF | PACKET_READ_NEVER_DIE) < 0) {
     ++		    PACKET_READ_GENTLE_ON_EOF | PACKET_READ_GENTLE_ON_READ_ERROR) < 0) {
      +		ret = error(_("could not read IPC response"));
      +		goto done;
      +	}
     @@ compat/simple-ipc/ipc-win32.c (new)
      +
      +	ret = read_packetized_to_strbuf(
      +		reply_data.fd, &buf,
     -+		PACKET_READ_GENTLE_ON_EOF | PACKET_READ_NEVER_DIE);
     ++		PACKET_READ_GENTLE_ON_EOF | PACKET_READ_GENTLE_ON_READ_ERROR);
      +	if (ret >= 0) {
      +		ret = server_thread_data->server_data->application_cb(
      +			server_thread_data->server_data->application_data,
     @@ compat/simple-ipc/ipc-win32.c (new)
      +	*returned_server_data = NULL;
      +
      +	ret = initialize_pipe_name(path, wpath, ARRAY_SIZE(wpath));
     -+	if (ret < 0)
     -+		return error(
     -+			_("could not create normalized wchar_t path for '%s'"),
     -+			path);
     ++	if (ret < 0) {
     ++		errno = EINVAL;
     ++		return -1;
     ++	}
      +
      +	hPipeFirst = create_new_pipe(wpath, 1);
     -+	if (hPipeFirst == INVALID_HANDLE_VALUE)
     -+		return error(_("IPC server already running on '%s'"), path);
     ++	if (hPipeFirst == INVALID_HANDLE_VALUE) {
     ++		errno = EADDRINUSE;
     ++		return -2;
     ++	}
      +
      +	server_data = xcalloc(1, sizeof(*server_data));
      +	server_data->magic = MAGIC_SERVER_DATA;
     @@ simple-ipc.h (new)
      + *
      + * Returns 0 if the asynchronous server pool was started successfully.
      + * Returns -1 if not.
     ++ * Returns -2 if we could not startup because another server is using
     ++ * the socket or named pipe.
      + *
      + * When a client IPC message is received, the `application_cb` will be
      + * called (possibly on a random thread) to handle the message and
     @@ simple-ipc.h (new)
      + *
      + * Returns 0 after the server has completed successfully.
      + * Returns -1 if the server cannot be started.
     ++ * Returns -2 if we could not startup because another server is using
     ++ * the socket or named pipe.
      + *
      + * When a client IPC message is received, the `application_cb` will be
      + * called (possibly on a random thread) to handle the message and
  7:  b368318e6a23 !  7:  34df1af98e5b unix-socket: elimiate static unix_stream_socket() helper function
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    unix-socket: elimiate static unix_stream_socket() helper function
     +    unix-socket: eliminate static unix_stream_socket() helper function
      
          The static helper function `unix_stream_socket()` calls `die()`.  This
          is not appropriate for all callers.  Eliminate the wrapper function
  8:  985b2e02b2df !  8:  d6ff6e0e050a unix-socket: add backlog size option to unix_stream_listen()
     @@ builtin/credential-cache--daemon.c: static int serve_cache_loop(int fd)
       
      
       ## unix-socket.c ##
     +@@
     + #include "cache.h"
     + #include "unix-socket.h"
     + 
     ++#define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
     ++
     + static int chdir_len(const char *orig, int len)
     + {
     + 	char *path = xmemdupz(orig, len);
      @@ unix-socket.c: int unix_stream_connect(const char *path)
       	return -1;
       }
     @@ unix-socket.h
      +	int listen_backlog_size;
      +};
      +
     -+#define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
     -+
     -+#define UNIX_STREAM_LISTEN_OPTS_INIT \
     -+{ \
     -+	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
     -+}
     ++#define UNIX_STREAM_LISTEN_OPTS_INIT { 0 }
      +
       int unix_stream_connect(const char *path);
      -int unix_stream_listen(const char *path);
  9:  1bfa36409d07 !  9:  21b8d3c63dbf unix-socket: disallow chdir() when creating unix domain sockets
     @@ unix-socket.h
      +	unsigned int disallow_chdir:1;
       };
       
     - #define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
     -@@ unix-socket.h: struct unix_stream_listen_opts {
     - #define UNIX_STREAM_LISTEN_OPTS_INIT \
     - { \
     - 	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
     -+	.disallow_chdir = 0, \
     - }
     + #define UNIX_STREAM_LISTEN_OPTS_INIT { 0 }
       
      -int unix_stream_connect(const char *path);
      +int unix_stream_connect(const char *path, int disallow_chdir);
 10:  b443e11ac32f ! 10:  1ee9de55a106 unix-socket: create `unix_stream_server__listen_with_lock()`
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    unix-socket: create `unix_stream_server__listen_with_lock()`
     +    unix-stream-server: create unix domain socket under lock
      
     -    Create a version of `unix_stream_listen()` that uses a ".lock" lockfile
     -    to create the unix domain socket in a race-free manner.
     +    Create a wrapper class for `unix_stream_listen()` that uses a ".lock"
     +    lockfile to create the unix domain socket in a race-free manner.
      
          Unix domain sockets have a fundamental problem on Unix systems because
          they persist in the filesystem until they are deleted.  This is
     @@ Commit message
      
          As an alternative, we hold a plain lockfile ("<path>.lock") as a
          mutual exclusion device.  Under the lock, we test if an existing
     -    socket ("<path>") is has an active server.  If not, create a new
     -    socket and begin listening.  Then we rollback the lockfile in all
     -    cases.
     +    socket ("<path>") is has an active server.  If not, we create a new
     +    socket and begin listening.  Then we use "rollback" to delete the
     +    lockfile in all cases.
     +
     +    This wrapper code conceptually exists at a higher-level than the core
     +    unix_stream_connect() and unix_stream_listen() routines that it
     +    consumes.  It is isolated in a wrapper class for clarity.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     - ## unix-socket.c ##
     + ## Makefile ##
     +@@ Makefile: ifdef NO_UNIX_SOCKETS
     + 	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
     + else
     + 	LIB_OBJS += unix-socket.o
     ++	LIB_OBJS += unix-stream-server.o
     + endif
     + 
     + ifdef USE_WIN32_IPC
     +
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     + 
     + elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
     + 	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
     +-	list(APPEND compat_SOURCES unix-socket.c)
     ++	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c)
     + endif()
     + 
     + if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     +
     + ## unix-stream-server.c (new) ##
      @@
     - #include "cache.h"
     ++#include "cache.h"
      +#include "lockfile.h"
     - #include "unix-socket.h"
     - 
     - static int chdir_len(const char *orig, int len)
     -@@ unix-socket.c: int unix_stream_listen(const char *path,
     - 	errno = saved_errno;
     - 	return -1;
     - }
     ++#include "unix-socket.h"
     ++#include "unix-stream-server.h"
      +
     ++#define DEFAULT_LOCK_TIMEOUT (100)
     ++
     ++/*
     ++ * Try to connect to a unix domain socket at `path` (if it exists) and
     ++ * see if there is a server listening.
     ++ *
     ++ * We don't know if the socket exists, whether a server died and
     ++ * failed to cleanup, or whether we have a live server listening, so
     ++ * we "poke" it.
     ++ *
     ++ * We immediately hangup without sending/receiving any data because we
     ++ * don't know anything about the protocol spoken and don't want to
     ++ * block while writing/reading data.  It is sufficient to just know
     ++ * that someone is listening.
     ++ */
      +static int is_another_server_alive(const char *path,
      +				   const struct unix_stream_listen_opts *opts)
      +{
     -+	struct stat st;
     -+	int fd;
     -+
     -+	if (!lstat(path, &st) && S_ISSOCK(st.st_mode)) {
     -+		/*
     -+		 * A socket-inode exists on disk at `path`, but we
     -+		 * don't know whether it belongs to an active server
     -+		 * or whether the last server died without cleaning
     -+		 * up.
     -+		 *
     -+		 * Poke it with a trivial connection to try to find
     -+		 * out.
     -+		 */
     -+		fd = unix_stream_connect(path, opts->disallow_chdir);
     -+		if (fd >= 0) {
     -+			close(fd);
     -+			return 1;
     -+		}
     ++	int fd = unix_stream_connect(path, opts->disallow_chdir);
     ++	if (fd >= 0) {
     ++		close(fd);
     ++		return 1;
      +	}
      +
      +	return 0;
      +}
      +
     -+struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
     ++int unix_stream_server__create(
      +	const char *path,
     -+	const struct unix_stream_listen_opts *opts)
     ++	const struct unix_stream_listen_opts *opts,
     ++	long timeout_ms,
     ++	struct unix_stream_server_socket **new_server_socket)
      +{
      +	struct lock_file lock = LOCK_INIT;
      +	int fd_socket;
      +	struct unix_stream_server_socket *server_socket;
      +
     ++	*new_server_socket = NULL;
     ++
     ++	if (timeout_ms < 0)
     ++		timeout_ms = DEFAULT_LOCK_TIMEOUT;
     ++
      +	/*
      +	 * Create a lock at "<path>.lock" if we can.
      +	 */
     -+	if (hold_lock_file_for_update_timeout(&lock, path, 0,
     -+					      opts->timeout_ms) < 0) {
     -+		error_errno(_("could not lock listener socket '%s'"), path);
     -+		return NULL;
     -+	}
     ++	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout_ms) < 0)
     ++		return -1;
      +
      +	/*
      +	 * If another server is listening on "<path>" give up.  We do not
      +	 * want to create a socket and steal future connections from them.
      +	 */
      +	if (is_another_server_alive(path, opts)) {
     -+		errno = EADDRINUSE;
     -+		error_errno(_("listener socket already in use '%s'"), path);
      +		rollback_lock_file(&lock);
     -+		return NULL;
     ++		errno = EADDRINUSE;
     ++		return -2;
      +	}
      +
      +	/*
     @@ unix-socket.c: int unix_stream_listen(const char *path,
      +	 */
      +	fd_socket = unix_stream_listen(path, opts);
      +	if (fd_socket < 0) {
     -+		error_errno(_("could not create listener socket '%s'"), path);
     ++		int saved_errno = errno;
      +		rollback_lock_file(&lock);
     -+		return NULL;
     ++		errno = saved_errno;
     ++		return -1;
      +	}
      +
      +	server_socket = xcalloc(1, sizeof(*server_socket));
     @@ unix-socket.c: int unix_stream_listen(const char *path,
      +	server_socket->fd_socket = fd_socket;
      +	lstat(path, &server_socket->st_socket);
      +
     ++	*new_server_socket = server_socket;
     ++
      +	/*
      +	 * Always rollback (just delete) "<path>.lock" because we already created
      +	 * "<path>" as a socket and do not want to commit_lock to do the atomic
     @@ unix-socket.c: int unix_stream_listen(const char *path,
      +	 */
      +	rollback_lock_file(&lock);
      +
     -+	return server_socket;
     ++	return 0;
      +}
      +
      +void unix_stream_server__free(
     @@ unix-socket.c: int unix_stream_listen(const char *path,
      +
      +	if (st_now.st_ino != server_socket->st_socket.st_ino)
      +		return 1;
     ++	if (st_now.st_dev != server_socket->st_socket.st_dev)
     ++		return 1;
      +
     -+	/* We might also consider the ctime on some platforms. */
     ++	if (!S_ISSOCK(st_now.st_mode))
     ++		return 1;
      +
      +	return 0;
      +}
      
     - ## unix-socket.h ##
     + ## unix-stream-server.h (new) ##
      @@
     - #define UNIX_SOCKET_H
     - 
     - struct unix_stream_listen_opts {
     -+	long timeout_ms;
     - 	int listen_backlog_size;
     - 	unsigned int disallow_chdir:1;
     - };
     - 
     -+#define DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT (100)
     - #define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
     - 
     - #define UNIX_STREAM_LISTEN_OPTS_INIT \
     - { \
     -+	.timeout_ms = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT, \
     - 	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
     - 	.disallow_chdir = 0, \
     - }
     -@@ unix-socket.h: int unix_stream_connect(const char *path, int disallow_chdir);
     - int unix_stream_listen(const char *path,
     - 		       const struct unix_stream_listen_opts *opts);
     - 
     ++#ifndef UNIX_STREAM_SERVER_H
     ++#define UNIX_STREAM_SERVER_H
     ++
     ++#include "unix-socket.h"
     ++
      +struct unix_stream_server_socket {
      +	char *path_socket;
      +	struct stat st_socket;
     @@ unix-socket.h: int unix_stream_connect(const char *path, int disallow_chdir);
      +/*
      + * Create a Unix Domain Socket at the given path under the protection
      + * of a '.lock' lockfile.
     ++ *
     ++ * Returns 0 on success, -1 on error, -2 if socket is in use.
      + */
     -+struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
     ++int unix_stream_server__create(
      +	const char *path,
     -+	const struct unix_stream_listen_opts *opts);
     ++	const struct unix_stream_listen_opts *opts,
     ++	long timeout_ms,
     ++	struct unix_stream_server_socket **server_socket);
      +
      +/*
      + * Close and delete the socket.
     @@ unix-socket.h: int unix_stream_connect(const char *path, int disallow_chdir);
      +int unix_stream_server__was_stolen(
      +	struct unix_stream_server_socket *server_socket);
      +
     - #endif /* UNIX_SOCKET_H */
     ++#endif /* UNIX_STREAM_SERVER_H */
 11:  43c8db9a4468 ! 11:  f2e3b046cc8f simple-ipc: add Unix domain socket implementation
     @@ Commit message
      
       ## Makefile ##
      @@ Makefile: ifdef NO_UNIX_SOCKETS
     - 	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
       else
       	LIB_OBJS += unix-socket.o
     + 	LIB_OBJS += unix-stream-server.o
      +	LIB_OBJS += compat/simple-ipc/ipc-shared.o
      +	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
       endif
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +#include "pkt-line.h"
      +#include "thread-utils.h"
      +#include "unix-socket.h"
     ++#include "unix-stream-server.h"
      +
      +#ifdef NO_UNIX_SOCKETS
      +#error compat/simple-ipc/ipc-unix-socket.c requires Unix sockets
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +
      +	if (read_packetized_to_strbuf(
      +		    connection->fd, answer,
     -+		    PACKET_READ_GENTLE_ON_EOF | PACKET_READ_NEVER_DIE) < 0) {
     ++		    PACKET_READ_GENTLE_ON_EOF | PACKET_READ_GENTLE_ON_READ_ERROR) < 0) {
      +		ret = error(_("could not read IPC response"));
      +		goto done;
      +	}
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +
      +	ret = read_packetized_to_strbuf(
      +		reply_data.fd, &buf,
     -+		PACKET_READ_GENTLE_ON_EOF | PACKET_READ_NEVER_DIE);
     ++		PACKET_READ_GENTLE_ON_EOF | PACKET_READ_GENTLE_ON_READ_ERROR);
      +	if (ret >= 0) {
      +		ret = worker_thread_data->server_data->application_cb(
      +			worker_thread_data->server_data->application_data,
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      + */
      +#define LISTEN_BACKLOG (50)
      +
     -+static struct unix_stream_server_socket *create_listener_socket(
     ++static int create_listener_socket(
      +	const char *path,
     -+	const struct ipc_server_opts *ipc_opts)
     ++	const struct ipc_server_opts *ipc_opts,
     ++	struct unix_stream_server_socket **new_server_socket)
      +{
      +	struct unix_stream_server_socket *server_socket = NULL;
      +	struct unix_stream_listen_opts uslg_opts = UNIX_STREAM_LISTEN_OPTS_INIT;
     ++	int ret;
      +
      +	uslg_opts.listen_backlog_size = LISTEN_BACKLOG;
      +	uslg_opts.disallow_chdir = ipc_opts->uds_disallow_chdir;
      +
     -+	server_socket = unix_stream_server__listen_with_lock(path, &uslg_opts);
     -+	if (!server_socket)
     -+		return NULL;
     ++	ret = unix_stream_server__create(path, &uslg_opts, -1, &server_socket);
     ++	if (ret)
     ++		return ret;
      +
      +	if (set_socket_blocking_flag(server_socket->fd_socket, 1)) {
      +		int saved_errno = errno;
     -+		error_errno(_("could not set listener socket nonblocking '%s'"),
     -+			    path);
      +		unix_stream_server__free(server_socket);
      +		errno = saved_errno;
     -+		return NULL;
     ++		return -1;
      +	}
      +
     ++	*new_server_socket = server_socket;
     ++
      +	trace2_data_string("ipc-server", NULL, "listen-with-lock", path);
     -+	return server_socket;
     ++	return 0;
      +}
      +
     -+static struct unix_stream_server_socket *setup_listener_socket(
     ++static int setup_listener_socket(
      +	const char *path,
     -+	const struct ipc_server_opts *ipc_opts)
     ++	const struct ipc_server_opts *ipc_opts,
     ++	struct unix_stream_server_socket **new_server_socket)
      +{
     -+	struct unix_stream_server_socket *server_socket;
     ++	int ret, saved_errno;
      +
      +	trace2_region_enter("ipc-server", "create-listener_socket", NULL);
     -+	server_socket = create_listener_socket(path, ipc_opts);
     ++
     ++	ret = create_listener_socket(path, ipc_opts, new_server_socket);
     ++
     ++	saved_errno = errno;
      +	trace2_region_leave("ipc-server", "create-listener_socket", NULL);
     ++	errno = saved_errno;
      +
     -+	return server_socket;
     ++	return ret;
      +}
      +
      +/*
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	struct ipc_server_data *server_data;
      +	int sv[2];
      +	int k;
     ++	int ret;
      +	int nr_threads = opts->nr_threads;
      +
      +	*returned_server_data = NULL;
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	 * connection or a shutdown request without spinning.
      +	 */
      +	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) < 0)
     -+		return error_errno(_("could not create socketpair for '%s'"),
     -+				   path);
     ++		return -1;
      +
      +	if (set_socket_blocking_flag(sv[1], 1)) {
      +		int saved_errno = errno;
      +		close(sv[0]);
      +		close(sv[1]);
      +		errno = saved_errno;
     -+		return error_errno(_("making socketpair nonblocking '%s'"),
     -+				   path);
     ++		return -1;
      +	}
      +
     -+	server_socket = setup_listener_socket(path, opts);
     -+	if (!server_socket) {
     ++	ret = setup_listener_socket(path, opts, &server_socket);
     ++	if (ret) {
      +		int saved_errno = errno;
      +		close(sv[0]);
      +		close(sv[1]);
      +		errno = saved_errno;
     -+		return -1;
     ++		return ret;
      +	}
      +
      +	server_data = xcalloc(1, sizeof(*server_data));
 12:  09568a6500dd ! 12:  6ccc7472096f t0052: add simple-ipc tests and t/helper/test-simple-ipc tool
     @@ t/helper/test-simple-ipc.c (new)
      +	return app__unhandled_command(command, reply_cb, reply_data);
      +}
      +
     ++struct cl_args
     ++{
     ++	const char *subcommand;
     ++	const char *path;
     ++	const char *token;
     ++
     ++	int nr_threads;
     ++	int max_wait_sec;
     ++	int bytecount;
     ++	int batchsize;
     ++
     ++	char bytevalue;
     ++};
     ++
     ++static struct cl_args cl_args = {
     ++	.subcommand = NULL,
     ++	.path = "ipc-test",
     ++	.token = NULL,
     ++
     ++	.nr_threads = 5,
     ++	.max_wait_sec = 60,
     ++	.bytecount = 1024,
     ++	.batchsize = 10,
     ++
     ++	.bytevalue = 'x',
     ++};
     ++
      +/*
      + * This process will run as a simple-ipc server and listen for IPC commands
      + * from client processes.
      + */
     -+static int daemon__run_server(const char *path, int argc, const char **argv)
     ++static int daemon__run_server(void)
      +{
     -+	struct ipc_server_opts opts = {
     -+		.nr_threads = 5
     -+	};
     ++	int ret;
      +
     -+	const char * const daemon_usage[] = {
     -+		N_("test-helper simple-ipc run-daemon [<options>"),
     -+		NULL
     -+	};
     -+	struct option daemon_options[] = {
     -+		OPT_INTEGER(0, "threads", &opts.nr_threads,
     -+			    N_("number of threads in server thread pool")),
     -+		OPT_END()
     ++	struct ipc_server_opts opts = {
     ++		.nr_threads = cl_args.nr_threads,
      +	};
      +
     -+	argc = parse_options(argc, argv, NULL, daemon_options, daemon_usage, 0);
     -+
     -+	if (opts.nr_threads < 1)
     -+		opts.nr_threads = 1;
     -+
      +	/*
      +	 * Synchronously run the ipc-server.  We don't need any application
      +	 * instance data, so pass an arbitrary pointer (that we'll later
      +	 * verify made the round trip).
      +	 */
     -+	return ipc_server_run(path, &opts, test_app_cb, (void*)&my_app_data);
     ++	ret = ipc_server_run(cl_args.path, &opts, test_app_cb, (void*)&my_app_data);
     ++	if (ret == -2)
     ++		error(_("socket/pipe already in use: '%s'"), cl_args.path);
     ++	else if (ret == -1)
     ++		error_errno(_("could not start server on: '%s'"), cl_args.path);
     ++
     ++	return ret;
      +}
      +
      +#ifndef GIT_WINDOWS_NATIVE
     @@ t/helper/test-simple-ipc.c (new)
      + * This is adapted from `daemonize()`.  Use `fork()` to directly create and
      + * run the daemon in a child process.
      + */
     -+static int spawn_server(const char *path,
     -+			const struct ipc_server_opts *opts,
     -+			pid_t *pid)
     ++static int spawn_server(pid_t *pid)
      +{
     ++	struct ipc_server_opts opts = {
     ++		.nr_threads = cl_args.nr_threads,
     ++	};
     ++
      +	*pid = fork();
      +
      +	switch (*pid) {
     @@ t/helper/test-simple-ipc.c (new)
      +		close(2);
      +		sanitize_stdfds();
      +
     -+		return ipc_server_run(path, opts, test_app_cb, (void*)&my_app_data);
     ++		return ipc_server_run(cl_args.path, &opts, test_app_cb,
     ++				      (void*)&my_app_data);
      +
      +	case -1:
      +		return error_errno(_("could not spawn daemon in the background"));
     @@ t/helper/test-simple-ipc.c (new)
      + * have `fork(2)`.  Spawn a normal Windows child process but without the
      + * limitations of `start_command()` and `finish_command()`.
      + */
     -+static int spawn_server(const char *path,
     -+			const struct ipc_server_opts *opts,
     -+			pid_t *pid)
     ++static int spawn_server(pid_t *pid)
      +{
      +	char test_tool_exe[MAX_PATH];
      +	struct strvec args = STRVEC_INIT;
     @@ t/helper/test-simple-ipc.c (new)
      +	strvec_push(&args, test_tool_exe);
      +	strvec_push(&args, "simple-ipc");
      +	strvec_push(&args, "run-daemon");
     -+	strvec_pushf(&args, "--threads=%d", opts->nr_threads);
     ++	strvec_pushf(&args, "--name=%s", cl_args.path);
     ++	strvec_pushf(&args, "--threads=%d", cl_args.nr_threads);
      +
      +	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
      +	close(in);
     @@ t/helper/test-simple-ipc.c (new)
      + * let it get started and begin listening for requests on the socket
      + * before reporting our success.
      + */
     -+static int wait_for_server_startup(const char * path, pid_t pid_child,
     -+				   int max_wait_sec)
     ++static int wait_for_server_startup(pid_t pid_child)
      +{
      +	int status;
      +	pid_t pid_seen;
     @@ t/helper/test-simple-ipc.c (new)
      +	time_t time_limit, now;
      +
      +	time(&time_limit);
     -+	time_limit += max_wait_sec;
     ++	time_limit += cl_args.max_wait_sec;
      +
      +	for (;;) {
      +		pid_seen = waitpid(pid_child, &status, WNOHANG);
     @@ t/helper/test-simple-ipc.c (new)
      +			 * after a timeout on the lock), but we don't
      +			 * care (who responds) if the socket is live.
      +			 */
     -+			s = ipc_get_active_state(path);
     ++			s = ipc_get_active_state(cl_args.path);
      +			if (s == IPC_STATE__LISTENING)
      +				return 0;
      +
     @@ t/helper/test-simple-ipc.c (new)
      +			 *
      +			 * Again, we don't care who services the socket.
      +			 */
     -+			s = ipc_get_active_state(path);
     ++			s = ipc_get_active_state(cl_args.path);
      +			if (s == IPC_STATE__LISTENING)
      +				return 0;
      +
     @@ t/helper/test-simple-ipc.c (new)
      + * more control and better error reporting (and makes it easier to write
      + * unit tests).
      + */
     -+static int daemon__start_server(const char *path, int argc, const char **argv)
     ++static int daemon__start_server(void)
      +{
      +	pid_t pid_child;
      +	int ret;
     -+	int max_wait_sec = 60;
     -+	struct ipc_server_opts opts = {
     -+		.nr_threads = 5
     -+	};
     -+
     -+	const char * const daemon_usage[] = {
     -+		N_("test-helper simple-ipc start-daemon [<options>"),
     -+		NULL
     -+	};
     -+
     -+	struct option daemon_options[] = {
     -+		OPT_INTEGER(0, "max-wait", &max_wait_sec,
     -+			    N_("seconds to wait for daemon to startup")),
     -+		OPT_INTEGER(0, "threads", &opts.nr_threads,
     -+			    N_("number of threads in server thread pool")),
     -+		OPT_END()
     -+	};
     -+
     -+	argc = parse_options(argc, argv, NULL, daemon_options, daemon_usage, 0);
     -+
     -+	if (max_wait_sec < 0)
     -+		max_wait_sec = 0;
     -+	if (opts.nr_threads < 1)
     -+		opts.nr_threads = 1;
      +
      +	/*
      +	 * Run the actual daemon in a background process.
      +	 */
     -+	ret = spawn_server(path, &opts, &pid_child);
     ++	ret = spawn_server(&pid_child);
      +	if (pid_child <= 0)
      +		return ret;
      +
     @@ t/helper/test-simple-ipc.c (new)
      +	 * Let the parent wait for the child process to get started
      +	 * and begin listening for requests on the socket.
      +	 */
     -+	ret = wait_for_server_startup(path, pid_child, max_wait_sec);
     ++	ret = wait_for_server_startup(pid_child);
      +
      +	return ret;
      +}
     @@ t/helper/test-simple-ipc.c (new)
      + *
      + * Returns 0 if the server is alive.
      + */
     -+static int client__probe_server(const char *path)
     ++static int client__probe_server(void)
      +{
      +	enum ipc_active_state s;
      +
     -+	s = ipc_get_active_state(path);
     ++	s = ipc_get_active_state(cl_args.path);
      +	switch (s) {
      +	case IPC_STATE__LISTENING:
      +		return 0;
      +
      +	case IPC_STATE__NOT_LISTENING:
     -+		return error("no server listening at '%s'", path);
     ++		return error("no server listening at '%s'", cl_args.path);
      +
      +	case IPC_STATE__PATH_NOT_FOUND:
     -+		return error("path not found '%s'", path);
     ++		return error("path not found '%s'", cl_args.path);
      +
      +	case IPC_STATE__INVALID_PATH:
     -+		return error("invalid pipe/socket name '%s'", path);
     ++		return error("invalid pipe/socket name '%s'", cl_args.path);
      +
      +	case IPC_STATE__OTHER_ERROR:
      +	default:
     -+		return error("other error for '%s'", path);
     ++		return error("other error for '%s'", cl_args.path);
      +	}
      +}
      +
      +/*
     -+ * Send an IPC command to an already-running server daemon and print the
     -+ * response.
     ++ * Send an IPC command token to an already-running server daemon and
     ++ * print the response.
      + *
     -+ * argv[2] contains a simple (1 word) command that `test_app_cb()` (in
     -+ * the daemon process) will understand.
     ++ * This is a simple 1 word command/token that `test_app_cb()` (in the
     ++ * daemon process) will understand.
      + */
     -+static int client__send_ipc(int argc, const char **argv, const char *path)
     ++static int client__send_ipc(void)
      +{
     -+	const char *command = argc > 2 ? argv[2] : "(no command)";
     ++	const char *command = "(no-command)";
      +	struct strbuf buf = STRBUF_INIT;
      +	struct ipc_client_connect_options options
      +		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
      +
     ++	if (cl_args.token && *cl_args.token)
     ++		command = cl_args.token;
     ++
      +	options.wait_if_busy = 1;
      +	options.wait_if_not_found = 0;
      +
     -+	if (!ipc_client_send_command(path, &options, command, &buf)) {
     ++	if (!ipc_client_send_command(cl_args.path, &options, command, &buf)) {
      +		if (buf.len) {
      +			printf("%s\n", buf.buf);
      +			fflush(stdout);
     @@ t/helper/test-simple-ipc.c (new)
      +		return 0;
      +	}
      +
     -+	return error("failed to send '%s' to '%s'", command, path);
     ++	return error("failed to send '%s' to '%s'", command, cl_args.path);
      +}
      +
      +/*
     @@ t/helper/test-simple-ipc.c (new)
      + * event in the server, so we spin and wait here for it to actually
      + * shutdown to make the unit tests a little easier to write.
      + */
     -+static int client__stop_server(int argc, const char **argv, const char *path)
     ++static int client__stop_server(void)
      +{
     -+	const char *send_quit[] = { argv[0], "send", "quit", NULL };
     -+	int max_wait_sec = 60;
      +	int ret;
      +	time_t time_limit, now;
      +	enum ipc_active_state s;
      +
     -+	const char * const stop_usage[] = {
     -+		N_("test-helper simple-ipc stop-daemon [<options>]"),
     -+		NULL
     -+	};
     -+
     -+	struct option stop_options[] = {
     -+		OPT_INTEGER(0, "max-wait", &max_wait_sec,
     -+			    N_("seconds to wait for daemon to stop")),
     -+		OPT_END()
     -+	};
     -+
     -+	argc = parse_options(argc, argv, NULL, stop_options, stop_usage, 0);
     -+
     -+	if (max_wait_sec < 0)
     -+		max_wait_sec = 0;
     -+
      +	time(&time_limit);
     -+	time_limit += max_wait_sec;
     ++	time_limit += cl_args.max_wait_sec;
     ++
     ++	cl_args.token = "quit";
      +
     -+	ret = client__send_ipc(3, send_quit, path);
     ++	ret = client__send_ipc();
      +	if (ret)
      +		return ret;
      +
      +	for (;;) {
      +		sleep_millisec(100);
      +
     -+		s = ipc_get_active_state(path);
     ++		s = ipc_get_active_state(cl_args.path);
      +
      +		if (s != IPC_STATE__LISTENING) {
      +			/*
     @@ t/helper/test-simple-ipc.c (new)
      +/*
      + * Send an IPC command with ballast to an already-running server daemon.
      + */
     -+static int client__sendbytes(int argc, const char **argv, const char *path)
     ++static int client__sendbytes(void)
      +{
     -+	int bytecount = 1024;
     -+	char *string = "x";
     -+	const char * const sendbytes_usage[] = {
     -+		N_("test-helper simple-ipc sendbytes [<options>]"),
     -+		NULL
     -+	};
     -+	struct option sendbytes_options[] = {
     -+		OPT_INTEGER(0, "bytecount", &bytecount, N_("number of bytes")),
     -+		OPT_STRING(0, "byte", &string, N_("byte"), N_("ballast")),
     -+		OPT_END()
     -+	};
      +	struct ipc_client_connect_options options
      +		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
      +
     @@ t/helper/test-simple-ipc.c (new)
      +	options.wait_if_not_found = 0;
      +	options.uds_disallow_chdir = 0;
      +
     -+	argc = parse_options(argc, argv, NULL, sendbytes_options, sendbytes_usage, 0);
     -+
     -+	return do_sendbytes(bytecount, string[0], path, &options);
     ++	return do_sendbytes(cl_args.bytecount, cl_args.bytevalue, cl_args.path,
     ++			    &options);
      +}
      +
      +struct multiple_thread_data {
     @@ t/helper/test-simple-ipc.c (new)
      + * Start a client-side thread pool.  Each thread sends a series of
      + * IPC requests.  Each request is on a new connection to the server.
      + */
     -+static int client__multiple(int argc, const char **argv, const char *path)
     ++static int client__multiple(void)
      +{
      +	struct multiple_thread_data *list = NULL;
      +	int k;
     -+	int nr_threads = 5;
     -+	int bytecount = 1;
     -+	int batchsize = 10;
      +	int sum_join_errors = 0;
      +	int sum_thread_errors = 0;
      +	int sum_good = 0;
      +
     -+	const char * const multiple_usage[] = {
     -+		N_("test-helper simple-ipc multiple [<options>]"),
     -+		NULL
     -+	};
     -+	struct option multiple_options[] = {
     -+		OPT_INTEGER(0, "bytecount", &bytecount, N_("number of bytes")),
     -+		OPT_INTEGER(0, "threads", &nr_threads, N_("number of threads")),
     -+		OPT_INTEGER(0, "batchsize", &batchsize, N_("number of requests per thread")),
     -+		OPT_END()
     -+	};
     -+
     -+	argc = parse_options(argc, argv, NULL, multiple_options, multiple_usage, 0);
     -+
     -+	if (bytecount < 1)
     -+		bytecount = 1;
     -+	if (nr_threads < 1)
     -+		nr_threads = 1;
     -+	if (batchsize < 1)
     -+		batchsize = 1;
     -+
     -+	for (k = 0; k < nr_threads; k++) {
     ++	for (k = 0; k < cl_args.nr_threads; k++) {
      +		struct multiple_thread_data *d = xcalloc(1, sizeof(*d));
      +		d->next = list;
     -+		d->path = path;
     -+		d->bytecount = bytecount + batchsize*(k/26);
     -+		d->batchsize = batchsize;
     ++		d->path = cl_args.path;
     ++		d->bytecount = cl_args.bytecount + cl_args.batchsize*(k/26);
     ++		d->batchsize = cl_args.batchsize;
      +		d->sum_errors = 0;
      +		d->sum_good = 0;
      +		d->letter = 'A' + (k % 26);
     @@ t/helper/test-simple-ipc.c (new)
      +
      +int cmd__simple_ipc(int argc, const char **argv)
      +{
     -+	const char *path = "ipc-test";
     ++	const char * const simple_ipc_usage[] = {
     ++		N_("test-helper simple-ipc is-active    [<name>] [<options>]"),
     ++		N_("test-helper simple-ipc run-daemon   [<name>] [<threads>]"),
     ++		N_("test-helper simple-ipc start-daemon [<name>] [<threads>] [<max-wait>]"),
     ++		N_("test-helper simple-ipc stop-daemon  [<name>] [<max-wait>]"),
     ++		N_("test-helper simple-ipc send         [<name>] [<token>]"),
     ++		N_("test-helper simple-ipc sendbytes    [<name>] [<bytecount>] [<byte>]"),
     ++		N_("test-helper simple-ipc multiple     [<name>] [<threads>] [<bytecount>] [<batchsize>]"),
     ++		NULL
     ++	};
     ++
     ++	const char *bytevalue = NULL;
     ++
     ++	struct option options[] = {
     ++#ifndef GIT_WINDOWS_NATIVE
     ++		OPT_STRING(0, "name", &cl_args.path, N_("name"), N_("name or pathname of unix domain socket")),
     ++#else
     ++		OPT_STRING(0, "name", &cl_args.path, N_("name"), N_("named-pipe name")),
     ++#endif
     ++		OPT_INTEGER(0, "threads", &cl_args.nr_threads, N_("number of threads in server thread pool")),
     ++		OPT_INTEGER(0, "max-wait", &cl_args.max_wait_sec, N_("seconds to wait for daemon to start or stop")),
     ++
     ++		OPT_INTEGER(0, "bytecount", &cl_args.bytecount, N_("number of bytes")),
     ++		OPT_INTEGER(0, "batchsize", &cl_args.batchsize, N_("number of requests per thread")),
     ++
     ++		OPT_STRING(0, "byte", &bytevalue, N_("byte"), N_("ballast character")),
     ++		OPT_STRING(0, "token", &cl_args.token, N_("token"), N_("command token to send to the server")),
     ++
     ++		OPT_END()
     ++	};
     ++
     ++	if (argc < 2)
     ++		usage_with_options(simple_ipc_usage, options);
     ++
     ++	if (argc == 2 && !strcmp(argv[1], "-h"))
     ++		usage_with_options(simple_ipc_usage, options);
      +
      +	if (argc == 2 && !strcmp(argv[1], "SUPPORTS_SIMPLE_IPC"))
      +		return 0;
      +
     ++	cl_args.subcommand = argv[1];
     ++
     ++	argc--;
     ++	argv++;
     ++
     ++	argc = parse_options(argc, argv, NULL, options, simple_ipc_usage, 0);
     ++
     ++	if (cl_args.nr_threads < 1)
     ++		cl_args.nr_threads = 1;
     ++	if (cl_args.max_wait_sec < 0)
     ++		cl_args.max_wait_sec = 0;
     ++	if (cl_args.bytecount < 1)
     ++		cl_args.bytecount = 1;
     ++	if (cl_args.batchsize < 1)
     ++		cl_args.batchsize = 1;
     ++
     ++	if (bytevalue && *bytevalue)
     ++		cl_args.bytevalue = bytevalue[0];
     ++
      +	/*
      +	 * Use '!!' on all dispatch functions to map from `error()` style
      +	 * (returns -1) style to `test_must_fail` style (expects 1).  This
      +	 * makes shell error messages less confusing.
      +	 */
      +
     -+	if (argc == 2 && !strcmp(argv[1], "is-active"))
     -+		return !!client__probe_server(path);
     ++	if (!strcmp(cl_args.subcommand, "is-active"))
     ++		return !!client__probe_server();
      +
     -+	if (argc >= 2 && !strcmp(argv[1], "run-daemon"))
     -+		return !!daemon__run_server(path, argc, argv);
     ++	if (!strcmp(cl_args.subcommand, "run-daemon"))
     ++		return !!daemon__run_server();
      +
     -+	if (argc >= 2 && !strcmp(argv[1], "start-daemon"))
     -+		return !!daemon__start_server(path, argc, argv);
     ++	if (!strcmp(cl_args.subcommand, "start-daemon"))
     ++		return !!daemon__start_server();
      +
      +	/*
      +	 * Client commands follow.  Ensure a server is running before
     -+	 * going any further.
     ++	 * sending any data.  This might be overkill, but then again
     ++	 * this is a test harness.
      +	 */
     -+	if (client__probe_server(path))
     -+		return 1;
      +
     -+	if (argc >= 2 && !strcmp(argv[1], "stop-daemon"))
     -+		return !!client__stop_server(argc, argv, path);
     ++	if (!strcmp(cl_args.subcommand, "stop-daemon")) {
     ++		if (client__probe_server())
     ++			return 1;
     ++		return !!client__stop_server();
     ++	}
      +
     -+	if ((argc == 2 || argc == 3) && !strcmp(argv[1], "send"))
     -+		return !!client__send_ipc(argc, argv, path);
     ++	if (!strcmp(cl_args.subcommand, "send")) {
     ++		if (client__probe_server())
     ++			return 1;
     ++		return !!client__send_ipc();
     ++	}
      +
     -+	if (argc >= 2 && !strcmp(argv[1], "sendbytes"))
     -+		return !!client__sendbytes(argc, argv, path);
     ++	if (!strcmp(cl_args.subcommand, "sendbytes")) {
     ++		if (client__probe_server())
     ++			return 1;
     ++		return !!client__sendbytes();
     ++	}
      +
     -+	if (argc >= 2 && !strcmp(argv[1], "multiple"))
     -+		return !!client__multiple(argc, argv, path);
     ++	if (!strcmp(cl_args.subcommand, "multiple")) {
     ++		if (client__probe_server())
     ++			return 1;
     ++		return !!client__multiple();
     ++	}
      +
     -+	die("Unhandled argv[1]: '%s'", argv[1]);
     ++	die("Unhandled subcommand: '%s'", cl_args.subcommand);
      +}
      +#endif
      
     @@ t/t0052-simple-ipc.sh (new)
      +'
      +
      +test_expect_success 'simple command server' '
     -+	test-tool simple-ipc send ping >actual &&
     ++	test-tool simple-ipc send --token=ping >actual &&
      +	echo pong >expect &&
      +	test_cmp expect actual
      +'
     @@ t/t0052-simple-ipc.sh (new)
      +'
      +
      +test_expect_success 'big response' '
     -+	test-tool simple-ipc send big >actual &&
     ++	test-tool simple-ipc send --token=big >actual &&
      +	test_line_count -ge 10000 actual &&
      +	grep -q "big: [0]*9999\$" actual
      +'
      +
      +test_expect_success 'chunk response' '
     -+	test-tool simple-ipc send chunk >actual &&
     ++	test-tool simple-ipc send --token=chunk >actual &&
      +	test_line_count -ge 10000 actual &&
      +	grep -q "big: [0]*9999\$" actual
      +'
      +
      +test_expect_success 'slow response' '
     -+	test-tool simple-ipc send slow >actual &&
     ++	test-tool simple-ipc send --token=slow >actual &&
      +	test_line_count -ge 100 actual &&
      +	grep -q "big: [0]*99\$" actual
      +'
     @@ t/t0052-simple-ipc.sh (new)
      +test_expect_success 'stop-daemon works' '
      +	test-tool simple-ipc stop-daemon &&
      +	test_must_fail test-tool simple-ipc is-active &&
     -+	test_must_fail test-tool simple-ipc send ping
     ++	test_must_fail test-tool simple-ipc send --token=ping
      +'
      +
      +test_done

-- 
gitgitgadget
