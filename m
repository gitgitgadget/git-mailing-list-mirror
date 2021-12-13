Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE73FC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhLMGcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhLMGcG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:06 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE674C0613F8
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:05 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id w1so14069108ilh.9
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdbO7Uz2W700OsYWOOJ8CEkm4cOJGIvldeSXHWdNciQ=;
        b=odqqaV4WUXKry2PR0kYEgO15fvU4pjC/ke3vw153V/GmKfbReqaMI4OU7D0G0G7pb1
         Ik2CH1mplcXk3hIwmx4CLITD4n7z12wvC6xXqX6uhy7s/VuJfk2SznGpnPMVIYTleas/
         DsArzWSCERnMV3IgxNmD/pquxZZgpVCPlIOeFPENoKZIpR10o7fms/Pf1vlSlH/vEUAQ
         /R9hi/kdpOKsr8+qEHE5asceHPx3Qg0fGGRdj4V8XjqRStRoNZX0+i7VU5qwL6Hd8On2
         QNC70T6Z3363bMU88okI5/xe0e/UYw3Iafy1uhSDybyU3Cnw/FQzkGhZbpzaPxta7VJF
         nrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zdbO7Uz2W700OsYWOOJ8CEkm4cOJGIvldeSXHWdNciQ=;
        b=7V4b+T7n+HWWlgbXcPY3GR/lHlaqaey/sf2FRXqm+wOT+4UTcpypk3uafJx6ZGVCEo
         nHrlRgQi51Cu1NrVSCFeYUn5oX07bn7hUlx6Z7Zwi2rI+X71m5BHy4zcGvR1Ed6uzfiM
         N2Oed+XgAlHsyNwIU//yGcMbi3SL++Zz8NRvOqEEBrRukY+2gZrynhcU+VR+V44dqZre
         xcESdk7fb9tCgPiLWmKJXFibB3Cps5E6B29yY/zjYY1CB1dYzJPeY6Dgi1fFH8NBspKh
         QcinTXd8+G7R1SZfzVdzIPyN14JrmJVR8ClS/i/5F2RUkPsKcAt2xwvC2Hg+Mp5dJI/0
         0Q4g==
X-Gm-Message-State: AOAM53076P/iNMKaQXy1G8/w6MURuNz+yoqHoy4IV01FwTsmvI8UCnVZ
        S+BeCJrXj0hUB2cwiMk1tOiDudTXVJHVxA==
X-Google-Smtp-Source: ABdhPJwn2W4q/Bqi5bnZROf+mz/tcxR2tDEZ35WhI1B0zC6nSLyJ3FNUt0JdhmXAHTfraNp1nn9Thw==
X-Received: by 2002:a05:6e02:1c88:: with SMTP id w8mr32319457ill.318.1639377124862;
        Sun, 12 Dec 2021 22:32:04 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:04 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 09/15] chainlint.sed: drop unnecessary distinction between ?!AMP?! and ?!SEMI?!
Date:   Mon, 13 Dec 2021 01:30:53 -0500
Message-Id: <20211213063059.19424-10-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From inception, when chainlint.sed encountered a line using semicolon to
separate commands rather than `&&`, it would insert a ?!SEMI?!
annotation at the beginning of the line rather ?!AMP?! even though the
&&-chain is also broken by the semicolon. Given a line such as:

    ?!SEMI?! cmd1; cmd2 &&

the ?!SEMI?! annotation makes it easier to see what the problem is than
if the output had been:

    ?!AMP?! cmd1; cmd2 &&

which might confuse the test author into thinking that the linter is
broken (since the line clearly ends with `&&`).

However, now that the ?!AMP?! an ?!SEMI?! annotations are inserted at
the point of breakage rather than at the beginning of the line, and
taking into account that both represent a broken &&-chain, there is
little reason to distinguish between the two. Using ?!AMP?! alone is
sufficient to point the test author at the problem. For instance, in:

    cmd1; ?!AMP?! cmd2 &&
    cmd3

it is clear that the &&-chain is broken between `cmd1` and `cmd2`.
Likewise, in:

    cmd1 && cmd2 ?!AMP?!
    cmd3

it is clear that the &&-chain is broken between `cmd2` and `cmd3`.
Finally, in:

    cmd1; ?!AMP?! cmd2 ?!AMP?!
    cmd3

it is clear that the &&-chain is broken between each command.

Hence, there is no longer a good reason to make a distinction between a
broken &&-chain due to a semicolon and a broken chain due to a missing
`&&` at end-of-line. Therefore, drop the ?!SEMI?! annotation and use
?!AMP?! exclusively.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                       | 21 ++++++++++-----------
 t/chainlint/negated-one-liner.expect  |  4 ++--
 t/chainlint/one-liner.expect          |  6 +++---
 t/chainlint/semicolon.expect          | 10 +++++-----
 t/chainlint/subshell-one-liner.expect |  8 ++++----
 5 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 91077b6e26..f5fcca09ca 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -24,9 +24,9 @@
 # in order to avoid misinterpreting the ")" in constructs such as "x=$(...)"
 # and "case $x in *)" as ending the subshell.
 #
-# Lines missing a final "&&" are flagged with "?!AMP?!", and lines which chain
-# commands with ";" internally rather than "&&" are flagged "?!SEMI?!". A line
-# may be flagged for both violations.
+# Lines missing a final "&&" are flagged with "?!AMP?!", as are lines which
+# chain commands with ";" internally rather than "&&". A line may be flagged
+# for both violations.
 #
 # Detection of a missing &&-link in a multi-line subshell is complicated by the
 # fact that the last statement before the closing ")" must not end with "&&".
