Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750CF1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933978AbdA0ReV (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 12:34:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60939 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933854AbdA0Rdf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:33:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBAC162847;
        Fri, 27 Jan 2017 12:33:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1agwnx5LoFqdlzDJOqV46FJ3kxQ=; b=mVPajs
        IwrXQwOwwRu7YuGJSbuSAhiNlpElo9/KmeyRc2VFvtLXjWskho3lP1vh+j3kCzlo
        963ZHR+V430bCIHWwlBA2ktQPzx63gZHz/ZsgN4NZ+Ss4kY4FPFtJWzKmjChlPfB
        S3TRrCO+tE+p5MKMwEHGQ6SudmVt8OOkehJUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iYVcm1TiEg7CLy7bneUJiaTJAPw7yWts
        GdDvR1D08iHqoAaJDeRi5pOOPlalGKbG3fYq2lZuvUPC44ePTh6f+KI/P2aPiD/k
        A1y/q3ku0QJjxUkYs5h1BmQbrhvTPjJbF+6GrgGhKVgDeP7bg8iMNSzi6CEv9B9+
        /c2rfDnMgh8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E25FF62843;
        Fri, 27 Jan 2017 12:33:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49D3562842;
        Fri, 27 Jan 2017 12:33:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, George Vanburgh <george@vanburgh.me>
Subject: Re: [PATCH v2] git-p4: Fix git-p4.mapUser on Windows
References: <01020159c0e82598-e373cf0d-2bad-41bb-b455-6896ad183e22-000000@eu-west-1.amazonses.com>
        <01020159d4ea6861-fce45d61-8be5-49b0-ab4e-d161b9429795-000000@eu-west-1.amazonses.com>
Date:   Fri, 27 Jan 2017 09:33:31 -0800
In-Reply-To: <01020159d4ea6861-fce45d61-8be5-49b0-ab4e-d161b9429795-000000@eu-west-1.amazonses.com>
        (George Vanburgh's message of "Wed, 25 Jan 2017 09:17:29 +0000")
Message-ID: <xmqqa8ac1k7o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9C433FC-E4B6-11E6-A8F8-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Vanburgh <george@vanburgh.me> writes:

> From: George Vanburgh <gvanburgh@bloomberg.net>
>
> When running git-p4 on Windows, with multiple git-p4.mapUser entries in
> git config - no user mappings are applied to the generated repository.
> ...
> Using splitlines solves this issue, by splitting config on all
> typical delimiters ('\n', '\r\n' etc.)

Luke, Lars, this version seems to be in line with the conclusion of
your earlier reviews, e.g.

<CAE5ih7_+Vc9oqKdjo8h2vgZPup4pto9wd=sBb=W6hCs4tuW2Jg@mail.gmail.com>

Even though it looks OK to my eyes, I'll wait for Acks or further
refinement suggestions from either of you two before acting on this
patch.

Thanks.

> Signed-off-by: George Vanburgh <gvanburgh@bloomberg.net>
> ---
>  git-p4.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index f427bf6..b66f68b 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -656,7 +656,7 @@ def gitConfigInt(key):
>  def gitConfigList(key):
>      if not _gitConfig.has_key(key):
>          s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
> -        _gitConfig[key] = s.strip().split(os.linesep)
> +        _gitConfig[key] = s.strip().splitlines()
>          if _gitConfig[key] == ['']:
>              _gitConfig[key] = []
>      return _gitConfig[key]
>
> --
> https://github.com/git/git/pull/319
