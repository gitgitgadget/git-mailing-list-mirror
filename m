Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED40C77B7E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 19:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDVTpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 15:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDVTpG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 15:45:06 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54191171C
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 12:45:04 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <admin@game-point.net>)
        id 1pqJAL-009FA4-L7; Sat, 22 Apr 2023 21:45:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=game-point.net; s=selector2; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject;
        bh=z0wMxYXvr9Ke53RleIW1Y6KU92DmTBmLahgTZ7ZdwXI=; b=skilh0FeQOX7g989iCF221sg4Y
        5uLuecNwn19YGjvUElZikh9LGdTWCR0yXfc4kY8RJbfPa+HCVWhxO/kntyruU0/4agYtqtyon4LkT
        xIbSOMO6Umw+F2QV+OXJGpT9YsdJ+GY+bsZHLVOgtPPN7ZIpajEdye2jA7IjDv30ARbnB9+QEOwqc
        yubjbcD8LP6KmXCcOCZgfopmsy57LvMIdz0oip9IX7qlKoMe15b+GEFosxT93Ty2/Q7+bTTOJzABz
        z5cbQhYD1xmlnNlZMIsSWB521pvcYGZyP9HUqF6NHsmJm6Ydvo/sxo7oJIV9JplrVlNc6siemXGlZ
        WcJHAL+A==;
Received: from [10.9.9.72] (helo=submission01.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <admin@game-point.net>)
        id 1pqJAL-0005et-AR; Sat, 22 Apr 2023 21:45:01 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (956903)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1pqJAA-0003S8-4U; Sat, 22 Apr 2023 21:44:50 +0200
Subject: Re: Proposal: tell git a file has been renamed
To:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <01cd01d9754b$f12326b0$d3697410$@nexbridge.com>
From:   Jeremy Morton <admin@game-point.net>
Message-ID: <fbe77ad2-ce65-e6a6-254e-01bf6446d582@game-point.net>
Date:   Sat, 22 Apr 2023 20:44:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <01cd01d9754b$f12326b0$d3697410$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I read that git mv is basically the equivalent to deleting the old 
file, creating the new file, and adding the changes.  Isn't it?  If so 
it's gonna have the same problem as I have now.

-- 
Best regards,
Jeremy Morton (Jez)

On 22/04/2023 19:54, rsbecker@nexbridge.com wrote:
> On Saturday, April 22, 2023 2:02 PM, Jeremy Morton wrote:
>> Yes, I know Linus specifically doesn't store file rename info in Git.
>> The trouble is, every now and then, I'll come across a situation where Git doesn't
>> successfully detect that I've renamed a file because I'm doing something like
>> renaming a class at the same time.  So I'll have a file OldClassNameTests.cs and a
>> NewClassNameTests.cs but a bunch of lines in that file have also changed from
>> OldClassName.DoThing() to NewClassName.DoThing().  I can clearly see that this is a
>> rename, but Git sees enough changed content that it doesn't realize it, and puts it in
>> as a delete/add, losing the content history.
>>
>> The standard answer for this is to rename the file in one commit, then make the
>> changes.  That's fine if you know ahead of time you'll want to do this.  However it's a
>> total PITA if you have a bunch of changes and you realize that a rename has caused
>> this problem.  You now have to back out your changes to the renamed file, add the
>> rename, commit it, then re-apply the changes.
>>
>> Could a command be added to git that means you tell Git that counts as a file
>> rename?  Git would add a marker to the staging area that the file has been renamed,
>> and upon commit, would first generate an additional commit for each rename before
>> generating the main commit, ensuring the rename operation counts as an actual
>> rename, and the content's history is maintained.
> 
> Would git mv work in your situation? You can stage changes to the original file, then use git mv. Or use git mv first. The rename shows as staged in any event.
> --Randall
> 
> 
