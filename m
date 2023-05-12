Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4FDC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 14:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241075AbjELOz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241621AbjELOzT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 10:55:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637219ED2
        for <git@vger.kernel.org>; Fri, 12 May 2023 07:54:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b51eso32019375e9.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683903288; x=1686495288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xhQ+ne+KZHiLstURVTh7dvKgRH0QWFdK/kZvMwpqN80=;
        b=kOELvZ4V5OrI+dE+9cdk88kcmlLcW6H3c3Y/PuzhJpJdnwCUmeebjweGgOu5ld0xjI
         qHPHGwqpMPnplEGL7KT3iRgKjb8pWyOhPu0S1622scrW4xL2BF7Om2/pdd0L1BEctxEp
         +LbD1DGZPe+dgEKkLIu6a1v5GMdWGjIiIKZC9Ma+2DhliUM9rtmycY+O6n9cheMExJ0r
         2JIMigRNzo/I4XpHhaQ2DuvldVSyUeRu6E69YJ4yX/retD672Lr7oWPmCe4dWWkyjYe6
         NFXLh7IR8WDPtdSnV2cGvcnJ9IlfKh1PuB9tSYVINqJumK/jhYdgBb398wpBYI2JtYIY
         B48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903288; x=1686495288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhQ+ne+KZHiLstURVTh7dvKgRH0QWFdK/kZvMwpqN80=;
        b=fNPKcDWu12Nh5uilhuKySOzsiFRt22Lf2n8lWLiOjcNWcIux+v805t351Xqy50pndW
         flJumyEhmNGGamehDJooTdFenp8hweeR3SGLfSamBXJc2/7g/yhDeeNev9fjhuX7FWAY
         B0Pa/A4VPvBlRdmjYDVPDNHz9gUPzsYl9FEUGUme6TKchFZdSeHxI9EGFryKMywI4Osf
         ZoB6vOs41jTKcq+37h1QEcW1LL8Ov5UOMGmiWP8xXH8zcGP0hVvF9nmuGGV0LCttA/hg
         b8U8QM+5363teA9lf6axiuW6zIkR+l88UB3+Cx8ZSZgqkaxFPi0M9WpjlTH2f+vCeqEz
         nEpg==
X-Gm-Message-State: AC+VfDw3EGqZO0nrntY9xdRTfwEVN2TIlsztrcnG3LHjvbEbTR0GxCf9
        0AcgwKy4fwkCdIYtgWNq8xk=
X-Google-Smtp-Source: ACHHUZ42PuzCE38jr9UYMXEqD80hjk22AlLPzmdobAJvHBSH8y5qdNcJUCjnO/1OW51tKytEcUDcxQ==
X-Received: by 2002:a7b:c04c:0:b0:3f3:4147:3048 with SMTP id u12-20020a7bc04c000000b003f341473048mr17306644wmc.10.1683903287804;
        Fri, 12 May 2023 07:54:47 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id h14-20020a056000000e00b002ceacff44c7sm23688173wrx.83.2023.05.12.07.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 07:54:47 -0700 (PDT)
Message-ID: <215b700d-6175-3527-857d-4347bb4efb95@gmail.com>
Date:   Fri, 12 May 2023 15:54:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 7/7] strbuf: remove global variable
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
References: <20230511194446.1492907-1-calvinwan@google.com>
 <20230511194822.1493798-7-calvinwan@google.com> <xmqqr0rmtuid.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqr0rmtuid.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/05/2023 22:42, Junio C Hamano wrote:
> Calvin Wan <calvinwan@google.com> writes:
>
> So this step, while it makes sense in a vacuum, is a cute idea, and
> is nicer in the longer term (because we certainly do not want to
> have to pass an extra parameter to the function), raises the risk of
> semantic mismerge higher for topics in flight that do want to use
> stripspace to remove lines that are commented out.  My quick "git
> log -S" seems to tell me there is no such topic I happened to have
> picked up in 'seen' right now, though, so it may be OK.

I just grepped seen for strbuf_stripspace() and it looks like all the 
callers are converted correctly.

Best Wishes

Phillip
