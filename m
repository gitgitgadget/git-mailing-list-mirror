Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0097EC636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 17:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjBORUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 12:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjBORUu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 12:20:50 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FCA38643
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:20:48 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id mg23so12256921pjb.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzKd4o8zaIxopG5No1I8DH5CC026C4czQfccMfruNnY=;
        b=bhXQzOxofHTMErmWmH5fg5HZKup8Y1JO21ciCpG1Fab95o7i56sBFdIc0KNH5XPpmE
         ZyOBSaf1gvfOt71C/ZGdUIB0HE6ixWT3WNjagqiKvlJzfu0MpkOGNkV05hRjgq1aWu2M
         Ua+TV4S+jSW16ORvk9lFnL+dHsfmbKg/Y8Nn6IWAvi0gSWRSDAqTuxKl8Y22QSxRBzq2
         dCIfz1A0EESXsm/ODqcGPhAV/sd3Hqiiy7bvbN96ZDV5NC3nDDLYlwl0bgiofsgMe3lp
         +zAZb7Jd8gDUSs+C23pbVaSlgXrLn7Hr42gVPdcAMUEmvl9c7vg6NttLhLvZNVAaOqyO
         evmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZzKd4o8zaIxopG5No1I8DH5CC026C4czQfccMfruNnY=;
        b=ue2W3G91FJTmZ9BYXankIzDN/OserrOr12ALYtZCzeWHa/mJ/hteHXLXWQOceRD0LG
         3OgHcbQfMjh9UVEs5DD7zJ6jOIRgKjwzmJMLUpTjsk2ePBz7oio78k9IrYOTXPAZkk/q
         C/F/WxaHI1GoHIWEdLKz65ILmNGjqPDJJCS2g/Oyj+veON7o8jQiYtaFlCakXBUTjw+k
         7DCrxqBFK0z1OYOVuYG5pR+TjzhAmRq76/Ug8enxhPzQOZq6Es29271mOHiG6VzhLoeu
         nhOXFI+cEffefOqT8wVS0fUVW5ShzmDx5DRE6T90wye7sz2sjHQYexZ3eNmORItFnn5H
         GYLQ==
X-Gm-Message-State: AO0yUKWO+zd0ZqkIWT0a0SgWG/3VXeYyjWIiT+C3N/A74lcjdRSYnyE0
        eKmVe0f3/f6xSrDmbvPKLw4=
X-Google-Smtp-Source: AK7set+SwMOJEPZZzkH5WUbA0tm2p6/AcV7lxlonJwArfLDi+34cjlzG693CKAb4vGjf8ZdfCU8WXQ==
X-Received: by 2002:a17:90a:e7c5:b0:234:118d:b1b1 with SMTP id kb5-20020a17090ae7c500b00234118db1b1mr3543271pjb.48.1676481648086;
        Wed, 15 Feb 2023 09:20:48 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id fs24-20020a17090af29800b002340d317f3esm1706797pjb.52.2023.02.15.09.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:20:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] gpg: do show gpg's error message upon failure
References: <pull.1480.git.1676440714.gitgitgadget@gmail.com>
        <ead90d343b1f4f4ce8998b2f31558fd30d7d2675.1676440714.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Feb 2023 09:20:47 -0800
In-Reply-To: <ead90d343b1f4f4ce8998b2f31558fd30d7d2675.1676440714.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 15 Feb 2023
        05:58:34 +0000")
Message-ID: <xmqqzg9ezvyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  	ret |= !cp;
> +	if (ret) {
> +		error(_("gpg failed to sign the data:\n%s"),
> +		      gpg_status.len ? gpg_status.buf : "(no gpg output)");
> +		strbuf_release(&gpg_status);
> +		return -1;
> +	}
>  	strbuf_release(&gpg_status);
> -	if (ret)
> -		return error(_("gpg failed to sign the data"));

Good.  As we are worried about error messages that are too terse,
dumping everything to the output would be a vast improvement.
Hopefully gpg_status.len would to be thousands of bytes long, and
this is not a codepath that is triggered remotely anyway.

Will queue.  Thanks.
