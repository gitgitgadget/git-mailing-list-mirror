Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E089CC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 14:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjDROv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjDROvy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 10:51:54 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FD3146C3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:51:26 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54c12009c30so568191577b3.9
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681829485; x=1684421485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VleRXOA+4AX5AUgzX00JyhEooEhPH66BcPfJ146xCkE=;
        b=bxsFRHCv39c+gWIdViBKNeX3/FwcMmY+R22UOI1l1fHVCoj5EZt/RJ+wHh2JX3zGLB
         YuzQuFcvtZC0g+9UFzjnpz7LUg2pfWYdVTG8VAYR6WrBgWGSNoP8hFKRRgZFzZXDmWCE
         //7iwAVuCxCC9MIZ7p1PHhtnb4Rp5hLdoun+02SQltvCSJ/9+D954ukFXqwCKbTtcFYs
         sMev+KhJZPePwWdHCHs8OGEiwyzAQ62TqrMlBps0crcsKKCH38FCeC+xyHMgm+cwKoY5
         lzLJp5zcLwfFZB6Zz/2MnoWG8ls92HGYKY6VgWNW3XQvwXvakdfRHl/q8krrkpmrvrmS
         7ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681829485; x=1684421485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VleRXOA+4AX5AUgzX00JyhEooEhPH66BcPfJ146xCkE=;
        b=Fr93/KGDbxrYrPkoonR5L17YpmYdiUUvNtyeoLTw+ovzUYpLJp8uk9Yjyob4khS/Tl
         7u9iEcmuGyVo6+kd2zVL790les/lPeHMzqKSPA5oD9Lm6maYvoRikPRNDslN4nL0U3jq
         QODvaF2b1Wpfgpe5ErS3/1nvGWvVsW+PxJkQXi0ltoEt/u1IJE1jkPBwcUDCkj+xxP77
         AY03d6owIw9PLN/6nqPM5+HSvV4RCt5PcHgwdED9xtCD/IE4NH0ahWG02tIIG3Gm9qHf
         wcmhDC102xBboOVKnvwj7MkeVqfrwfcOSXU+viOWxphiE/ePj0j7IVPDk/oWsPOklLGS
         J3+A==
X-Gm-Message-State: AAQBX9fem2oCU5RNj4GDi8poQv4Ef192eUR60pIhrla3BdZWFQDQ9g/S
        9qiZACgtLmAciuy7kBCiu/tELA==
X-Google-Smtp-Source: AKy350Ydf3A5k8cbiBwwvYtEc+uRxGDNzXgRSl51SP9xa2kwb8NyzH+WBZMcjtwz2pHp7cpmfQKU9g==
X-Received: by 2002:a0d:f0c1:0:b0:552:96e5:61ee with SMTP id z184-20020a0df0c1000000b0055296e561eemr102443ywe.19.1681829485027;
        Tue, 18 Apr 2023 07:51:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id da15-20020a05690c0d8f00b00555abba6ff7sm569920ywb.113.2023.04.18.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 07:51:24 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:51:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/4] fsck: check rev-index checksums
Message-ID: <ZD6ua4dSynRWmW2a@nand.local>
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
 <7db4ec3e327ed3695f4f5409cb2dc80c72688758.1681748502.git.gitgitgadget@gmail.com>
 <ZD3HI/LIXVv6Pacn@nand.local>
 <2628249e-fe9a-d15c-5414-33d815b35cd1@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2628249e-fe9a-d15c-5414-33d815b35cd1@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 10:27:57AM -0400, Derrick Stolee wrote:
> >> +test_expect_success 'fsck catches invalid checksum' '
> >> +	revfile=$(ls corrupt/.git/objects/pack/pack-*.rev) &&
> >
> > Would this test be tighter if we introduced a sub-shell and cd'd into
> > "corrupt" here?
>
> corrupt_rev_and_verify does the subshell thing. Why should we do that
> here in the test?

I was thinking that it might be more concise if you moved the subshell
to the test and out of corrupt_rev_and_verify. In addition to making
corrupt_rev_and_verify work in other instances where the repository
isn't required to be in a directory named "corrupt", I think it
simplifies the result.

Here's what I was thinking, as a diff on top of this patch:

--- >8 ---
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 6b7c709a1f..7dfbaf6b37 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -160,29 +160,30 @@ test_expect_success 'set up rev-index corruption tests' '
 '

 corrupt_rev_and_verify () {
-	(
-		pos="$1" &&
-		value="$2" &&
-		error="$3" &&
+	pos="$1" &&
+	value="$2" &&
+	error="$3" &&

-		cd corrupt &&
-		revfile=$(ls .git/objects/pack/pack-*.rev) &&
+	revfile=$(ls .git/objects/pack/pack-*.rev) &&

-		# Reset to original rev-file.
-		cp $revfile.bak $revfile &&
+	# Reset to original rev-file.
+	cp $revfile.bak $revfile &&

-		printf "$value" | dd of=$revfile bs=1 seek="$pos" conv=notrunc &&
-		test_must_fail git fsck 2>err &&
-		grep "$error" err
-	)
+	printf "$value" | dd of=$revfile bs=1 seek="$pos" conv=notrunc &&
+	test_must_fail git fsck 2>err &&
+	grep "$error" err
 }

 test_expect_success 'fsck catches invalid checksum' '
-	revfile=$(ls corrupt/.git/objects/pack/pack-*.rev) &&
-	orig_size=$(wc -c <$revfile) &&
-	hashpos=$((orig_size - 10)) &&
-	corrupt_rev_and_verify $hashpos bogus \
-		"invalid checksum"
+	(
+		cd corrupt &&
+
+		revfile=$(ls .git/objects/pack/pack-*.rev) &&
+		orig_size=$(wc -c <$revfile) &&
+		hashpos=$((orig_size - 10)) &&
+		corrupt_rev_and_verify $hashpos bogus \
+			"invalid checksum"
+	)
 '

 test_done
--- 8< ---

If you do take my suggestion, make sure to remember to come back in
patches 3/4 and 4/4 and adjust those instances of
'corrupt_rev_and_verify' to first change into "corrupt".

Thanks,
Taylor
