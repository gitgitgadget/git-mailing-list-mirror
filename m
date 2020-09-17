Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B24C43463
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 21:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4635F208E4
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 21:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="ZZJ3t5a4";
	dkim=pass (1024-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="wq9+ZphC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgIQVQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 17:16:50 -0400
Received: from smtp114.ord1d.emailsrvr.com ([184.106.54.114]:39771 "EHLO
        smtp114.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgIQVQu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Sep 2020 17:16:50 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 17:16:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1600370490;
        bh=2HJPC8KV09dvecGouCVtdNyYEBdkXzf+tr7cdC92HLI=;
        h=Subject:To:From:Date:From;
        b=ZZJ3t5a4nltlPs1VjpQpsIJp4zQxaj0rW4JpNb8Nac4memExqvDT8IYxgmI7jcQRg
         wPQJiHj9P3UsBHyUs+JnpxqgsXY8XPmBmjPuJol46qBfH/JCrIS2l5X+qGauW2LlEz
         KTQcW6qYQBTDuyZfeS1rThb2ednfLfNOi3f7Yw7U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xiplink.com;
        s=20181102-2c3qeqyt; t=1600370490;
        bh=2HJPC8KV09dvecGouCVtdNyYEBdkXzf+tr7cdC92HLI=;
        h=Subject:To:From:Date:From;
        b=wq9+ZphCQJ8SpfweAu49eRl2XrrUbUeprxLvOgoLdoDRb1/zvZinMgTyNiqL77CD4
         FueDCZRBNiLG7fuLigMKgpUUmY1KfBDY0jqTovm1DOxSqfM5RKBW/vOIXqCjgt1gHE
         qIuqyIK6xxYvOGcSfLVR/Psa3KWnl9Zqake3GOzA=
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp23.relay.ord1d.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CF21F2039C;
        Thu, 17 Sep 2020 15:21:29 -0400 (EDT)
Subject: Re: [RFC PATCH 2/2] core.fsyncObjectFiles: make the docs less
 flippant
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Christoph Hellwig <hch@lst.de>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
 <20200917112830.26606-3-avarab@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <1edd9eb1-365b-b4f7-87f8-3ad35bd7d5be@xiplink.com>
Date:   Thu, 17 Sep 2020 15:21:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917112830.26606-3-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Classification-ID: 36143543-7a10-467d-8fa3-aec8e5b40934-1-1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-17 7:28 a.m., Ævar Arnfjörð Bjarmason wrote:
> As amusing as Linus's original prose[1] is here it doesn't really explain
> in any detail to the uninitiated why you would or wouldn't enable
> this, and the counter-intuitive reason for why git wouldn't fsync your
> precious data.
> 
> So elaborate (a lot) on why this may or may not be needed. This is my
> best-effort attempt to summarize the various points raised in the last
> ML[2] discussion about this.
> 
> 1.  aafe9fbaf4 ("Add config option to enable 'fsync()' of object
>      files", 2008-06-18)
> 2. https://lore.kernel.org/git/20180117184828.31816-1-hch@lst.de/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   Documentation/config/core.txt | 42 ++++++++++++++++++++++++++++++-----
>   1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 74619a9c03..5b47670c16 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -548,12 +548,42 @@ core.whitespace::
>     errors. The default tab width is 8. Allowed values are 1 to 63.
>   
>   core.fsyncObjectFiles::
> -	This boolean will enable 'fsync()' when writing object files.
> -+
> -This is a total waste of time and effort on a filesystem that orders
> -data writes properly, but can be useful for filesystems that do not use
> -journalling (traditional UNIX filesystems) or that only journal metadata
> -and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
> +	This boolean will enable 'fsync()' when writing loose object
> +	files. Both the file itself and its containng directory will

Typo: containng

		M.

> +	be fsynced.
> ++
> +When git writes data any required object writes will precede the
> +corresponding reference update(s). For example, a
> +linkgit:git-receive-pack[1] accepting a push might write a pack or
> +loose objects (depending on settings such as `transfer.unpackLimit`).
> ++
> +Therefore on a journaled file system which ensures that data is
> +flushed to disk in chronological order an fsync shouldn't be
> +needed. The loose objects might be lost with a crash, but so will the
> +ref update that would have referenced them. Git's own state in such a
> +crash will remain consistent.
> ++
> +This option exists because that assumption doesn't hold on filesystems
> +where the data ordering is not preserved, such as on ext3 and ext4
> +with "data=writeback". On such a filesystem the `rename()` that drops
> +the new reference in place might be preserved, but the contents or
> +directory entry for the loose object(s) might not have been synced to
> +disk.
> ++
> +Enabling this option might slow git down by a lot in some
> +cases. E.g. in the case of a naïve bulk import tool which might create
> +a million loose objects before a final ref update and `gc`. In other
> +more common cases such as on a server being pushed to with default
> +`transfer.unpackLimit` settings the difference might not be noticable.
> ++
> +However, that's highly filesystem-dependent, on some filesystems
> +simply calling fsync() might force an unrelated bulk background write
> +to be serialized to disk. Such edge cases are the reason this option
> +is off by default. That default setting might change in future
> +versions.
> ++
> +In older versions of git only the descriptor for the file itself was
> +fsynced, not its directory entry.
>   
>   core.preloadIndex::
>   	Enable parallel index preload for operations like 'git diff'
> 
