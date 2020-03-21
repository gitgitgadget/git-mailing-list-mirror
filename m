Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD54C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1134F20775
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvKj7BQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbgCUSfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:35:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38875 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgCUSfx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:35:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id z25so807063pfa.5
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1GDjsU4TCBoO6IsVYiABTm5B0F8REj+jQBvMeymTSEQ=;
        b=tvKj7BQu2AcPNKX8Bf96cqBqhxts6bHh0eFUlKRdbd5OmoFQ68/rHIz4lXXvNX2JDc
         hsjfa4ShYGMAl6Fep+pMBaenuN0E4Eyq6d9cF5/mBX08CnhQ9QFAVMa4FsDQQIxvokxb
         UqWu4BChTDKpkuRM4sJTQA8t1bde8/iY+wrErMDDRwq8gk0Y1+8HeoxipDKLcd7jpvAc
         HUWHYCBz4cRM9Y438J0CQ5vIhbFfXK5D0q4l6gsuKRTzKH3smjMaT5juHuqm+dW/49Mb
         lBbOy5wNaIH7ve2P6t96Hzzz12aLXBn7AaElmOtzGJAUSZRrMxQfnOF4ufz5a/Zhik3j
         c0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1GDjsU4TCBoO6IsVYiABTm5B0F8REj+jQBvMeymTSEQ=;
        b=blmM9KxZqyetnnhPnJAAW8hxnYRwUSocqXQLbNbC1cxexXAWKDSfV/EljCNEVsKImQ
         Kf4ga+gk/Ycnc5znDg0XNY0WlTmYMEenLD4GahbFFJzdlXfvMCfXISJWGBim1no7MFqd
         0k/r/Hy7AKFTkVwA9uuCb9JKa6CY0KIzXtEyT5pI0jgXwq/s2tWblyJ+3+oOFJjz9bjg
         xdoX1kp6evSRMz4cdoTWjeNxmMfXVEtlkNwXK1g0kt2SOsf0wdpB+YrI1EcU4QL7kqsc
         mNFKsIGDC4hT2eEbtxfmFQhMzx3A4Igzzxg/aLW3ijPDdftfaWRbbu865u6SaFGX7I7G
         v1gQ==
X-Gm-Message-State: ANhLgQ1P7OZQtlcZe6lLWMMaAW9l2GlAwEhhDsf66WvyqYhuaj6czpHq
        C8bjgjg7QPAjxfwcS2dJGtmhhCKqrQc=
X-Google-Smtp-Source: ADFU+vvHFYG2Kp/GYBa4rj+oIGdSNFleUCUALKL5tQrWiXnK7DZh1ZJm8p9WkjkkRAz7PdVFmee0Iw==
X-Received: by 2002:a63:5864:: with SMTP id i36mr15291197pgm.426.1584815752390;
        Sat, 21 Mar 2020 11:35:52 -0700 (PDT)
Received: from konoha ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id f3sm7784587pgg.46.2020.03.21.11.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:35:51 -0700 (PDT)
Date:   Sun, 22 Mar 2020 00:05:45 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jnareb@gmail.com,
        christian.couder@gmail.com
Subject: [RFC]rev-parse: rev-parse.h does not exist for rev-parse.c
Message-ID: <20200321183545.GA17453@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I was writing the C code for the summary subcommand of 'git submodule'
when I came across this:

I need to use 'git rev-parse' in the main frontend module_status()
function. Now, instead of creating a string for the 'git rev-parse'
using 'argv_array_pushl()', I thought maybe I could call 'rev-parse.h'
and use the 'cmd_rev_parse()' function directly.

The 'rev-parse.h' file does not exist, only its .c counterpart does. Is
there any reason for this? Would you advise creating a 'rev-parse.h'
file?

Thank you so much in advance for the help and comments :)

Regards,
Shourya Shukla
