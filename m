Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B552207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 02:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034781AbdDUCr5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 22:47:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52041 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034778AbdDUCr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 22:47:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4363F7C3C7;
        Thu, 20 Apr 2017 22:47:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VfNuIjoeyWFY
        A3Hrjt8lvfxYbdA=; b=G9Ed385x5l9OR1d5wHKyDVAVUSJ/0vHC53r9Yab1Fqd8
        +MB5Q4c4IyLdche9BaJ7FiBGNW0prw7GiGgYUUdISTKh1uGLRVnH/RK2chOxP40S
        3Uudy0RrzRtHW6gil2kxeCaYwKqlivNydjlMenXSyqy3wSuhCuEVn5KwR8sLNW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=upfPr5
        AQZYIVgMWZAw86QpNh7Hga9QfwzgI/z6WUHlRqzfsXLd5xuGQoX5TYmisyMKIhtg
        xuVKFTpYOkJyyr1+Odl0QI5AdlQRnT8zHd5BldP4b7069bjNDjocuxPM2/CVvSnp
        T7kSqYyu0usWKXh4eJrG746nBT8Aa97CulC7Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A2D97C3C5;
        Thu, 20 Apr 2017 22:47:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A3F07C3C4;
        Thu, 20 Apr 2017 22:47:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] worktree move: refuse to move worktrees with submodules
References: <20170420101024.7593-1-pclouds@gmail.com>
        <20170420101024.7593-6-pclouds@gmail.com>
Date:   Thu, 20 Apr 2017 19:47:53 -0700
In-Reply-To: <20170420101024.7593-6-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 20 Apr 2017 17:10:23 +0700")
Message-ID: <xmqqvapy5vdy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EB592C8E-263C-11E7-9E02-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Submodules contains .git files with relative paths. After a worktree
> move, these files need to be updated or they may point to nowhere.
>
> This is a bandage patch to make sure "worktree move" don't break
> people's worktrees by accident. When .git file update code is in
> place, this validate_no_submodules() could be removed.

Right.  I am OK with "small steps first" approach like this.  We'd
need to document the limitation, though, i.e. "Note that you cannot
move the primary working tree.  Also you cannot move a working tree
that has a submodule."

Again drop "yet" from the error message.  Our aspiration does not
ease the pain the end users get when they are given the error
message.
