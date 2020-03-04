Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACDEC3F2CE
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C2020842
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 20:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgCwaSuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbgCDUzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:55:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41210 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgCDUzK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 15:55:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id v4so4205992wrs.8
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 12:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5fli4TqSVnDHYpGMSYHfgY/hmqzEFPmqELjU9v7gub0=;
        b=fgCwaSuciUTtm/fESiOpNWkAS88utglzz+X20/7AyIPVU5EgTIK+7Mkhsj9eQbIHLv
         M15/U5Fvdz2fzI6u8T7HwgukQ6HVSVWu66uLyHGuyPSbwOtiTNw5ahyLuBiyOrN7venG
         O+rQLH1jx2gy/FNnMKoZFKpQwU8SvMj2BeyM/vjZz7gm1kvk8vBQQqoAWbOsqy40e1Ug
         bMPmrSfExtLRLbqI5FAYQ78qLnGoduWblUWCNEapo1XPw4WRqXSv9b705xOQ08REW+mN
         sTWadSoAosY6cshasczcHhhDJVhIJxK23pWzM7qe8vFo7XKPXNBcY2W1aHEhW6NSYE50
         g4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5fli4TqSVnDHYpGMSYHfgY/hmqzEFPmqELjU9v7gub0=;
        b=XlTbBEDJICZ0qCED0JDaTDYdoPeNhWFBtbzN0T8JHZ9W/F5j1j6YWvKff8F+g920pu
         VCK8nPOO6RTkjchy0iF+rCtMamf/rC/IWWEZaUNBYkz6oQKCXh3TSJTofZRcSzTAs8Kc
         LSGJSTIwHzqJ82T9SZEQ8GLhRNEBohfsZRoFDY4rj17qbYzyrPBVDZ8jn4lcWnDP5+81
         n1KRG0IpXkE3A7oqFtwKLsaqdC1zvX+tW7tGHpVgBOwgTws3GKejXLFeEQATtLUXxrcV
         1V9PLXI/Tbm1zDx5aaiar+yMlwyH0IbjWBRijEO2hNwjeI20OWxcrVpuXZ2wTREvwkLd
         m4yg==
X-Gm-Message-State: ANhLgQ1XI2NexvVAra0E6N6bb0nSkjCFXn6SXIY4xuMlJ+l4BV0vhI8Q
        HSHoFdb+cjTxY38AHn9XpVlqR3EG
X-Google-Smtp-Source: ADFU+vsN1t4E7KahBrbUsUf1O/Td8WggGQut3J6sG/otRYIrUOUtTV3MSO3hcgJ5bEtOPcpUR4GPJQ==
X-Received: by 2002:adf:9462:: with SMTP id 89mr5789794wrq.197.1583355307488;
        Wed, 04 Mar 2020 12:55:07 -0800 (PST)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id r12sm6224081wrw.77.2020.03.04.12.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 12:55:07 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: rebase --abort Unespected behavior
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Blaise Garant <blaise@garantcoutu.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CANXsDork=bL=SUodXDzkcnjpPALm53e++UkVkJFWxaZPMBK-SQ@mail.gmail.com>
 <13cdf33b-7ca2-c391-fddd-53bdbae7f0d3@gmail.com>
 <CABPp-BFDJL5sbfY_CK_VuO0+hR3ZNsZqQKoRWNFMjwkqt52Riw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <46d88e20-3832-ece3-16b6-7088c11bf586@gmail.com>
Date:   Wed, 4 Mar 2020 20:55:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BFDJL5sbfY_CK_VuO0+hR3ZNsZqQKoRWNFMjwkqt52Riw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 29/02/2020 15:51, Elijah Newren wrote:
> Hi Phillip and Blaise,
> 
> On Sat, Feb 29, 2020 at 6:30 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Blaise
>>
>> On 28/02/2020 17:36, Blaise Garant wrote:
>>> Hello,
>>>
>>> I don't know if this is a bug but it was unexpected for us. I
>>> accidentally added untracked files through a `git add .` while doing
>>> an interactive rebase and aborting the rebase deleted those files. Is
>>> this to be expected?
>>
>> I agree that this is surprising and undesirable but it's not unexpected
>> given the way --abort is implemented. 'rebase --abort' calls 'reset
>> --hard <branch we're rebasing>' so it will discard all the uncommitted
>> changes in the worktree and reset the worktree and index to the branch tip.
> 
> And it's worth noting that if they had done something similar outside
> of rebase/merge/cherry-pick/etc.:
> 
> git add $UNTRACKED
> git reset --hard
> 
> then the $UNTRACKED file would be deleted, so this isn't new or
> unusual but matches git behavior elsewhere.

It's not new but it can be confusing. rm warns if you remove a newly 
added file but reset --hard will happily blow it away

$ touch untracked
$ git add untracked
$ git rm untracked
error: the following file has changes staged in the index:
     untracked
(use --cached to keep the file, or -f to force removal)
$ git reset --hard
HEAD is now at <oid> <subject>

>> The tricky thing with your situation is that the files are tracked at
>> the point we call 'reset --hard' as they've been added to the index so
>> git feels free to discard them. Perhaps rather than calling 'reset
>> --hard' it would be better to use a custom callback with unpack_trees()
>> that errors out if there are any paths in the index that are not in
>> HEAD, the commit we just picked or the branch tip we're resetting to. If
> 
> Should such a special callback also be used for reset --hard?
 >
> Also, this special callback, as stated here, wouldn't work: paths can
> exist in a merge that didn't exist in any of the three commits being
> threeway merged.  All of the following situations are cases where that
> can happen (and there may be more that I'm just not thinking of off
> the top of my head):
> 
> 1) merge in a not-fully clean state.  rebase may disallow this, at
> least right now, but merge traditionally hasn't.  I'm not sure
> cherry-pick --no-commit disallows this.

I'm pretty sure cherry-pick --no-commit will operate on a dirty index, 
I'd forgotten about that

> 2) directory/file or submodule/file or submodule/subdirectory or
> regular-file/symlink conflicts. the merge machinery should be free to
> rename paths to something that didn't exist on either side so that the
> paths from both side can coexist.
> 3) directory renames.  If one side renamed z/->y/, and the other side
> added a new file z/new, the merge should be allowed to move that file
> to y/new (depending on the setting of merge.directoryRenames...).
> Note that y/new didn't exist on either side of history nor in the
> merge base.

Thanks for pointing that out. I'd assumed we'd only check index entries 
in stage 0 so if the user aborts while these entries are unmerged then 
it wouldn't be a problem but if they've partially resolved the merge 
then --abort could fail.

>> we do that we should consider using the same thing for
>> 'cherry-pick/merge/reset --abort' as well. --autostash potentially
>> complicates things as the file might be in the stash but not in the
>> other commits but lets not worry about that at the moment.
> 
> reset --abort?  Not sure what you're referring to here.

I meant revert

I'm not sure what a good way forward is, blindly wiping out newly added 
files is not great from the users point of view but avoiding false 
positives is tricky

Best Wishes

Phillip
