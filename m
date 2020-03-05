Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A230AC3F2D8
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 18:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5865C2146E
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 18:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gtwAXAV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCESa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:30:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55177 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCESaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 13:30:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF0EC644C3;
        Thu,  5 Mar 2020 13:30:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dK1buSnoz86c2NOZo00SewmbukM=; b=gtwAXA
        V9WAA7IcHbzJtEMuVVEUocF9ovR2/cVkxWPMXAeV7Hyrz3H+LnFcLMvvgFX0pUT6
        qz1OOwkDEISJczxUR4V4EiR6yOr93Oz6I+sPq2u+hWyfmPyV7uShqfCp/WXuoFQq
        FJfneeau3lm2iWU70fu3C2+7Mq/a3TeOqW/hw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rl0ZL0GlKKnL6OEcSM3KqkUHYg7L1PGA
        nd7Lbx8wFHSpM7Wnk72LxxbnVmn++5e7T3M7FCBMYa6XLCEYZt5Pz3Qh+Ho1bzKq
        AfuZ42fclp1LH9bYjFTwgoooKM9TzxrbqvWOvoDRubbFpeZJCd5DSMqqTCjBd8hi
        3DGGbo2Swcs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D61EB644C2;
        Thu,  5 Mar 2020 13:30:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47FD2644BF;
        Thu,  5 Mar 2020 13:30:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, rcdailey.lists@gmail.com, newren@gmail.com,
        rsbecker@nexbridge.com, annulen@yandex.ru, tytso@mit.edu
Subject: Re: [PATCH v4] pull: warn if the user didn't say whether to rebase or to merge
References: <20200304022931.2469455-1-alexhenrie24@gmail.com>
        <xmqq4kv45995.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 05 Mar 2020 10:30:16 -0800
In-Reply-To: <xmqq4kv45995.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 04 Mar 2020 09:18:30 -0800")
Message-ID: <xmqqk13y4ptz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D536DC8-5F0F-11EA-8D82-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> - Revise warning message based on Junio's feedback
>> - Consistently wrap warning lines to 75 characters for easy viewing in
>> PO files
>
> Nice to see attention to such a detail ;-)
>
>> - Fix test failures
>
> Ah, OK, hmmm.  
>
> For --quiet test, that wants to ensure that "pull --quiet" does not
> say anything, it certainly stops the test from failing if we set the
> configuration before executing such a test, but I wonder if that is
> in line with the spirit of the feature the test tries to protect in
> the first place.  I would imagine those who write "pull --quiet" in
> automation would not want to see any non-error message, and because
> this is not an error, they do not want to see any output.  Shouldn't
> such a use of "pull --quiet" bypass this warning, too?

Actually, the change to t/t5521 does not even sweep the problem
under the rug X-<

>> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
>> index ccde8ba491..6e890ec936 100755
>> --- a/t/t5521-pull-options.sh
>> +++ b/t/t5521-pull-options.sh
>> @@ -8,7 +8,8 @@ test_expect_success 'setup' '
>>  	mkdir parent &&
>>  	(cd parent && git init &&
>>  	 echo one >file && git add file &&
>> -	 git commit -m one)
>> +	 git commit -m one) &&
>> +	git config pull.rebase false

This affects the repository at the top of the trash directory, but
the test immediately after this one looks like this:

    test_expect_success 'git pull -q' '
            mkdir clonedq &&
            (cd clonedq && git init &&
            git pull -q "../parent" >out 2>err &&
            test_must_be_empty err &&
            test_must_be_empty out)
    '

The patch added pull.rebase to "t/trash directory.5521/.git/config",
but it would not affect this "git pull -q", that is run in the
repository that uses "t/trash directory.5521/clonedq/.git/config"
as its configuration.

For now, I added the following patch on top of the topic before
queuing it to 'pu'.

Thanks.

-- >8 --
Subject: [PATCH] SQUASH???

Let's declare that for the purpose of "pull --quiet", the new "you
might have created a merge when you may wanted to rebase" warning is
an unwanted noise.

Revert the hack made to t5521; the second test that creates a new
repository and runs a pull inside it will not get affected by the
local configuration setting it makes to the original trash
repository and the breakage won't be worked around with it anyways.

This is not a full remedy for the previous step, yet.  The topic
needs a test to ensure the warning is emitted when it should be.
Existing t5521 is a test that ensures the warning is not given in
one of the conditions it should not be (i.e. when --quiet is in
effect).  Negative tests for other cases (e.g. when --ff-only is
given from the command line, without pull.rebase configured) should
also be added.
---
 builtin/pull.c          | 3 ++-
 t/t5521-pull-options.sh | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 351b933c4d..0ef192fd64 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -327,7 +327,8 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	if (!opt_ff || strcmp(opt_ff, "--ff-only")) {
+	if (0 <= opt_verbosity &&
+	    (!opt_ff || strcmp(opt_ff, "--ff-only"))) {
 		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
 			"discouraged. You can squelch this message by running one of the following\n"
 			"commands sometime before your next pull:\n"
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 6e890ec936..ccde8ba491 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -8,8 +8,7 @@ test_expect_success 'setup' '
 	mkdir parent &&
 	(cd parent && git init &&
 	 echo one >file && git add file &&
-	 git commit -m one) &&
-	git config pull.rebase false
+	 git commit -m one)
 '
 
 test_expect_success 'git pull -q' '
-- 
2.25.1-595-g3aa4872962

