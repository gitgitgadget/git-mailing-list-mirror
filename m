Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D4420A17
	for <e@80x24.org>; Mon, 23 Jan 2017 19:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbdAWTiL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 14:38:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50979 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750723AbdAWTiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 14:38:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67FA863100;
        Mon, 23 Jan 2017 14:38:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pc7IeQ0io6USURy/fYccfg+Nq80=; b=rObS+x
        Dkgu7QG3nrfIweqVt5UtFUxkdvFFKYMuhithGDGIxnSM6tMnzzUHlufHAg3Xpb6c
        KlzDA1ZV7qhmJkt1674WJggS+STRLE/g0/MG572pWATLYhibrQ9WyhWXl3b5gvlI
        jYD58OWnUaUdgScH7PinH8Szebg2HdttMLMHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nIaEPDo5l55JG7ONSUuqVwFPAfUe0API
        CGVvDwmKAGlrkeTGa+5TMC8kwxKXthTSLk1pLOUJ22jDc3WYyOLnAdimvcbkrtaf
        y9er90VhYSLbORlslblKBlUzPTPaPiuwcukCtA29X66FAgZ/p5Dlqtk5BiIXCmd4
        Wa/+80r2Bkg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ECA6630FF;
        Mon, 23 Jan 2017 14:38:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9B41630FE;
        Mon, 23 Jan 2017 14:38:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Dakota Hawkins <dakota@dakotahawkins.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [RFC] Case insensitive Git attributes
References: <CAHnyXxRx_iagZhki1rmVEpw+GZPWBRx7mNmahs3pruy57L3h-Q@mail.gmail.com>
        <xmqqvat5sjym.fsf@gitster.mtv.corp.google.com>
        <C265204B-BCCF-4085-9933-F28EB459CFB9@gmail.com>
        <xmqq1svtshnr.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 23 Jan 2017 11:38:06 -0800
In-Reply-To: <xmqq1svtshnr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 23 Jan 2017 11:25:12 -0800")
Message-ID: <xmqqwpdlr2ht.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 773C50F2-E1A3-11E6-A917-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So you are worried about the case where somebody on a case
> insensitive but case preserving system would do
>
>     $ edit file.txt
>     $ edit .gitattributes
>     $ git add file.txt .gitattributes
>
> and adds "*.TXT	someattr=true" to the attributes file, which
> would set someattr to true on his system for file.txt, but when the
> result is checked out on a case sensitive system, it would behave
> differently because "*.TXT" does not match "file.txt"?
>
> How do other systems address it?  Your Java, Ruby, etc. sources may
> refer to another file with "import" and the derivation of the file
> names from class names or package names would have the same issue,
> isn't it?  Do they have an option that lets you say
>
>     Even though the import statements may say "import a.b.C", we
>     know that the source tarball was prepared on a case insensitive
>     system, and I want you to look for a/b/C.java and a/b/c.java and
>     use what was found.
>
> or something like that?  Same for anything that records other
> filenames in the content to refer to them, like "Makefile".
>
> My knee jerk reaction to that is that .gitattributes and .gitignore
> should not be instructed to go case insensitive on case sensitive
> systems.  If the system is case insensitive but case preserving,
> it probably would make sense not to do case insensitive matching,
> which would prevent the issue from happening in the first place.

Sorry, but there is a slight leap in the above that makes it hard to
track my thought, so let me clarify a bit.  

In the above, I am guessing the answer to the "How do other systems
address it?" question to be "nothing".  And that leads to the
conclusion that it is better to do "nothing on case sensitive
systems, and probably become evem more strict on case insensitive
but case preserving systems", because that will give us a chance to
expose the problem earlier, hopefully even on the originating
system.
