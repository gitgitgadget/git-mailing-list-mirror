Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88A71F461
	for <e@80x24.org>; Mon, 13 May 2019 06:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfEMGM5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 02:12:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51597 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfEMGM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 02:12:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E44BB14EDD0;
        Mon, 13 May 2019 02:12:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=faYcLocTa8ke
        nPh42mvpim/d84g=; b=v8K3/UUzbDuENi/2TZ3nryYRw47ViY52FjptmhRbfI0K
        Wf9XXOEbe32n/ia7NAUH1BEkPUMEHeIiEuaO/H/yubHJkVsih0TxeFPqvJvj7/Fq
        3Djg+GwY1TzIf9QP/TE/om7zflsDUS6OGQMmxQUFRhT2npjyELI0MocUt/s3YU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PtBRHr
        yM/jyZBPpGzXsVL8eaHTUj46pt+u08ecLeSObePPUCsCCJVNl6W9K20neO9uIlEl
        EBq5BCm11jGf7EUKk/huWRdjQJ6r/cEsh6w4KEHrnc0aqaM4dGdVmLyzRFpr+aT7
        lyBnIcFlEHvccgLxFfKntzm/PJINihHWbt5+0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCE4D14EDCF;
        Mon, 13 May 2019 02:12:56 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CC1414EDCE;
        Mon, 13 May 2019 02:12:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] init: make --template path relative to $CWD
References: <20190510104657.26585-1-pclouds@gmail.com>
Date:   Mon, 13 May 2019 15:12:55 +0900
In-Reply-To: <20190510104657.26585-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 10 May 2019 17:46:57 +0700")
Message-ID: <xmqq5zqedgrc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 265CF0D6-7546-11E9-B813-E828E74BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> During git-init we chdir() to the target directory, but --template is
> not adjusted. So it's relative to the target directory instead of
> current directory.

> It would be ok if it's documented, but --template in git-init.txt
> mentions nothing about this behavior. Change it to be relative to $CWD,
> which is much more intuitive.
>
> The changes in the test suite show that this relative-to-target behavio=
r
> is actually used. I just hope that it's only used in the test suite and
> it's safe to change. Otherwise, the other option is just document
> it (i.e. relative to target dir) and move on.

Yeah, that other option does sound safer, but ...

>  	mkdir template-source &&
>  	echo content >template-source/file &&
> -	git init --template=3D../template-source template-custom &&
> +	git init --template=3Dtemplate-source template-custom &&

... the example may show that the updated behaviour may match the
end-user expectation better.  It certainly is more in line with how
the "--reference" option of "git clone" uses a relative path.

It also makes it easier to <TAB> complete if these things were
relative to the current directory at the time of command
invocation.  I often find it frustrating when I have to create a
symbolic link in a directory I am not yet in that points to
somewhere using a relative path for the exact reason ;-)
