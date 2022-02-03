Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AA5C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbiBCViM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiBCViL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:38:11 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F85C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:38:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so6517645pjy.1
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4mbFDlH0h8XY0hGNhLZlQWN8H96rerVWBSXLuVOp9Ss=;
        b=EMLvcHWIXSnNOkr7p3zrKID4YhKi4DHTYVR1XBq9SxQw2MDQOLkIHw/Za+/7UtYw8p
         COOzDJGECNjOaM2u97KdjnNHGkvpL4kH82tNsRIx2+YRgGKTExKadJuhyHzJHc21GZyK
         senPmKc2RXio7ad4+uablBDGQBnoBnnmkL5Xr+ZNlPlDXo4OUt7tFMWe3PxXEsDYX1H6
         YAJg5TS7PvIEGzhKqh1II6fMHzxPjlJi33AsfJWkJmnPky1nDXFR5i/CPpJssSbA+slB
         IT110kmLkccm32EdF38hp64CnOV0OiuL4YnploSJZnMrOKE06+Vcfeq21mQsy90hgedH
         EGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4mbFDlH0h8XY0hGNhLZlQWN8H96rerVWBSXLuVOp9Ss=;
        b=ukJBWoyXvUE7xvd1bsrU/sldOLZKtvxNivZ/bjJw8mmSo4jko8jqvGM1r1lu3ZgaAV
         PKAAiiv4y39fAyixa7BpkArC3V7MDo14k1XLym8gYFlnoVw7p3UKm7WEvE8mqY5CEvwt
         yxYdFL4jOWAMNmEt4VEh5eEHYkpB84JMcBSsoFWFdRfzdzasgKU4YcuKxcdXeE1eManO
         awnPCvOBrHa6fiPD3qaqcNgSlbxc/03CR780AaPLt2CObxSmAjFb47cnch7bkxAmTu3o
         2hl25meJ8i9BWtA3AbFoDR8dIb5+L3hB2XpQMA/cirmIgLPM+DVjBDeFYNAkda4EpceL
         FrOw==
X-Gm-Message-State: AOAM533Ut4awIJp69bO73UKhn4jAyyPg42M7swjghIb3BXWuEs3Gmfja
        hzIefsEbDfmb2j+lwlJyxuQw/WOtEMs=
X-Google-Smtp-Source: ABdhPJw7Rgh8BNdx03uiSbYUgKUFWscfqEPcFbxWjK8aP8DiOJuB8pLn/v2j8w6mexKKNUZOH1uj+Q==
X-Received: by 2002:a17:902:e5cb:: with SMTP id u11mr36780016plf.146.1643924290430;
        Thu, 03 Feb 2022 13:38:10 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id c12sm30614625pfl.130.2022.02.03.13.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:38:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH] gpg-interface: fix for gpgsm v2.3
References: <20220203123724.47529-1-fs@gigacodes.de>
        <Yfw0kapgSSWO3Pyx@pobox.com>
Date:   Thu, 03 Feb 2022 13:38:09 -0800
In-Reply-To: <Yfw0kapgSSWO3Pyx@pobox.com> (Todd Zullinger's message of "Thu, 3
        Feb 2022 15:01:21 -0500")
Message-ID: <xmqqsfszr5q6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

>     -	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
>     +	string_list_split_in_place(&lines, gpg_status.buf, '\n', -1);
>     +	ret |= !unsorted_string_list_has_string(&lines, "[GNUPG:] SIG_CREATED ");

Is "SIG_CREATED " supposed to be at the end of that line?  I thought
that has_string() asks for an exact match, and unfortunately(?)
there is not the string_list_has_string_that_has_this_prefix()
function.  So...

