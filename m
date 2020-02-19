Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD5C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F093B2464E
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y5hhFJTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgBSQzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:55:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64730 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSQzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:55:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C40146C16;
        Wed, 19 Feb 2020 11:55:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YV3IVPmzvk0RYGbJHHYZCb+F9cQ=; b=Y5hhFJ
        TJaXyl+lbXEHxNVs7cv/qWeF8/18YyW+8ms0zRMNpChil76UGg0Rn8fU9ePc2IDw
        qXY/J6qT2eqv+UBXVtojZ/H6kDzgDg6uXG6uMDRJONeE9tH/O42uekt1qS4iXESL
        9twfZz32FCW9qLDmJl/6P3ZeNiFbXO37XmjvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WqgI9GFg8DOF+snw8+8rOurPai2dwNWF
        h6hDCk5Ph9SxvkqKHR2YnrJssOkU7/119mhAnISa0QC5ZwzhbVp7vYl8Dtupoxt3
        nQvOqSMBbxWeX+XNVnz3fZEJGExNrUcjesOBKUzzs7F6K8TT3risTVjyOhgLDy4B
        Vmz5KGtPAj0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CEEA46C14;
        Wed, 19 Feb 2020 11:55:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B53B346C13;
        Wed, 19 Feb 2020 11:55:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging info
References: <20200214015343.201946-1-emilyshaffer@google.com>
        <20200214015343.201946-4-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2002191515310.46@tvgsbejvaqbjf.bet>
Date:   Wed, 19 Feb 2020 08:55:04 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2002191515310.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 19 Feb 2020 15:18:09 +0100 (CET)")
Message-ID: <xmqq7e0ih5zr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 942F09CA-5338-11EA-ACFD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +int cmd_main(int argc, const char **argv)
>> +{
>> +...
>> +	if (report == NULL) {
>> +		strbuf_release(&report_path);
>> +		die("couldn't open '%s' for writing", report_path.buf);
>> +	}
>> +
>> +	strbuf_write(&buffer, report);
>> +	fclose(report);
>> +
>> +	fprintf(stderr, _("Created new report at '%s'.\n"), report_path.buf);
>> +
>> +	UNLEAK(buffer);
>> +	UNLEAK(report_path);
>> +	return -launch_editor(report_path.buf, NULL, NULL);
>
> This would be the first time (at least that _I_ know of) that we use `-`
> in this way. We seem to use `!!` a lot more often. And now I wonder
> whether there is a reason for that `-` that I missed?

In general, our preferred way to report an error from API functions
is to return a negative number and a success is reported by
returning zero.

The argument to exit(3), which the return value from the main()
function essentially is, on the other hand, is expected to be a
small non-negative integer.  As long as we are in tight control of
the range of the returned value from launch_editor() (i.e. it must
return a small non-positive integer whose negation is suitable to be
fed to exit(3)), the above is fine.

The idiom "return !!fn();" is to canonicalize the value to 0 or 1
for the caller who asked "so, did fn() give us 0 or non-zero?",
which can also be used as the value given to exit(3), and could be
more appropriate under some conditions:

 - we MUST know launch_editor() returns zero if and only if it is
   successful.

 - we do not have to be confident to be in tight control of the
   range of the returned value from launch_editor() (e.g. it could
   return a positive upon an error).

 - we MUST NOT care to differenciate different error codes returned
   from launch_editor().  IOW, we must be fine to give the invoker
   of the program only 0 (success) or 1 (unspecified failure).

Use of "return !!fn();" that is not to give to exit(3) is probably
more common in our codebase.  See apply.c::try_create_file() and the
comment before the function about its possible return values for
example.
