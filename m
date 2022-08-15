Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9751C25B0F
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 01:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiHOBHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 21:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiHOBHA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 21:07:00 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46511156
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 18:06:56 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 67so5970320vsv.2
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=y3mh1wPIMjQCB26G0El4h0cGAmbno5/PAN+k4msD72U=;
        b=UVk03kbB9sw8XHVd3njKn2lwlmrcPgroF9+1AD7IoTWfRviSsTiy1RzavG7C6zupra
         kQPBGbUPvcTdhFDfWIHMvjTqlHMmOXzzVJPdDu2bsQYe0Dv5p3uN722loTVsVWNSu89C
         qaejcfP8wmrD+BUrWre1rTvqOdSXfqlkiK4vnrYt4j56RiDEW7EPaDqPqJurdouzPS2O
         F5RWEhkQjdkxkPUA/EceeWbuJibit1FnscwrybCaMeuzTdtZ9VmtCTDjL985Z1r67Doc
         ured3REodJaLxbjFYhGm1/eIkuIknvjchE32z3UEWKwyzXMNBIes4rnxci79aBSBbrkt
         5yVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=y3mh1wPIMjQCB26G0El4h0cGAmbno5/PAN+k4msD72U=;
        b=2X/8eK3A/64+p1CmOHPJQ9G9yPOd0gTCTxB++pxr2N5p0pKP3m9DRzolS2MvQLIjVZ
         TwalV2TBv5YmdBjD75mh2/2XPOB5RCn7RaZdvaKLhHZxx00rhPCi7iUVIueVJBBRqLbj
         Jhn+KUsmjp+ntWu4vOfyd9XH/FAXVGanWO9X8A+xkvFONLbAVZECoGepu6ylfLpojx8O
         oPl8Pt6h95dkoBdfUDrFc3ayTBTrUarJ28zoJMXs4qk/LXHXWorgMWP1bJ9W2sP2tWOv
         PyNDncLy0qbCV+OUnwcv684anpNTxHbiJUW+MoZrWdsR4vW8e/BM2lQL7V6CXoLF43lj
         5vug==
X-Gm-Message-State: ACgBeo0cH41PJqJ5ha4s2y0zKOzPQkd+giN5vaSCaR0/EsNgA4+bHBQp
        FGQf3u9lnL8INnQZi6Ja4iSxWeoMotKZEg==
X-Google-Smtp-Source: AA6agR7eXsAGqu2ml2lOE1jPkjEXlDHR0yWFET7WYiU6By55vXZXJf+IZHAUPGcKs/zmEKC6iCRmUQ==
X-Received: by 2002:a67:ca12:0:b0:38a:7bf5:a588 with SMTP id z18-20020a67ca12000000b0038a7bf5a588mr5111832vsk.48.1660525614752;
        Sun, 14 Aug 2022 18:06:54 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id d66-20020a1f9b45000000b003791113188csm5943133vke.55.2022.08.14.18.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 18:06:54 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, johannes.schindelin@gmx.de
Subject: [PATCH v4 0/3] t0021: convert perl script to C test-tool helper
Date:   Sun, 14 Aug 2022 22:06:35 -0300
Message-Id: <cover.1660522524.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659291025.git.matheus.bernardino@usp.br>
References: <cover.1659291025.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert t/t0021/rot13-filter.pl to a test-tool helper to avoid the PERL
prereq in various tests.

Main changes since v3:
Patch 2:
- Mentioned in commit message why we removed the flush() calls for the
  log file handler.
- Removed 'buf[size] = \0' and relied on the fact that packet_read()
  already 0-terminates the buffer. This also allows us to use NULL
  instead of &size in many places, dropping down the unneeded variable.
- Used parse-options instead of manual argv fiddling. I'm not strongly
  about one way or another, but I found the parse-options slightly
  easier for new options that may be added in the future.
- Style: removed unnecessary {} and newline.

