Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1826DC433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 19:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90EB208B6
	for <git@archiver.kernel.org>; Tue, 26 May 2020 19:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqynxx6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392314AbgEZTZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 15:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391649AbgEZTGe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 15:06:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87DC03E96D;
        Tue, 26 May 2020 12:06:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so2146745plb.11;
        Tue, 26 May 2020 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GRcaB+mIzfLDLlFG78mKyVuPh26Fe+lvp5hkpJeot3s=;
        b=Nqynxx6PjGvEUZ1vtdBukxxUlM6ZSXnf+QzDLWfl+huq9Bf6ZSVBiPnYfUBC9Dm8qI
         /YHuV8Ukd1QPbrbMm1BaQRDqMZJKOKzQBA795QM0k1YDFT0WAC+i7zjw2PRJZiDXDdQ2
         BbUxqeqtNKM1TJTdMA7ERT3IRA1HFK6NQjZ2X3X33quoU+tMoTGq+FbMWjPuRbPHSSfP
         u22Kd9dK22J+1vfq2qmx6QYQvBoBhUhts04C/Ya9NKP6eL67/4Dn9Cl43sOvYNNasjgi
         7b266JVDDOmQQgGmWUcj6idaoJHHU6hTILO6Z9oYrNUIGCN3PjGiQYRAWASkHnSdhY3X
         xGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GRcaB+mIzfLDLlFG78mKyVuPh26Fe+lvp5hkpJeot3s=;
        b=e3qDmNQ5ewExzFSuFpCrQqPt680oaerEbRKvlQ7O81qMi0OWWRscMT5T0rd1CMbuuP
         Dg0qgn3dVIwc9mKTVgm4PcjXCnZzXExBt3c3v5Mm8CJHH6Ur8dpJR18Ey9qKjACISNAr
         ufeo8oYG7yI2BmFtYHsliA/9obSQ/8CCqCZTMh/T55mOmPKzlVAdVojIq8NRQCA/maLt
         yE8+l2VU3d5hUA366bhXwqsHYtw9bb+5IE07ZGFTGnqko2n6qPKWD2R9RtQyUvDsEh1p
         iEjMwO3zWyv0+PNkhbn47U3QWiUSea8vyI8Ug7fTzwdmRCnJZ/ibF31Se4C6yBl2YRXc
         38Jw==
X-Gm-Message-State: AOAM530j0twft7uQg8u+v1iw1FWjzr2L79imGHmfXfTJkISkS9R8Gc/F
        k618p2qJlG7ZvAO2vANQQ3o=
X-Google-Smtp-Source: ABdhPJyj7v5wDj7jxE/+gZB0RtFsKRceZTkA3pyRGaDUaeRtW5SFdh5wW2q4rDfjAwUOuIi02wPtug==
X-Received: by 2002:a17:902:47:: with SMTP id 65mr2284406pla.54.1590519993316;
        Tue, 26 May 2020 12:06:33 -0700 (PDT)
Received: from [192.168.208.37] ([49.206.126.69])
        by smtp.gmail.com with ESMTPSA id s123sm242456pfs.170.2020.05.26.12.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 12:06:32 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.27.0-rc2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <xmqqtv02mt2m.fsf@gitster.c.googlers.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <e66ea483-5e7f-4ebd-5ba8-91227efa454a@gmail.com>
Date:   Wed, 27 May 2020 00:36:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqtv02mt2m.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 27-05-2020 00:17, Junio C Hamano wrote:
> Shourya Shukla (4):
>        submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
>        gitfaq: files in .gitignore are tracked
>        gitfaq: fetching and pulling a repository
>        submodule: port subcommand 'set-url' from shell to C

This is the only place where the `set-url` conversion from Shell to C is 
mentioned. I wonder if it's enough or if it needs a little bit more 
attention may be in the "Performance, Internal Implementation, 
Development Support etc." as it is a conversion of a submodule sub-command?

I'm not sure about the importance that these kinds of conversion 
require, thus the question :)

-- 
Sivaraam
