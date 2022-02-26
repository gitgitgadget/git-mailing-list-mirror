Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432A6C433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 18:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiBZSCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 13:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBZSCO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 13:02:14 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7C81C232C
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 10:01:39 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e11so6916160ils.3
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 10:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6BMMBp017OCOaEEwLszoqcAw4z/bBE4MFrr+jErLbXc=;
        b=I8XJKtogahMbd+l7qr6f4oI7vNSPvXXG98aTwmMGfj1DMSW8cjg9rg3WOcxXGtyGgw
         j3R1btUAo/dy5ZBvG1opmsxglrY9HgB+l9TgKRtSQiVWoESBOn00OXZEA4f/fhaFbrSK
         9Kh9gDiyTCEWgFFEZwXR5S74kMOYTO1p7B6Da5mgoXEHAB5ReKkxUyt0jC2gloD+l7Nk
         N2JnJLGbCfquzcxXsTaAAe4EedDxx/JyT9vIIzxZH3c5E9sQVX9rva4jcH8sDtgbL9TP
         8LaGelpukQskmjnPqDCvyUJEq3rofz034/vpk1eAyLgVC7y5fEYj85MBeVuzCZATDAkT
         beBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6BMMBp017OCOaEEwLszoqcAw4z/bBE4MFrr+jErLbXc=;
        b=QsAgSEshRY2msE+vXwAW/Ep3HPwBzlp0c+uk8WyDv5OsuuVlvPjDI4S6YpOFIu59+P
         E6sIXUbfItpkvtMEGdU1YzAxRlLIsF85L0IH3ZsL/w07YQ6WxXKDGc5PIXsUEhkuIKob
         Xb0ykZehWi4NmB3hDFuFY6eF9duY0/fLUS9cxvnOzUDxeswBWjXK7MpaMbOD6SUoLerr
         kaSUgNwBSVyLklG/mGe8S0VxvmrtqNRr/Q5wga4vW5usGMpi5gDlDNW26TPIOu+fsjKb
         Z+B0/B/ji7P31h1wGe2Z9c+OYY5qqBvVSqxCEkVZOlu4ekO/ZdCO4GKuS21oAJqao6IC
         3Mlw==
X-Gm-Message-State: AOAM5319OGyS/ymzAtO0ymxy/GA653uRxbyZlQVi/xOfc2EWS15+V2oL
        SzPBDZeBl6pst5ZBvO0aQRva0g==
X-Google-Smtp-Source: ABdhPJxSm/aYsqYOKEsTKri9xzPnwnbzYFtkLmg8yUbeyYS6DzB7cHtNA7d+atulphhu3P79jV2MEg==
X-Received: by 2002:a05:6e02:1be9:b0:2c2:85a8:50cc with SMTP id y9-20020a056e021be900b002c285a850ccmr11528061ilv.131.1645898498889;
        Sat, 26 Feb 2022 10:01:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j9-20020a92ca09000000b002c21fd9d87csm3892807ils.58.2022.02.26.10.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:01:38 -0800 (PST)
Date:   Sat, 26 Feb 2022 13:01:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http API: fix dangling pointer issue noted by GCC 12.0
Message-ID: <YhprAb1f1WYIktCV@nand.local>
References: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
 <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 10:09:11AM +0100, Ævar Arnfjörð Bjarmason wrote:
> There's a few possible ways to fix this, but the simplest is to assign
> NULL to "slot->finished" at the end of run_active_slot(), it's the
> only caller that ever assigns non-NULL to it. It was suggested[2] to
> guard that with "if (slot->finished == &finished)", but that'll still
> trigger the warning.

I'm not quite sure that I follow this. This isn't the only spot that
assigns non-NULL to "slot->finished", see the assignments in
http-walker.c:process_alternates_response() and
http.c:finish_active_slot().

But even if it were, I'm not sure how this being the only spot that
*writes* non-NULL matters from a reader's perspective.

Looking more at process_alternates_response(), it really looks like this
variable wants to hold a tri-state value. I wonder if it would be
clearer to replace the NULL/(pointer to) 0/(pointer to) 1 with a
UNKNOWN/TRUE/FALSE enum.

Thanks,
Taylor
