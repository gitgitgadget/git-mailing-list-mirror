Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAABC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 01:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbiDZBP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 21:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiDZBP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 21:15:56 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E11E8E19F
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 18:12:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC1E011FC2A;
        Mon, 25 Apr 2022 21:12:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=s/evt0e5SlR/
        0dUQYjFq2Ic2fewiCN8w2xwqGm0gR1I=; b=WlNCkBJMecwAgX4C9aJcVubjnDf3
        Q03fYZDRbb1gIkNRksRtwTSP3eQ5TYWEDdiygXtak+qSV7EheVlPb/IUQXunyODz
        h2RVia/4LuPglMGewqdU6QbBFWJRV/cCdbGke3mAAcRbIBWGcNtgPkfmqmofCLNT
        bg6oNFU2gvyE2ls=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C226611FC29;
        Mon, 25 Apr 2022 21:12:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3766011FC28;
        Mon, 25 Apr 2022 21:12:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 1/4] ci: make failure to find perforce more user
 friendly
References: <20220422013911.7646-1-carenas@gmail.com>
        <20220423142559.32507-1-carenas@gmail.com>
        <20220423142559.32507-2-carenas@gmail.com>
Date:   Mon, 25 Apr 2022 18:12:47 -0700
In-Reply-To: <20220423142559.32507-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sat, 23 Apr 2022 07:25:56 -0700")
Message-ID: <xmqq35i0tzow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC6D3014-C4FD-11EC-B650-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> -if type p4d >/dev/null && type p4 >/dev/null
> +if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
>  then
>  	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
>  	p4d -V | grep Rev.
>  	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
>  	p4 -V | grep Rev.
> +else
> +	echo "WARNING: perforce wasn't installed, see above for clues why" >2
>  fi
> -if type git-lfs >/dev/null
> +if type git-lfs >/dev/null 2>&1
>  then
>  	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
>  	git-lfs version
> +else
> +	echo "WARNING: git-lfs wasn't installed, see above for clues why" >2
>  fi

NO!  Why do we want to create a file whose name is "2" here?

Good that I caught them before I merged them to 'next'.

Will locally amend and see if it fixes CI failure in 'seen'

Thanks.

