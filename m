Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676801F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 17:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbcHBRUX (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 13:20:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50309 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756429AbcHBRUR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 13:20:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D699A317D5;
	Tue,  2 Aug 2016 13:17:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zoWBL04+zTz9ViXsry2rkpHaVCw=; b=x0Q73m
	udgGI3us7hq5qsbWUN8PPG62SlcvYy0pqTuFlMqBnXMV5x+p+j+xPdn2S4iLDvIw
	Bhbnn3lsn0Iy2NlQJnBBOjngu1KU6Ns01Qoql0xGeyQfkxWWI8eue5ihwhYByqXx
	LUYC363K+ioDTMiw9zD7tLzkDtp69lgUQiePw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mm30HQ/9oGc7CypzaOpmgot2fiby7BrF
	sv0bzYd/dCE95e3IrjObK4+ODZYfNTLc/SrNfpVhpx0+oHzZmX/ZPtVi28+bELtm
	pEstl1x+vM4vPH0/w6AZew8hLcE8ED3nBaOftBT5QiXaS98ZopSKoUqDbbgWFyIY
	5MDonGgRjjQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C77F7317D4;
	Tue,  2 Aug 2016 13:17:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5158D317D3;
	Tue,  2 Aug 2016 13:17:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Torstem =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"e\@80x24.org" <e@80x24.org>
Subject: Re: [PATCH] t7063: work around FreeBSD's lazy mtime update feature
References: <20160718223038.GA66056@plume>
	<20160730182005.14426-1-pclouds@gmail.com>
	<6955746D-E47E-4BB8-AB0E-44D461E67AD6@web.de>
	<CACsJy8D=dZeE1tLFRaCefkkNX8dHQfTL134Nv--5=BXvnUm1ZQ@mail.gmail.com>
	<xmqq4m74i4k3.fsf@gitster.mtv.corp.google.com>
	<20160802153715.GA25286@duynguyen>
Date:	Tue, 02 Aug 2016 10:17:24 -0700
In-Reply-To: <20160802153715.GA25286@duynguyen> (Duy Nguyen's message of "Tue,
	2 Aug 2016 17:37:15 +0200")
Message-ID: <xmqqfuqnf5uj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBE033E4-58D4-11E6-8E36-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> OK how about this squashed in? The name was taken from fbsd definition
> IN_LAZYMOD.

I am sorry that I didn't spot this possiblity earlier, but do we
need anything conditional?  Either FREEBSD or LAZYMOD prerequisite
tells very little what the "Work around lazy mtime update" is and
where it triggers (I think the conclusion of your investigation was
that the timestamp on the containing directory, but that is ONLY
recorded in the log message, i.e. readers need to run 'git blame'
to find out).

It might be a better approach to have a helper function with
descriptive name and comment early in t7063, e.g.

	# On some filesystems (e.g. FreeBSD's ext2 and ufs) this
        # and that happens when we do blah, which forces the
        # untracked cache code to take the slow path.  A test
        # that wants to make sure the fast path works correctly
        # should call this helper to make mtime of the containing
        # directory in sync with the reality after doing blah and
        # before checking the fast path behaviour
	test_sync_directory_mtime () {
		ls -ld . >/dev/null
        }

and then call it at strategic places without any prerequisite.

The helper may turn out to be useful outside the context of 7063
later, at which time we can move it to test-lib-functions, but that
is a separate step.

> Off topic. Since I found this macro defined twice, in ext2 and ufs,
> but not in zfs (found its source!), I assume zfs does not have this
> particular feature (but I didn't test it). Untracked cache may be more
> effecient there.


> -- 8< --
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index 08fc586..8bb048a 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -419,7 +419,7 @@ test_expect_success 'create/modify files, some of which are gitignored' '
>  	rm base
>  '
>  
> -test_expect_success FREEBSD 'Work around lazy mtime update' '
> +test_expect_success LAZYMOD 'Work around lazy mtime update' '
>  	ls -ld . >/dev/null
>  '
>  
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 3c730a2..1fc5266 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -962,7 +962,7 @@ case $(uname -s) in
>  	test_set_prereq GREP_STRIPS_CR
>  	;;
>  *FreeBSD*)
> -	test_set_prereq FREEBSD
> +	test_set_prereq LAZYMOD
>  	test_set_prereq POSIXPERM
>  	test_set_prereq BSLASHPSPEC
>  	test_set_prereq EXECKEEPSPID
> -- 8< --
>
> --
> Duy
