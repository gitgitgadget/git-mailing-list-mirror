Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23291ECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 21:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiHaVom (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 17:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiHaVok (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 17:44:40 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C2DF5CCC
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 14:44:38 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c24so14604443pgg.11
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 14:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=xelxNBSXaJEEpjX0zAMeWa1h8IWvWiKX7pfvm/lzXH4=;
        b=eFZoktk+Ukz6XUN+3YEo/hVykp4WYGS3yTrSRLy1GVR3rkKf0ZeACq/fmgGmMY2EZl
         E4+3WyYS3XCO8zZjTbIbS55DHtMfczzmtwsaObX7aqAF8JZrjGzFCc2SaCL6D68iECMS
         ioehZqHXJxIR1JlgRLm3zbz1BQNSQxgkXIRoYLkyCCwC2UaMXo7iPdcqK1NC2qXH64Hm
         KsbJXPj/cfeLCqkSI7bXXLoq0Ff8wlP7V0E+ESZIR/UGbCH0kHFY0zy+DrwnpWl0G8Ql
         LXD1SGVC5zF2hwsA/TudnFZcPAP1KDqDtGQBL4W/eG6xVuAPOmWHeXA9KeOg54tu9NoO
         Kn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xelxNBSXaJEEpjX0zAMeWa1h8IWvWiKX7pfvm/lzXH4=;
        b=ML7VuoM8bQwW3R+fjZsJ/BTjxwPhH05cUKAyrQimLBhg5Tv7Qm1muyHc3Oxucpg4EC
         gkE7mRkbHrGSBxOO4ABQVcGLhY+WxCfMp+WehW/2qAziSV5x4FWJ2DQo6M+G+uMD8rqM
         GQPg+SeYsDNBQ7TMT2N0XBMtduuAJ8Lbkf7tWABJN90oO70I1FhJ//IEhutngA2WptH7
         UtdL9ZZMb604uLvHi3Rpgl9BORd0Yc81kzGY9gTvJc4C33SG/hBdMQbu0dT1TpFGQXWW
         NIuehy5wIqp3XBO2wTyjN+ltHUEN+el7a1X2mVZ/uhIp7wTkRJTDTgtxgXvBo/eFBY5D
         3gVQ==
X-Gm-Message-State: ACgBeo03ldAGefu8gpN8oIH6hONVUW53pp0Kd2/gfkoypFljksGcIVhz
        QPOfZvGDeFE9e6JbpSDhPsz2fhpWShY=
X-Google-Smtp-Source: AA6agR5UQgiaVj2maHvJ5OWpZgP+VrxVQLQdVvcRDFb9Cmui2SPRkc8oOtXkmnVQm3tiDqQJAXnM/Q==
X-Received: by 2002:a05:6a00:22cd:b0:52f:706a:5268 with SMTP id f13-20020a056a0022cd00b0052f706a5268mr27734744pfj.80.1661982277685;
        Wed, 31 Aug 2022 14:44:37 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902ed8d00b0016d66d49b85sm8939463plj.239.2022.08.31.14.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:44:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] Makefile: use $(OBJECTS) instead of $(C_OBJ)
References: <patch-v2-1.1-e77fd23a824-20220321T170412Z-avarab@gmail.com>
        <cover-v3-0.2-00000000000-20220831T090744Z-avarab@gmail.com>
        <patch-v3-2.2-cb3bc8b5029-20220831T090744Z-avarab@gmail.com>
Date:   Wed, 31 Aug 2022 14:44:36 -0700
In-Reply-To: <patch-v3-2.2-cb3bc8b5029-20220831T090744Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Aug
 2022 11:18:44
        +0200")
Message-ID: <xmqqmtbkdr5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> In the preceding commit $(C_OBJ) added in c373991375a (Makefile: list
> generated object files in OBJECTS, 2010-01-26) became synonymous with
> $(OBJECTS). Let's avoid the indirection and use the $(OBJECTS)
> variable directly instead.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

This is a declaration that we would never ever build .o files out of
sources other than .c files.  While it does make sense to have it
outside the scope of [PATCH 1/2], I am not sure if it even belongs
to the same series.

