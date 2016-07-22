Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17D7203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 17:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbcGVR6j (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:58:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751621AbcGVR6i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 13:58:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D11E32DC83;
	Fri, 22 Jul 2016 13:58:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ePXDerJQZFbmk6Z3Zn7i0PsBhCE=; b=TOl5pU
	m6QV9A/M4NMp0eZ6czZ/uZh3b20kggygTHpx5efo906O3rzcO6/poQ/T+ei2sShq
	icovfYUum/snhHQR7kGv20V3ZyAqjdCRyAQALs4vmYyVMaxtKSCBOfWpdpRxmHur
	2OkMJHy8dunl2jciTR/TZoKjKPDXimzQAVFDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UcoYlhQ6VaX/HAUnRuZLAtT6qWJ9TptD
	sVPooTDRFdqcRHUXfPH39e+UIEHQcC71BXfCyLKzJHUZj2e9uyMH94CAqbKoLK4K
	NkbXlxaQx0OXDGVnUzkClKaXQ6N4brMPL1parp2CxtDnPJcJyScTR6pN2zmVS+bF
	48Kkba0TeVU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C9B7F2DC82;
	Fri, 22 Jul 2016 13:58:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4EFBB2DC81;
	Fri, 22 Jul 2016 13:58:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Parker Moore <parkrmoore@gmail.com>
Cc:	git <git@vger.kernel.org>
Subject: Re: [PATCH] contrib/persistent-https: use Git version for build label
References: <CAOiOGAfWfEy60qg3AbbPNqkvJDMsXBHY8ZSXBCKJYha_gDB8mw@mail.gmail.com>
Date:	Fri, 22 Jul 2016 10:58:34 -0700
In-Reply-To: <CAOiOGAfWfEy60qg3AbbPNqkvJDMsXBHY8ZSXBCKJYha_gDB8mw@mail.gmail.com>
	(Parker Moore's message of "Wed, 20 Jul 2016 19:00:00 -0600")
Message-ID: <xmqqwpkda71x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E98F5488-5035-11E6-8043-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Parker Moore <parkrmoore@gmail.com> writes:

> diff --git a/contrib/persistent-https/Makefile
> b/contrib/persistent-https/Makefile
> index 92baa3be..8248269 100644
> --- a/contrib/persistent-https/Makefile
> +++ b/contrib/persistent-https/Makefile
> @@ -12,7 +12,7 @@
>  # See the License for the specific language governing permissions and
>  # limitations under the License.
>
> -BUILD_LABEL=$(shell date +"%s")
> +BUILD_LABEL=$(shell cat ../../GIT-VERSION-FILE | cut -d" " -f3)

We tend to avoid catting a single file only to pipe the result into
a different command, so I'd rewrite this like so:

    BUILD_LABEL=$(shell cut -d" " -f3 ../../GIT-VERSION-FILE)

while queuing.

Thanks.
