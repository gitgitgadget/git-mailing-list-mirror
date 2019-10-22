Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18C301F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbfJVXq4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:46:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63649 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbfJVXqz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:46:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CDA61AE8F1;
        Tue, 22 Oct 2019 19:46:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4QxSH3pZ+76wNZ1barb50BtBP88=; b=O4Ke4Q
        iE20Lx80MAyEsVpZMuUOKiy7ISYh79mx0KX0qsz818+mE1Km3t+mNl8q6pQanii/
        twPfZjjuheV9Qe5N6aIZbURClFeaeiomPz3bzJtBaRjcMFfjZAhYJkiXQVidTubF
        uztE6KAPTVux76D+R7j9XTXBPIoHNBkgxQxhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pH8pwK9I7G/qm6KNGRTQB80xIxXXA4Ey
        IyWWbqK5GJ+NEHtvcTtONehLmOyPw37btadEDeD71+/AoBmmvkMeT4e69QzRIDtQ
        76FnicNNrpRopybEwYZ0WU0yzEkkBFDZHOU/SWnrnz8SA21FVgf/dglbPSDoELFX
        5rYjoXvHpro=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5F73AE8F0;
        Tue, 22 Oct 2019 19:46:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEE24AE8ED;
        Tue, 22 Oct 2019 19:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pretty: Add "%aU"|"%au" option to output author's username
References: <20191022232847.5212-1-prarit@redhat.com>
Date:   Wed, 23 Oct 2019 08:46:47 +0900
In-Reply-To: <20191022232847.5212-1-prarit@redhat.com> (Prarit Bhargava's
        message of "Tue, 22 Oct 2019 19:28:47 -0400")
Message-ID: <xmqqy2xcjqc8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3753B9BE-F526-11E9-9536-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prarit Bhargava <prarit@redhat.com> writes:

> Subject: Re: [PATCH] pretty: Add "%aU"|"%au" option to output author's username

Downcase "Add" (see "git shortlog --no-merges -100 master" and
mimick the project convention).

> Add a "%aU"|"%au" option that outputs the author's email username.

Even though I personally do not see the use for it, I agree it would
make sense to have an option to show the local part only where the
e-mail address is shown.  

I do not know if u/U is a good mnemonic; it hints too strongly that
it may come from GIT_{AUTHOR/COMMITTER}_NAME but that is not what
you are doing---isn't there a letter that better conveys that this
is about RFC 2822 local-part (cf. page 16 ieft.org/rfc/rfc2822.txt)?

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index b87e2e83e6d0..479a15a8ab12 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -163,6 +163,9 @@ The placeholders are:
>  '%ae':: author email
>  '%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
>  	or linkgit:git-blame[1])
> +'%au':: author username
> +'%aU':: author username (respecting .mailmap, see linkgit:git-shortlog[1]
> +	or linkgit:git-blame[1])
>  '%ad':: author date (format respects --date= option)
>  '%aD':: author date, RFC2822 style
>  '%ar':: author date, relative

> diff --git a/pretty.c b/pretty.c
> index b32f0369531c..2a5b93022050 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -706,6 +706,11 @@ static size_t format_person_part(struct strbuf *sb, char part,
>  		strbuf_add(sb, mail, maillen);
>  		return placeholder_len;
>  	}
> +	if (part == 'u' || part == 'U') {	/* username */
> +		maillen = strstr(s.mail_begin, "@") - s.mail_begin;
> +		strbuf_add(sb, mail, maillen);
> +		return placeholder_len;
> +	}

I think users get %eu and %eU for free with this change, which should
be documented.
