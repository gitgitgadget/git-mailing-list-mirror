Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D9B1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 19:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfF0Toq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 15:44:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61324 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0Toq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 15:44:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35EF17BFBF;
        Thu, 27 Jun 2019 15:44:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L6VJaZisI8At
        SrTgT28Xf1smuDY=; b=UAS7IRAjHk3YsJRPfcd8NmonJp7APcs7JsQUJBlFEsjC
        abnczYLOSUhQVlRlvCQWadMQTK3aQzitUcdrmrXnSjP7YWai7VMke0u7PC0SbepI
        PBwOrnwbvr2Pndsbx9spd0IQNDaChRwck4lAr8omV1mRp0MUV5IkhC1eX18/Dk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ss3j3z
        W3cHchoXu9C9UIbnN0REmC8A5KJB3oZDT25Szv0jIYQPcjNvoKE6jDWvTZ/XTgLj
        9lky4f7mPXHWzWEu5+nldjCiCtCD/v2YytohVLBM8PD0D55P6WmnYIMxCMcBF7ZD
        iZBSWpvzCBWTbX6lFfAol/PuQLS7f2rcPQFek=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DB4E7BFBE;
        Thu, 27 Jun 2019 15:44:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 362FD7BFBD;
        Thu, 27 Jun 2019 15:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] Kill the_repository in tree-walk.c
References: <20190624095533.22162-1-pclouds@gmail.com>
        <20190627092852.11326-1-pclouds@gmail.com>
Date:   Thu, 27 Jun 2019 12:44:40 -0700
In-Reply-To: <20190627092852.11326-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 27 Jun 2019 16:28:46 +0700")
Message-ID: <xmqqr27eak47.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 01EF83C0-9914-11E9-96E1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  tree-walk.h                 |  8 ++++---
>  unpack-trees.c              |  2 +-
>  25 files changed, 129 insertions(+), 97 deletions(-)
>
> Range-diff d=E1=BB=B1a tr=C3=AAn v1:
> 1:  35d7cdbe6a ! 1:  9e73c39f9a sha1-file.c: remove the_repo from read_=
object_with_reference()

I see inconsistent l10n here. =20

I see merit in both=20

 (1) forcing the C locale when preparing project-wide communications
     like patch e-mails, even when end-user's UI is usually showing
     in another locale, for maximum reach, or

 (2) honoring the locale end-user's even when preparing project-wide
     communications, to help with mono-culture projects.

Whichever stance we take, we should be consistent ;-)
