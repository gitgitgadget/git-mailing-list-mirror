Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C61C6FA82
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 17:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiIBR7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 13:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiIBR7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 13:59:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0C52FFDB
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 10:59:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q7so4362501lfu.5
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/SJsiYvUs2aJboB7te4k1o8G/7c6aoANv4jSRZsUKEI=;
        b=QeIg1hdK7m0t2VO4+BhFOjCEALac7fM48UMJ7txZIPbosF2LW+nYmp442gcg6kA8mo
         t969uePJ6AleSqInnBGLTnm3t5mJEIs41Dz6S9R77jtE9nmCxk5DEaa5t9HMvrLw/WkM
         93PZTm7re5GeuqYKqdrzJ8G/KXOaXD/+8ePSO1DnnZSWvp2LbBlbkSYTHxr/mFRYd/JG
         y/+bmGlab2fYgbOVYaCDvHC+x1CwE75i//x69QLgpQi28ZIvpCx89uSK5bGyDQkvFiDk
         EJOm38Zx0r3aI1xgoMsqdkvIXuS0iMRD+3DXCAU9iRBKJ2IaEctd2Kuvc5/FBM9Yl0Wj
         F3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/SJsiYvUs2aJboB7te4k1o8G/7c6aoANv4jSRZsUKEI=;
        b=r5QcQGjHaNaD2cIpmsm26hmU+GU3J5FBZ9UsZ7aPUr6jMBdvHOFci18y+066cqf+Qm
         HpJkY5lpNuNCRDVhQJ9HB0hIX9bHB1a2y9bP/xoh2lAfA7rHwPT91eJQVz1bU7zRkGBL
         mXTiDnBshIlA/BvuTuQ0QMXabwIxFOAYkCLdKQ59ZkV2HZKDiluntHgJvSaduxxMbgmo
         amAiNKt32Cf91uOliFPmU1G0qwCDRIiQaFnbpGwpOoH1XhDYIL3HcTzqTm5ORNYE9tHJ
         5t4OilSVcc6zC9MnVK9yNngDUm66FAUuD8x2Hgh+KXWlz3G1G+o9u3BPmdCoXGBa+9lP
         P5Mg==
X-Gm-Message-State: ACgBeo0nWvWT463eeBuyJyywV7ff+e9hK/YyzwDiJxmlGmwTuQ831ye0
        bX3J2qRO7kOgvRe5v1M32h6DixdnDKQePQ==
X-Google-Smtp-Source: AA6agR7gecRC5kb2SP8ejs+8CYd1+Z1In0qdQLZFJM632LUUOZlKxWvWRWzNIV8siCd1kwyDPuaSaA==
X-Received: by 2002:a05:6512:3e1:b0:494:64c5:5b52 with SMTP id n1-20020a05651203e100b0049464c55b52mr8455383lfq.420.1662141550131;
        Fri, 02 Sep 2022 10:59:10 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id r21-20020ac24d15000000b00492e69be4d6sm317352lfi.27.2022.09.02.10.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 10:59:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, ingy@ingy.net, oystwa@gmail.com,
        szeder.dev@gmail.com
Subject: [PATCH] rev-parse --parseopt: detect missing opt-spec
Date:   Fri,  2 Sep 2022 19:59:02 +0200
Message-Id: <20220902175902.22346-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <xmqq5yi5aghf.fsf@gitster.g>
References: <xmqq5yi5aghf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After 2d893dff4c (rev-parse --parseopt: allow [*=?!] in argument hints,
2015-07-14) updated the parser, a line in parseopts's input can start
with one of the flag characters and be erroneously parsed as a opt-spec
where the short name of the option is the flag character itself and the
long name is after the end of the string. This makes Git want to
allocate SIZE_MAX bytes of memory at this line:

    o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);

Since s and sb.buf are equal the second argument is -2 (except unsigned)
and xmemdupz allocates len + 1 bytes, ie. -1 meaning SIZE_MAX.

Avoid this by checking whether a flag character was found in the zeroth
position.

Reported-by: Ingy dot Net <ingy@ingy.net>
Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Øystein Walle <oystwa@gmail.com>
---

Hi guys, thanks for the review. I incorporated a reference to the old
commit into the message (and took the liberty of adding --parseopt to
the subject like it had). I tried to verify that it was in fact this
commit, since the code prior to this one had the exact same xmemdupz()
call. I wasn't able to build that commit, and reverting it also wasn't
straightforward. But I'm fairly confident it's the case since the old
call had an if similar to the one added here.

I completely agree with the changes to the test; it makes little sense
to mix stdout and stderr here.

Jeff, I agree that perhaps a larger rewrite would be better. I
personally can get easily confused by "sporadic" ifs like this one in
the middle of a piece of code. At least in this case the message within
die() neatly explains what's going on.

Øsse

 builtin/rev-parse.c           | 3 +++
 t/t1502-rev-parse-parseopt.sh | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index b259d8990a..85c271acd7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -479,6 +479,9 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		if (!s)
 			s = help;
 
+		if (s == sb.buf)
+			die(_("missing opt-spec before option flags"));
+
 		if (s - sb.buf == 1) /* short option only */
 			o->short_name = *sb.buf;
 		else if (sb.buf[1] != ',') /* long option only */
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 284fe18e72..de1d48f3ba 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -306,6 +306,13 @@ test_expect_success 'test --parseopt help output: "wrapped" options normal "or:"
 	test_cmp expect actual
 '
 
+test_expect_success 'test --parseopt invalid opt-spec' '
+	test_write_lines x -- "=, x" >spec &&
+	echo "fatal: missing opt-spec before option flags" >expect &&
+	test_must_fail git rev-parse --parseopt -- >out <spec 2>err &&
+	test_cmp expect err
+'
+
 test_expect_success 'test --parseopt help output: multi-line blurb after empty line' '
 	sed -e "s/^|//" >spec <<-\EOF &&
 	|cmd [--some-option]
-- 
2.34.1

