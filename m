Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA546C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 02:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A293C2071B
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 02:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YkhtnNuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgICCDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:03:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52652 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgICCDg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 22:03:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1927181C4C;
        Wed,  2 Sep 2020 22:03:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JyPL+MsBFhw9nkvQhpo8z97tdJo=; b=YkhtnN
        uIC26Z6P46h22XUzLGfDsS8SgIr7/EsEYrfqz8qWMRUwcapiaL0Xv+oVE/vkDXT4
        hopE97Z1t+qclzTUtLZVcVWLGaRqQYz63MndH+j4Atsu6bu85lHtByp7US7a5ax8
        eOfqQ0sFVoJJs7IVmJAuT0nbglDdMlHPgii9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MFWptK2WuTiTKipaN2rLEFrCKN8qaZBi
        zPihQMUHSG8mJmCi5T3AjmApIvCU0VKsOC7L4RwuVzy36XyokTd/3mtwjSd8hkyA
        I/wGR0GQ9qZd4PPPP9iYodASDzaf9yuQ7jwnIic5AAz1E4+o/NW834r355PYrJSu
        tCwEPuxdR1g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1247981C4A;
        Wed,  2 Sep 2020 22:03:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C33381C49;
        Wed,  2 Sep 2020 22:03:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] fetch: no FETCH_HEAD display if --no-write-fetch-head
References: <xmqq7dtcaqob.fsf@gitster.c.googlers.com>
        <20200902210539.1981453-1-jonathantanmy@google.com>
        <20200902235628.GB4035286@google.com>
Date:   Wed, 02 Sep 2020 19:03:31 -0700
In-Reply-To: <20200902235628.GB4035286@google.com> (Jonathan Nieder's message
        of "Wed, 2 Sep 2020 16:56:28 -0700")
Message-ID: <xmqqo8mnaa6k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB2FB700-ED89-11EA-A7F9-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>  builtin/fetch.c          |  8 +++++++-
>>  t/t0410-partial-clone.sh |  7 +++++--
>>  t/t5510-fetch.sh         | 18 ++++++++++--------
>>  3 files changed, 22 insertions(+), 11 deletions(-)
>
> Thanks for fixing it, and sorry I didn't catch it during initial
> review.
> ...
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 320ba9471d..c6c4689250 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1023,11 +1023,17 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>>  				rc |= update_local_ref(ref, what, rm, &note,
>>  						       summary_width);
>>  				free(ref);
>> -			} else
>> +			} else if (write_fetch_head || dry_run) {
>> +				/*
>> +				 * Display fetches written to FETCH_HEAD (or
>> +				 * would be written to FETCH_HEAD, if --dry-run
>
> nit: to fix the parallel construction, s/would/that would/ or
> s/written/that were written/

True.

>> +				 * is set).
>> +				 */
>>  				format_display(&note, '*',
>>  					       *kind ? kind : "branch", NULL,
>>  					       *what ? what : "HEAD",
>>  					       "FETCH_HEAD", summary_width);
>> +			}

Strictly speaking, I suspect that this is still broken when the user
says "fetch --no-write-fetch-head --dry-run" in which case we should
skip this block.

And to fix it properly, we would probably need to keep track of
three things semi-independently.

 - were we told this is a "dry-run"? (current 'dry_run' variable)

 - were we told not to store fetch-head? (missing)

 - after all, are we going to write or not write fetch-head (current
   'write_fetch_head' variable)

And the conditional to protect this block would be fixed to use only
the second and new "have we seen --no-fetch-head on the command
line?" variable, and ignore the settings of the dry_run variable, I
think.

Thanks.
