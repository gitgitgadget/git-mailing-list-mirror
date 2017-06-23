Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554F720282
	for <e@80x24.org>; Fri, 23 Jun 2017 15:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754412AbdFWPO0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 11:14:26 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33099 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdFWPOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 11:14:25 -0400
Received: by mail-io0-f196.google.com with SMTP id j200so7297725ioe.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f/lq8pRUqYWanyr1gazhpZcNnsnEPv8XWC6fpop4oZM=;
        b=lIArjTe67Qf0W/FYPpYvnEWRvQ643O6d0lwZKHffeVHQJkFmK2DVZKPS9gk5nBpoQE
         dPQSBCTBm0I4+g0/E2dvxwF+Sa9/waMI2b9JeFngwJuD1sa8Po76Q67i3mmDyjeasMce
         /l091AUJJpDgdtQQ1PCxJUOxL5ECLWo4wA+TiA7ENndmrjfrndEAwbbQnEeaAfGBzAGm
         Wv++1HpLRFbjRivtzfmLGRi4DB+wgIhS2j7uH0/wgMZs01j110ecYVYIePR344M9O9tp
         fnT64i+RMlF4uSW1joutNSWyntUoQPTFb4PgmPCpE61nyr7FEddvJ1H1sMGRNdqCXOKo
         IxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f/lq8pRUqYWanyr1gazhpZcNnsnEPv8XWC6fpop4oZM=;
        b=onx6LXdHktR6LFUoTbH/RDx3CXhPRS2/49KjwhPdyjG+kghrdc6N6OJ3EME3w6b019
         gliY/7DnwlFU7TrZzh5ojdH3PE4vdcFAWuYys03l7hZGDwPYaqMIKaSjTE/NYvpbBmYR
         w4JhPAyIjqkvu4pbpFzbwyhpIBdZZ4AipHb597hP/s0VmXxxvc1wXAEmtR5/0LwiuxzR
         npXS+5lwm91VrVVRsYwJcCJYlsWEdsouV9+DVRUH6LaXV6Qdiq+ZfOM5UQ4wqcFFK7Bt
         JBKWFdZ2G3k07T3krECvsHVLVPUr31XERUOf2czviBHCYvIJ3AVZ27i5zV9zIBqmDVkQ
         CVxA==
X-Gm-Message-State: AKS2vOw5F/nkjvjVqf8rju5RzQMtUt9Yhb1MNFTtEB2otf4qCwKBpmcB
        ZgpGJAhPkAjb7VtrpWm1WuqwBuVUdQ==
X-Received: by 10.107.145.86 with SMTP id t83mr9067633iod.129.1498230864627;
 Fri, 23 Jun 2017 08:14:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Fri, 23 Jun 2017 08:14:24 -0700 (PDT)
In-Reply-To: <xmqq8tkjkdgl.fsf@gitster.mtv.corp.google.com>
References: <20170622190158.13265-1-chriscool@tuxfamily.org> <xmqq8tkjkdgl.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 23 Jun 2017 17:14:24 +0200
Message-ID: <CAP8UFD0OrPW+CUiXHBCXjumG=VOkpjnQFe09=UT9W0ULXE=X=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] read-cache: use shared perms when writing shared index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 9:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:

>> Let's fix that by using create_tempfile() instead of mks_tempfile()
>> to create the shared index file.
>>
>> ...
>> -     fd = mks_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));
>> +     fd = create_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));
>
> So we used to create a temporary file that made sure its name is
> unique but now we create sharedindex_XXXXXX with 6 X's literally
> at the end?
>
> Doesn't mks_tempfile() family include a variant where you can give
> custom mode?  Better yet, perhaps you can call adjust_shared_perm()
> on the path _after_ seeing that mks_tempfile() succeeds (you can ask
> get_tempfile_path() which path to adjust, I presume)?

Yeah, adjust_shared_perm() is called after mks_tempfile() succeeds, in
the next version.
