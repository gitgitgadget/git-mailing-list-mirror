Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C50C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085BD60FE6
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhHKQAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 12:00:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58464 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbhHKQAo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 12:00:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 218ACE26C0;
        Wed, 11 Aug 2021 12:00:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ifi9I14RuN9A723gLrdgPyi95tK8J1Nhvg/bc5
        5J0Sg=; b=Gwri7ci7+Yz/PcTf5fRKhI8ywg9JC7IULdT78IdUq+aJDtr+zxgg+A
        mmEcW660f5RcuX9TWyqYE/+rEYJcCVf6Ptd5bX03fFMdZJsvN/qNvtFwzVYQMp1x
        Ka5U1P7alTS516//xkLwzpjZI4ZoJo6QXpCqY1GeYBW3jUhIdv+cc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18DA5E26BE;
        Wed, 11 Aug 2021 12:00:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82381E26BD;
        Wed, 11 Aug 2021 12:00:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
        <20210811045727.2381-7-felipe.contreras@gmail.com>
        <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com>
Date:   Wed, 11 Aug 2021 09:00:18 -0700
In-Reply-To: <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com> (Bagas Sanjaya's
        message of "Wed, 11 Aug 2021 13:12:11 +0700")
Message-ID: <xmqqzgto9dkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A1A8CB0-FABD-11EB-8273-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 11/08/21 11.57, Felipe Contreras wrote:
>> @@ -12,6 +12,7 @@ SYNOPSIS
>>   'git stage' [options] [--] [<paths>...]
>>   'git stage' (-a | --add) [options] [--] [<paths>...]
>>   'git stage' (-r | --remove) [options] [--] [<paths>...]
>> +'git stage' (-d | --diff) [options] [--] [<paths>...]
>>     
>>   DESCRIPTION
>> @@ -32,11 +33,15 @@ OPTIONS
>>   --remove::
>>   	Remove changes from the staging area. See linkgit:git-reset[1].
>>   +-d::
>> +--diff::
>> +	View the changes staged for the next commit. See linkgit:git-diff[1].
>>   
>
> Is it synonym to `git diff --staged`?

Looks like it.

A more notable aspect of the above list is not the similarity but
difference from the rest of Git.  The above organizes various
operations on the staging area in a single command as its operating
modes, so you'd use "git stage --diff" for comparing with the
staging area but use something else ("git commit --diff HEAD"???).

It is a good example that illustrates that the proposed organization
may not help learning or using the system for operations that also
apply to other things like commit and working tree (in other words,
"git stage --grep" may not be such a good idea for the same reason
as "git stage --diff").  But if it were limited to operations that
apply only to the index (e.g. "git add" and "git rm"), it may be an
improvement (I think we added "git stage" synonym exactly for that
reason, already).

Having said that, if we added "git stage --remove", there may be
complaints that say "the stage command does too many things", just
like those that caused "checkout" to be split into "restore" (check
out contents for selected paths in order to work on the current
branch) and "switch" (check out a branch in order to start working
on it).  I dunno.
