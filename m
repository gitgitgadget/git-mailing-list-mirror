Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141D8EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 11:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjF3LZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 07:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjF3LZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 07:25:11 -0400
Received: from mail.zombino.com (c2.zombino.com [65.108.93.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E782CC0
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 04:25:08 -0700 (PDT)
Received: from [10.168.4.114] (unknown [81.95.8.244])
        by mail.zombino.com (Postfix) with ESMTPS id C23713E802;
        Fri, 30 Jun 2023 11:25:06 +0000 (UTC)
Message-ID: <5880fe56-aa98-64ce-4d91-ca078d3a7354@zombino.com>
Date:   Fri, 30 Jun 2023 13:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: SHA256 support not experimental, or?
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
 <xmqqmt0iajww.fsf@gitster.g> <ZJ303bm+VAvp5nyV@tapette.crustytoothpaste.net>
 <xmqqa5wh9adg.fsf@gitster.g> <ZJ4uKYIZMxi3DHo3@tapette.crustytoothpaste.net>
 <vt3cizczmwbcpgktwrkr3jbiwhee37rt7m243hnkzxik7gt4m2@d2upsqoxtlgc>
From:   Adam Majer <adamm@zombino.com>
In-Reply-To: <vt3cizczmwbcpgktwrkr3jbiwhee37rt7m243hnkzxik7gt4m2@d2upsqoxtlgc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/30/23 11:31, Patrick Steinhardt wrote:
> Indeed, supporting SHA256 is a major effort on our side at GitLab. Most
> of the work isn't really adapting our production code, but it's rather
> that tons of tests were written with seed repositories and hardcoded
> object hashes. Converting all of that isn't all that hard in the general
> case, but it's a tedious job.

Hi!

This actually reminds me of a funny story from my side.

Earlier this year, I was testing various frontends and how they would 
handle SHA256 repositories. All of them failed, not surprising. I even 
managed to lock myself out of Gitlab by importing a SHA256 private repo 
into my home project -- every time this project became visible, it would 
result in Error 500 from the UI. Today (few weeks ago), this appears to 
be fixed -- the UI is just broken, so you can't see anything in sha256 
repository, but at least I was able to delete the project.

The repository was correctly imported and I could clone from gitlab, so 
the problem is mostly "just" UI. :-)

The most likely frontend we'll use for our internal project is Gitea. 
The sha256 support is in progress

https://github.com/go-gitea/gitea/pull/23894

 From the size of this patch, you can see how ingrained SHA1 assumption 
was. Most of the patch is just to remove the hardcoded elements, 
including hardcoded SHA1 empty-tree hashes and assumption that 20 bytes 
is enough to hold a hash. And I didn't even add sha256 test cases...

But I have to say that in at least one occasion, people are bringing up 
the experimental nature of git's sha256 support (per current wording) as 
reason not to make their tools sha256 compliant.

> In any case I'm fully supportive of relaxing the current warning. Except
> for the recently discussed edge case where cloning empty repositories
> didn't create a SHA256 repository I have found the SHA256 code to be
> stable and working as advertised. We should caution people that many
> services will not work with SHA256 yet though.

That is exactly true. But this is also chicken-egg problem. Services are 
not adapted for sha256 repositories because there is simply no demand 
for them. Only when people will start using sha256 repos, will there be 
some demand generated.

- Adam
