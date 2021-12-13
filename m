Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EECC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhLMGcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhLMGcF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:05 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0875EC0613F8
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:05 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id v13so789243ilm.8
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjcawDkWagOZ4PH55/UleBPB2dTtvFZJjqPUuLyBAAw=;
        b=l9gtGJ/cNNa3QRrxSeGEBTzO/J7+cb8si/3ZJMOZTeT9RsAxTZI0tE1Wz4nYX3ph3W
         oebC85+ggrwkg/2imdpebN3vmdM9tdEazuuogcFJebeM6xif6Bc4HuPTD8wbNNylaeHG
         VJiCvsebLR6nqFuRYj5SH1m/CPJmmbIACjWUNRr1dpHQoysgR4a/MuT2fDWyeXiuoJtm
         xMNcm6czgNT177IDojR6E8wlE8F1mezURWaf3r+GJygFUNSrro9zSsSNd1kb57EsRRay
         3yKKR45IAR7VAz9aIILmcnE0KPMAAncS7ckQdKNLYJnOWpbT+1B2RJ3243gMe922iQ2a
         KU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CjcawDkWagOZ4PH55/UleBPB2dTtvFZJjqPUuLyBAAw=;
        b=Wzdfv1EOTwtkhLg07tu1rqmr0fcPIili2bywqZPdqFqNO8lP08v/W3AO9Vx+n92EKB
         tNpgQaTqmQMnqx0pKphsHzLSrfh4kW2DokS8iuV89GWX8nggznxh2iHtasOkqmRAUEgh
         H2HhYHjt8ExOsyLk/V9B1UL+EFIwm/WojNe8aISZ0PcT+oX57rOppJa7iKGqGYcFO501
         RV1fs+/siBj7I/jeQuJsYIFtExgCe8BphHKMNExypUNBo91Cob1+NpithzBApT7mSWrv
         FXlSmadYFivBEjgwJmkhOHTVHBBVSoEgpYiL90PJSqUBElKa5v7HK9oWsf8JAFBv3sH0
         6DFw==
X-Gm-Message-State: AOAM531Q7Fsz0kneXHLrQa5Zr3S93JsrT1Ex5Kro9wt9X835d/DAqCOk
        gaimxAQBY5ooyNGpae3j8T9LiFRy5SFp2g==
X-Google-Smtp-Source: ABdhPJw5vIBVFt66+S+OYsT/IoDFB7FCSTOLeL6n4ngqXExNEKomNYhxQkU9/M8FW+KZ0GsiSS0iMw==
X-Received: by 2002:a05:6e02:1648:: with SMTP id v8mr32284793ilu.157.1639377124194;
        Sun, 12 Dec 2021 22:32:04 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:03 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 08/15] chainlint.sed: tolerate harmless ";" at end of last line in block
Date:   Mon, 13 Dec 2021 01:30:52 -0500
Message-Id: <20211213063059.19424-9-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

chainlint.sed flags ";" when used as a command terminator since it
breaks the &&-chain, thus can allow failures to go undetected. However,
when a command terminated by ";" is the last command in the body of a
compound statement, such as `command-2` in:

    if test $# -gt 1
    then
        command-1 &&
        command-2;
    fi

then the ";" is harmless and the exit code from `command-2` is passed
through untouched and becomes the exit code of the compound statement,
as if the ";" was not present. Therefore, tolerate a trailing ";" in
this position rather than complaining about broken &&-chain.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed              | 11 ++++++-----
 t/chainlint/semicolon.expect |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 60c2099c18..91077b6e26 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -47,8 +47,9 @@
 # "?!AMP?!" violation is removed from the "bar" line (retrieved from the "hold"
 # area) since the final statement of a subshell must not end with "&&". The
 # final line of a subshell may still break the &&-chain by using ";" internally
-# to chain commands together rather than "&&", so "?!SEMI?!" is never removed
-# from a line (even though "?!AMP?!" might be).
+# to chain commands together rather than "&&", so "?!SEMI?!" is not removed
+# from such a line; however, if the line ends with "?!SEMI?!", then the ";" is
+# harmless and the annotation is removed.
 #
 # Care is taken to recognize the last _statement_ of a multi-line subshell, not
 # necessarily the last textual _line_ within the subshell, since &&-chaining
@@ -303,7 +304,7 @@ bcase
 # that line legitimately lacks "&&"
 :else
 x
-s/ ?!AMP?!$//
+s/\( ?!SEMI?!\)* ?!AMP?!$//
 x
 bcont
 
@@ -311,7 +312,7 @@ bcont
 # "suspect" from final contained line since that line legitimately lacks "&&"
 :done
 x
-s/ ?!AMP?!$//
+s/\( ?!SEMI?!\)* ?!AMP?!$//
 x
 # is 'done' or 'fi' cuddled with ")" to close subshell?
 /done.*)/bclose
@@ -354,7 +355,7 @@ bblock
 # since that line legitimately lacks "&&" and exit subshell loop
 :clssolo
 x
-s/ ?!AMP?!$//
+s/\( ?!SEMI?!\)* ?!AMP?!$//
 p
 x
 s/^/>/
diff --git a/t/chainlint/semicolon.expect b/t/chainlint/semicolon.expect
index d2d804f5b0..0e6389f532 100644
--- a/t/chainlint/semicolon.expect
+++ b/t/chainlint/semicolon.expect
@@ -11,10 +11,10 @@
 	cat foo; ?!SEMI?! echo bar
 >) &&
 (
-	foo; ?!SEMI?!
+	foo;
 >) &&
 (
 cd foo &&
 	for i in a b c; do
-		echo; ?!SEMI?!
+		echo;
 >	done)
-- 
2.34.1.397.gfae76fe5da

