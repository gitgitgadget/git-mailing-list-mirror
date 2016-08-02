Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19FCE1F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 18:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936293AbcHBSRL (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 14:17:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52353 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932253AbcHBSQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 14:16:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 736B9321C8;
	Tue,  2 Aug 2016 14:16:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JZyvg2H2sFvTOJs1xoJaxMk/Ghk=; b=Lvmj9q
	VYwMJvvotNqbf1fWrcjX6TGKPlRW7u2hQYpBRAhfPFB2zSBaYA/Nl43pUw7/Tj9T
	/A08QBTmX/Pz1z7//VW5RAel5e6h6t8tvEXp8OZiDO+yYlkjfViRXlhLhQLrVtAE
	vJS/36tupnJENVP2KlP0F5Ua3MJgkxIj767ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WmlRkTtvNWoUjOWHOJZqQ62A7cqeXFEu
	AuLh3HwqtVE7UMDbtL04VGrheGFrUOrN1aekGG7oIRUtJJTpbxLKwG4r/v5mes2W
	LEfGx6V69BZj1i8kjBUkWEhlQG1DzOSH41XtcOq0plvIiE2YV/aggNaTbc/AucTQ
	7WBSSSm+xmY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6ACBD321C7;
	Tue,  2 Aug 2016 14:16:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E58BB321C6;
	Tue,  2 Aug 2016 14:16:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joe Perches <joe@perches.com>
Cc:	Florian Mickler <florian@mickler.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>
Subject: Re: get_maintainer.pl and .mailmap entries with more than 2 addresses
References: <1470155781.3998.181.camel@perches.com>
Date:	Tue, 02 Aug 2016 11:16:26 -0700
In-Reply-To: <1470155781.3998.181.camel@perches.com> (Joe Perches's message of
	"Tue, 02 Aug 2016 09:36:21 -0700")
Message-ID: <xmqqpoprdojp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B7974EA-58DD-11E6-959F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> Hello Florian.
>
> There is at least an oddity with get_maintainer handling of a
> .mailmap entry form.
>
> For instance:
>
> Mauro's .mailmap entry is:
> Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com> <mchehab@infradead.org> <mchehab@redhat.com> <m.chehab@samsung.com> <mchehab@osg.samsung.com> <mchehab@s-opensource.com>
>
> Is this a valid form?

I do not think so, according to "git shortlog --help" (the canonical
source of the document is Documentation/mailmap.txt, but shortlog
doc includes it).  Here is the relevant bits.

    In the simple form, each line in the file consists of the canonical
    real name of an author, whitespace, and an email address used in the
    commit (enclosed by '<' and '>') to map to the name. For example:
    --
            Proper Name <commit@email.xx>
    --

    The more complex forms are:
    --
            <proper@email.xx> <commit@email.xx>
    --
    which allows mailmap to replace only the email part of a commit, and:
    --
            Proper Name <proper@email.xx> <commit@email.xx>
    --
    which allows mailmap to replace both the name and the email of a
    commit matching the specified commit email address, and:
    --
            Proper Name <proper@email.xx> Commit Name <commit@email.xx>
    --
    which allows mailmap to replace both the name and the email of a
    commit matching both the specified commit name and email address.

