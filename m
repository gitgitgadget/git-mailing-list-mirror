Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94328C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 14:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjAMOa1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 13 Jan 2023 09:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjAMO3z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 09:29:55 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836917A93A
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 06:22:05 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 30DEM1VO078780
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Jan 2023 09:22:01 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Hans Petter Selasky'" <hps@selasky.org>, <git@vger.kernel.org>
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org> <20230113133059.snyjblh3sz2wzcnd@carbon> <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
In-Reply-To: <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
Subject: RE: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Date:   Fri, 13 Jan 2023 09:21:56 -0500
Organization: Nexbridge Inc.
Message-ID: <009701d9275a$678416b0$368c4410$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG1ruR/R8aOK53MseGE8PcTBMgOqAJK+xVsAv4V3WSuuQpfIA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 13, 2023 8:40 AM, Hans Petter Selasky wrote:
>On 1/13/23 14:30, Konstantin Khomoutov wrote:
>> On Fri, Jan 13, 2023 at 01:59:44PM +0100, Hans Petter Selasky wrote:
>>
>>> Currently GIT only supports cryptographic hashes for its commit tags.
>> [...]
>>
>> https://github.com/git/git/blob/9bf691b78cf906751e65d65ba0c6ffdcd9a5a1
>> 2c/Documentation/technical/hash-function-transition.txt
>>
>> It's not clear why are you referring to Gitorious in your mail's
>> subject and then talk about Git.
>>
>
>Hi,
>
>I thought that Git was short for Gitorious? My bad.
>
>The document you refer to really highlights my concerns, that a strong
>cryptographic hash algorithm is the highway to hell.
>
>Do _not_ use a cryptographic hash for Git. Use plain good old CRC hashes.
>
>Just imagine the consequences of finding child porn inside a 10-year old firmware
>binary blob in the Linux kernel. Will you just ignore it, or will you fix it?
>
>That's why I say, that it must be possible to forge the hashes by default.

I do not understand the goal of this request. If it is possible to forge hashes, then nothing in a git repository can ever be trusted. Signed content will no longer be verifiable. The whole Merkel Tree representing the commit history becomes easily corruptible by hackers and no upstream remote repository can ever be trusted - or someone's own if someone targets a repo with malware that rewrites hashes. Imagine a scenario when malware replaces a blob in a repo and then forges the hash to pretend that the replacement never occurred. Using git as a supply chain audit trail becomes impossible. This is a potential vector for ransomware invading the git ecosystem. This seems like a really fatal path to take for the product.

The advantage of how git functions is that it is possible to mirror or clone repositories, protecting from hardware errors. Repositories exist in distributed form, so there may be hundreds or thousands of copies in case someone's copy is corrupted by a disk or memory write error - so that takes hash reconstruction out of the requirement set. If the git architecture was based on a central repository model only, then this might be a reasonable request, but that is not how git works. If, for instance, a main GitHub repo is somehow corrupted, it can be repaired by a push --force or a clone from a different instance.

Unless I am missing your point.
--Randall

