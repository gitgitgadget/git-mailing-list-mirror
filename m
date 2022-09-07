Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4A7C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIGOp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIGOp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:45:26 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047C617A94
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:45:22 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id m21-20020a9d6ad5000000b00638df677850so10422668otq.5
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dnitTWfp0jWHa2mrswFrLOxbi7shkkL/+zhkUTmUuF8=;
        b=ClTSVkkqT717GEMhXVCgZW8VPjk+4gaLhO/1KGq/Ym/gtT/i8So4zTrfMm2Bdmb8cE
         BDevHYS1fCTyLkVgms9UEQ7evieke4FXxVfw0atEKda0wOKIwujtpyrFuVi3KfYf/K1p
         EJXjQgFFwx5I7ueZY/hD1w4rRos2KFWSsAklgrY+xMmDmZH8OqOhT/P+YI6w+mphTGeR
         ntF5+VIY9MHtfUAYY7WuW4e3q8azk4MJR2moa7iZse3AckdtPHKSG+zCvXmbE4bCrqfZ
         hD2kS99TJDIg9/LiOZS7UT8tB+/uVGR41tbTYZDwPlpqfAio/Xbo58SZMesiPdQ/RUSj
         MMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dnitTWfp0jWHa2mrswFrLOxbi7shkkL/+zhkUTmUuF8=;
        b=DUG7mOJytEZCXXMUKdN5Wxq9jXS/bS/A4WQSYoB/DzqyxIxfDmfE02uzmt2HYUqHd5
         wFwBfNJVfQwV0eGlbdADmsQi0ZjDz9PWwvOegFS1QYVnfPRuWM1CNwTF5QAePc/XevlH
         bTVqwWELOQGSRCLAq79+hY+ncnv+RRBGm1VhUFTa8X4Xg4q2pI+hFqiZpw5Z9H4Oczmq
         Macpgu5ebh3ro0X/6HFetumLqlSuqz6K+IL4M4gW7nhelQzuTWk1eIMjPdIegevLIX48
         jpozso+a2GB4DVR9rmn4Co8cr1gXPVs/O+T9OuRu3/v6kNEnJv2bhsFKU4dT8CFHkwJl
         Bolg==
X-Gm-Message-State: ACgBeo3+9Dc3MZ0YO1XmyQETbwpOFPLnBwDlPU4Jp/d3UppXNWE+gXVe
        Bx7dF5yRObSCyYkMxKhxKcgG8Nxnq5Suvg==
X-Google-Smtp-Source: AA6agR4B06BfmBWhty7aUWpuV3dKyoZ0koyBVQ4iksiVdchKbIiSGR41Csnt7Wo37rKPcc3t5ErrzQ==
X-Received: by 2002:a05:6830:10ce:b0:63c:f303:6d72 with SMTP id z14-20020a05683010ce00b0063cf3036d72mr1594109oto.154.1662561920744;
        Wed, 07 Sep 2022 07:45:20 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id p21-20020a056830319500b00638bfd0673bsm7175012ots.51.2022.09.07.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:45:20 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, l.s.r@web.de
Subject: [PATCH v2 0/2] format-patch: warn if commit msg contains a patch delimiter
Date:   Wed,  7 Sep 2022 11:44:55 -0300
Message-Id: <cover.1662559356.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <220905.864jxmme0a.gmgdl@evledraar.gmail.com>
References: <220905.864jxmme0a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes format-patch warn on strings like "---" and "-- >8 --", which
can make a later git am fail to properly apply the generated patch.

Changes in v2:
- Use heredoc in tests.
- Add internationalization _()
- Incorporate René changes to use a buf/size pair.

René, I added your changes from [1] as a preparatory patch. Please let
me know if you are OK with that so that I can add your SoB in the next
re-roll.

[1]: https://lore.kernel.org/git/904b784d-a328-011f-c71a-c2092534e0f7@web.de/

Matheus Tavares (1):
  format-patch: warn if commit msg contains a patch delimiter

René Scharfe (1):
  patchbreak(), is_scissors_line(): work with a buf/len pair

 builtin/log.c           |  1 +
 log-tree.c              |  1 +
 mailinfo.c              | 37 +++++++++++++++++++------------------
 mailinfo.h              |  3 +++
 pretty.c                | 16 +++++++++++++++-
 pretty.h                |  3 ++-
 revision.h              |  3 ++-
 t/t4014-format-patch.sh | 26 ++++++++++++++++++++++++++
 8 files changed, 69 insertions(+), 21 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  99012733e4 patchbreak(), is_scissors_line(): work with a buf/len pair
