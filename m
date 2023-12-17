Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1E446B2
	for <git@vger.kernel.org>; Sun, 17 Dec 2023 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLqyV4EJ"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7b7a9f90edaso189623139f.0
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 06:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702824100; x=1703428900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqLz7lFZVlik7vjdCYBALriUSN7EU5nFHw67BP0L2FM=;
        b=TLqyV4EJlL1opI7CDZhbBLQBLN4WsGQYDq8stDoTs+BXm+0uTMZrJT/oBPFhUwj3jv
         bu8vAxbU8REUPCMxx36llt3cAKcLsttcFrJhZtxoSusKEc3oWROAAoI862GVgvOrTvk5
         NG5AchoSXHCUbBNYNtFBJHO+sf3x8MAXjJR7K/pcrCtgmQ9IZltmVUM28In5dED1jai9
         gAlM0/ls3a6x45L6HFEN5gK3hdU6FjV8MvnkWm0x1AuAeRFlLvtHrD12kXW1R0dwfIUZ
         Jct4587NbbyL8TlbnxIE7aAWn4xKyTMiM3GnkjRfiq5DaZVeTKVynlxErZDhLsH9CJBy
         frug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702824100; x=1703428900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqLz7lFZVlik7vjdCYBALriUSN7EU5nFHw67BP0L2FM=;
        b=mYScQdSoUqhorknKfdfE6yE17JSo1nF66RUdW8dc5+yyG8cRPs9dgNEicOOp25BbHj
         YttwpxyV2HUcYEw7Wb51wwMaZEPNwrS6OsyKjbsIaVB3GA4UvtRG94HCR6f+RIUkNVTh
         Q/M6hBWjiHsZ+mA4W3B6+evtqkmi55l9gg0aYKZ+xqWd7sj00D2SWRZf4Ka6ZTF/nREy
         orqS90TJ6vErow2gB3IDZJ+ny51lrKR+f5wanYHdvZoDBbN9e/0MO7Zo0QIOpUDaUjzf
         gcBnT5TFjYX3DUCP5nFAjSV+1Cds9nLxcVAjIeZ8QKhx96ilySJ7gMdkodf1F+eUEBTV
         Mt3A==
X-Gm-Message-State: AOJu0YyKRskAE0sAgRLS0mB4tzijuga+A6g/anbsNk6FNvrrxTqD/xEq
	1kM4/SZSpbVCrejb/7c5YyjbPp1Q8go=
X-Google-Smtp-Source: AGHT+IFGO3nH6i4PrMqC4ZYRE06t7TK+aSUtMFMs3eMTXRbpa9X2xQAy5dwM2FaPoUieQnRrf46Nrg==
X-Received: by 2002:a92:cd8d:0:b0:35f:af09:23c7 with SMTP id r13-20020a92cd8d000000b0035faf0923c7mr893099ilb.52.1702824100587;
        Sun, 17 Dec 2023 06:41:40 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b005c1ce3c960bsm16276657pgg.50.2023.12.17.06.41.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2023 06:41:40 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 0/3] Sideband-all demultiplexer fixes
Date: Sun, 17 Dec 2023 22:41:35 +0800
Message-Id: <cover.1702823801.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1696425168.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1696425168.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

# Changes since v3:

Change commit message and comments to make them clear for review.


# range-diff v3...v4

