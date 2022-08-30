Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F719C0502A
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiH3Jcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiH3Jc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:27 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF698A896E
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:12 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id d18-20020a9d72d2000000b0063934f06268so7690058otk.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4Ii+7GiIUf2Kag52CRz43gixuv5IGmAUflOSyrgKks0=;
        b=A18zemkQJC9e/JxqFnpc3A90JOJQ7SxfJDwckcOp17cuT7W868cGNSjPUcC/j/8Khu
         i5ffH6Z59lkMLj7dBnYfcd8lH9Gyr+ktFcXOYLG0Z5lo2NQgIdSrTay6rrIB6sMi4Zef
         +oNdhE9DDoHTam5fbmBGsmo5uJFlL/5JOxk6fUSLNxZW1I/jwpgH2kH9JM1UdI8UKLkb
         KackZPP5gApIMpgJu3Wbk2xXo+VIfWk4rkjKfN7Tm+nqRFvn8yct6YgLK4B3K+TRmxLt
         CIMT5zn9W6BBDpwylUoy2/CzdlDqdQqWH0A7Qn7QMxfCVZVSyiCzofSCDR53OjNyQRe1
         l+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4Ii+7GiIUf2Kag52CRz43gixuv5IGmAUflOSyrgKks0=;
        b=w8hpY5wka3ZUKgW0+Zoi66PxPv6Q9HxRo5TArmmicocDFl8IxoATNf9/kusvMHcrQH
         twwJ/n2KDv/zRgR/jJJqBz5WOwoktgAfUBK50AOwhWjOoHoCWkWaezDLlED57Lxtc6jv
         cdmO8C7X10Wx205aT61lxv5dsso391BMw8XFw1LbO8HrkMsTO8jVRqU74Mzt54t0EXle
         X9R6sdlu8aFJAwO5dBYdrwpVg+VduuBtSqui5zrQ4s4WVyhJVQq5gYwssfv5wFhvOJrN
         ZDdPPpaAjhE4p2AS7FQpnhyzj8z0WYUMWabxoJ4vjpakzthG62tK79a6HUtBKnkPY4v8
         6DYQ==
X-Gm-Message-State: ACgBeo1T6Kw+q/tKJcBT6HTz7r9coRJcAJr9aclwMHl1Hpjb2Sl8WPTY
        EtgCzZmMVzNKivzAR1wHvEBbwxmVCyM=
X-Google-Smtp-Source: AA6agR75J5QLPhzDbTF2Uqs6OHZaUuRYOVxg7hhmq00pN0YoFQexPRA1shOVz+lApEMjTchMsxk5CQ==
X-Received: by 2002:a9d:6a97:0:b0:636:ed2e:94ec with SMTP id l23-20020a9d6a97000000b00636ed2e94ecmr8052418otq.272.1661851930065;
        Tue, 30 Aug 2022 02:32:10 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056830660600b0063b34c35575sm1563395otb.42.2022.08.30.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:09 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 18/51] completion: bash: get rid of any non-append code
Date:   Tue, 30 Aug 2022 04:31:05 -0500
Message-Id: <20220830093138.1581538-19-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4a7e75b48d..ed126bbec4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -314,7 +314,7 @@ __gitcomp_direct ()
 	COMPREPLY+=($1)
 }
 
-__gitcompappend ()
+__gitcompadd ()
 {
 	local x i=${#COMPREPLY[@]}
 	for x in $1; do
@@ -324,12 +324,6 @@ __gitcompappend ()
 	done
 }
 
-__gitcompadd ()
-{
-	COMPREPLY=()
-	__gitcompappend "$@"
-}
-
 # Generates completion reply, appending a space to possible completion words,
 # if necessary.
 # It accepts 1 to 4 arguments:
@@ -443,7 +437,7 @@ __gitcomp_builtin ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Fills the COMPREPLY array with prefiltered paths without any additional
@@ -456,7 +450,7 @@ __gitcomp_file_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 
 	# use a hack to enable file mode in bash < 4
 	compopt -o filenames +o nospace 2>/dev/null ||
-- 
2.37.2.351.g9bf691b78c.dirty

