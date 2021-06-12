Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9E5C49360
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 05:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD7A611C9
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 05:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFLFKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 01:10:32 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:44795 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFLFKc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 01:10:32 -0400
Received: by mail-pg1-f171.google.com with SMTP id y11so4102613pgp.11
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 22:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kHgD5jYnxfm0GN8xFVvELNhAeBrfzEEu/HqI8Xh6dus=;
        b=Ol4cR4YgdOv0iOSpYOHfHTqfhOfrpz19JcNWtFqv88n+M3hxYuSKveLA7Go/hX+cFr
         8gZN/DR2W+8EC0RnytqwFKrxVK3zSZr1WW+EPDUZz4nqNfK1n2VeLc4y8SDqUjzOzjB6
         hIeerYEP5rT9eUP77RDNSJtU788SJuExcf0Gxfvz/Da40txU5nx6Yw83OPFXw5g7KrZc
         ywhZW7LtlmoTlxOc3016ggco/X7HdTYuhnrrqox231ObaIGU7vHY6ZDJoutV8R7mVO5Y
         2HpfYr5WossrMHqdkkW2OPw1tjQf80EPF8hVFm5yZvhwvhxaZClFt8qJFG/GGx0mGXSM
         1xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHgD5jYnxfm0GN8xFVvELNhAeBrfzEEu/HqI8Xh6dus=;
        b=sBGT7W0v0jme6Hu5bKX3bFtA/ytxuwHBw7Y7g4oZ1htYzsDL/4HJ2/zjbVR1Uaxm/H
         yPzcFbsB8L3S1PxwXZlN4lvPtf+K4FPoernsElvQMyta7geB/tv2LIVQSU17pqeeNBGd
         V42Rfnv0mSYDjVCaDe9Se2mLYd/qQjz6Jbl7cT4EJP0Pzxh7eh4HRFUu4tK+Fno7lYLG
         q/TxNIC42KwkOdUn/ftD/1fLUQo6kk9j+aRj6sr1d8m5Z9ogss/hLknBCRzbVL36oHM6
         39UIcSRIt31iAlxl0Czfg4kMEG5ERUhl6GmqNM5APaeHOMET1NblsmrQbEU9jQpuna38
         gj8g==
X-Gm-Message-State: AOAM531Cs7kRl5TB07mFiq+Gk+w47BZrRwrzHFpQuk7hhhT+XSQBQ40Z
        Fhd56+JWYELTd+U4V+EjPK4=
X-Google-Smtp-Source: ABdhPJzjw6vbyHLfVf5qoCt5QQuse+WyN2ZpdsjcwDqyCpNg61wOu9j60BumI13tIcakmhQNkQnMug==
X-Received: by 2002:aa7:8a5a:0:b029:2ec:7134:7540 with SMTP id n26-20020aa78a5a0000b02902ec71347540mr11315225pfa.66.1623474436921;
        Fri, 11 Jun 2021 22:07:16 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n23sm6651745pff.93.2021.06.11.22.07.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 22:07:16 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 1/4] t6020: fix bash incompatible issue
Date:   Sat, 12 Jun 2021 13:07:08 +0800
Message-Id: <20210612050711.4057-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <87im2s5jjm.fsf@evledraar.gmail.com>
References: <87im2s5jjm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Ævar reported that the function `make_user_friendly_and_stable_output()`
failed on a i386 box (gcc45) in the gcc farm boxes with error:

    sed: couldn't re-allocate memory

It turns out that older versions of bash (4.3) or dash (0.5.7) cannot
evaluate expression like `${A%${A#???????}}` used to get the leading 7
characters of variable A.

Replace the complex expressions so that t6020 works on older version of
bash or dash.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t6020-bundle-misc.sh | 50 ++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 881f72fd44..3140ca4fdc 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -80,30 +80,42 @@ test_commit_setvar () {
 	eval $var=$oid
 }
 
