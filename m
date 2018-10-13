Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E8C1F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 08:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeJMPod (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 11:44:33 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:36514 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeJMPod (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 11:44:33 -0400
Received: by mail-lj1-f176.google.com with SMTP id p89-v6so13264645ljb.3
        for <git@vger.kernel.org>; Sat, 13 Oct 2018 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=o5GsQ3ke8XCKfJgGdWCEFCyp/MUTweVqRuBa8dZw/so=;
        b=TYa2XiiADDAdtYMvQFJj4mfiSN3NoFrHWaX4ymyVsZ+cUXCJ2qBTQsiYTkxQlXry3P
         CVlGcklzrwQxTyQMkbwj5A2iaibL0JnPtJ9fg4ltj6vg38W4H1MiJ1jvRMQy4yG/2EjH
         ffAzwosfQGnG4KqdPJCtf3Y5NY8EFB+YlDdtPFWA3Uuq2iOLxloUXLncZEDiuo583drW
         gWUH0X85yTTkim5x0aZqLss2WwUR6qrRRfUlcCT+zWKQtW/AreC+YM4tTx/IxJfg0KKv
         ZG2PHKeNoT9UmgJg609oKc8xBKOHB1Txa2M24VX1ryEUyIx8DWEUVGeQ3FcQUKuowRO7
         iLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=o5GsQ3ke8XCKfJgGdWCEFCyp/MUTweVqRuBa8dZw/so=;
        b=QWAmf+LvYxkvomug07icvAr0gPDNRnu1xi+zycWQ6Woet+cX6H6P/11QApZCHMQPNG
         cjVWigiIhumPPoP36WRjXPZfaW1k+kQ6RZYVt6A+PO2m6mX2wGbfASWuyQSHjHB7yisp
         Y3Y0sC/jDBkvYunAokyLFSw6IUbMKYEDnX2FFJZVXpxp22Bf9Qd6MYTs29aFSsFU8c/g
         PxrBYZh+EHZ8SAbFRQC/EAbGThf3JQJBRNMwymv53RsRA1cVuzRYHHgYVkwyscPYDPe/
         2eRPLS3IduscMRkYw0BJgkaCuQaEoqyqVmSFKC+kBfxnJSDY1oD5WhYy/hh6IWQug/2O
         oQPQ==
X-Gm-Message-State: ABuFfojp/oWuOQ98zClMDNDqT7QeuGQ3TVoPGi1oXNHht3onlprs+eoS
        Ut+HHagCSWNJeDJ9ZAHCXm0NaQRh
X-Google-Smtp-Source: ACcGV62U8BG/Cy5J2Z5yFzSm48cseCf/TdyqriFYrNGSrMfiQwS7JMTGCnjb7ltRx/VVOR/uW5TfZQ==
X-Received: by 2002:a2e:4e01:: with SMTP id c1-v6mr6385134ljb.157.1539418099579;
        Sat, 13 Oct 2018 01:08:19 -0700 (PDT)
Received: from ?IPv6:2a01:110f:d32:a800:abd5:65cf:ddaa:57c7? ([2a01:110f:d32:a800:abd5:65cf:ddaa:57c7])
        by smtp.gmail.com with ESMTPSA id w202-v6sm737167lff.71.2018.10.13.01.08.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 01:08:19 -0700 (PDT)
Subject: How do smart git helpers transport objects?
References: <100fc0a7-a7fd-e6ba-937e-f795b30b3f35@gmail.com>
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Stanis=c5=82aw_Drozd?= <drozdziak1@gmail.com>
X-Forwarded-Message-Id: <100fc0a7-a7fd-e6ba-937e-f795b30b3f35@gmail.com>
Message-ID: <79cad128-383f-9a9a-cb53-6089afa36081@gmail.com>
Date:   Sat, 13 Oct 2018 10:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <100fc0a7-a7fd-e6ba-937e-f795b30b3f35@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm writing a remote helper and decided implement the `fetch` and `push` capabilities,
but one thing still remains a mystery for me. Namely, is my helper supposed
to instantiate and pin git objects in `GIT_DIR` upon `fetch <sha> <ref>`?

In general I'm trying to determine how exactly I need to proceed upon receiving
this command and find out whether libgit2 will be able to help me with whatever that is.

I'm also contemplating hooking up to libgit2's transport API, but IIUC its operation isn't
very well suited for the backend I'm trying to use behind the scenes (IPFS,https://ipfs.io/,
long story short it's P2P and doesn't have a "server side" per se).

Thanks,
Stan

PS: If my libgit2 questions feel outside scope I'd gladly join a community more focused
on libgit2; I'm already on #libgit2 on freenode, but there's only 11 people there ATM

   


