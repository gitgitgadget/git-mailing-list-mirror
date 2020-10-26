Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8FAC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 20:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880BC20829
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 20:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhN1TbfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgJZUuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:50:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45920 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgJZUub (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 16:50:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id 15so25372pgd.12
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8aDoUo/X46z2A1t9dbjuf5wo9uNuBpOjem9fONq+Z0k=;
        b=BhN1TbfFExMn+id0VkB4JpSKnmGIuzQ6wGfGPM/jBIuAdO0yoJ1LB1Jr/VLCV2u5qs
         tukiFtVAnUUgN5p3laYswj4BkNhG2SfKvMJWZWv0W+4+3aVhL/jida1VQC0uBRVp5OL8
         kZiQArAQHNeIM1dl4I3S+NfqgMr7k/CmhAxVOlnuL5N+E6cpSYJ/LLtTPk9lBvpkrrrx
         IDZ593xQSSnD5CBl+KFrCSnB6Gt+l2rAmfJ/aUO/dPJXc1mglzLAbI8/XR5kV5BXMhbM
         u0TWmH1YpO2NOHPDcKgu/4Gac6M36mXugI6PMIfHKptCEDg/RyGxMCB469Zsu448IsjG
         ieNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8aDoUo/X46z2A1t9dbjuf5wo9uNuBpOjem9fONq+Z0k=;
        b=QaLrlvRuFk4RKPVp42sJMGzeB5Mvg835+nNw/gpUawJrXIB4cVA+j48+fUwOW3dqHE
         dCa8ExXrabQpFFQoWaN/n5ayDfHL3vPQ0/XeuzL9XU32oMokfLb6g/uyq64F7q9fkUpP
         u2zHOwFIQa+neHlRVhxXBdJgre4n1NggBVhKRDhUVbHeIp1xj9zOjnCJrDeenr2++gRK
         PQ7koqq111Ir+hzEcrgF+1GBrCCTJ+ky55/viq2e02B/ONC2Xy7FejIs+AU+YfvXGOaH
         o8hc286mIwTc4FQhw8m0+tAM1h2NwEudvRaaXeJrM+vm7zTD9E8sGgq9fsWgHRoO14yF
         PLKQ==
X-Gm-Message-State: AOAM532l2VkJFv2Oe7lraTrai3HaD9CkZEX4N/1GdoSal+HK7RE87s+U
        cJS0rGNPqGf3+KDiYRnVa9sKewq+w2k=
X-Google-Smtp-Source: ABdhPJx5Hb2LvWGIZtjyFxm1lB53snfUYegRGpvHwfbis7M6QIn+TGnwBJbDaDAy58iJRc4l95KRCQ==
X-Received: by 2002:a63:1b1a:: with SMTP id b26mr14043157pgb.405.1603745430964;
        Mon, 26 Oct 2020 13:50:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id y22sm12895855pfr.62.2020.10.26.13.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 13:50:30 -0700 (PDT)
Date:   Mon, 26 Oct 2020 13:50:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Joey S <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in
 test script
Message-ID: <20201026205028.GC2645313@google.com>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Joey S wrote:

> Modernize the test by replacing `test -e` instances with
> `test_path_is_file` helper functions, and `! test -e` with
> `test_path_is_missing`, for better readability and diagnostic messages.
>
> Signed-off-by: Joey Salazar <jgsal@protonmail.com>
> ---
>  t/t7006-pager.sh | 84 ++++++++++++++++++++++++------------------------
>  1 file changed, 42 insertions(+), 42 deletions(-)

Grepping for 'test -' in the file after applying this patch, I find no
more instances.

[...]
> -	test -e paginated.out
> +	test_path_is_file paginated.out

This kind of change ensures that if the file exists but as a
directory, the test will diagnose it, which is a nice thing.

Overall (as someone who's worked a bit with this test script before),
looks good to me.  Thanks for your work.

> -		${if_local_config}test -e core.pager_used
> +		${if_local_config}test_path_is_file core.pager_used

This bit is a little subtle: ${if_local_config} is either '' or '! ',
and in the latter case the benefit of test_path_is_file printing a
message if and only if the result is false goes away.

Would the following, squashed in, make sense?

Thanks,
Jonathan

diff --git i/t/t7006-pager.sh w/t/t7006-pager.sh
index fdb450e446a..11327944741 100755
--- i/t/t7006-pager.sh
+++ w/t/t7006-pager.sh
@@ -411,13 +411,13 @@ test_PAGER_overrides() {
 }
 
 test_core_pager_overrides() {
-	if_local_config=
+	pager_wanted=true
 	used_if_wanted='overrides PAGER'
 	test_core_pager "$@"
 }
 
 test_local_config_ignored() {
-	if_local_config='! '
+	pager_wanted=
 	used_if_wanted='is not used'
 	test_core_pager "$@"
 }
@@ -432,18 +432,23 @@ test_core_pager() {
 		export PAGER &&
 		test_config core.pager 'wc >core.pager_used' &&
 		$full_command &&
-		${if_local_config}test_path_is_file core.pager_used
+		if test -n '$pager_wanted'
+		then
+			test_path_is_file core.pager_used
+		else
+			test_path_is_missing core.pager_used
+		fi
 	"
 }
 
 test_core_pager_subdir() {
-	if_local_config=
+	pager_wanted=true
 	used_if_wanted='overrides PAGER'
 	test_pager_subdir_helper "$@"
 }
 
 test_no_local_config_subdir() {
-	if_local_config='! '
+	pager_wanted=
 	used_if_wanted='is not used'
 	test_pager_subdir_helper "$@"
 }
@@ -464,7 +469,12 @@ test_pager_subdir_helper() {
 			cd sub &&
 			$full_command
 		) &&
-		${if_local_config}test_path_is_file core.pager_used
+		if test -n '$pager_wanted'
+		then
+			test_path_is_file core.pager_used
+		else
+			test_path_is_missing core.pager_used
+		fi
 	"
 }
 
