Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665081F45F
	for <e@80x24.org>; Tue,  7 May 2019 04:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEGEoH (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 00:44:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60308 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfEGEoH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 00:44:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3D48625E9;
        Tue,  7 May 2019 00:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k+e5IIJELFU9TvBZvNmtzVFqsaQ=; b=keZmrH
        PTtthAe/9KA/ks4vkM/O6zDq0b4ZQRsRZhORnIP8NNRC7OgTpSQwkDoAORKt/ORe
        3zqwV3RmxSBT1m4V9xpMs7LRU9sddk8wjtYi8AhPo7Yzhl9CnYFRzIuUem10/zz7
        e1zZy/YOFlk96obd5mciPW+4tvzozdq0Zg+YY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IhhhMdM/J94fq9bBtunuKawZqkLNOuQn
        A5iLQ3gQFVpvaG9Pis0QPQTmKWst4Nv0aYEjFiIawXXOV7u0CfFNdt4yuvAQnT2v
        QhoBxXFYJBL2/VpDe/5GneMiyvwzotf5ELXDfhDcUWEWLzdWxUsUgoKcwBYnLriA
        Y75fcidue+s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9ABC8625E8;
        Tue,  7 May 2019 00:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7BC31625E5;
        Tue,  7 May 2019 00:44:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] format-patch: teach format.notes config option
References: <cover.1556388260.git.liu.denton@gmail.com>
        <1338045be4a185cddc3ebf8adbe4b744551acf15.1556388260.git.liu.denton@gmail.com>
Date:   Tue, 07 May 2019 13:43:59 +0900
In-Reply-To: <1338045be4a185cddc3ebf8adbe4b744551acf15.1556388260.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sat, 27 Apr 2019 15:25:25 -0400")
Message-ID: <xmqqlfzinab4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC174018-7082-11E9-95DE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In git-format-patch, notes can be appended with the `--notes` option.
> However, this must be specified by the user on an
> invocation-by-invocation basis. If a user is not careful, it's possible
> that they may forget to include it and generate a patch series without
> notes.
>
> Teach git-format-patch the `format.notes` config option where if its
> value is true, notes will automatically be appended. This option is
> overridable with the `--no-notes` option in case a user wishes not to
> append notes.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/config/format.txt    |  4 ++++
>  Documentation/git-format-patch.txt |  3 +++
>  builtin/log.c                      |  6 ++++++
>  t/t4014-format-patch.sh            | 28 ++++++++++++++++++++++++++++
>  4 files changed, 41 insertions(+)
>
> diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
> index dc77941c48..55327b6511 100644
> --- a/Documentation/config/format.txt
> +++ b/Documentation/config/format.txt
> @@ -85,3 +85,7 @@ format.outputDirectory::
>  format.useAutoBase::
>  	A boolean value which lets you enable the `--base=auto` option of
>  	format-patch by default.
> +
> +format.notes::
> +	A boolean value which lets you enable the `--notes` option of
> +	format-patch by default.

Whoa.  Why should this be a boolean?

I think I can do

	git format-patch --notes=amlog master..

and was hoping that this can be used to configure the option out of
my command line typing.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index b6e2fdbc44..fe9522121a 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -738,6 +738,34 @@ test_expect_success 'format-patch --notes --signoff' '
>  	sed "1,/^---$/d" out | grep "test message"
>  '

And if you look at the existing test above this, you'd notice that
the command is tested is in "format-patch --notes=test" form.  We
should make sure that the same is done with the config in the new
test, too.

> +test_expect_success 'format-patch notes output control' '
> +	git notes add -m "notes config message" HEAD &&
> +	test_when_finished git notes remove HEAD &&
> +
> +	git format-patch -1 --stdout >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes >out &&
> +	grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes --notes >out &&
> +	grep "notes config message" out &&
> +
> +	test_config format.notes true &&
> +	git format-patch -1 --stdout >out &&
> +	grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes >out &&
> +	grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes --notes >out &&
> +	grep "notes config message" out
> +'
> +
>  echo "fatal: --name-only does not make sense" > expect.name-only
>  echo "fatal: --name-status does not make sense" > expect.name-status
>  echo "fatal: --check does not make sense" > expect.check
