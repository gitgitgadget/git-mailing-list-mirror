Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D007C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 07:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D90061AE2
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 07:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhHPH5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 03:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhHPH5a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 03:57:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFF6C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 00:56:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a5so19843139plh.5
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 00:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rsrdApOgaPx2NYqZ7AJD7ELG7km9g09cia/iBhtPdhE=;
        b=TWrThekLySDqm/Mc2pjPLrEUPtgoadrsQkbPN6g3ufl1RycEzfSCec1rTTWcxJxB8k
         QGsFLAr3CZSCxrYrda0mpSRzx2HIGRt7GZXW6fpppnvOhmSA6HGun7j0Q5jxEhzhX9a9
         clshGK7I1OOS2osPyHV7fPngkoVp4h8D4GsHDFct1/+Z4dpjHUGuvxpk6MZCA4VVCPJO
         WGcgqBKriASnYydVfg9N7Bck7U/BZjACTz/aQsRYdlGhsW7xdYmmtMFVF0fNrHjtvJ9z
         sBt12NRGVMukD9xvuQIcX61G9E7d7z0ECpvY7fQ35di0vgUugL1gFlAg0CS8CI1Xsemn
         sjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rsrdApOgaPx2NYqZ7AJD7ELG7km9g09cia/iBhtPdhE=;
        b=YbAlMav4Gr5cV/NugC3JNDVPFCEym2TqQnJZ0bLM6sfms0TZX6RkcKrlkYhpKI4/3J
         j3yj/IEw70yLpEsTeSv92f0r+mPUSNKNBOvRY+S9Q/1aA39cBShLSnp1um6KC4NTV84i
         vY43N3+PpmiZjL/IKL3JEZmic7Ql5Sg59NEGQngVs39w/zlp7uD6yyFILpNptg9lxaWV
         gPEOwI4gT1KlmOmP+h3gTQjuiBALyIWNM8soB+XN8r4Tca0+rOx33PsAip4dz1JM2no8
         l3OJVk6bi0nBlGL+WImW9QkfB0TvN/ZL6oEguHXIpYde208xq51JvimQsZi+98LwJJd7
         a5TA==
X-Gm-Message-State: AOAM532itxzh0Y0fLk4r3yfc++VszmG8FPFZ5iC6f9MtHY1LKy9ZhOmf
        RHEsE4bkbRJWEbVzMzG7Nt3QoZVxomY=
X-Google-Smtp-Source: ABdhPJyrc0xLOC6foPBoMZHuwvqS1MQTUUJgNeY2hOV8hwO37uXFV/kD6n2wF1tCpRimt46pmODFZw==
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id m1-20020a170902bb8100b0012da7ec3d85mr8292307pls.17.1629100618741;
        Mon, 16 Aug 2021 00:56:58 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id t22sm12074638pgv.35.2021.08.16.00.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 00:56:58 -0700 (PDT)
Subject: Re: git format-patch -s enhancement
To:     jim.cromie@gmail.com, git@vger.kernel.org
References: <CAJfuBxxT_7weC8_O=KYScSbDcSeBdb3v5d_gtn-NXzW_fKLrsA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <c308b4e5-066e-d0d8-ac14-5769d1a47684@gmail.com>
Date:   Mon, 16 Aug 2021 14:56:55 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJfuBxxT_7weC8_O=KYScSbDcSeBdb3v5d_gtn-NXzW_fKLrsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/08/21 06.07, jim.cromie@gmail.com wrote:
> hi all
> 
> git format-patch -s is sub-optimal :
> it appends the SoB,
> which falls after the snips
> ---
> changelog ...
> that the commit message may contain
> 
> 
> So it misfires on any maintainer scripts
> expecting the SoB above the 1st snip.
> 
> The workaround is manual SoBs above any snips.
> 
> I note this in -s doc,
> 
>             Add a Signed-off-by trailer to the commit message, using
> the committer identity of yourself.
>             See the signoff option in git-commit(1) for more information.
> 
> "trailer" is really "document current working behavior"
> (normative docu-speak, so to speak;)
> 
> Ideal behavior is to find 1st in-body  --- snip
> and insert there
> 

It seems like you don't tell us what snip means. Can you describe your 
environment and reproduction steps so that I can reproduce this issue?

And next time you can use `git bugreport`.

-- 
An old man doll... just what I always wanted! - Clara
