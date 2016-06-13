From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 02/40] builtin/apply: make apply_patch() return -1 instead of die()ing
Date: Mon, 13 Jun 2016 15:55:43 -0700
Message-ID: <xmqq37ogbswg.fsf@gitster.mtv.corp.google.com>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
	<20160613160942.1806-3-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:56:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCalx-00074h-Qv
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 00:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbcFMWzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 18:55:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752006AbcFMWzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 18:55:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74BCA24E88;
	Mon, 13 Jun 2016 18:55:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pP3QlFbjMNILnW17oVusJnWWmZM=; b=rbXKoW
	cuoC/fu7eYVEAnY932+cvr0aZExzK3vHOSNsoPi8nXHIfH3oD/xvrq2DuOt6lIHF
	+sy4gAStNTx/75rXFTFqUkA7tkYATnO7x4YJ71WVSnfOCBSSBUczQ/l9ljIypPQn
	Eao6sjIN0inp/bgmKsAP5IgYjarDbDgjQ2kyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GzsIao8KBG5YUIZwK74otHQF62bbEL5/
	iqQdDiBJm9OyfJHV0dik3/BvgFlde/4gSDLP8I6InhT+hqZTuO8xnHCu7c+71Vml
	EbHulgJhhBn1FVZ+shc7nxekGqcYDIwkNNBN82rNJ9uKxXp4XCutqP9LIFXeDupw
	DoW/e4IkWXg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C0A724E87;
	Mon, 13 Jun 2016 18:55:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3D6224E85;
	Mon, 13 Jun 2016 18:55:44 -0400 (EDT)
In-Reply-To: <20160613160942.1806-3-chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 13 Jun 2016 18:09:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F62B17D0-31B9-11E6-9F37-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297258>

Christian Couder <christian.couder@gmail.com> writes:

> +/*
> + * Try to apply a patch.
> + *
> + * Returns:
> + *  -1 if an error happened
> + *   0 if the patch applied
> + *   1 if the patch did not apply
> + */
>  static int apply_patch(struct apply_state *state,
>  		       int fd,
>  		       const char *filename,
> @@ -4413,6 +4421,7 @@ static int apply_patch(struct apply_state *state,
>  	struct strbuf buf = STRBUF_INIT; /* owns the patch text */
>  	struct patch *list = NULL, **listp = &list;
>  	int skipped_patch = 0;
> +	int res = 0;
>  
>  	state->patch_input_file = filename;
>  	read_patch_file(&buf, fd);
> @@ -4445,8 +4454,10 @@ static int apply_patch(struct apply_state *state,
>  		offset += nr;
>  	}
>  
> -	if (!list && !skipped_patch)
> -		die(_("unrecognized input"));
> +	if (!list && !skipped_patch) {
> +		res = error(_("unrecognized input"));
> +		goto end;
> +	}

Before this patch, the program said "fatal: $message" and exited
with status = 128.  All these changes in this step modifies the
external behaviour and make it say "error: $message" and exit with
status = 1 (at least the caller in apply_all_patches() does so).

Will that be an issue for the calling scripts?
