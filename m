Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1691F667
	for <e@80x24.org>; Tue, 22 Aug 2017 16:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbdHVQDc (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 12:03:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59720 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751561AbdHVQDb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 12:03:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D784BB0464;
        Tue, 22 Aug 2017 12:03:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fl/HsLF2MqPq+5tmiN6JZ4NjR8I=; b=pBqhQx
        fbEHnrDNWcISRM3tdODRYJ63l3xdwf0Jx7Mb1MaIKn5yAml45sjiTwLxkmTl+M21
        PDcO+LxvXaEAkEOeZj8DsqWoAGqo8lF3uaM/pxzpIqNIrsBMpGe+2ben4joZ5Ay2
        VnC/O2zUSVnN/ttQEXk8oQ7xgdwFqu1z5MmiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u1HpZ6F+VFX0fju4IXbmkuDizgu1z21v
        m9u/gQzpvMyu127eETPu3a0q7KM5UJOJZOOiKxNhP25i9EFMmJ+huU3aIy/O6VD8
        GRLjZAsvgMsS4FQ2lNbE3GPSvjO5fRHEFIgc8Uc1Vp3FeNHnNTaNQCJ60MgelWWW
        ZCGITXg3fzU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0A73B0463;
        Tue, 22 Aug 2017 12:03:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38E2DB0462;
        Tue, 22 Aug 2017 12:03:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <michael@grubix.eu>
Cc:     git@vger.kernel.org, hIpPy <hippy2981@gmail.com>
Subject: Re: [PATCH v2 3/3] merge: save merge state earlier
References: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
        <cover.1503319519.git.git@grubix.eu>
        <407f205e2b824d56c652411256eea3c0047576ef.1503319519.git.git@grubix.eu>
        <xmqqk21w4et2.fsf@gitster.mtv.corp.google.com>
        <36bea69b-010a-9542-ec87-38b00d2bb009@grubix.eu>
Date:   Tue, 22 Aug 2017 09:03:29 -0700
In-Reply-To: <36bea69b-010a-9542-ec87-38b00d2bb009@grubix.eu> (Michael
        J. Gruber's message of "Tue, 22 Aug 2017 11:36:13 +0200")
Message-ID: <xmqq60df4mjy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70CB8FF2-8753-11E7-8B85-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <michael@grubix.eu> writes:

>> Can squash ever be true in this function?
>> 
>> This function has two callsites: merge_trivial() and
>> finish_automerge().
>> 
>> I think merge_trivial() will not be called under "--squash", which
>> turns option_commit off and the only callsite of it is inside an
>> else-if clause that requres option_commit to be true.  You can do a
>> similar deduction around the "automerge_was_ok" variable to see if
>> finish_automerge() can be called when "--squash" is given; I suspect
>> the answer may be no.
>
> I'll go without the if, after more testing.

I was sort of expecting that tracing the control flow would give us
the definite answer and that would be much better than any amount of
testing.

In any case, I wasn't even suggesting to remove "if".  It might even
be worth doing

	if (squash)
		BUG("the control must not reach here under --squash");
	write_emrge_heads(...);

if we know the control does not have to reach with "--squash" in
today's code, so that future careless refactoring does not break
this fix.