@@ -47,9 +47,8 @@
 # "?!AMP?!" violation is removed from the "bar" line (retrieved from the "hold"
 # area) since the final statement of a subshell must not end with "&&". The
 # final line of a subshell may still break the &&-chain by using ";" internally
-# to chain commands together rather than "&&", so "?!SEMI?!" is not removed
-# from such a line; however, if the line ends with "?!SEMI?!", then the ";" is
-# harmless and the annotation is removed.
+# to chain commands together rather than "&&", but an internal "?!AMP?!" is
+# never removed from a line even though a line-ending "?!AMP?!" might be.
 #
 # Care is taken to recognize the last _statement_ of a multi-line subshell, not
 # necessarily the last textual _line_ within the subshell, since &&-chaining
@@ -127,7 +126,7 @@ b
 # "&&" (but not ";" in a string)
 :oneline
 /;/{
-	/"[^"]*;[^"]*"/!s/;/; ?!SEMI?!/
+	/"[^"]*;[^"]*"/!s/;/; ?!AMP?!/
 }
 b
 
@@ -231,7 +230,7 @@ s/.*\n//
 # string and not ";;" in one-liner "case...esac")
 /;/{
 	/;;/!{
-		/"[^"]*;[^"]*"/!s/;/; ?!SEMI?!/
+		/"[^"]*;[^"]*"/!s/;/; ?!AMP?!/
 	}
 }
 # line ends with pipe "...|" -- valid; not missing "&&"
@@ -304,7 +303,7 @@ bcase
 # that line legitimately lacks "&&"
 :else
 x
-s/\( ?!SEMI?!\)* ?!AMP?!$//
+s/\( ?!AMP?!\)* ?!AMP?!$//
 x
 bcont
 
@@ -312,7 +311,7 @@ bcont
 # "suspect" from final contained line since that line legitimately lacks "&&"
 :done
 x
-s/\( ?!SEMI?!\)* ?!AMP?!$//
+s/\( ?!AMP?!\)* ?!AMP?!$//
 x
 # is 'done' or 'fi' cuddled with ")" to close subshell?
 /done.*)/bclose
@@ -355,7 +354,7 @@ bblock
 # since that line legitimately lacks "&&" and exit subshell loop
 :clssolo
 x
-s/\( ?!SEMI?!\)* ?!AMP?!$//
+s/\( ?!AMP?!\)* ?!AMP?!$//
 p
 x
 s/^/>/
diff --git a/t/chainlint/negated-one-liner.expect b/t/chainlint/negated-one-liner.expect
index 60baf84b7a..ad4c2d949e 100644
--- a/t/chainlint/negated-one-liner.expect
+++ b/t/chainlint/negated-one-liner.expect
@@ -1,5 +1,5 @@
 ! (foo && bar) &&
 ! (foo && bar) >baz &&
 
-! (foo; ?!SEMI?! bar) &&
-! (foo; ?!SEMI?! bar) >baz
+! (foo; ?!AMP?! bar) &&
+! (foo; ?!AMP?! bar) >baz
diff --git a/t/chainlint/one-liner.expect b/t/chainlint/one-liner.expect
index 3b46554728..57a7a444c1 100644
--- a/t/chainlint/one-liner.expect
+++ b/t/chainlint/one-liner.expect
@@ -2,8 +2,8 @@
 (foo && bar) |
 (foo && bar) >baz &&
 
-(foo; ?!SEMI?! bar) &&
-(foo; ?!SEMI?! bar) |
-(foo; ?!SEMI?! bar) >baz &&
+(foo; ?!AMP?! bar) &&
+(foo; ?!AMP?! bar) |
+(foo; ?!AMP?! bar) >baz &&
 
 (foo "bar; baz")
diff --git a/t/chainlint/semicolon.expect b/t/chainlint/semicolon.expect
index 0e6389f532..54a08ce582 100644
--- a/t/chainlint/semicolon.expect
+++ b/t/chainlint/semicolon.expect
@@ -1,14 +1,14 @@
 (
-	cat foo ; ?!SEMI?! echo bar ?!AMP?!
-	cat foo ; ?!SEMI?! echo bar
+	cat foo ; ?!AMP?! echo bar ?!AMP?!
+	cat foo ; ?!AMP?! echo bar
 >) &&
 (
-	cat foo ; ?!SEMI?! echo bar &&
-	cat foo ; ?!SEMI?! echo bar
+	cat foo ; ?!AMP?! echo bar &&
+	cat foo ; ?!AMP?! echo bar
 >) &&
 (
 	echo "foo; bar" &&
-	cat foo; ?!SEMI?! echo bar
+	cat foo; ?!AMP?! echo bar
 >) &&
 (
 	foo;
diff --git a/t/chainlint/subshell-one-liner.expect b/t/chainlint/subshell-one-liner.expect
index 432217801b..4b44632b09 100644
--- a/t/chainlint/subshell-one-liner.expect
+++ b/t/chainlint/subshell-one-liner.expect
@@ -2,13 +2,13 @@
 	(foo && bar) &&
 	(foo && bar) |
 	(foo && bar) >baz &&
-	(foo; ?!SEMI?! bar) &&
-	(foo; ?!SEMI?! bar) |
-	(foo; ?!SEMI?! bar) >baz &&
+	(foo; ?!AMP?! bar) &&
+	(foo; ?!AMP?! bar) |
+	(foo; ?!AMP?! bar) >baz &&
 	(foo || exit 1) &&
 	(foo || exit 1) |
 	(foo || exit 1) >baz &&
 	(foo && bar) ?!AMP?!
-	(foo && bar; ?!SEMI?! baz) ?!AMP?!
+	(foo && bar; ?!AMP?! baz) ?!AMP?!
 	foobar
 >)
-- 
2.34.1.397.gfae76fe5da

