Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36758202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 14:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbdKTOBw (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 09:01:52 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:39759 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdKTOBv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 09:01:51 -0500
Received: by mail-qt0-f182.google.com with SMTP id p44so14807599qtj.6
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 06:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q/pqlnMYEuA1K7o8TJ2hi5Tx8HVyTCC7aQSLWOHF6EM=;
        b=Rp42V8qLdZ0fuWE/oHigarQAl82+GGrUaOrx7XBhASqxzCxA5+hOmj7fPU2pFDCxQF
         qmfbOALsexbgh0GjRK6LQ1ApNbBIagxGCq/pzk2xzvhi5g4aPUyNbFxFVm/5TtabJhnG
         F37inODPmFIGLq8YquOFTUYL2G7HWkr0+s11OwBx3tYRyzy3ltjoqSyjLtKLQtDXD1CP
         92bbD8NoRwViWRZUn55Th+4aIw1vyyiObH6cFhpStojfSqRybyFnOiCuk5IUc1AE3/uZ
         ECMYV5B1/30W8EP2M+P1ZeQu3Qczy3l7CVdTFzm5m6U4Sv9lE6M9lSYHqGgQ/sGH5sjV
         1BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q/pqlnMYEuA1K7o8TJ2hi5Tx8HVyTCC7aQSLWOHF6EM=;
        b=pGUtvtc5+1++TPgLzVqOl9FhNlnpUMlgDkKTGBtvDYwQ2wAxRIhs7Dcx3BZtW/vxPs
         yYH1XCav/OmalqaPArBsktaHQAG8Zv/yhGd5uXMNEnAbop0kqISeP9s/SWaYnZ2VMtw+
         1SVz2sgKJ8jZC5gf7f+3fOhNqqRsbd9mLZtIPN0P1eP4N0RCFJ/afFDSk5z/WcFr20O7
         yrJ5LgTwsvwka/VeX22lAzFD/lLkXlCuG0Wf3q3h1sF4phy6sJGZIcr8fz/K/tBWGnZv
         kTWQieCaOVxW+j8M7b3NtVMIyYwpOgC0O/49ygRIP5N9+gC1Wx5wfVwhkHfS72muQiRd
         N15Q==
X-Gm-Message-State: AJaThX5jyN/mtpi+TUlIcqOKKDETQU9DN1TEJFsoBZMVwimxRy4E8FK7
        Wy793pV3/k+UpSeA7E8UPks=
X-Google-Smtp-Source: AGs4zMbFJYnZtCfyztaAUyK5CHjbdCIy+8KWVhs7Zvt0crdnyqRmr2YEu2GUjMbiy6cNVKbwyluTVQ==
X-Received: by 10.200.40.54 with SMTP id 51mr21675420qtq.339.1511186510289;
        Mon, 20 Nov 2017 06:01:50 -0800 (PST)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f142sm7407899qka.6.2017.11.20.06.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 06:01:48 -0800 (PST)
Subject: Re: [PATCH v1 1/4] fastindex: speed up index load through
 parallelization
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net
References: <20171109141737.47976-1-benpeart@microsoft.com>
 <20171109141737.47976-2-benpeart@microsoft.com>
 <xmqqbmkahhar.fsf@gitster.mtv.corp.google.com>
 <7e5a9fde-67fc-2bb9-51b6-54bdaed162db@gmail.com>
 <xmqq7eut8y36.fsf@gitster.mtv.corp.google.com>
 <7428e41e-b705-f377-1951-b11af851c4d5@gmail.com>
 <xmqq7eus3nr2.fsf@gitster.mtv.corp.google.com>
 <73fd93cd-91f4-1286-732c-cd8185fe2027@gmail.com>
 <xmqqwp2s1h1x.fsf@gitster.mtv.corp.google.com>
 <9ba23d2c-2198-55d7-5a02-69879fbbb3cb@gmail.com>
 <xmqq1sl017dw.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <92b0b0ff-6878-003a-b26f-3b4c2c857be3@gmail.com>
Date:   Mon, 20 Nov 2017 09:01:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq1sl017dw.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Further testing has revealed that switching from the regular heap to a 
refactored version of the mem_pool in fast-import.c produces similar 
gains as parallelizing do_index_load().  This appears to be a much 
simpler patch for similar gains so we will be pursuing that path.

Combining the two patches resulted in a further 25% reduction of 
do_index_load() but with index load times getting smaller, that only 
resulted in a 3% improvement in total git command time.  Given the 
greater complexity of this patch, we've decided to put it on hold for 
now.  We'll keep it in our back pocket in case we need it in the future.

