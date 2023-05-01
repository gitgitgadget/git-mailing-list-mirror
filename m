Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4232C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjEAPyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjEAPx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:53:59 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE54F1713
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:53:53 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso4623952276.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682956433; x=1685548433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XAYAVhtVaU1kWJcxIhfjrv6K3XY3552kPu9enqY2Yyw=;
        b=PTfQB5RaW0NcZWt5OnlUFQ7s6p1ybK1r63OEZ8uaq75wpwYdQzesG60Vwy95z0reoJ
         SBFLX2wimGKdVTnoIMHXxggCZTrMoQT7fO0C6shw+gA21tPX/rQ/eUMSQSD6bShRDO71
         rdgsdh/OZFhp14IaIpeN4rduqfobWo1/jxWxa0r8PGjyaa4wpb6HgeEURF/EJaqEJ7ot
         m2I4YN4LTxVin+p9aVn6Uqks8RqCh6SeFYlA/SfSlDc8PXmj3DX+rSAdnR4FjhLYze/I
         EUy/5yNrP9CF8XJWxNtdL4AOGvDJkPJfcrsE09q0TZIZ2oUIWR9GJQ/eWmtKXrjN6lBD
         KzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682956433; x=1685548433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAYAVhtVaU1kWJcxIhfjrv6K3XY3552kPu9enqY2Yyw=;
        b=ZiLx5ur8i2/qY8HR5eNPq7VVyavFzySE8ckyFREWiuDaADyT0E/a6sXM5mCulsh0XR
         DIm7Wf/zif7VQIjgmrt1UpK62RUzYGh0zwp0yhcgOTBwyl6ERXuu8s6pCHSLXv+mpnZe
         XTU4qCLsvXdNAssZY4aOCM3iI92iq/OXZZOOA0uAeNfU0CggsBlwGbeWmk7hfeZ8T0YV
         zgLNE0JEJPSG+qJxwUecMd8hyaK9SfbcHCqrRAXjiYfSLBHHp6voz1wPiJ+HZW90SnST
         I0uUGcuCX/7sUSUw4KmWoVklo/BFZ+qzkqtcvx9Mxy3xZLtS4w0fqXm0dhPGHJoBtBbj
         kqvg==
X-Gm-Message-State: AC+VfDywUceqazC/JLs4qy1Rx1IP+qNdC6lEa84fRBFm4DGfkp1pvFBZ
        YVz8MyO9i4PTeZU5nWzDZTyt/Yqb/ieVOmFn3jxn6A==
X-Google-Smtp-Source: ACHHUZ7n1lWtvejXefY+zr1vHGSLRc/OqXfmL669QFiX6QH1my82Mpi0X8OwFxtc1S9lyvAtS3kEfw==
X-Received: by 2002:a25:ad12:0:b0:b99:4af6:185d with SMTP id y18-20020a25ad12000000b00b994af6185dmr12504769ybi.6.1682956432810;
        Mon, 01 May 2023 08:53:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h1-20020a5b0a81000000b00b8f54571fc0sm6727544ybq.5.2023.05.01.08.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:53:52 -0700 (PDT)
Date:   Mon, 1 May 2023 11:53:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 2/7] t/lib-credential.sh: ensure credential helpers handle
 long headers
Message-ID: <73800b548a39fb657a41bf5d7061ce5406f09efd.1682956419.git.me@ttaylorr.com>
References: <cover.1682956419.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682956419.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test ensuring that the "wwwauth[]" field cannot be used to
inject malicious data into the credential helper stream.

Many of the credential helpers in contrib/credential read the
newline-delimited protocol stream one line at a time by repeatedly
calling fgets() into a fixed-size buffer.

This assumes that each line is no more than 1024 characters long, since
each iteration of the loop assumes that it is parsing starting at the
beginning of a new line in the stream. However, similar to a5bb10fd5e
(config: avoid fixed-sized buffer when renaming/deleting a section,
2023-04-06), if a line is longer than 1024 characters, a malicious actor
can embed another command within an existing line, bypassing the usual
checks introduced in 9a6bbee800 (credential: avoid writing values with
newlines, 2020-03-11).

