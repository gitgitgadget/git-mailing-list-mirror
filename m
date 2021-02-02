Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC57C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA1E64F50
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbhBBRTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 12:19:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50205 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbhBBRPX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 12:15:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A87E09BFD6;
        Tue,  2 Feb 2021 12:14:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2dbNInkoSSyRNv0jNN7GZzreBJk=; b=jLmT+f
        kGr3qz7R06qGCcW1J03xEIPQE9abe585Jlmr4SfMr/JOKVfXn2A/j4AhFqUZEYr8
        fbAf1IuMeUmh3iJDOV0wy0zQ21yOCSPgZf2Hyv8qyqQMv69ORILNw8pWMsE8IA1l
        sgxTjrc5L1blIVWeY3wAOSHfN9BI4zWjnDKEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JKIwn68wlRUaTtbWp3EI+0Sg4pj2Ru5s
        dVQbktMTk5nQ/gFDRs1ZfQZBrCzcz6eFmx5QiMfnqL+bkORJ3Dtjo615RjuvjFSR
        rQiUwlH/0tEotPiW4Tc4BcZdUA6U4VUsJEf9udO2VGit5CSrASqxQmkimDYlhlly
        AsAGJTu6dbY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A13979BFD4;
        Tue,  2 Feb 2021 12:14:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E6739BFCF;
        Tue,  2 Feb 2021 12:14:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Paul Jolly <paul@myitcv.io>, git@vger.kernel.org
Subject: Re: Bash completion suggests tags for git branch -D
References: <CACoUkn6+9C3+HVVQF905t1siAD9Sqo1JvRa0Whw-J6x7V7icyg@mail.gmail.com>
        <YBkVFTOP6K1//i6m@coredump.intra.peff.net>
        <YBkZnY8X5VyNkXkR@coredump.intra.peff.net>
Date:   Tue, 02 Feb 2021 09:14:39 -0800
In-Reply-To: <YBkZnY8X5VyNkXkR@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 2 Feb 2021 04:21:33 -0500")
Message-ID: <xmqqpn1igznk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22600F38-657A-11EB-8403-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 02, 2021 at 04:02:13AM -0500, Jeff King wrote:
>
>> > b-is-a-tag is not a branch, so should not be offered as a completion
>> > candidate in this instance.
>> 
>> It looks like lowercase "-d" works. So maybe the "-d" here:
>> 
>>   $ sed -n '/git_branch/,/^}/p' contrib/completion/git-completion.bash | head 
>>   _git_branch ()
>>   {
>>   	local i c=1 only_local_ref="n" has_r="n"
>>   
>>   	while [ $c -lt $cword ]; do
>>   		i="${words[c]}"
>>   		case "$i" in
>>   		-d|--delete|-D|-m|--move)	only_local_ref="y" ;;
>>   		-r|--remotes)		has_r="y" ;;
>>   		esac
>> 
>> just needs to look for "-D", too?
>
> Oops. I meant to paste the "before" snippet, but this is obviously after
> I stuck "-D" in there. It does seem to work. :)

;-)

Before we forget, as you said a few times that everything you send
here on Git are signed off...

-- >8 --
From: Jeff King <peff@peff.net>
Date: Tue Feb 2 04:02:13 2021 -0500
Subject: [PATCH] completion: treat "branch -D" the same way as "branch -d"

Paul Jolly noticed that the former offers not just branches but tags
as completion candidates.  Mimic how "branch -d" limits its suggestion
to branch names.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4b1f4264a6..b54113e2f9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1447,7 +1447,7 @@ _git_branch ()
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
-		-d|--delete|-m|--move)	only_local_ref="y" ;;
+		-d|--delete|-D|-m|--move)	only_local_ref="y" ;;
 		-r|--remotes)		has_r="y" ;;
 		esac
 		((c++))
-- 
2.30.0-586-g047f30a795

