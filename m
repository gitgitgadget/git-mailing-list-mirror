Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86620C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 07:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BCC861458
	for <git@archiver.kernel.org>; Sat,  8 May 2021 07:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhEHHxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 03:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhEHHxc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 03:53:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BDC061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 00:52:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id y32so9013834pga.11
        for <git@vger.kernel.org>; Sat, 08 May 2021 00:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=D3Vc5rPGA6OvpMEGfhCa06m1ZtnhBjy3JfhsiFy8V9I=;
        b=uLfH/HP0oxfo+VRqC04gY1C6oDCGnWOHigUigz0MdPdjdSXEZSSbF5RdqlxJWQDlVH
         V+Tc3BpD8pQ+Bu4o1b/H8mlxqTShLWoBWt8CNKszIbvJulSle0YrhWwVfZay+4VessdP
         ihbAConPPik5fckAATEP8w+4QYC0OQ4wv5A2mzm7UXlYGeNpnNrOUeWhllEiwrNCesPZ
         XBNE4E+DPwVIhVq8pmP0JoNX066rwA/qziwtXzzLULjZE3GL1YOfeGXk9NPqH3KRc1B3
         RWHkI4i3H5I4U1/Ss4gZiKG9kBtmuMFO5Op6tri604PsdT17HW4TR2Y1ZM88bgniiseU
         4OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D3Vc5rPGA6OvpMEGfhCa06m1ZtnhBjy3JfhsiFy8V9I=;
        b=LMynzBQ6rZcQa2AeiaqQhKzDLlax8eAaFsL8FhjXT8z+E8cNXCATK72Pp7rtLqqWEH
         oLD6z2afRhr8JwG/5+MO3cQepMNhu4ifV5WYfKeqHsgi5bv4SzsGQ3A5IxQEMzvpOLsC
         oWMxC8/aPL61Q4xhUTFpzml75mVEjOBYSjTPiglvuvwpYhKkvEzkwFdQgjeNqPxNyp0y
         71GO6xnKQ9lTGcTuasnU4dN13ZZTWBlb80GIvXMQnJ2JTTloH3nFF41MKRcwOPz+vURn
         Wnvv0elXifBebREt1+5opbo/kKS0RlpzYBlJUvitjunwLHrf/R4rwxL53SBZUNFqc1SW
         zKTQ==
X-Gm-Message-State: AOAM532CHPC42+A5p3Jyd9OAKLuiw2M+1FnapVtzSAdRQ1cUurP40z30
        PyRyWYMYGKTpt4qQ7gJQtyY/D1OIHzYEZw==
X-Google-Smtp-Source: ABdhPJxEMy8mMRYB24upgPrcQB386zVxGhgLxNswiahlk/g/ugBXbGHzUM0e3qcHsMlGUoMoQhSBJg==
X-Received: by 2002:a65:40c7:: with SMTP id u7mr14350383pgp.29.1620460350681;
        Sat, 08 May 2021 00:52:30 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-32.three.co.id. [116.206.28.32])
        by smtp.gmail.com with ESMTPSA id c13sm8021520pjc.43.2021.05.08.00.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 00:52:30 -0700 (PDT)
Subject: Re: [RFC PATCH v1 1/1] Modifies documentation for universal
 cryptographic signing
To:     Dave Huseby <dwh@linuxprogrammer.org>, git@vger.kernel.org
References: <cover.1620454449.git.dwh@linuxprogrammer.org>
 <c454bcc4c3c5de1a17c63461c6091689098c75b9.1620454449.git.dwh@linuxprogrammer.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <94624d84-be7e-016b-50f2-90a4c423be42@gmail.com>
Date:   Sat, 8 May 2021 14:52:27 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c454bcc4c3c5de1a17c63461c6091689098c75b9.1620454449.git.dwh@linuxprogrammer.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/05/21 13.18, Dave Huseby wrote:
> +In mergtags, the whole signed tag object is stored in the field name

Oops, s/mergtags/mergetags/

> +The `sign` field is very similar to the old `gpgsig` field in commits. The data
> +is can be multi-line with subsequent lines starting with spaces to mark them as
> +additional data. The only difference is that the `sign` field stores signatures
> +with newlines and carriage returns escaped because whitespace is significate in

Oops, s/significate/significant/

-- 
An old man doll... just what I always wanted! - Clara
