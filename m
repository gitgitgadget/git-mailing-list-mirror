Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAEAC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6263461433
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhEKUFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhEKUFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:05:07 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B66C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:04:00 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so12263872oth.8
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=ANRK3IPo1+9sxClqEoNQw4KQBbFR9VlrJ4sXOFjfW2M=;
        b=XlYfTCIOnD15TgMQEIQzNK44do+BYRA5NvS9a0LiqsB0xdc379zmzvnlJVa5DqSjHK
         JSFeSLGKNXZ08tfsnqfMYSAnM8ZZDTSvq/bdarGTJHLNRHmmK6Mzk7AWxznu1GxLXJAU
         6So4xySrOaMOO0NcMvE3qbZZiiHSOVZWy0JcmMZDZIkT9yL4n6NiWzSYNOW9ATn1trAt
         zn+li1NmNIU5fVpaUh2MVrfbAtIQ4gY73dy0wWSXSXSAIamhlm2LaVXddtWCY3eGVGpq
         4c8BBJNH4/uUJ8JhwP3oZcMM2YwcjHPzh1eOxpHIsBUORGTNEs1BStsKmg2O5B7UKjuo
         LV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=ANRK3IPo1+9sxClqEoNQw4KQBbFR9VlrJ4sXOFjfW2M=;
        b=UUco3hgK2CT9L6Of0V8JemfgjWZ6yYRtS01KsoSwgu4YhoHhI2siSDnyG7r4Vd8Xal
         VqJWPGeJDrT+Q2ypAGNhtEBj1yCiCkN+HKIQMImj4Fc0cDpdFBf5eG/VDz+QRAjkSidV
         t5dbHu/mlmrIAx4aaL968UhFFQ1mwXt0Rly1nMGwjomtTuz1QyXPaGFSX5g6PDKbUY51
         QAO9HyReX9b64VpHi9q5wUPHsNxLmGSYPNzKPYtlFhnt2FziA25BsgFD6wLvR+U3BKrX
         BRXxXp8phJiO5RZ0kovV9MiNJppqyYGnnfJGBK8UoE9bgSPIjcc3yVWY1gBoSc3sBGUz
         iORA==
X-Gm-Message-State: AOAM53106A1VzaFtwJpMvgCo+dLfDlZOb00nT32AfEyqGB6VMembjcWs
        AitcMnL7cuIfSBxL+rK2/Gp/ZYI1T47Xmw==
X-Google-Smtp-Source: ABdhPJzMQ7m1DFaeIrTBMX706DmSO4Lx4lfbiqijmEF+ayM838/pYHXXZErdn5DCN0SoXcBKXUF+TA==
X-Received: by 2002:a05:6830:15d2:: with SMTP id j18mr27710923otr.89.1620763439577;
        Tue, 11 May 2021 13:03:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id v28sm3623871ood.27.2021.05.11.13.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:03:59 -0700 (PDT)
Date:   Tue, 11 May 2021 15:03:58 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Gregory Anders <greg@gpanders.com>, git@vger.kernel.org
Message-ID: <609ae32e3b9f_60649208e0@natae.notmuch>
In-Reply-To: <20210511191510.25888-1-greg@gpanders.com>
References: <20210511191510.25888-1-greg@gpanders.com>
Subject: RE: [PATCH v3] git-send-email: use ! to indicate relative path to
 command
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders wrote:
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1492,11 +1492,14 @@ sub send_message {
>  
>  	if ($dry_run) {
>  		# We don't want to send the email.
> -	} elsif (file_name_is_absolute($smtp_server)) {
> +	} elsif (file_name_is_absolute($smtp_server) || $smtp_server =~ /^!/) {

Is there any particular reason why we are checking for an absolute path?

-- 
Felipe Contreras
