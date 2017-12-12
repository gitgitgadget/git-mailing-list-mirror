Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41FCC1F404
	for <e@80x24.org>; Tue, 12 Dec 2017 00:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbdLLA7L (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 19:59:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50812 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750759AbdLLA7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 19:59:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D4B9BC748;
        Mon, 11 Dec 2017 19:59:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+lc8cTzAtW3AONo7uI5snYjoE80=; b=B+bs4K
        gvlhJwi6Mfw49YlfRiVz4WCeAl6TIobc/Nxn6MJYDsfix0BizOHbvYitQVkzJcCf
        OITFrTYqaqtJlzFi1rlZk8uuBKFdyBZALNiy35UAvNTZpt2IsQLUlpqysJrYCIny
        vcDDIF22+MLS/36ZX50J+F7Y7vEmWKjwo1iI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bjbHlNp/xJAgmFERsgbSx8hldcm9j7nX
        /BesmihUAeYzNM2IM6Dcr6t+tLttPImgYN8smjYC1VJvvWteMJU3VornMyFMI+3i
        K55lIPmogNmU+1RmB2RU8sdCOUHdeqrcf0snwO6+s9iFj7TIa16MfpBSAZkQJ+Xd
        FQ/nkrwgvR8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54B74BC747;
        Mon, 11 Dec 2017 19:59:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7EBCBC746;
        Mon, 11 Dec 2017 19:59:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, lars.schneider@autodesk.com,
        git@vger.kernel.org, tboegi@web.de, peff@peff.net,
        patrick@luehne.de
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
        <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
        <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com>
Date:   Mon, 11 Dec 2017 16:59:02 -0800
In-Reply-To: <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com> (Lars
        Schneider's message of "Tue, 12 Dec 2017 00:42:23 +0100")
Message-ID: <xmqqzi6o3go9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5B7B282-DED7-11E7-A03F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I contemplated:
>   - "enc" or "encode" because "eol" and "ident" use abbreviations, too
>     (enc could be confused with encryption. plus, a user might ask
>      what is the difference between "enc" and "encoding" attribute :-)
>   - "wte", "wtenc", or "worktree-encoding" to emphasize that this is 
>     the encoding used in the worktree 
>     (I fear that users think that is git-worktree, the command, related)

In the context of Git, the word "worktree" does have a specific
meaning that is different from working tree.  

Stepping back a bit, what does this thing do you are introducing?
And what does the other thing do that J6t is using, that would get
confused with this new one?

What does the other one do?  "Declare that the contents of this path
is in this encoding"?  As opposed to the new one, which tells Git to
"run iconv from and to this encoding when checking out and checking
in"?

If so, any phrase that depends heavily on the word "encode" would
not help differenciating the two uses.  The phrase needs to be
something that contrasts the new one, which actively modifies things
(what is on the filesystem is not what is stored in the object
store), with the old one, which does not (passed as a declaration to
a viewer what encoding the contents already use and does not change
anything).

Do people who will use this feature familiar with the concept of
smudge/clean?  If you want to avoid "working-tree" (or "worktree",
which definitely you would want to avoid) because you fear confused
users, perhaps "smudge-encoding" would work (we declare that the
result of smudge operations are left in this encoding, so the
opposite operation "clean" will do the reverse---and we say this
without explicitly saying that the other end of the conversion is
always UTF-8)?  Or "checkout-encoding" (the same explanation; we do
not say the opposite operation "checkin/add" will do the reverse).

I personally do not think "working-tree-encoding" is too horrible,
but I do agree that some users may be confused.  So I dunno.



