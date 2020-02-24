Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7A1C38BE0
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F55920838
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OxSp2VEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgBXSay (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:30:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57202 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbgBXSay (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:30:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 890A7A6072;
        Mon, 24 Feb 2020 13:30:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gq6cEvWWMpjBSmY8R5nXXGoS0ss=; b=OxSp2V
        EEzgP5K6uJMrDuPJk75gLzExxKqVcbN+JciX62oyfUU/K6qVAcOli28sbwxTd9uL
        zhJLXYbgN0Pz9ybK8XozvyxbdQ6LXg7uwy7JMwJRRu+OHtnMDMP5oPuhYlf9I8Ak
        ICgjOSpLsH1U6Z2ApcCfVEgrC+jnpMT2DAhls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wu4LVEhZdL6OH3gXCdvq1XaLgwCgV1MI
        GZ/WCOltuSPwQcBN/yE2lco6e/hWdUx4GjcIhdlEbguaJ6gQ1BXDkS3zrjYTrQs6
        SLNMiYgeuCq3emqMrXxLBHUxqikuVWsTFB9sG9q3hzTW66hPkU6Cg4tP4lrMjPeR
        8myNhGnPh0Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82285A6071;
        Mon, 24 Feb 2020 13:30:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A4F12A606E;
        Mon, 24 Feb 2020 13:30:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 19/24] tag: store SHA-256 signatures in a header
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-20-sandals@crustytoothpaste.net>
Date:   Mon, 24 Feb 2020 10:30:47 -0800
In-Reply-To: <20200222201749.937983-20-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 22 Feb 2020 20:17:44 +0000")
Message-ID: <xmqq36azrg6g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7E60A44-5733-11EA-9390-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> In the future, we'll want to allow a user to sign both the SHA-1 version
> of a tag and the SHA-256 version at the same time.  Since for SHA-1 the
> signature is appended to the tag message, we must use a different way to
> allow multiple signature.

"multiple signatureS"?

> The transition plan envisions this using a gpgsig-sha256 header, much as
> for commits.  Refactor the commit code that performs parsing of this
> header and use it for tags that use SHA-256.  Check that we get tags in
> the correct format depending on what algorithm we're using.

Sounds sensible.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index b3c1092338..caeabfb293 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -54,6 +54,17 @@ test_atom() {
>  	"
>  }
>  
> +test_atom_hash () {
> +	local val
> +	if [ "$(test_oid algo)" = sha1 ]
> +	then

        if test "$(...)" = sha1
        then

I saw there are a few other copies of these in the result of
applying the whole series.

> +	else
> +
> +		git cat-file tag "$1" | sed -e '/^gpgsig-sha256/{s/^gpgsig-sha256 //;h;d};/^ /d;${p;x;/^$/d}'

Please line-wrap an overlong line, immediately after the pipe '|' character.

> +	fi
>  }
