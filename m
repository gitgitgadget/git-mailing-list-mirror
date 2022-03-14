Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022B4C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 21:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242042AbiCNV0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 17:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbiCNV0E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 17:26:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214F32C676
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 14:24:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7128188F85;
        Mon, 14 Mar 2022 17:24:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ryG1XZo3e2cnLNVfyV7y170qohsRjKQEgTEvcA
        C8eU8=; b=KGxcWDwD0CmXnbOgFsG9xxtc45dk4jWP2EXSeoYILXSKMeqhmGz2/k
        JFCFZtbOZ+ioajQaAMU1Et+tJ7nTssL3qJGBlzj6g4PJWQdNva4Mvq9UjHtRb4j6
        R2BETWefMYm8YyTTxYJmszV9ond3m5WKzUrRFwX7vNq49HsSkQ46c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF375188F84;
        Mon, 14 Mar 2022 17:24:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49744188F83;
        Mon, 14 Mar 2022 17:24:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Sean Allred <allred.sean@gmail.com>, rsbecker@nexbridge.com,
        git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
        <01cc01d83671$0acd4a20$2067de60$@nexbridge.com>
        <87zglu9c82.fsf@gmail.com>
        <01f201d836e5$89247c30$9b6d7490$@nexbridge.com>
        <87v8whap0b.fsf@gmail.com>
        <01f301d836eb$5c7a6810$156f3830$@nexbridge.com>
        <87r175amw2.fsf@gmail.com>
        <f6ecca05-b669-0e36-302f-a6113571ac12@iee.email>
        <87ilsha2b7.fsf@gmail.com> <xmqqtuc1tpdj.fsf@gitster.g>
        <697d8717-bd3f-0871-d5b3-e6303c4ed726@iee.email>
Date:   Mon, 14 Mar 2022 21:24:48 +0000
In-Reply-To: <697d8717-bd3f-0871-d5b3-e6303c4ed726@iee.email> (Philip Oakley's
        message of "Mon, 14 Mar 2022 11:56:17 +0000")
Message-ID: <xmqq1qz4p6qn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DCD412C-A3DD-11EC-AC57-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 13/03/2022 23:16, Junio C Hamano wrote:
>> Sean Allred <allred.sean@gmail.com> writes:
>>
>>> rather than use magic comments :-) Adapting to your suggestion, this
>>> might look like the following:
>>>
>>>     A. U. Thor <foo@example.com> <ada.example.com> <[ approxidate ]>
>> You'd probably want a timerange (valid-from and valid-to), instead
>> of one single timestamp?
> I'm not so sure that the date range approach won't bring it's own
> problems. What happens outside the date range? i.e. Do we then have
> three identities: Before, During, and After, with only 'During' being
> defined?

I have been assuming that the default is "what the commit has is
correct".

> I more see a single date being used as a termination point for an
> existing email sequence that defines a retrospective end point for the
> mapping of the old email addresses to a single person.

Implicitly specifying the valid-from date (which is either the
beginning of time, or the newest of valid-until time for the same
identifying string that is older than the valid-until date for the
entry in question) is fine.  I do not see fundamental difference
between the approach you suggest and having an explicit valid-from
date.
