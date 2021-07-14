Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51DFC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96AC61374
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhGNNty (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:49:54 -0400
Received: from elephants.elehost.com ([216.66.27.132]:24440 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhGNNtx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:49:53 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 16EDkwwO058663
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 14 Jul 2021 09:46:59 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <20210712223139.24409-1-randall.becker@nexbridge.ca>        <20210712223139.24409-3-randall.becker@nexbridge.ca> <xmqqr1g1zow4.fsf@gitster.g>
In-Reply-To: <xmqqr1g1zow4.fsf@gitster.g>
Subject: RE: [Patch 2/3] Documentation/config.txt: add worktree includeIf conditionals.
Date:   Wed, 14 Jul 2021 09:46:52 -0400
Message-ID: <006b01d778b6$b74b8600$25e29200$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQF2HyHHSxX17r/iTwhwCI4yh2NyqQFrZIJJAS8qKBur8FmPoA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 13, 2021 9:05 PM. Junio C Hamano wrote:
>randall.becker@nexbridge.ca writes:
>
>> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>>
>> Documentation of the worktree and worktree/i conditionals is add based
>> on gitdir rules except that the trailing / form of the path is not supported.
>>
>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> ---
>>  Documentation/config.txt | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt index
>> bf82766a6a..7e951937ae 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -143,7 +143,16 @@ refer to linkgit:gitignore[5] for details. For convenience:
>>
>>  `gitdir/i`::
>>  	This is the same as `gitdir` except that matching is done
>> -	case-insensitively (e.g. on case-insensitive file systems)
>> +	case-insensitively (e.g. on case-insensitive file systems).
>> +
>> +`worktree`::
>> +	This is similar to `gitdir` except that matching is done with
>> +	the path of a worktree instead of the main repository. Unlike
>> +	`gitdir`, the trailing / form of the worktree path is not supported.
>
>It is not immediately obvious what "the trailing / form" means.
>
>Does it refer to the 4th item in the 4-bullet list in the description just above the patch context (I am trying to make a guess
here)?
>
>The problem I perceive in this description is that there is no phrase "trailing" in the vicinity of what readers have read so far;
readers who
>are not exactly familiar with the system may need a bit more assurance that they guessed correctly.
>
>    Unlike `gitdir`, `**` will not be automatically added to a
>    pattern that ends with `/`
>
>would be easier to give that assurance, albeit more verbosely.
>
>Assuming that I guessed correctly, is this a deliberate design decision not to "automatically add ** after a pattern that ends with
a slash",
>and if so why?  I would have thought that "in the worktrees that I create inside /var/tmp/, please enable these configuration
variables"
>would be a fairly natural thing to ask, and I do not immediately see a reason why we want to apply different syntax rules between
"gitdir"
>and "worktree".

The reason for this comes down to what is in *the_repository. Essentially, the_repository->gitdir always has a /path/to/.git
directory with full qualification. the_repository->worktree does not have /.git added for obvious reasons, so the /path/to is bare
of the trailing /. This causes a trailing pattern /to/path/** match to fail. I could copy the value into a working buffer but that
seemed a bit clunky. So using the available information, the syntax rules need to be different between the two, unless the value of
worktree is augmented. I was unsure which way the team wanted to go on this.

