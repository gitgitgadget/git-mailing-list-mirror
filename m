Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46B711F462
	for <e@80x24.org>; Fri,  7 Jun 2019 16:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfFGQfs (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 12:35:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57880 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbfFGQfs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 12:35:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 751107AA0A;
        Fri,  7 Jun 2019 12:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gUi+VPWKr3uo
        JrgNyd75BFldavE=; b=u8z2vvB6d/cwkNon7Z4jOqq04FLtJtseWdZB4q6CbusY
        Il09TMlqid1MwNkMsrPv2sSr9vWD2H0O5bTaDWmV9FwjpwPQPjke3eF8ujbsQ+Od
        0aC35OktwYgd0RUD1T3AVTH8WFunxRw11LHz+e7lHMO9Y+59fkMVRja/oMQ/aVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HOP7oQ
        0C59QchBO8zNux+GnyavG+cp/84C335+wEhFtpk1jZCoM2t1jvQTzf3cBV8A+5iW
        ZrG4+vZbAdDo4S/WfwLSiBJ0lK56sri/AVsoSdcCaD9GAzokX6FkJuEFPYTMFGH9
        Fkixy/QJtxuDvPkZl+rDeiKoINFSOqHBPO31w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DA3C7AA09;
        Fri,  7 Jun 2019 12:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5DEC57AA01;
        Fri,  7 Jun 2019 12:35:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org,
        szeder.dev@gmail.com
Subject: Re: [PATCH] completion: do not cache if --git-completion-helper fails
References: <20190607022443.5706-1-felipe.contreras@gmail.com>
        <20190607093034.816-1-pclouds@gmail.com>
Date:   Fri, 07 Jun 2019 09:35:39 -0700
In-Reply-To: <20190607093034.816-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Fri, 7 Jun 2019 16:30:34 +0700")
Message-ID: <xmqqzhmtpd44.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4A9ACA6C-8942-11E9-A6AF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  	if [ -z "$options" ]; then
> +		local nocache=3D
>  		# leading and trailing spaces are significant to make
>  		# option removal work correctly.
> -		options=3D" $incl $(__git ${cmd/_/ } --git-completion-helper) "
> +		options=3D" $incl $(__git ${cmd/_/ } --git-completion-helper) " || n=
ocache=3Dt
> +
>  		for i in $excl; do
>  			options=3D"${options/ $i / }"
>  		done

Is there a point in doing this loop if we are not going to eval
after all?  IOW...

> -		eval "$var=3D\"$options\""
> +		test -n "$nocache" || eval "$var=3D\"$options\""
>  	fi

... I am wondering why it is not more like this

	if options=3D" $incl $(__git ${cmd/_/ } --git-completion-helper) "
	then
		for i in $excl
		do
			options=3D...
		done
		eval "$var=3D..."
	fi

or just return from the function instead of introducing and setting
a new variable, as only remaining thing the function does is to call
__gitcomp with $options, but we know that we are giving up on
completing this round.

