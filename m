Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBC4C77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 21:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjEIVPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 17:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEIVPF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 17:15:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B08198E
        for <git@vger.kernel.org>; Tue,  9 May 2023 14:15:03 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9ef06cb784so8258425276.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683666903; x=1686258903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fngonr/ESP/oDwUtuR8SWbxiwz5xot3DOcA9/50yfo=;
        b=furzFssL9dvosLGNVRUth5yfz3gauYl+sCLV6+Exq4ANl9M3GzMRUkI7HrbULvA1Sp
         j9hHG7vF4eDnSxCL4YtQuywnYE1n9FTSjK9LoNYm/aSL+WxWShKduxFRO6bQkPDQcbet
         9IKlpY+Fx3xd1DIFgftujthxP8qXc+6VFdcBcLcGvfbU8UENAe1663qnuQV28O+pBkHf
         09OQ5vHvh3E9OzntJQdP0wk9UwGS7L6qCaqNJKXsn6D5GuHI01G9KJJVh2EIYeU+ms53
         rTG1nTJRcjuStx+J9Wf1VNVn6dJp5ylSCxnFgsw87U33yfMVXANuMQk1EZLsk15hSidw
         ygfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683666903; x=1686258903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fngonr/ESP/oDwUtuR8SWbxiwz5xot3DOcA9/50yfo=;
        b=CWLvvaBRmFhVQO+IX25OZ40Bszntu7bHUy6TaGZX3tzx3mP5sgJ9kOqd6Extb4AjiB
         TYZS71Xoj6Ev75z6dXuDGTI+Ii/iCWpgdDPbtB8SR2cyR2eKfdTCpGEHzmy1Ttumsoml
         46QeaSP8xG5BSpemAm03QQo0P55351VodxXYIz3uxWTIJOrO2cgZO4U+9gkkFDicls/T
         lmOqrjIjr0Qn+/8GxmorA6PgWQl/zAZcf7cuF8ZLOcPsreVVRZuRmVPs5wA1J28hF9b8
         zb/VlkNxt0KFLOf0XSd4Fzg4d/fb1sY3CYNKPpYzGpabZ8KMvlCE5RM/ZVmTZpP38NxP
         xoXA==
X-Gm-Message-State: AC+VfDwUOj23RXAzulOL7OI9IAWRL7mywQa6LrktfBZGSyZA3jfeYVKn
        5iSg/U4AHcWHzT1GNydBFVhDnQ==
X-Google-Smtp-Source: ACHHUZ6ft0w2EwQ5oKAnRO7VpOKgllYZGHxbo24KRgfaswcuSDUcnvwd4t9Z4orjRsDvyyV/HowsZg==
X-Received: by 2002:a81:5456:0:b0:55d:5ab4:6659 with SMTP id i83-20020a815456000000b0055d5ab46659mr14741041ywb.48.1683666903092;
        Tue, 09 May 2023 14:15:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q129-20020a817587000000b0054601bc6ce2sm3605690ywc.118.2023.05.09.14.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 14:15:02 -0700 (PDT)
Date:   Tue, 9 May 2023 17:15:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/15] refs/packed-backend.c: implement skip lists to
 avoid excluded pattern(s)
Message-ID: <ZFq31XquMwJrPEOK@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
 <ZFpjn-vjP6H_v_KD@ncase>
 <ZFqzW2vqcFJqqPXH@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFqzW2vqcFJqqPXH@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2023 at 04:55:55PM -0400, Taylor Blau wrote:
> Good catch. I think applying this on top should do the trick:
>
> --- 8< ---
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 137a4233f6..3b1337267a 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1054,9 +1054,9 @@ static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
>  	 * we want to combine that into a single entry jumping from A to
>  	 * C.
>  	 */
> -	for (i = 1, j = 1; i < iter->skip_nr; i++) {
> +	for (i = 0, j = 0; i < iter->skip_nr; i++) {
>  		struct skip_list_entry *ours = &iter->skip[i];
> -		struct skip_list_entry *prev = &iter->skip[i - 1];
> +		struct skip_list_entry *prev = &iter->skip[j];
>
>  		if (ours->start == ours->end) {
>  			/* ignore empty regions (no matching entries) */
> @@ -1066,7 +1066,7 @@ static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
>  			prev->end = ptr_max(prev->end, ours->end);
>  		} else {
>  			/* otherwise, insert a new region */
> -			iter->skip[j++] = *ours;
> +			iter->skip[++j] = *ours;
>  		}
>  	}
> --- >8 ---

Oops, this is wrong. It should be something like this instead:

--- 8< ---
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 137a4233f6..574f32d67f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1007,6 +1007,7 @@ static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
 {
 	size_t i, j;
 	const char **pattern;
+	struct skip_list_entry *last_disjoint;

 	if (!excluded_patterns)
 		return;
@@ -1054,19 +1055,22 @@ static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
 	 * we want to combine that into a single entry jumping from A to
 	 * C.
 	 */
+	last_disjoint = iter->skip;
+
 	for (i = 1, j = 1; i < iter->skip_nr; i++) {
 		struct skip_list_entry *ours = &iter->skip[i];
-		struct skip_list_entry *prev = &iter->skip[i - 1];

 		if (ours->start == ours->end) {
 			/* ignore empty regions (no matching entries) */
 			continue;
-		} else if (prev->end >= ours->start) {
+		} else if (ours->start <= last_disjoint->end) {
 			/* overlapping regions extend the previous one */
-			prev->end = ptr_max(prev->end, ours->end);
+			last_disjoint->end = ptr_max(last_disjoint->end, ours->end);
 		} else {
 			/* otherwise, insert a new region */
 			iter->skip[j++] = *ours;
+			last_disjoint = ours;
+
 		}
 	}
--- >8 ---

Thanks,
Taylor