1:  059811c85f ! 2:  a2c4514aa0 format-patch: warn if commit msg contains a patch delimiter
    @@ mailinfo.c: static void decode_transfer_encoding(struct mailinfo *mi, struct str
      	free(ret);
      }
      
    --static inline int patchbreak(const struct strbuf *line)
    -+int patchbreak(const struct strbuf *line)
    +-static inline int patchbreak(const char *buf, size_t len)
    ++int patchbreak(const char *buf, size_t len)
      {
    - 	size_t i;
    - 
    -@@ mailinfo.c: static inline int patchbreak(const struct strbuf *line)
    + 	/* Beginning of a "diff -" header? */
    + 	if (skip_prefix_mem(buf, len, "diff -", &buf, &len))
    +@@ mailinfo.c: static inline int patchbreak(const char *buf, size_t len)
      	return 0;
      }
      
    --static int is_scissors_line(const char *line)
    -+int is_scissors_line(const char *line)
    +-static int is_scissors_line(const char *line, size_t len)
    ++int is_scissors_line(const char *line, size_t len)
      {
      	const char *c;
      	int scissors = 0, gap = 0;
    @@ mailinfo.h: void setup_mailinfo(struct mailinfo *);
      int mailinfo(struct mailinfo *, const char *msg, const char *patch);
      void clear_mailinfo(struct mailinfo *);
      
    -+int patchbreak(const struct strbuf *line);
    -+int is_scissors_line(const char *line);
    ++int patchbreak(const char *line, size_t len);
    ++int is_scissors_line(const char *line, size_t len);
     +
      #endif /* MAILINFO_H */
     
    @@ pretty.c: void pp_remainder(struct pretty_print_context *pp,
      	struct grep_opt *opt = pp->rev ? &pp->rev->grep_filter : NULL;
     -	int first = 1;
     +	int first = 1, found_delimiter = 0;
    -+	struct strbuf linebuf = STRBUF_INIT;
      
      	for (;;) {
      		const char *line = *msg_p;
    @@ pretty.c: void pp_remainder(struct pretty_print_context *pp,
      		if (!linelen)
      			break;
      
    -+		if (pp->check_in_body_patch_breaks) {
    -+			strbuf_reset(&linebuf);
    -+			strbuf_add(&linebuf, line, linelen);
    -+			if (patchbreak(&linebuf) || is_scissors_line(linebuf.buf)) {
    -+				strbuf_strip_suffix(&linebuf, "\n");
    -+				warning("commit message has a patch delimiter: '%s'",
    -+					linebuf.buf);
    -+				found_delimiter = 1;
    -+			}
    ++		if (pp->check_in_body_patch_breaks &&
    ++		    (patchbreak(line, linelen) || is_scissors_line(line, linelen))) {
    ++			warning(_("commit message has a patch delimiter: '%.*s'"),
    ++				line[linelen - 1] == '\n' ? linelen - 1 : linelen,
    ++				line);
    ++			found_delimiter = 1;
     +		}
     +
      		if (is_blank_line(line, &linelen)) {
    @@ pretty.c: void pp_remainder(struct pretty_print_context *pp,
      		strbuf_addch(sb, '\n');
      	}
     +
    -+	if (found_delimiter)
    -+		warning("git am might fail to apply this patch. "
    -+			"Consider indenting the offending lines.");
    -+
    -+	strbuf_release(&linebuf);
    ++	if (found_delimiter) {
    ++		warning(_("git am might fail to apply this patch. "
    ++			  "Consider indenting the offending lines."));
    ++	}
      }
      
      void pretty_print_commit(struct pretty_print_context *pp,
    @@ t/t4014-format-patch.sh: test_expect_success 'interdiff: solo-patch' '
     +test_expect_success 'warn if commit message contains patch delimiter' '
     +	>delim &&
     +	git add delim &&
    -+	GIT_EDITOR="printf \"title\n\n---\" >" git commit &&
    ++	cat >msg <<-\EOF &&
    ++	title
    ++
    ++	---
    ++	EOF
    ++	git commit -F msg &&
     +	git format-patch -1 2>stderr &&
     +	grep "warning: commit message has a patch delimiter" stderr
     +'
    @@ t/t4014-format-patch.sh: test_expect_success 'interdiff: solo-patch' '
     +test_expect_success 'warn if commit message contains scissors' '
     +	>scissors &&
     +	git add scissors &&
    -+	GIT_EDITOR="printf \"title\n\n-- >8 --\" >" git commit &&
    ++	cat >msg <<-\EOF &&
    ++	title
    ++
    ++	-- >8 --
    ++	EOF
    ++	git commit -F msg &&
     +	git format-patch -1 2>stderr &&
     +	grep "warning: commit message has a patch delimiter" stderr
     +'
-- 
2.37.2

