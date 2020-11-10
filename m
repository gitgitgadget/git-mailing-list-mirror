Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E31C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EE7206D8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NT5If83l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKJRCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 12:02:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54088 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJRCU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 12:02:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 775A810D335;
        Tue, 10 Nov 2020 12:02:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TJ76itK8xbdFKFMcMZfAOjyQlxk=; b=NT5If8
        3lX8F+92pNtV3R0kBtNV7BNh1MO9B1f/8IH7EaKU4NsHF6nZ/gWgjp+/BzmKYTkH
        JPYV9kytIK5dOoQdk4/ajwxRPKkMTKYb7owRkw0/WVEZDR0Ki1m8qkWKJqvwkgrK
        xZZ3hid3/8QtPBq8l1FZq2U3Xo5Cdaif4dWNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bBcOMqGJ6PNXL+f0HW2+PizsGNkzNu13
        yhoR76YXkqGYilRh3xj59ivRKs+cG0lC8l1878BMj2qN+36Vl9q7ur//jbqxtszm
        TQFONdkh96dkPl8oYPMpO28bu6HSjvAxoiNcfvsA/G3IbptFgKoUfC4xaA1bLe4W
        RA8y7Ce9T5I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F83010D334;
        Tue, 10 Nov 2020 12:02:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ADDE810D333;
        Tue, 10 Nov 2020 12:02:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jinoh Kang <luke1337@theori.io>, Junio C Hamano <junio@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] diff: make diff_free_filespec_data accept NULL
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io>
        <xmqq4km4lppy.fsf@gitster.c.googlers.com>
        <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
        <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
        <nycvar.QRO.7.76.6.2011101257540.18437@tvgsbejvaqbjf.bet>
Date:   Tue, 10 Nov 2020 09:02:13 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011101257540.18437@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 10 Nov 2020 13:08:22 +0100
        (CET)")
Message-ID: <xmqqblg587sa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BEE8BEC-2376-11EB-ABAD-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  void diff_free_filespec_data(struct diff_filespec *s)
>>  {
>> +	if (!s)
>> +		return;
>> +
>>  	diff_free_filespec_blob(s);
>>  	FREE_AND_NULL(s->cnt_data);
>
> We can write this in a more canonical way without wasting all that many
> lines:
>
> 	if (s) {
> 		diff_free_filespec_blob(s);
> 		FREE_AND_NULL(s->cnt_data);
> 	}

On only this part.  Please do not use this one, as what was posted
is better.

By making it clear that we do not do anything when given NULL
upfront, it lets readers concentrate on the main part of the
function---"now we are done with NULL, what happens on a real case?"
And when readers are doing so, one extra indentation level is just
an extra noise that does not help.

In this particular case, it is important more from coding discipline
than anything else---for a small enough function like this one whose
main part fits on less than fourth of a screen, extra indentation
does not matter, but all code tends to grow and it starts to matter
if/when we need to clean more things in the function.

Everything else said in the review was excellent and very helpful.

Thanks.
