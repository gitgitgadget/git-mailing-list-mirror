Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D742CC47247
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6567208D6
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WahNhi9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEGXGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:06:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50876 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgEGXGU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 19:06:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 156A7DA8D7;
        Thu,  7 May 2020 19:06:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E//LaNB1xfX4+YdVM/xI76p0rAg=; b=WahNhi
        9Xm06YVpL1pr2681ahSlBWPoDAmYOKKsz0ZL2Jv93FdfG9ltBDJOfIGbchl7ZX/F
        qKqCPOYxmYDkuPhdJTW06CEVz3H+P0J3VPrEDO46ZEPGIRk4a0+7ezZQTshZYCM+
        JV4TTEDdg4c3X1gWSd7DqLnBy1dxVE98FXkac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G1q1LvEBv8i/leaucqMTcJBHNuDYJfvJ
        AqkjiRPkyKHSF/gNbWqG6d8x/8WAbKxfJDmDAUSa7QguDS6DHN1qvCrmGxVzKPo7
        dhEtbwhiJS4n6jgfq1+VlNCfNZ5tKmHvZ+qQ26tXf5i6LNfWzojKiuvgcZ/AfVfz
        zDRLTnwZdAI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D887DA8D6;
        Thu,  7 May 2020 19:06:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 579BCDA8D5;
        Thu,  7 May 2020 19:06:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] bugreport: collect list of populated hooks
References: <20200427233820.179891-1-emilyshaffer@google.com>
        <20200430012425.209122-1-emilyshaffer@google.com>
        <20200430015049.GA115238@google.com>
        <xmqqv9lgswar.fsf@gitster.c.googlers.com>
        <xmqqwo5wpqvg.fsf@gitster.c.googlers.com>
        <20200507210849.GH77802@google.com>
Date:   Thu, 07 May 2020 16:06:14 -0700
In-Reply-To: <20200507210849.GH77802@google.com> (Emily Shaffer's message of
        "Thu, 7 May 2020 14:08:49 -0700")
Message-ID: <xmqqa72j2vmh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AB975B0-90B7-11EA-AAF2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>>  test_expect_success 'indicates populated hooks' '
>> -	test_when_finished rm git-bugreport-hooks.txt &&
>> -	test_when_finished rm -fr .git/hooks &&
>
> I'm not sure it's necessary to lose these two lines. Especially the
> generated bugreport I'd like to clean up.

I do not care either way, actually.  I left it so that it would be
easier to debug the test by looking at the output.

>> +	rm -fr .git/hooks &&
>>  	mkdir .git/hooks &&
>> -	write_script .git/hooks/applypatch-msg &&
>> -	write_script .git/hooks/prepare-commit-msg.sample &&
>> +	for hook in applypatch-msg prepare-commit-msg.sample
>> +	do
>> +		write_script ".git/hooks/$hook" <<-\EOF || return 1
>> +		echo "hook $hook exists"
>> +		EOF
>> +	done &&
>
> I like this placeholder script a lot.

I actually don't.  At least the final version should not quote EOF
(otherwise $hook will appear verbatim).

>>  	git bugreport -s hooks &&
>>  	grep applypatch-msg git-bugreport-hooks.txt &&
>>  	! grep prepare-commit-msg git-bugreport-hooks.txt
>> -- 
>> 2.26.2-447-gd61d20c9b4
>> 

Thanks.
