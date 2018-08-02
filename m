Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7DE41F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeHBTyP (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 15:54:15 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:38482 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732348AbeHBTyO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 15:54:14 -0400
Received: by mail-qk0-f182.google.com with SMTP id 126-v6so2208519qke.5
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MlOkF+k3N1F4oQynbRedJK/svMqrhnWfQib9Jp0GKXw=;
        b=O59rXf6RqcnX5/3Ual2AnEmdTk0wCtx2PtOJLGzmYoHoEdLmSkpx2pGraND0vN8x3p
         CyACI/4kHQuV8nN5gseVIKtONt9NYJ7hH8ytdG9vk0QdBZS7zWQqRXH321zkuBgo24RC
         inXZPPGY+f2QBWVFjAXikZbM4X5LqXlC8PAzf8ftihfVYiXBa/LMHd3FeAefN1WmKXZJ
         fCFr08s15hwcUlDaVp4Q1H+mGpGxfHns6b11TLChCF0olD3i6Vsg8wErhgz7QNbaIMWb
         AqjcJ/GlvFabhVd9m3aeJ2fBQxemGMCaCZ6Bra6SRpbRHKZwSUWqKJh7QVYRGa+jD6qr
         UxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MlOkF+k3N1F4oQynbRedJK/svMqrhnWfQib9Jp0GKXw=;
        b=odp9uyoFlmhfx5IbIGNej4FqCQ3k0X++AospnlV44+2Ev95IvDiP1QHlrOnsGsO28h
         zfNKim3+Jk7MB2v50sLd19mTTG4U4rIYrrjNPX/Re3i2++cWFJtDQnDnFAOEQEHVv19V
         lLSLnbZhGBdpaxksWb3yDyK64Dg2SpGIQYdn7bW1RPmIv5ZuT4nbhwI9CB2w0yuxlha2
         GbqWXZP4kWdY6ktCok0zpxT+jT1dsvSJW8AMfkVVf9wV68G7YQCnJJlgbTQjMuvliajf
         yTCXY0RNI7I3nIfUYEoQY6SsLd7RxKOeGaMO4JKyfxxA5Yl4F+VXaWw2cOxkTOobU/Fi
         /zOg==
X-Gm-Message-State: AOUpUlHYhohrtpYUKN2UmPRr43sxWiBgWAMd6FMI86UBwZM2FNesFI9K
        1q9PNB7MgZihGnuooEaHWDQ=
X-Google-Smtp-Source: AAOMgpdihusDP7U1qLyzrHOmZDvDaXPaj+sHiay0yCKhpOHKvkoGZbEHVtpEwQ/eRLACMySLjiyHkQ==
X-Received: by 2002:a37:6b84:: with SMTP id g126-v6mr493990qkc.231.1533232922064;
        Thu, 02 Aug 2018 11:02:02 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id g39-v6sm1796081qtb.47.2018.08.02.11.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 11:02:00 -0700 (PDT)
Subject: Re: [PATCH v2] checkout: optimize "git checkout -b <new_branch>"
To:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <Ben.Peart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180731163909.19004-1-benpeart@microsoft.com>
 <CACsJy8DMEMsDnKZc65K-0EJcm2udXZ7OKY=xoFmX4COM0dSH=g@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <3900401c-4d7b-233c-2098-9771a06ec0dd@gmail.com>
Date:   Thu, 2 Aug 2018 14:02:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8DMEMsDnKZc65K-0EJcm2udXZ7OKY=xoFmX4COM0dSH=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/1/2018 11:10 AM, Duy Nguyen wrote:
> On Tue, Jul 31, 2018 at 7:03 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
>>
>> From: Ben Peart <Ben.Peart@microsoft.com>
>>
>> Skip merging the commit, updating the index and working directory if and
>> only if we are creating a new branch via "git checkout -b <new_branch>."
>> Any other checkout options will still go through the former code path.
> 
> I'd like to see this giant list of checks broken down and pushed down
> to smaller areas so that chances of new things being added but checks
> not updated become much smaller. And ideally there should just be no
> behavior change (I think with your change, "checkout -b" will not
> report local changes, but it's not mentioned in the config document;
> more things like that can easily slip).
> 

One trade off of pushing these optimizations down into the lower-level 
functions is that they have a greater potential to break other command 
if our assumptions are wrong.  Changing these low level functions is a 
much more invasive set of patches.

I didn't feel confident enough to pursue this path and instead, decided 
to do the single, high level optimization around the specific scenario. 
While it has its own drawbacks (the nasty set of conditions we're 
testing), the potential for breaking other commands is much smaller.

That said, I'm willing to look into the model of pushing the 
checks/optimizations down to smaller areas if we can 1) ensure we aren't 
breaking other commands and 2) we can get similar performance.

