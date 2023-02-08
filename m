Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F0AC636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 14:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjBHOvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 09:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjBHOvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 09:51:17 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61EA303E7
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 06:51:13 -0800 (PST)
Received: from host-2-103-194-72.as13285.net ([2.103.194.72] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pPlmx-0003Dc-C9;
        Wed, 08 Feb 2023 14:51:12 +0000
Message-ID: <1e073897-162d-e1e6-bab2-b424b21e1015@iee.email>
Date:   Wed, 8 Feb 2023 14:51:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Unexpected (bug-like) behavior in `git ls-remote` matching.
To:     William Blevins <wblevins001@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
 <xmqqedr0vd1l.fsf@gitster.g>
 <CALJHx12DetwZ=+aMEG6Ss4P3fMTeLN2styXuPw93C5N6yg98NA@mail.gmail.com>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CALJHx12DetwZ=+aMEG6Ss4P3fMTeLN2styXuPw93C5N6yg98NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/02/2023 13:49, William Blevins wrote:
> This still feels "weird" to me. Other pattern matching tools like grep
> and sed don't have exceptions to their behavior like this.
>
> Can you reference the unit tests that verifies this specific behavior?

As someone who also trips up over the *nix command line, Is this a bash
(glob) expansion issue?
So there is a two step 'expansion', first by bash, and then by git's
pattern match. Even plain text could be "expanded" if there's a suitable
expansion

a quick search suggested
https://superuser.com/questions/861077/is-it-possible-to-print-out-the-shell-expansion
which has some tipe I wasn't aware of.

Philip

>
> On Wed, Feb 8, 2023 at 2:20 AM Junio C Hamano <gitster@pobox.com> wrote:
>> William Blevins <wblevins001@gmail.com> writes:
>>
>>> What is totally unexpected.... is the most simple search for ABC-1...
>>> ```
>>> $ git ls-remote --heads git@github.com:owner/repo.git ABC-1
>>> <ref>    refs/head/ABC-1
>>> <ref>    refs/head/feature/ABC-1
>>> ```
>> Sorry, but I cannot see what is surprising about the above.  If you
>> have these branches locally, you should also see these refs in the
>> output of "git show-ref ABC-1".  Refname hierarchies work just like
>> pathnames with directories, and without glob in the pattern, tail
>> matching that honors path component boundary is very much the norm
>> in the oldest part of Git, i.e. ABC-1 matches refs/heads/ABC-1 but
>> not refs/heads/XABC-1.

