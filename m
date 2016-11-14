Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12AAC1F40E
	for <e@80x24.org>; Mon, 14 Nov 2016 01:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbcKNBzZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Nov 2016 20:55:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56346 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751167AbcKNBzY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2016 20:55:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 376C550973;
        Sun, 13 Nov 2016 20:55:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xQZg5nyyTEHK9E4oYaK+kfNGB2M=; b=Nwn+Qc
        zUdENNgUg690KRBLwIZ7hrTRn2AmmVH6QR2aF1vOILX14ieu28tLjbzBHyQi2h4h
        RyDYTXgtl+Pm+PH10KzdyyPlkTaIdl9+ED6a8qwGCkhqf0qOgWvCifzcpj1gGflA
        SXWT+FQMvhKQibl8irm8vKhMUi9S9AYwHO6zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m/k5mw6YA/XUOg6A4aiLir0UiVQtKVBG
        ZnpUq9V9FLjGpJxJKLRGks/XwQAXiML41deKL9bsboW2P+whjO6Hl7pM5LexZKlT
        iZJ9JHkANJ0Ma1FzzmE8t6TRHcX1iTJfxdom+TyuSVV0Ulvz3cJbroyKRmosRM+E
        ScK2lexj+Ac=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F73350972;
        Sun, 13 Nov 2016 20:55:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9638250971;
        Sun, 13 Nov 2016 20:55:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for ref printing atoms
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-14-Karthik.188@gmail.com>
        <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
        <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
Date:   Sun, 13 Nov 2016 17:55:21 -0800
In-Reply-To: <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
        (Karthik Nayak's message of "Sun, 13 Nov 2016 19:37:41 +0530")
Message-ID: <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67550A26-AA0D-11E6-A34D-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

>>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>>> index 600b703..f4ad297 100644
>>> --- a/Documentation/git-for-each-ref.txt
>>> +++ b/Documentation/git-for-each-ref.txt
>>> @@ -96,7 +96,9 @@ refname::
>>>         slash-separated path components from the front of the refname
>>>         (e.g., `%(refname:strip=2)` turns `refs/tags/foo` into `foo`.
>>>         `<N>` must be a positive integer.  If a displayed ref has fewer
>>> -       components than `<N>`, the command aborts with an error.
>>> +       components than `<N>`, the command aborts with an error. For the base
>>> +       directory of the ref (i.e. foo in refs/foo/bar/boz) append
>>> +       `:base`. For the entire directory path append `:dir`.

Sorry that I missed this so far and I do not know how many recent
rerolls had them like this, but I am not sure about these :base and
:dir suffixes.  From their names I think readers would expect that
they do rough equivalents to basename() and dirname() applied to the
refname, but the example contradicts with that intuition.  The
result of applying basename() to 'refs/boo/bar/boz' would be 'boz'
and not 'foo' as the example says.

So assuming that :base and :dir are unrelated to basename() and
dirname():

 - I think calling these :base and :dir may be misleading

 - More importantly, what do these do?  I do not think of a good
   description that generalizes "base of refs/foo/bar/boz is foo" to
   explain your :base.

 - A :dir that corresponds to the :base that picks 'foo' from
   'refs/foo/bar/boz' needs an example, too.

Or is the above example simply a typo?  Is refs/foo/bar/boz:base
'boz', not 'foo'?



