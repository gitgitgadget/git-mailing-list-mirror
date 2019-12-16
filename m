Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E750C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256CB2082E
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t2cadfpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfLPSsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:48:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50580 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfLPRyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 12:54:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE03D904C7;
        Mon, 16 Dec 2019 12:54:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T5slsG24JrJqdvY2PI+cVVyNs5U=; b=t2cadf
        pOGqm+n6OYM+cCUWN4ViXZYl8yB5BX4c15jevECcv6Z5FuMPN7ktM7rcOjr7wzuC
        zYWE9K8iF16GIpKegFW+67C19l9TBAbzqQUTKAuEqh1pB8N3AjDXYprRI08EXo3o
        W+0AqjsHjEbHiySsecTOmozknZzpGo4AnfzIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hJvOj2o2TV1d0mBBr3eioBVskBiz7Y8z
        0348KhNaVK9kPm5kG2p3DmWYyFr7Dk4n1ibvSsNLwtKJ0VEIwdSuzZ7YQQ8NI7EA
        TZvbcBrKwVOy82uGAsqvg0sybj1TwnPVk7HCbuG9VGYoH2ieJGXViHPFLaeTKGXY
        fUbvtckNHk0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4407904C6;
        Mon, 16 Dec 2019 12:54:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2F3A904C2;
        Mon, 16 Dec 2019 12:54:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v3 1/4] git-p4: yes/no prompts should sanitize user text
References: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
        <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
        <fff93acf4430e2e7702ae1345f9899244a9867aa.1576179987.git.gitgitgadget@gmail.com>
        <20191213014537.GA13064@generichostname>
        <xmqqsgloj9fd.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1912152125390.46@tvgsbejvaqbjf.bet>
Date:   Mon, 16 Dec 2019 09:54:08 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1912152125390.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 15 Dec 2019 21:30:40 +0100 (CET)")
Message-ID: <xmqq1rt4kvgf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10633744-202D-11EA-A86D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 13 Dec 2019, Junio C Hamano wrote:
>
>> Denton Liu <liu.denton@gmail.com> writes:
>>
>> >> @@ -4170,3 +4175,4 @@ def main():
>> >>
>> >>  if __name__ == '__main__':
>> >>      main()
>> >> +
>> >
>> > Spurious trailing line. Perhaps we could make GGG error out on
>> > whitespace errors before submissions are allowed?
>>
>> I think you are asking the tool for too much support.
>>
>> It may help a lot more if we gave a Makefile target (or two) that
>> the contributors can run before going public.  Perhaps
>>
>>
>> 	O=origin/master
>> 	upstream-check::
>> 		git log -p --check $(O)..
>>
>> that can be used like so:
>>
>> 	$ make upstream-check
>> 	$ make O=gitster/next upstream-check
>>
>> That way, those who use format-patch+email without GGG or those who
>> push to a shared repository to be reviewed among the peer developers
>> before going public would benefit, not just GGG users.
>>
>> Hmm?
>
> I'd like that a lot, _and_ I think GitGitGadget could learn the trick of
> running that `Makefile` target and report failures back to the PR
> _especially_ because GitGitGadget knows the base branch of the PR.

Yup.  That's the right approach---provide a common base that
everybody can use, and then teach the tool help its users with it.
That way, the improvement won't be limited to the audience of a
single tool.
