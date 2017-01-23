Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E559A20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 19:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbdAWTZQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 14:25:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53013 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750705AbdAWTZP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 14:25:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E8A362E23;
        Mon, 23 Jan 2017 14:25:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jnYT8Dutp6mU0wGi/Bymko6ecpI=; b=r01Daf
        4HP5I/Mti1xO7Wv4ho4rGpKm2EGCSWOsjfI3YOP7G+MTgBZxzJ67y1i5KQPKCyWM
        aifPdx6E3Cpbqa9w36+KaZgtzJ452vyxftW/2yIdB+4thoGHxY7Xs5swFVZatuhR
        WlCMwmHpjTmdZ/XFut41c8Ect6G8MBDAGU8nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N2Z5PHhtY86i234yZe70s0g3XZx4J1G/
        jA3r/EhDfppoGHPu1eH2vM7+z6gwwD6wOExhxrisfx8XV9URn/TJeMtISUHe/GGT
        xG3TnRpD+IvM20XlJLgqrWtWfgtp888FpD4SCYFbgumaaMQePQ0Sx3nPPVv7rDox
        KxtaQWgVBLY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15AD062E22;
        Mon, 23 Jan 2017 14:25:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D45962E21;
        Mon, 23 Jan 2017 14:25:13 -0500 (EST)
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
Date:   Mon, 23 Jan 2017 11:25:12 -0800
In-Reply-To: <C265204B-BCCF-4085-9933-F28EB459CFB9@gmail.com> (Lars
        Schneider's message of "Mon, 23 Jan 2017 19:42:40 +0100")
Message-ID: <xmqq1svtshnr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9BFA2EC-E1A1-11E6-99D8-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Problem:
> Git attributes for path names are generally case sensitive. However, on 
> a case insensitive file system (e.g. macOS/Windows) they appear to be
> case insensitive (`*.bar` would match `foo.bar` and `foo.BAR`). That 
> works great until a Git users joins the party with a case sensitive file 
> system. For this Git user the attributes pattern only matches files with
> the exact case (*.bar` would match only `foo.bar`).
>
> Question/Proposal:
> Could we introduce some flag to signal that certain attribute patterns
> are always case insensitive? 
>
> Thread:
> http://public-inbox.org/git/C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com/#t

Thanks for a pointer.

So you are worried about the case where somebody on a case
insensitive but case preserving system would do

    $ edit file.txt
    $ edit .gitattributes
    $ git add file.txt .gitattributes

and adds "*.TXT	someattr=true" to the attributes file, which
would set someattr to true on his system for file.txt, but when the
result is checked out on a case sensitive system, it would behave
differently because "*.TXT" does not match "file.txt"?

How do other systems address it?  Your Java, Ruby, etc. sources may
refer to another file with "import" and the derivation of the file
names from class names or package names would have the same issue,
isn't it?  Do they have an option that lets you say

    Even though the import statements may say "import a.b.C", we
    know that the source tarball was prepared on a case insensitive
    system, and I want you to look for a/b/C.java and a/b/c.java and
    use what was found.

or something like that?  Same for anything that records other
filenames in the content to refer to them, like "Makefile".

My knee jerk reaction to that is that .gitattributes and .gitignore
should not be instructed to go case insensitive on case sensitive
systems.  If the system is case insensitive but case preserving,
it probably would make sense not to do case insensitive matching,
which would prevent the issue from happening in the first place.


