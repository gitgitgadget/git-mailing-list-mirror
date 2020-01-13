Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E06C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 16:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F5A2080D
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 16:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxAuF8QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgAMQyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:54:35 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46627 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgAMQyf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 11:54:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so9084083qke.13
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 08:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WgYrV5pkU2+i5P0OoMbrQkaUH4mxgbk9foY8LHyexnI=;
        b=oxAuF8QKIKmY1II8+T/WvfNWEJ3ZyxJFO0Ptor4m/1DCdn4m17S4pxqwC34OQm3cTs
         D8zpZ76LB8e6LjRkRzAQ7WIBbDKZVALW1MjfW89evIHMHXjnt7KAQ5ViAAKw1LLn7XJY
         9DvfsKbk5eFMZO/0cgPJjae6nIt5hGNxK/g1ztwsf7u/wdfF9T7CrddRxy0YkzAsW6/g
         5A/X2lJrD1ar6OwAmgz3o3FpcCcehTKntHikT2MjMDMslqm+CYlaEHHyEFhFgeZpmuJA
         AqZc4hy9kITVz67/QI01khOPAuFsOfO88yM4wv0udc/wUB4d+UHOykdYllkAwAjiQeXp
         ndSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WgYrV5pkU2+i5P0OoMbrQkaUH4mxgbk9foY8LHyexnI=;
        b=cowZN6G1GpnEtM/guFTPDKy53VbNhRYxWJHk/FrXrrJxn//NiHvgfAiigaVGccHrHk
         OJfD707PeD7vfitSF/KwoIg7IyqpJYAeOf1nciEyqUGPMJrLE/0TqAm1CuApUUK5X2KG
         UK0Afa2PnWnDUOMxN83ZsKpX2gRUMl0MHQ98r49MneLi3ZOGhZ8akmgkDK7aqdPgClUf
         f51yzNKWD10h/29Km6qGcVFk0U/VkDm4XEC7TLw1R5jSaq5phTB9OaIE/nkKEfZaJ141
         O5QnODj44i6zzyIvz0E9o82pXXsERLfW1hi9PJ0VMG3cJ1763oBMiLWp9iCf1ckbDpqp
         vQcA==
X-Gm-Message-State: APjAAAUcPl8n7qhVz6sdVC/yVMjkxmgkxVQ8F7n94CgM+xVSWlknSCEZ
        VTOFtdMmhm5s16HshmB4d/w=
X-Google-Smtp-Source: APXvYqzjETVhRs52oJXC/Hln4f5cnl3VcaGAAcllUfbw3MKxcxyI/WKEH0VJyIRdAQXlbYA8vU0nRg==
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr12191654qkk.423.1578934474026;
        Mon, 13 Jan 2020 08:54:34 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:69fe:2d70:2369:9bfd? ([2001:4898:a800:1012:1b33:2d70:2369:9bfd])
        by smtp.gmail.com with ESMTPSA id i16sm5208391qkh.120.2020.01.13.08.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 08:54:33 -0800 (PST)
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
To:     Jakub Narebski <jnareb@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <86d0c44f5s.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <3aaf02fe-ac83-5694-2c69-e133879a0030@gmail.com>
Date:   Mon, 13 Jan 2020 11:54:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <86d0c44f5s.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/31/2019 11:45 AM, Jakub Narebski wrote:
> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> Performance Gains: We tested the performance of 'git log -- <path>' on the git
>> repo, the linux repo and some internal large repos, with a variety of paths
>> of varying depths.
>>
>> On the git and linux repos: We observed a 2x to 5x speed up.
>>
>> On a large internal repo with files seated 6-10 levels deep in the tree: We
>> observed 10x to 20x speed ups, with some paths going up to 28 times faster.
> 
> Could you provide some more statistics about this internal repository,
> such as number of files, number of commits, perhaps also number of all
> objects?  Thanks in advance.
> 
> I wonder why such large difference in performance 2-5x vs 10-20x.  Is it
> about the depth of the file hierarchy?  How would the numbers look for
> files seated closer to the root in the same large repository, like 3-5
> levels deep in the tree?

The internal repository we saw these massive gains on has:
- 413579 commits. 
- 183303 files distributed across 34482 folders
The size on disk is about 17 GiB. 

And yes, the difference is performance gains is mostly because of how 
deep the files were in the hierarchy. How often a file has been touched
also makes a difference. The performance gains are less dramatic if the 
file has a very sparse history even if it is a deep file. 

The numbers from the git and linux repos for instance, are for files 
closer to the root, hence 2x to 5x. 

Thanks! 
Garima Singh
