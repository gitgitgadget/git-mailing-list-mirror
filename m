Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F23C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 13:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477D920797
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 13:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=theori-io.20150623.gappssmtp.com header.i=@theori-io.20150623.gappssmtp.com header.b="iWdKxd+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgKJNRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJNRC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 08:17:02 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFECC0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 05:17:02 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so11380548pfb.10
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 05:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori-io.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8DAmbxVGFmPx19VVzfDDmd/ZPZuWTbkjNGSRAMcCP2k=;
        b=iWdKxd+KS5tuSOw4B5T1NlD3xjKFULFdzBBnP6aWyJKoQNj/ojxvtayrXAnXSSAXWX
         vk08luJe2aXdeBhvJ9uvKEMV0xm6ezpdKnVwW0/6EyD0ACsIL75iiJLgzDwvhnDWL922
         qgC0IBCZScJnUsnW11adTwhMoixy2mKgZN6+cVoZKd0UQ2+2fbePZGF6bBXgQHIsP1aS
         7TOqGgMSTNb46ZJ+rZSv7yokJmFVYA1GDtSYxQaF05NH38UcYENz8R22VSa7LIl/b4ZL
         yGWwHPW8nzaRjtQ+Quhy24ug/KqiqZKXe2PLIBDko25uajUqQFVls/i+jAKm8ZZV6IxQ
         x1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8DAmbxVGFmPx19VVzfDDmd/ZPZuWTbkjNGSRAMcCP2k=;
        b=t2RfouXS9bvR1GtBwnBZwYjivVRKsPdYCQF+Bk4lhtJCRwjPW/aaWeShx50WMXxKzC
         IX68OaDEPD2Yuqame4fa7uR49G1cevGvGbWayJcuyqTj9UK1jfMLj0uuEBAPxfr3xOND
         LA7/fpFxqxaf46VF4D2/q0Vxm2o3sN16p70uc5SbHdbOCu3xtyq4TDwUPI3+rOKoxbUx
         CkVkX5qJ6O9j5YPz+5MncV756RIjGIy/4KtmWkodj9AmrAX3wmO7dNqA9VcdlZO3JrKq
         5xFnOAMMhVMZYJwGWXWvZ8ng2c3jlnKCZ34+5atsJFitkhPmkvXHVQvAGX2HEA2osZrJ
         iJvg==
X-Gm-Message-State: AOAM532gbwkap4x/MP4+3mFOOpPbZaOGLTlGumlEn92M7lkZXtSw6tiH
        LBTK+IcKzY/CdorWcLpDgVV646obDJVRuA==
X-Google-Smtp-Source: ABdhPJwY4rUF96JM1ez4EAc5WYelJlltrJnfCp0siGNNBl2bmiRsxhx6g1httJpm7N+ZqCr1CI3aFA==
X-Received: by 2002:a63:161a:: with SMTP id w26mr16583494pgl.17.1605014221686;
        Tue, 10 Nov 2020 05:17:01 -0800 (PST)
Received: from [127.0.0.1] ([222.99.114.187])
        by smtp.gmail.com with ESMTPSA id j19sm12173854pfd.189.2020.11.10.05.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 05:17:00 -0800 (PST)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io>
 <xmqq4km4lppy.fsf@gitster.c.googlers.com>
 <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
 <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
 <nycvar.QRO.7.76.6.2011101257540.18437@tvgsbejvaqbjf.bet>
From:   Jinoh Kang <luke1337@theori.io>
Subject: Re: [PATCH v3] diff: make diff_free_filespec_data accept NULL
Message-ID: <17491ac3-ce1b-ca5d-d4e8-9fa8ab72d7e3@theori.io>
Date:   Tue, 10 Nov 2020 13:16:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2011101257540.18437@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/20 12:08 PM, Johannes Schindelin wrote:
> Hi Jinoh,
> 
> On Fri, 6 Nov 2020, Jinoh Kang wrote:
> 
>> Commit 3aef54e8b8 ("diff: munmap() file contents before running external
>> diff") introduced calls to diff_free_filespec_data in
>> run_external_diff, which may pass NULL pointers.
> 
> Sorry for the breakage!

No worries. Those functions were indeed confusing...

> 
> Maybe the commit message could talk a bit about the circumstances when
> this happens? Of course, I (and every other reader...) could analyze your
> patch to guess what it is that triggers the bug, but it's really a good
> use of the commit message to describe it in plain English.

Agreed. The v1 PATCH, which was off-list, did explain that NULL filespecs
are used to indicate unmerged files (i.e. with unresolved conflicts).

> 
>>
>> Fix this and prevent any such bugs in the future by making
>> `diff_free_filespec_data(NULL)` a no-op.
>>
>> Fixes: 3aef54e8b8 ("diff: munmap() file contents before running external diff")
> 
> I am unaware of any other commit having a `Fixes:` trailer in the commit
> message. In any case, I would have expected `Fixes:` to mention a ticket
> or a bug report, not the commit that fixed _a separate_ issue (but
> unfortunately introduced this regression).

Sorry for this one; somehow I didn't notice that git and linux use
different conventions.

-- 
Jinoh Kang
Theori
