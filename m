Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28215C3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 17:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjAMRwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 12:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjAMRvh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 12:51:37 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CF58BF38
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:44:22 -0800 (PST)
Received: from 88-110-98-79.dynamic.dsl.as9105.com ([88.110.98.79] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pGO6F-0000Ty-3S;
        Fri, 13 Jan 2023 17:44:19 +0000
Message-ID: <5c696705-08f8-3ca4-530d-c2c12abc4593@iee.email>
Date:   Fri, 13 Jan 2023 17:44:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Content-Language: en-GB
To:     rsbecker@nexbridge.com, 'Hans Petter Selasky' <hps@selasky.org>,
        git@vger.kernel.org
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <009701d9275a$678416b0$368c4410$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/01/2023 14:21, rsbecker@nexbridge.com wrote:
> On January 13, 2023 8:40 AM, Hans Petter Selasky wrote:
>> On 1/13/23 14:30, Konstantin Khomoutov wrote:
>>> On Fri, Jan 13, 2023 at 01:59:44PM +0100, Hans Petter Selasky wrote:
>>>
>>>> Currently GIT only supports cryptographic hashes for its commit tags.
>>> [...]
>>>
>>> https://github.com/git/git/blob/9bf691b78cf906751e65d65ba0c6ffdcd9a5a1
>>> 2c/Documentation/technical/hash-function-transition.txt
>>>
>>> It's not clear why are you referring to Gitorious in your mail's
>>> subject and then talk about Git.
>>>
>> Hi,
>>
>> I thought that Git was short for Gitorious? My bad.
>>
>> The document you refer to really highlights my concerns, that a strong
>> cryptographic hash algorithm is the highway to hell.
>>
>> Do _not_ use a cryptographic hash for Git. Use plain good old CRC hashes.
>>
>> Just imagine the consequences of finding child porn inside a 10-year old firmware
>> binary blob in the Linux kernel. Will you just ignore it, or will you fix it?
>>
>> That's why I say, that it must be possible to forge the hashes by default.
> I do not understand the goal of this request. 

I'd agree about the core need for 'absolute' integrity checking.

However we have been here before, but without a way forward.

It was the "Subject: [TOPIC 3/17] Obliterate" at Git Contributor Summit,
Los Angeles (April 5, 2020).
https://lore.kernel.org/git/5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au/

Discussion at
https://docs.google.com/document/d/15a_MPnKaEPbC92a4jhprlHvkyirDh2CtTtgOxNbnIbA/edit#heading=h.wljwyo3r1m6l

The core need I think HPS is referring to is that need to 'obliterate'
some blob (which contains the en-mass data), and perhaps some trees,
commits and tags, which may also hold objectionable meta data, at least
from reference repositories, and at the same time authenticate (if
that's the right term) the list of such obliterated objects.

It will be a difficult task to carefully cut the fog of misdirection and
scares in this arena.

It's one of those problem statements whose answer is "42".

> If it is possible to forge hashes, then nothing in a git repository can ever be trusted. Signed content will no longer be verifiable. The whole Merkel Tree representing the commit history becomes easily corruptible by hackers and no upstream remote repository can ever be trusted - or someone's own if someone targets a repo with malware that rewrites hashes. Imagine a scenario when malware replaces a blob in a repo and then forges the hash to pretend that the replacement never occurred. Using git as a supply chain audit trail becomes impossible. This is a potential vector for ransomware invading the git ecosystem. This seems like a really fatal path to take for the product.

The supply chain audit is (would be) a real problem if the presence of a
specific hash is a punishable criminal offence. I suspect it already is
in some jurisdictions.

>
> The advantage of how git functions is that it is possible to mirror or clone repositories, protecting from hardware errors. Repositories exist in distributed form, so there may be hundreds or thousands of copies in case someone's copy is corrupted by a disk or memory write error - so that takes hash reconstruction out of the requirement set. If the git architecture was based on a central repository model only, then this might be a reasonable request, but that is not how git works.

The law works in mysterious ways it's wonderful ways to demonstrate ;-)
Possession of certain artefacts can be a problem, so it is something
that is worth careful consideration. We shouldn't let the 'distribution
of criminal artefacts' be something 'guaranteed' by Git, despite careful
users.

>  If, for instance, a main GitHub repo is somehow corrupted, it can be repaired by a push --force or a clone from a different instance.
>
> Unless I am missing your point.
> --Randall
>

The forced replacement of 'redacted' material is already a problem in
other domains. We should be able to manage a redaction list for a
repository that needs it.

All that said, CRC isn't any sort of solution!

--
Philip
