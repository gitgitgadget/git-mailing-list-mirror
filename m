Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC1B1F576
	for <e@80x24.org>; Tue, 30 Jan 2018 11:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeA3LPv (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 06:15:51 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:45496 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeA3LPu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 06:15:50 -0500
Received: from [192.168.2.201] ([92.28.135.202])
        by smtp.talktalk.net with SMTP
        id gTtEezxzyNSVVgTtEe6cJ6; Tue, 30 Jan 2018 11:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1517310948;
        bh=Yc05+sxGZrh4XVRIRqzHALzBnyvqcQJFPxIxb7KVk98=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Y3aeE9xrqB6BdbvkRhla0jew3ukbWMAX5SUoQMfTQAjXHFPABMc8c9Gn2WllvdL4Y
         M1mxraYk4axgnoIk2iO1vrjT6GlAcAFp+SEjnrAGeV3o0tMHsJwWMhH4bhfg16CjNy
         RoQE7KfinAKh1zE3T0s6Wxcqe1IZI5AfflKx8Now=
X-Originating-IP: [92.28.135.202]
X-Spam: 0
X-OAuthority: v=2.2 cv=NYGW7yL4 c=1 sm=1 tr=0 a=+9ZQAP2FB+pNrrgMTYJMPA==:117
 a=+9ZQAP2FB+pNrrgMTYJMPA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=Xny5CrZRA3X-0_ilolQA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] rebase: add --show-patch
To:     Duy Nguyen <pclouds@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20180126095520.919-1-pclouds@gmail.com>
 <20180126095520.919-3-pclouds@gmail.com>
 <4d7eb4c8-8d48-7c8d-259a-ba6b2f64def0@talktalk.net>
 <CACsJy8BsJjuxD8hhZ9P2KgTxraRvCJgYt83onBaD_gXA0ZP9DA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <a504c74a-49d4-4921-e763-34f5e7676868@talktalk.net>
Date:   Tue, 30 Jan 2018 11:15:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CACsJy8BsJjuxD8hhZ9P2KgTxraRvCJgYt83onBaD_gXA0ZP9DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKKT8bX1EEQSQmZAoQWTiytQifYeZFiQWJlXmOJ2eZNTyZFbnO9r4yyrQaAped4ha9LpB1sTPX+lzYLhD26BT/zg6x86l7lLCCGKb/fVL3UblD/R+68o
 NECxF76mTXz2LdPc7DFVjCE46I65NWcKYU6m4FpJAsgwshlCKngF9id5z/F+1OrChO8wCzVQpu1PV7bsWJtTl+wYoCRaBTuXhEIpd+cH9EQhin7tNyi3ZMUJ
 V8ahm1m+I5kAj1hLd+e/4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/01/18 11:22, Duy Nguyen wrote:
> On Fri, Jan 26, 2018 at 6:12 PM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>>> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
>>> index 06a4723d4d..5c513a9736 100644
>>> --- a/git-rebase--merge.sh
>>> +++ b/git-rebase--merge.sh
>>> @@ -137,6 +137,10 @@ skip)
>>>       finish_rb_merge
>>>       return
>>>       ;;
>>> +show-patch)
>>> +     cmt="$(cat "$state_dir/current")"
>>> +     exec git format-patch --subject-prefix= --stdout "${cmt}^!"
>>> +     ;;
>>>  esac
>>
>> Here and in the git-rebase--interactive you have access to the SHA of
>> the failed pick so you could run git log --patch and git colored output
> 
> Yes. My first revision I actually did "git diff" here. The only
> problem is inconsistency because we can't color "git am --show-patch"
> the same way, the patch source is in text format, not in the repo. But
> if people are ok with that I sure would switch to "git show".
> 
>> and it would use the pager in the same way as 'git am --show-patch' does
> 
> format-patch does set up pager. If it does not I would be very
> annoyed. I added this for convenience after all.
> 
Ah, I didn't realize that (now I come to think of it I've only ever used
--stdout to redirect the output). As my perceived lack of pager was the
main reason I suggested using log I'd ignore me.

I think the suggestion of having a ref for 'rebase -i' and 'rebase -m'
could be good as it'd be more flexible though I'm not sure what you'd do
about plain old rebase.

Best Wishes

Phillip