> So. I assume this reason for this patch is because on super large worktrees
> 
>   - 2-way merge is too slow
>   - applying spare checkout patterns on a huge worktree is also slow
>   - writing index is, again, slow
>   - show_local_changes() slow
> 

That is pretty close but here is some real data on a large repo.

"git checkout -b <new_branch>" with this patch takes 0.32 seconds.
"git checkout -b <new_branch>" without this patch takes 14.6 seconds.

Note, all numbers are with a hot disk cache - real world numbers for the 
unpatched case can be much worse as it has to do a lot of disk IO to 
read/write the 267 MB index, load 500K+ tree objects, etc:

Name                                      	Inc %	      Inc
  ||+ git!mainCRTStartup                   	 89.2	   13,380
  || + git!__tmainCRTStartup               	 89.2	   13,380
  ||  + git!cmd_main                       	 89.2	   13,380
  ||   + git!handle_builtin                	 89.2	   13,380
  ||    + git!cmd_checkout                 	 89.2	   13,380
  ||     + git!unpack_trees                	 71.5	   10,725
  ||     |+ git!traverse_trees             	 39.7	    5,956
  ||     |+ git!cache_tree_update          	 16.1	    2,408
  ||     |+ git!??unpack_callback          	 11.0	    1,649
  ||     |+ git!discard_index              	  2.8	      423
  ||     + git!write_locked_index          	  8.4	    1,257
  ||     + git!??cache_tree_invalidate_path	  5.1	      767
  ||     + git!read_index_preload          	  3.4	      514

> For 2-way merge, I believe we can detect inside unpack_trees() that
> it's a 2-way merge (fn == twoway_merge), from HEAD to HEAD (simple
> enough check), then from the 2-way merge table we know for sure
> nothing is going to change and we can just skip traverse_trees() call
> in unpack_trees().
> 

If we can skip the call to traverse_trees(), that will give us the bulk 
of the savings (39.7% + 11% = 50.7% if my math is correct).

> On the sparse checkout application. This only needs to be done when
> there are new files added, or the spare-checkout file has been updated
> since the last time it's been used. We can keep track of these things
> (sparse-checkout file change could be kept track with just stat info
> maybe as an index extension) then we can skip applying sparse checkout
> not for this particular case for but general checkouts as well. Spare
> checkout file rarely changes. Big win overall.
> 

With the current patch, we don't need to load or update the index at 
all.  Without the patch, we've already replaced the standard 
sparse-checkout logic with something significantly faster so in our 
particular case, I think it's safe to skip the additional complexity of 
keeping track of changes to the sparse-checkout file.

> And if all go according to plan, there will be no changes made in the
> index (by either 2-way merge or sparse checkout stuff) we should be
> able to just skip writing down the index, if we haven't done that
> already.
> 

That would be great as writing the index is 8.4% of the time spent.

> show_local_changes() should be sped up significantly with the new
> cache-tree optimization I'm working on in another thread.
> 

As you can see, updating the cache_tree is relatively expensive (16.1% + 
5.1%) so we would definitely benefit from any improvements there.

> If I have not made any mistake in my analysis so far, we achieve a big
> speedup without adding a new config knob and can still fall back to
> slower-but-same-behavior when things are not in the right condition. I
> know it will not be the same speedup as this patch because when facing
> thousands of items, even counting them takes time. But I think it's a
> reasonable speedup without making the code base more fragile.
> 

So my rough math says we can potentially save 50.7% + 8.4% + (x * 21.2%) 
(where x is the percentage savings with an optimized cache_tree).  If we 
assume x == 50%, that means we can save 69.7% of the overall time.

For comparison, that would put "git checkout -b <new_branch>" at:

0.3 seconds - with the current patch
4.4 seconds - with the proposed patch
14.6 seconds - with no patch

Am I missing anything?  Is my math wrong?  Any other ideas for how to 
improve the proposed patch?

Thanks,

Ben