Notes:
- About the s/die()/BUG()/ suggestion: I ended up leaving the die()
  calls because this seems to be the preferred mechanics at the
  t/helper/*.c files.

- About the suggestion of dropping the dot printing from Dscho: I really
  wished we could do that because I dislike the huge function name at
  pkt-line.*. Unfortunately, though, many tests in t0021-conversion.sh
  do seem to rely on the number of dots printed to the log file to check
  the proper number of packets sent. See e.g. the test 'required process
  filter should process multiple packets'.

Matheus Tavares (3):
  t0021: avoid grepping for a Perl-specific string at filter output
  t0021: implementation the rot13-filter.pl script in C
  tests: use the new C rot13-filter helper to avoid PERL prereq

 Makefile                                |   1 +
 pkt-line.c                              |   5 +-
 pkt-line.h                              |   8 +-
 t/helper/test-rot13-filter.c            | 382 ++++++++++++++++++++++++
 t/helper/test-tool.c                    |   1 +
 t/helper/test-tool.h                    |   1 +
 t/t0021-conversion.sh                   |  71 +++--
 t/t0021/rot13-filter.pl                 | 247 ---------------
 t/t2080-parallel-checkout-basics.sh     |   7 +-
 t/t2082-parallel-checkout-attributes.sh |   7 +-
 10 files changed, 434 insertions(+), 296 deletions(-)
 create mode 100644 t/helper/test-rot13-filter.c
 delete mode 100644 t/t0021/rot13-filter.pl

Range-diff against v3:
1:  5ec95c7e69 = 1:  64dc9af1ad t0021: avoid grepping for a Perl-specific string at filter output
2:  86e6baba46 ! 2:  99d8458f35 t0021: implementation the rot13-filter.pl script in C
    @@ Commit message
         command. The following commit will take care of actually modifying the
         said tests to use the new C helper and removing the Perl script.
     
    +    The Perl script flushes the log file handler after each write. As
    +    commented in [1], this seems to be an early design decision that was
    +    later reconsidered, but possibly ended up being left in the code by
    +    accident:
    +
    +            >> +$debug->flush();T
    +            >
    +            > Isn't $debug flushed automatically?
    +
    +            Maybe, but autoflush is not explicitly enabled. I will
    +            enable it again (I disabled it because of Eric's comment
    +            but I re-read the comment and he is only talking about
    +            pipes).
    +
    +    Anyways, this behavior is not really needed for the tests and the
    +    flush() calls make the code slightly larger, so let's avoid them
    +    altogether in the new C version.
    +
    +    [1]: https://lore.kernel.org/git/7F1F1A0E-8FC3-4FBD-81AA-37786DE0EF50@gmail.com/
    +
         Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    @@ t/helper/test-rot13-filter.c (new)
     + * Example implementation for the Git filter protocol version 2
     + * See Documentation/gitattributes.txt, section "Filter Protocol"
     + *
    -+ * Usage: test-tool rot13-filter [--always-delay] <log path> <capabilities>
    ++ * Usage: test-tool rot13-filter [--always-delay] --log=<path> <capabilities>
     + *
     + * Log path defines a debug log file that the script writes to. The
     + * subsequent arguments define a list of supported protocol capabilities
    @@ t/helper/test-rot13-filter.c (new)
     +#include "pkt-line.h"
     +#include "string-list.h"
     +#include "strmap.h"
    ++#include "parse-options.h"
     +
     +static FILE *logfile;
     +static int always_delay, has_clean_cap, has_smudge_cap;
     +static struct strmap delay = STRMAP_INIT;
     +
    ++static inline const char *str_or_null(const char *str)
    ++{
    ++	return str ? str : "(null)";
    ++}
    ++
     +static char *rot13(char *str)
     +{
     +	char *c;
    @@ t/helper/test-rot13-filter.c (new)
     +	return str;
     +}
     +
    -+static char *get_value(char *buf, size_t size, const char *key)
    ++static char *get_value(char *buf, const char *key)
     +{
     +	const char *orig_buf = buf;
    -+	int orig_size = (int)size;
    -+
    -+	if (!skip_prefix_mem((const char *)buf, size, key, (const char **)&buf, &size) ||
    -+	    !skip_prefix_mem((const char *)buf, size, "=", (const char **)&buf, &size) ||
    -+	    !size)
    -+		die("expected key '%s', got '%.*s'",
    -+		    key, orig_size, orig_buf);
    -+
    -+	buf[size] = '\0';
    ++	if (!buf ||
    ++	    !skip_prefix((const char *)buf, key, (const char **)&buf) ||
    ++	    !skip_prefix((const char *)buf, "=", (const char **)&buf) ||
    ++	    !*buf)
    ++		die("expected key '%s', got '%s'", key, str_or_null(orig_buf));
     +	return buf;
     +}
     +
    @@ t/helper/test-rot13-filter.c (new)
     + */
     +static char *packet_key_val_read(const char *key)
     +{
    -+	int size;
     +	char *buf;
    -+	if (packet_read_line_gently(0, &size, &buf) < 0)
    ++	if (packet_read_line_gently(0, NULL, &buf) < 0)
     +		return NULL;
    -+	return xstrdup(get_value(buf, size, key));
    ++	return xstrdup(get_value(buf, key));
     +}
     +
     +static inline void assert_remote_capability(struct strset *caps, const char *cap)
    @@ t/helper/test-rot13-filter.c (new)
     +static void read_capabilities(struct strset *remote_caps)
     +{
     +	for (;;) {
    -+		int size;
    -+		char *buf = packet_read_line(0, &size);
    ++		char *buf = packet_read_line(0, NULL);
     +		if (!buf)
     +			break;
    -+		strset_add(remote_caps, get_value(buf, size, "capability"));
    ++		strset_add(remote_caps, get_value(buf, "capability"));
     +	}
     +
     +	assert_remote_capability(remote_caps, "clean");
    @@ t/helper/test-rot13-filter.c (new)
     +}
     +
     +static void check_and_write_capabilities(struct strset *remote_caps,
    -+					 const char **caps, int caps_count)
    ++					 const char **caps, int nr_caps)
     +{
     +	int i;
    -+	for (i = 0; i < caps_count; i++) {
    ++	for (i = 0; i < nr_caps; i++) {
     +		if (!strset_contains(remote_caps, caps[i]))
     +			die("our capability '%s' is not available from remote",
     +			    caps[i]);
    @@ t/helper/test-rot13-filter.c (new)
     +{
     +	for (;;) {
     +		char *buf, *output;
    -+		int size;
     +		char *pathname;
     +		struct delay_entry *entry;
     +		struct strbuf input = STRBUF_INIT;
    @@ t/helper/test-rot13-filter.c (new)
     +		fprintf(logfile, " %s", pathname);
     +
     +		/* Read until flush */
    -+		while ((buf = packet_read_line(0, &size))) {
    ++		while ((buf = packet_read_line(0, NULL))) {
     +			if (!strcmp(buf, "can-delay=1")) {
     +				entry = strmap_get(&delay, pathname);
    -+				if (entry && !entry->requested) {
    ++				if (entry && !entry->requested)
     +					entry->requested = 1;
    -+				} else if (!entry && always_delay) {
    ++				else if (!entry && always_delay)
     +					add_delay_entry(pathname, 1, 1);
    -+				}
     +			} else if (starts_with(buf, "ref=") ||
     +				   starts_with(buf, "treeish=") ||
     +				   starts_with(buf, "blob=")) {
    @@ t/helper/test-rot13-filter.c (new)
     +			}
     +		}
     +
    -+
     +		read_packetized_to_strbuf(0, &input, 0);
     +		fprintf(logfile, " %"PRIuMAX" [OK] -- ", (uintmax_t)input.len);
     +
    @@ t/helper/test-rot13-filter.c (new)
     +
     +static void packet_initialize(void)
     +{
    -+	int size;
    -+	char *pkt_buf = packet_read_line(0, &size);
    ++	char *pkt_buf = packet_read_line(0, NULL);
     +
    -+	if (!pkt_buf || strncmp(pkt_buf, "git-filter-client", size))
    -+		die("bad initialize: '%s'", xstrndup(pkt_buf, size));
    ++	if (!pkt_buf || strcmp(pkt_buf, "git-filter-client"))
    ++		die("bad initialize: '%s'", str_or_null(pkt_buf));
     +
    -+	pkt_buf = packet_read_line(0, &size);
    -+	if (!pkt_buf || strncmp(pkt_buf, "version=2", size))
    -+		die("bad version: '%.*s'", (int)size, pkt_buf);
    ++	pkt_buf = packet_read_line(0, NULL);
    ++	if (!pkt_buf || strcmp(pkt_buf, "version=2"))
    ++		die("bad version: '%s'", str_or_null(pkt_buf));
     +
    -+	pkt_buf = packet_read_line(0, &size);
    ++	pkt_buf = packet_read_line(0, NULL);
     +	if (pkt_buf)
    -+		die("bad version end: '%.*s'", (int)size, pkt_buf);
    ++		die("bad version end: '%s'", pkt_buf);
     +
     +	packet_write_fmt(1, "git-filter-server");
     +	packet_write_fmt(1, "version=2");
     +	packet_flush(1);
     +}
     +
    -+static char *rot13_usage = "test-tool rot13-filter [--always-delay] <log path> <capabilities>";
    ++static const char *rot13_usage[] = {
    ++	"test-tool rot13-filter [--always-delay] --log=<path> <capabilities>",
    ++	NULL
    ++};
     +
     +int cmd__rot13_filter(int argc, const char **argv)
     +{
    -+	const char **caps;
    -+	int cap_count, i = 1;
    ++	int i, nr_caps;
     +	struct strset remote_caps = STRSET_INIT;
    ++	const char *log_path = NULL;
     +
    -+	if (argc > 1 && !strcmp(argv[1], "--always-delay")) {
    -+		always_delay = 1;
    -+		i++;
    -+	}
    -+	if (argc - i < 2)
    -+		usage(rot13_usage);
    ++	struct option options[] = {
    ++		OPT_BOOL(0, "always-delay", &always_delay,
    ++			 "delay all paths with the can-delay flag"),
    ++		OPT_STRING(0, "log", &log_path, "path",
    ++			   "path to the debug log file"),
    ++		OPT_END()
    ++	};
    ++	nr_caps = parse_options(argc, argv, NULL, options, rot13_usage,
    ++				PARSE_OPT_STOP_AT_NON_OPTION);
     +
    -+	logfile = fopen(argv[i++], "a");
    ++	if (!log_path || !nr_caps)
    ++		usage_with_options(rot13_usage, options);
    ++
    ++	logfile = fopen(log_path, "a");
     +	if (!logfile)
     +		die_errno("failed to open log file");
     +
    -+	caps = argv + i;
    -+	cap_count = argc - i;
    -+
    -+	for (i = 0; i < cap_count; i++) {
    -+		if (!strcmp(caps[i], "clean"))
    -+			has_clean_cap = 1;
    -+		else if (!strcmp(caps[i], "smudge"))
    ++	for (i = 0; i < nr_caps; i++) {
    ++		if (!strcmp(argv[i], "smudge"))
     +			has_smudge_cap = 1;
    ++		if (!strcmp(argv[i], "clean"))
    ++			has_clean_cap = 1;
     +	}
     +
     +	add_delay_entry("test-delay10.a", 1, 0);
    @@ t/helper/test-rot13-filter.c (new)
     +	packet_initialize();
     +
     +	read_capabilities(&remote_caps);
    -+	check_and_write_capabilities(&remote_caps, caps, cap_count);
    ++	check_and_write_capabilities(&remote_caps, argv, nr_caps);
     +	fprintf(logfile, "init handshake complete\n");
     +	strset_clear(&remote_caps);
     +
     +	command_loop();
     +
    -+	fclose(logfile);
    ++	if (fclose(logfile))
    ++		die_errno("error closing logfile");
     +	free_delay_entries();
     +	return 0;
     +}
3:  c66fc0a186 ! 3:  d6033abbce tests: use the new C rot13-filter helper to avoid PERL prereq
    @@ t/t0021-conversion.sh: test_expect_success 'diff does not reuse worktree files t
     -test_expect_success PERL 'required process filter should filter data' '
     -	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
     +test_expect_success 'required process filter should filter data' '
    -+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
    ++	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
      	test_config_global filter.protocol.required true &&
      	rm -rf repo &&
      	mkdir repo &&
    @@ t/t0021-conversion.sh: test_expect_success PERL 'required process filter should
     -test_expect_success PERL 'required process filter should filter data for various subcommands' '
     -	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
     +test_expect_success 'required process filter should filter data for various subcommands' '
    -+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
    ++	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
      	test_config_global filter.protocol.required true &&
      	(
      		cd repo &&
    @@ t/t0021-conversion.sh: test_expect_success PERL 'required process filter should
     +test_expect_success 'required process filter takes precedence' '
      	test_config_global filter.protocol.clean false &&
     -	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
    -+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean" &&
    ++	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean" &&
      	test_config_global filter.protocol.required true &&
      	rm -rf repo &&
      	mkdir repo &&
    @@ t/t0021-conversion.sh: test_expect_success PERL 'required process filter takes p
     -test_expect_success PERL 'required process filter should be used only for "clean" operation only' '
     -	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
     +test_expect_success 'required process filter should be used only for "clean" operation only' '
    -+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean" &&
    ++	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean" &&
      	rm -rf repo &&
      	mkdir repo &&
      	(
    @@ t/t0021-conversion.sh: test_expect_success PERL 'required process filter should
     -test_expect_success PERL 'required process filter should process multiple packets' '
     -	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
     +test_expect_success 'required process filter should process multiple packets' '
    -+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
    ++	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
      	test_config_global filter.protocol.required true &&
      
      	rm -rf repo &&
    @@ t/t0021-conversion.sh: test_expect_success PERL 'required process filter should
     -test_expect_success PERL 'required process filter with clean error should fail' '
     -	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
     +test_expect_success 'required process filter with clean error should fail' '
    -+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
    ++	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
      	test_config_global filter.protocol.required true &&
      	rm -rf repo &&
      	mkdir repo &&
    @@ t/t0021-conversion.sh: test_expect_success PERL 'required process filter with cl
     -test_expect_success PERL 'process filter should restart after unexpected write failure' '
     -	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
     +test_expect_success 'process filter should restart after unexpected write failure' '
    -+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
    ++	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
      	rm -rf repo &&
      	mkdir repo &&
      	(
    @@ t/t0021-conversion.sh: test_expect_success PERL 'process filter should restart a
     -test_expect_success PERL 'process filter should not be restarted if it signals an error' '
     -	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
     +test_expect_success 'process filter should not be restarted if it signals an error' '
    -+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
    ++	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
      	rm -rf repo &&
      	mkdir repo &&
      	(
    @@ t/t0021-conversion.sh: test_expect_success PERL 'process filter should not be re
     -test_expect_success PERL 'process filter abort stops processing of all further files' '
     -	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
     +test_expect_success 'process filter abort stops processing of all further files' '
    -+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
    ++	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
      	rm -rf repo &&
      	mkdir repo &&
      	(
    @@ t/t0021-conversion.sh: test_expect_success PERL 'invalid process filter must fai
     -test_expect_success PERL 'delayed checkout in process filter' '
     -	test_config_global filter.a.process "rot13-filter.pl a.log clean smudge delay" &&
     +test_expect_success 'delayed checkout in process filter' '
    -+	test_config_global filter.a.process "test-tool rot13-filter a.log clean smudge delay" &&
    ++	test_config_global filter.a.process "test-tool rot13-filter --log=a.log clean smudge delay" &&
      	test_config_global filter.a.required true &&
     -	test_config_global filter.b.process "rot13-filter.pl b.log clean smudge delay" &&
    -+	test_config_global filter.b.process "test-tool rot13-filter b.log clean smudge delay" &&
    ++	test_config_global filter.b.process "test-tool rot13-filter --log=b.log clean smudge delay" &&
      	test_config_global filter.b.required true &&
      
      	rm -rf repo &&
    @@ t/t0021-conversion.sh: test_expect_success PERL 'delayed checkout in process fil
     -test_expect_success PERL 'missing file in delayed checkout' '
     -	test_config_global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
     +test_expect_success 'missing file in delayed checkout' '
    -+	test_config_global filter.bug.process "test-tool rot13-filter bug.log clean smudge delay" &&
    ++	test_config_global filter.bug.process "test-tool rot13-filter --log=bug.log clean smudge delay" &&
      	test_config_global filter.bug.required true &&
      
      	rm -rf repo &&
    @@ t/t0021-conversion.sh: test_expect_success PERL 'missing file in delayed checkou
     -test_expect_success PERL 'invalid file in delayed checkout' '
     -	test_config_global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
     +test_expect_success 'invalid file in delayed checkout' '
    -+	test_config_global filter.bug.process "test-tool rot13-filter bug.log clean smudge delay" &&
    ++	test_config_global filter.bug.process "test-tool rot13-filter --log=bug.log clean smudge delay" &&
      	test_config_global filter.bug.required true &&
      
      	rm -rf repo &&
    @@ t/t0021-conversion.sh: do
      	"delayed checkout with $mode-collision don't write to the wrong place" '
      		test_config_global filter.delay.process \
     -			"\"$TEST_ROOT/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
    -+			"test-tool rot13-filter --always-delay delayed.log clean smudge delay" &&
    ++			"test-tool rot13-filter --always-delay --log=delayed.log clean smudge delay" &&
      		test_config_global filter.delay.required true &&
      
      		git init $mode-collision &&
    @@ t/t0021-conversion.sh: do
      	(
      		cd collision-with-submodule &&
     -		git config filter.delay.process "\"$TEST_ROOT/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
    -+		git config filter.delay.process "test-tool rot13-filter --always-delay delayed.log clean smudge delay" &&
    ++		git config filter.delay.process "test-tool rot13-filter --always-delay --log=delayed.log clean smudge delay" &&
      		git config filter.delay.required true &&
      
      		# We need Git to treat the submodule "a" and the
    @@ t/t0021-conversion.sh: test_expect_success PERL,SYMLINKS,CASE_INSENSITIVE_FS \
      	(
      		cd progress &&
     -		git config filter.delay.process "rot13-filter.pl delay-progress.log clean smudge delay" &&
    -+		git config filter.delay.process "test-tool rot13-filter delay-progress.log clean smudge delay" &&
    ++		git config filter.delay.process "test-tool rot13-filter --log=delay-progress.log clean smudge delay" &&
      		git config filter.delay.required true &&
      
      		echo "*.a filter=delay" >.gitattributes &&
    @@ t/t0021-conversion.sh: do
      	(
      		cd repo &&
     -		git config filter.delay.process "../rot13-filter.pl delayed.log clean smudge delay" &&
    -+		git config filter.delay.process "test-tool rot13-filter delayed.log clean smudge delay" &&
    ++		git config filter.delay.process "test-tool rot13-filter --log=delayed.log clean smudge delay" &&
      		git config filter.delay.required true &&
      
      		echo "*.a filter=delay" >.gitattributes &&
    @@ t/t2080-parallel-checkout-basics.sh: test_expect_success SYMLINKS 'parallel chec
     +test_expect_success '"git checkout ." report should not include failed entries' '
      	test_config_global filter.delay.process \
     -		"\"$(pwd)/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
    -+		"test-tool rot13-filter --always-delay delayed.log clean smudge delay" &&
    ++		"test-tool rot13-filter --always-delay --log=delayed.log clean smudge delay" &&
      	test_config_global filter.delay.required true &&
      	test_config_global filter.cat.clean cat  &&
      	test_config_global filter.cat.smudge cat  &&
    @@ t/t2082-parallel-checkout-attributes.sh: test_expect_success 'parallel-checkout
     +test_expect_success 'parallel-checkout and delayed checkout' '
      	test_config_global filter.delay.process \
     -		"\"$(pwd)/rot13-filter.pl\" --always-delay \"$(pwd)/delayed.log\" clean smudge delay" &&
    -+		"test-tool rot13-filter --always-delay \"$(pwd)/delayed.log\" clean smudge delay" &&
    ++		"test-tool rot13-filter --always-delay --log=\"$(pwd)/delayed.log\" clean smudge delay" &&
      	test_config_global filter.delay.required true &&
      
      	echo "abcd" >original &&
-- 
2.37.1

