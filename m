Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A9D1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 18:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbeGQSxV (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:53:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56260 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQSxU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:53:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so295207wmc.5
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fUvVHDBQjNRJl55o49oKT75B549XU/VZCpuroS3p6QU=;
        b=WtSadX+rjRgxzB602lj4D3fxU6p/rYPh/PpgEl0igoDH4ZBq3ne1yF4XrYgSnEgLqV
         Ba6NFWYjs6XIOlRbJ9GmGfzjAMEKSs0b/1AjRxZse5iRyqWJVUt90QcSpTY86178LXNO
         XL0MN4I5ACYGqaIgHxctco8QVe6IrsUTdjl6ZkvxJ8TLzysFIJZZpAGu0/KhBzNTiwcX
         zx6RLXMu9fFKN6/ty7YGCvyKGW+h60B77NRFK2YbiXJ+3ieJuX66jLyZ1wRBiH/5tElT
         16tdn31NpkP3GunRBeD2BCgXyuNz4zPqal5HILAT/e96b/TFmHjSw2O+V5BRxokY8GrE
         ud7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fUvVHDBQjNRJl55o49oKT75B549XU/VZCpuroS3p6QU=;
        b=mPgakUmdDgFX2Ah2R5XSf/F96pHneZM3iUVjQraPJahfXoOnlLXQaOV1ulYDlJ1jhr
         h0GCxZ9mIQCXncEMRFinsNTB1wZlnV2Wa70xR+n3Sj1Cs6t7jIt8wvboHL8st1RzfDOd
         zBxiRuMSgiqSAZAu5LwWMFjGUPwewlerppbSOSqLmDSoQVDFIr2pjWlod81Z1qv6j9cn
         RCaPDmI3uopXDD+rKo2hH3wzHZhpyAtkAw301DSdBoEp1Dybw4DOi+Z0U0EJc6c9cyTM
         cC22sJtMBXFVLGXbWoKMi715hgQDL7agdhidOTi6t5AidLN57y23or5qMJJpSEta8jrv
         y0lA==
X-Gm-Message-State: AOUpUlHdfxyxia08oxnP7AHvRWPSnyPLZX20/m0sO6AcdAt9QC0uGqyE
        wY40JwtGryWOJxO/CZnIjnMfJlai
X-Google-Smtp-Source: AAOMgpcyZdQ+RqS8jWvc0svYg1qezgLZCkulRrD/NzcjMdwq6Rr8Pnnj64l68iZVmStBeiU0hwlHTA==
X-Received: by 2002:a1c:6b90:: with SMTP id a16-v6mr1974162wmi.74.1531851569499;
        Tue, 17 Jul 2018 11:19:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w9-v6sm2429069wrr.77.2018.07.17.11.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 11:19:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] gc: improve handling of errors reading gc.log
References: <20180716172717.237373-1-jonathantanmy@google.com>
        <20180717065151.GA177907@aiede.svl.corp.google.com>
        <20180717065321.GB177907@aiede.svl.corp.google.com>
Date:   Tue, 17 Jul 2018 11:19:28 -0700
In-Reply-To: <20180717065321.GB177907@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 16 Jul 2018 23:53:21 -0700")
Message-ID: <xmqqy3e9ohcf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> - avoid being confused by a gc.log larger than INT_MAX bytes

;-)

>
> Noticed by code inspection.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Looks good.