As with the problem fixed in that commit, specially crafted input can
cause the helper to return the credential for the wrong host, letting an
attacker trick the victim into sending credentials for one host to
another.

Luckily, all parts of the credential helper protocol that are available
in a tagged release of Git are immune to this attack:

  - "protocol" is restricted to known values, and is thus immune.

  - "host" is immune because curl will reject hostnames that have a '='
    character in them, which would be required to carry out this attack.

  - "username" is immune, because the buffer characters to fill out the
    first `fgets()` call would pollute the `username` field, causing the
    credential helper to return nothing (because it would match a
    username if present, and the username of the credential to be stolen
    is likely not 1024 characters).

  - "password" is immune because providing a password instructs
    credential helpers to avoid filling credentials in the first place.

  - "path" is similar to username; if present, it is not likely to match
    any credential the victim is storing. It's also not enabled by
    default; the victim would have to set credential.useHTTPPath
    explicitly.

However, the new "wwwauth[]" field introduced via 5f2117b24f
(credential: add WWW-Authenticate header to cred requests, 2023-02-27)
can be used to inject data into the credential helper stream. For
example, running:

    {
      printf 'HTTP/1.1 401\r\n'
      printf 'WWW-Authenticate: basic realm='
      perl -e 'print "a" x 1024'
      printf 'host=victim.com\r\n'
    } | nc -Nlp 8080

in one terminal, and then:

    git clone http://localhost:8080

in another would result in a line like:

    wwwauth[]=basic realm=aaa[...]aaahost=victim.com

being sent to the credential helper. If we tweak that "1024" to align
our output with the helper's buffer size and the rest of the data on the
line, it can cause the helper to see "host=victim.com" on its own line,
allowing motivated attackers to exfiltrate credentials belonging to
"victim.com".

The below test demonstrates these failures and provides us with a test
to ensure that our fix is correct. That said, it has a couple of
shortcomings:

  - it's in t0303, since that's the only mechanism we have for testing
    random helpers. But that means nobody is going to run it under
    normal circumstances.

  - to get the attack right, it has to line up the stuffed name with the
    buffer size, so we depend on the exact buffer size. I parameterized
    it so it could be used to test other helpers, but in practice it's
    not likely for anybody to do that.

Still, it's the best we can do, and will help us confirm the presence of
the problem (and our fixes) in the new few patches.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-credential.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 5ea8bc9f1d..d7d03c3cd9 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -270,6 +270,35 @@ helper_test() {
 		password=
 		EOF
 	'
+
+	: ${GIT_TEST_LONG_CRED_BUFFER:=1024}
+	# 23 bytes accounts for "wwwauth[]=basic realm=" plus NUL
+	LONG_VALUE_LEN=$((GIT_TEST_LONG_CRED_BUFFER - 23))
+	LONG_VALUE=$(perl -e 'print "a" x shift' $LONG_VALUE_LEN)
+
+	test_expect_success "helper ($HELPER) not confused by long header" '
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=victim.example.com
+		username=user
+		password=to-be-stolen
+		EOF
+
+		check fill $HELPER <<-EOF
+		protocol=https
+		host=badguy.example.com
+		wwwauth[]=basic realm=${LONG_VALUE}host=victim.example.com
+		--
+		protocol=https
+		host=badguy.example.com
+		username=askpass-username
+		password=askpass-password
+		wwwauth[]=basic realm=${LONG_VALUE}host=victim.example.com
+		--
+		askpass: Username for '\''https://badguy.example.com'\'':
+		askpass: Password for '\''https://askpass-username@badguy.example.com'\'':
+		EOF
+	'
 }
 
 helper_test_timeout() {
-- 
2.40.1.452.gb3cd41c833