1:  e387088da2 ! 1:  ff4e5aff2a test-pkt-line: add option parser for unpack-sideband
    @@ Commit message
          * Use "test-tool pkt-line send-split-sideband" to generate sideband
            messages.
     
    -     * We can pipe these generated sideband messages to command "test-tool
    -       pkt-line unpack-sideband" to test packet_reader_read() function.
    +     * Pipe these generated sideband messages to command "test-tool pkt-line
    +       unpack-sideband" to test packet_reader_read() function.
     
         In order to make a complete test of the packet_reader_read() function,
         add option parser for command "test-tool pkt-line unpack-sideband".
     
    -    To remove newlines in sideband messages, we can use:
    +     * To remove newlines in sideband messages, we can use:
     
    -        $ test-tool pkt-line unpack-sideband --chomp-newline
    +            $ test-tool pkt-line unpack-sideband --chomp-newline
     
    -    To preserve newlines in sideband messages, we can use:
    +     * To preserve newlines in sideband messages, we can use:
     
    -        $ test-tool pkt-line unpack-sideband --no-chomp-newline
    +            $ test-tool pkt-line unpack-sideband --no-chomp-newline
     
    -    To parse sideband messages using "demultiplex_sideband()" inside the
    -    function "packet_reader_read()", we can use:
    +     * To parse sideband messages using "demultiplex_sideband()" inside the
    +       function "packet_reader_read()", we can use:
     
    -        $ test-tool pkt-line unpack-sideband --reader-use-sideband
    +            $ test-tool pkt-line unpack-sideband --reader-use-sideband
     
    -    Add several new test cases in t0070. Among these test cases, we pipe
    +    We also add new example sideband packets in send_split_sideband() and
    +    add several new test cases in t0070. Among these test cases, we pipe
         output of the "send-split-sideband" subcommand to the "unpack-sideband"
         subcommand. We found two issues:
     
          1. The two splitted sideband messages "Hello," and " world!\n" should
    -        be concatenated together. But when we enabled the function
    -        "demultiplex_sideband()" to parse sideband messages, the first part
    -        of the splitted message ("Hello,") is lost.
    +        be concatenated together. But when we turn on use_sideband field of
    +        reader to parse sideband messages, the first part of the splitted
    +        message ("Hello,") is lost.
     
          2. The newline characters in sideband 2 (progress info) and sideband 3
    -        (error message) should be preserved, but they are also trimmed.
    +        (error message) should be preserved, but they are both trimmed.
     
         Will fix the above two issues in subsequent commits.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## t/helper/test-pkt-line.c ##
     @@
    @@ t/helper/test-pkt-line.c: static void unpack_sideband(void)
     +			/*
     +			 * When the "use_sideband" field of the reader is turned
     +			 * on, sideband packets other than the payload have been
    -+			 * parsed and consumed.
    ++			 * parsed and consumed in packet_reader_read(), and only
    ++			 * the payload arrives here.
     +			 */
     +			if (reader.use_sideband) {
     +				write_or_die(1, reader.line, reader.pktlen - 1);
    @@ t/helper/test-pkt-line.c: static void unpack_sideband(void)
      	packet_response_end(1);
      
     +	/*
    -+	 * The unpack_sideband() function above requires a flush
    -+	 * packet to end parsing.
    ++	 * We use unpack_sideband() to consume packets. A flush packet
    ++	 * is required to end parsing.
     +	 */
     +	packet_flush(1);
     +
    @@ t/t0070-fundamental.sh: test_expect_success 'missing sideband designator is repo
     +	test_cmp expect-err err
     +'
     +
    -+test_expect_failure 'unpack-sideband with demultiplex_sideband(), no chomp newline' '
    ++test_expect_failure 'unpack-sideband: packet_reader_read() consumes sideband, no chomp payload' '
     +	test_when_finished "rm -f expect-out expect-err" &&
     +	test-tool pkt-line send-split-sideband >split-sideband &&
     +	test-tool pkt-line unpack-sideband \
    @@ t/t0070-fundamental.sh: test_expect_success 'missing sideband designator is repo
     +	test_cmp expect-err err
     +'
     +
    -+test_expect_failure 'unpack-sideband with demultiplex_sideband(), chomp newline' '
    ++test_expect_failure 'unpack-sideband: packet_reader_read() consumes sideband, chomp payload' '
     +	test_when_finished "rm -f expect-out expect-err" &&
     +	test-tool pkt-line send-split-sideband >split-sideband &&
     +	test-tool pkt-line unpack-sideband \
2:  633bfbac39 ! 2:  5942b74cab pkt-line: memorize sideband fragment in reader
    @@ t/t0070-fundamental.sh: test_expect_success 'unpack-sideband: --chomp-newline (d
      	test_cmp expect-err err
      '
      
    --test_expect_failure 'unpack-sideband with demultiplex_sideband(), no chomp newline' '
    -+test_expect_success 'unpack-sideband with demultiplex_sideband(), no chomp newline' '
    +-test_expect_failure 'unpack-sideband: packet_reader_read() consumes sideband, no chomp payload' '
    ++test_expect_success 'unpack-sideband: packet_reader_read() consumes sideband, no chomp payload' '
      	test_when_finished "rm -f expect-out expect-err" &&
      	test-tool pkt-line send-split-sideband >split-sideband &&
      	test-tool pkt-line unpack-sideband \
3:  2a2da65fac ! 3:  dd2e34da16 pkt-line: do not chomp newlines for sideband messages
    @@ pkt-line.h: void packet_fflush(FILE *f);
      /*
     
      ## t/t0070-fundamental.sh ##
    -@@ t/t0070-fundamental.sh: test_expect_success 'unpack-sideband with demultiplex_sideband(), no chomp newli
    +@@ t/t0070-fundamental.sh: test_expect_success 'unpack-sideband: packet_reader_read() consumes sideband, no
      	test_cmp expect-err err
      '
      
    --test_expect_failure 'unpack-sideband with demultiplex_sideband(), chomp newline' '
    -+test_expect_success 'unpack-sideband with demultiplex_sideband(), chomp newline' '
    +-test_expect_failure 'unpack-sideband: packet_reader_read() consumes sideband, chomp payload' '
    ++test_expect_success 'unpack-sideband: packet_reader_read() consumes sideband, chomp payload' '
      	test_when_finished "rm -f expect-out expect-err" &&
      	test-tool pkt-line send-split-sideband >split-sideband &&
      	test-tool pkt-line unpack-sideband \


Jiang Xin (3):
  test-pkt-line: add option parser for unpack-sideband
  pkt-line: memorize sideband fragment in reader
  pkt-line: do not chomp newlines for sideband messages

 pkt-line.c               | 36 ++++++++++++++++++++----
 pkt-line.h               |  4 +++
 t/helper/test-pkt-line.c | 59 ++++++++++++++++++++++++++++++++++++----
 t/t0070-fundamental.sh   | 58 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 10 deletions(-)

-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

