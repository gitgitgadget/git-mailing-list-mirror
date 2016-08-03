Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2ED1F858
	for <e@80x24.org>; Wed,  3 Aug 2016 16:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757921AbcHCQQN (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:16:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753522AbcHCQQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 12:16:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 729042E82E;
	Wed,  3 Aug 2016 12:16:09 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KohJqQJC2Bmn
	rFyRVm+p6ZC+ZtM=; b=dzx3XFwPH2z/tt0nuYI2PV5Zc2XSOGHSP4KcJ2Sz5jse
	j+rLp8RhEwZuc/sjpirPlnDZYJWN8rGHzD+eIXyS48Jlt108Q1jHGlRP1yAQtQE/
	zfieY0cXiRRWMzUDnYSGtRv4IgPvUMKgPO9K5tRfmaeWsnuWP63ackWZySsLE/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SYd5Z4
	pRYRHZe55QBP0fM3YwRQUdfXltd9nXgznBPpoTXAdVl7eq9V2rRH9QlsGIm+K8OI
	YyfJABEjCmlRjTEWmgogGVRMqYlb0HZ29dsj/Q4yus8rZ7a5iKtCB1s+sAESoCaB
	Qt/Rj6K5bUsfLj51Z+hZ0ZHpeOFVS/NcpW/Os=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 696C22E82D;
	Wed,  3 Aug 2016 12:16:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAA552E82C;
	Wed,  3 Aug 2016 12:16:08 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, e@80x24.org, tboegi@web.de
Subject: Re: [PATCH v2] t7063: work around FreeBSD's lazy mtime update feature
References: <20160730182005.14426-1-pclouds@gmail.com>
	<20160803160536.15596-1-pclouds@gmail.com>
Date:	Wed, 03 Aug 2016 09:16:06 -0700
In-Reply-To: <20160803160536.15596-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Wed, 3 Aug 2016 18:05:36 +0200")
Message-ID: <xmqqmvktakvt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 965D8BB8-5995-11E6-BFED-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>  v2 goes with Junio's suggestion (good one!).

Ehh, have you even read what you copied and pasted?  "this and that"
and "blah" are meant to be placeholders for you to fill in.

I am not sure if "-exec ls -ld" is a good idea.  Doesn't "find" by
itself does enough lstat(2) call to work already?  Even if it were
necessary to trigger a separate stat(2) call, wouldn't "-ls" be
sufficient?

> +# On some filesystems (e.g. FreeBSD's ext2 and ufs) this and that
> +# happens when we do blah, which forces the untracked cache code to
> +# take the slow path.  A test that wants to make sure the fast path
> +# works correctly should call this helper to make mtime of the
> +# containing directory in sync with the reality after doing blah and
> +# before checking the fast path behaviour
> +sync_mtime () {
> +	find . -type d -exec ls -ld {} \; >/dev/null
> +}
> +
>  avoid_racy() {
>  	sleep 1
>  }
> @@ -416,7 +426,8 @@ test_expect_success 'create/modify files, some of which are gitignored' '
>  	echo four >done/four && # four is gitignored at a higher level
>  	echo five >done/five && # five is not gitignored
>  	echo test >base && #we need to ensure that the root dir is touched
> -	rm base
> +	rm base &&
> +	sync_mtime
>  '
>  
>  test_expect_success 'test sparse status with untracked cache' '
