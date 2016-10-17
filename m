Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAD171F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 18:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756779AbcJQSIj (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 14:08:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55616 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755769AbcJQSIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 14:08:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AED5E450E5;
        Mon, 17 Oct 2016 14:08:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=RoPD10fJk49lm/BJpghYohLtB
        O0=; b=KO1XUim3FlQajXHRL5wLi2puqDufRffzz+O76lqRkguPmHGP3lG09xoNW
        bzb34Gkd7XfIGfuOmkyB7gN1J/bjQ0id4hs5APFZMjRsw5evn97410WdpXHhIm2n
        MiSAchqrJqr75qvXCZNbXQ/MHMJ9QWKMtq97MJLSPHoxwZ4AEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=LEcgITO88p2uUFCmFWN
        H2JoijI+yJt4U76esfNk5H9bL45kfpv5vHzP+zejURNSyF226pxzj4QWd0TfltWH
        pfNKJItpcWB9IQliWlwmdv9aWX1cgJIxs0Aaz1gFwdsJlcfruRi6ihfQ7y6H/CGj
        mg0kRKSaRTAv/cTocDG7oSd0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6CDC450E4;
        Mon, 17 Oct 2016 14:08:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17E77450E3;
        Mon, 17 Oct 2016 14:08:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] cocci: avoid self-references in object_id transformations
References: <a5ed26c0-7fea-259c-74c1-0cd870a35290@web.de>
        <20161015134503.u3aznujploqee2le@vauxhall.crustytoothpaste.net>
Date:   Mon, 17 Oct 2016 11:08:33 -0700
Message-ID: <xmqqlgxmvof2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B8FE55F0-9494-11E6-A736-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Sat, Oct 15, 2016 at 10:25:34AM +0200, Ren=C3=A9 Scharfe wrote:
>> The object_id functions oid_to_hex, oid_to_hex_r, oidclr, oidcmp, and
>> oidcpy are defined as wrappers of their legacy counterparts sha1_to_he=
x,
>> sha1_to_hex_r, hashclr, hashcmp, and hashcpy, respectively.  Make sure
>> that the Coccinelle transformations for converting legacy function cal=
ls
>> are not applied to these wrappers themselves, which would result in
>> tautological declarations.
>
> Ah, yes, this is a good idea.  I've had to hack around this, but this i=
s
> much better than having to fix it up by hand.

Yes, seeing an empty *.cocci.patch files after running coccicheck is
a great feeling, but without something like this patch, we can never
reach that goal ;-)

Thanks.

... oops.  Totally unrelated to this patch, but I see these in
strbuf.cocci.patch (this is at the tip of 'pu'), which are total
nonsense.  Perhaps I am running a way-stale spatch?  It claims to be
"spatch version 1.0.0-rc19 with Python support and with PCRE support"

--- date.c
+++ /tmp/cocci-output-21568-bd3448-date.c
@@ -179,7 +179,7 @@ const char *show_date(unsigned long time
=20
 	if (mode->type =3D=3D DATE_UNIX) {
 		strbuf_reset(&timebuf);
-		strbuf_addf(&timebuf, "%lu", time);
+		strbuf_addstr(&timebuf, time);
 		return timebuf.buf;
 	}
=20
--- log-tree.c
+++ /tmp/cocci-output-21608-b02087-log-tree.c
@@ -400,7 +400,7 @@ void log_write_email_headers(struct rev_
 		extra_headers =3D subject_buffer;
=20
 		if (opt->numbered_files)
-			strbuf_addf(&filename, "%d", opt->nr);
+			strbuf_addstr(&filename, opt->nr);
 		else
 			fmt_output_commit(&filename, commit, opt);
 		snprintf(buffer, sizeof(buffer) - 1,