+get_abbrev_oid () {
+	oid=$1 &&
+	suffix=${oid#???????} &&
+	oid=${oid%$suffix} &&
+	if test -n "$oid"
+	then
+		echo "$oid"
+	else
+		echo "undefined-oid"
+	fi
+}
+
 # Format the output of git commands to make a user-friendly and stable
 # text.  We can easily prepare the expect text without having to worry
 # about future changes of the commit ID and spaces of the output.
 make_user_friendly_and_stable_output () {
 	sed \
-		-e "s/${A%${A#???????}}[0-9a-f]*/<COMMIT-A>/g" \
-		-e "s/${B%${B#???????}}[0-9a-f]*/<COMMIT-B>/g" \
-		-e "s/${C%${C#???????}}[0-9a-f]*/<COMMIT-C>/g" \
-		-e "s/${D%${D#???????}}[0-9a-f]*/<COMMIT-D>/g" \
-		-e "s/${E%${E#???????}}[0-9a-f]*/<COMMIT-E>/g" \
-		-e "s/${F%${F#???????}}[0-9a-f]*/<COMMIT-F>/g" \
-		-e "s/${G%${G#???????}}[0-9a-f]*/<COMMIT-G>/g" \
-		-e "s/${H%${H#???????}}[0-9a-f]*/<COMMIT-H>/g" \
-		-e "s/${I%${I#???????}}[0-9a-f]*/<COMMIT-I>/g" \
-		-e "s/${J%${J#???????}}[0-9a-f]*/<COMMIT-J>/g" \
-		-e "s/${K%${K#???????}}[0-9a-f]*/<COMMIT-K>/g" \
-		-e "s/${L%${L#???????}}[0-9a-f]*/<COMMIT-L>/g" \
-		-e "s/${M%${M#???????}}[0-9a-f]*/<COMMIT-M>/g" \
-		-e "s/${N%${N#???????}}[0-9a-f]*/<COMMIT-N>/g" \
-		-e "s/${O%${O#???????}}[0-9a-f]*/<COMMIT-O>/g" \
-		-e "s/${P%${P#???????}}[0-9a-f]*/<COMMIT-P>/g" \
-		-e "s/${TAG1%${TAG1#???????}}[0-9a-f]*/<TAG-1>/g" \
-		-e "s/${TAG2%${TAG2#???????}}[0-9a-f]*/<TAG-2>/g" \
-		-e "s/${TAG3%${TAG3#???????}}[0-9a-f]*/<TAG-3>/g" \
+		-e "s/$(get_abbrev_oid $A)[0-9a-f]*/<COMMIT-A>/g" \
+		-e "s/$(get_abbrev_oid $B)[0-9a-f]*/<COMMIT-B>/g" \
+		-e "s/$(get_abbrev_oid $C)[0-9a-f]*/<COMMIT-C>/g" \
+		-e "s/$(get_abbrev_oid $D)[0-9a-f]*/<COMMIT-D>/g" \
+		-e "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" \
+		-e "s/$(get_abbrev_oid $F)[0-9a-f]*/<COMMIT-F>/g" \
+		-e "s/$(get_abbrev_oid $G)[0-9a-f]*/<COMMIT-G>/g" \
+		-e "s/$(get_abbrev_oid $H)[0-9a-f]*/<COMMIT-H>/g" \
+		-e "s/$(get_abbrev_oid $I)[0-9a-f]*/<COMMIT-I>/g" \
+		-e "s/$(get_abbrev_oid $J)[0-9a-f]*/<COMMIT-J>/g" \
+		-e "s/$(get_abbrev_oid $K)[0-9a-f]*/<COMMIT-K>/g" \
+		-e "s/$(get_abbrev_oid $L)[0-9a-f]*/<COMMIT-L>/g" \
+		-e "s/$(get_abbrev_oid $M)[0-9a-f]*/<COMMIT-M>/g" \
+		-e "s/$(get_abbrev_oid $N)[0-9a-f]*/<COMMIT-N>/g" \
+		-e "s/$(get_abbrev_oid $O)[0-9a-f]*/<COMMIT-O>/g" \
+		-e "s/$(get_abbrev_oid $P)[0-9a-f]*/<COMMIT-P>/g" \
+		-e "s/$(get_abbrev_oid $TAG1)[0-9a-f]*/<TAG-1>/g" \
+		-e "s/$(get_abbrev_oid $TAG2)[0-9a-f]*/<TAG-2>/g" \
+		-e "s/$(get_abbrev_oid $TAG3)[0-9a-f]*/<TAG-3>/g" \
 		-e "s/ *\$//"
 }
 
-- 
2.32.0.rc0.27.g7b1e85181b

