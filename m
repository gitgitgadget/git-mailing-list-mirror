Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834261F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 05:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbeKLPpZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 10:45:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55801 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeKLPpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 10:45:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46C812F306;
        Mon, 12 Nov 2018 00:53:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QLrs6dHcJHX+
        ih+4+NRC8NRXQ2s=; b=GJwL4DHmJm6aQZkVhxjtX1FL1FoprFtL+6JkIaAZmafU
        FojTTBX/AgxXGrIgMvll+Ph2/zQ6BnJkTG/aM2tZa16hsY5T9Qt56L+aJuYV9Ai2
        cKbZf7TRPsQqab0sWn9MsCV+pGrsjyCO/2vAogDl4o9QZ5DjYiP5FWUuzZ1LH8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jvEqjv
        1hM2ggy0MLr9pg1Yqb6ItjQAy3Rltz5rYPEApEUmJ6OtbC+L113mBfP56nvqtbsq
        lEvvp/IDKHc29Ykrofs3sTc/D6MtWwwGJJgg+30BOzmSDX4mqzOpLCkB7bCUgwAJ
        wmhbR3hTTNI9KVXF/VZ3jTF+clp2G976zQMLg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 402EE2F305;
        Mon, 12 Nov 2018 00:53:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4C0B32F301;
        Mon, 12 Nov 2018 00:53:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 00/22] Kill the_index part 5
References: <20181110054910.10568-1-pclouds@gmail.com>
Date:   Mon, 12 Nov 2018 14:53:37 +0900
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 10 Nov 2018 06:48:48 +0100")
Message-ID: <xmqqftw63kpq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4D8E1F04-E63F-11E8-B5AE-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> I did start pushing the_repository out of library code [1] in the botto=
m
> half of this series. There aren't big surprises except that cache-tree
> API now take _both_ struct repository and struct index_state. The
> reason is cache-tree can work on temporary indexes and repo->index is
> about $GIT_DIR/index.

Yes, this is very sensible, and I expect many more functions would
(and probably should) follow suit, as we'd want to be able to work
with temporary index (not in the sense that we'll write out on-disk
temporary index, but multiple in-core instances of istate that is
not necessarily tied to the current or the next state of
$GIT_DIR/index) from more places.

