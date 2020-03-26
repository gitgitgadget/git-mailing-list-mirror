Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BE2C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FEC20714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GjusbolY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCZVQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:16:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58799 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZVQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 17:16:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7610B5458B;
        Thu, 26 Mar 2020 17:16:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xSfEYYifxcg8
        8HOUUzFas6n9W0Q=; b=GjusbolYjrVsT9TbtqjX/eJcm2pTOWxfGnQoZB2bNfEH
        W5LQeu81Uux1qdnDSih8xbEr41Y4viE0En+MOgk6G/GzugEguq/FwqI8RVYHjy3G
        foIuUaY5g+DS0XuXqYs6CHzUP8Msbp8wTBGnFr+PguitS5GHZE3Wlq8r0z0Kn4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GxnHQo
        jln3wdrChJYzFEOzn8KQaFi7/GHOhImkoACFipwSAE12iucBR94lPtv/TJV/otSC
        izYZBkJr69R9eyU5My4yy1eAg5xVXe/4KcOo5EkLuzg0anWgwAizAoRrxN1FYsNM
        9qyYr3bnwM/iWamQ0z+thaHRP6QMaLHLsGcp0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D6165458A;
        Thu, 26 Mar 2020 17:16:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6AE854589;
        Thu, 26 Mar 2020 17:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     =?utf-8?Q?Andr=C3=A1s?= Kucsma via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?utf-8?Q?Andr=C3=A1s?= Kucsma <r0maikx02b@gmail.com>
Subject: Re: [PATCH v2] Fix dir sep handling of GIT_ASKPASS on Windows
References: <pull.587.git.1584997990694.gitgitgadget@gmail.com>
        <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
        <20200325163540.vdc7l72fke7yqryb@tb-raspi4>
Date:   Thu, 26 Mar 2020 14:16:51 -0700
In-Reply-To: <20200325163540.vdc7l72fke7yqryb@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 25 Mar 2020 17:35:40
 +0100")
Message-ID: <xmqqftduizp8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1CAE54EC-6FA7-11EA-8363-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> On Windows with git installed through cygwin, GIT_ASKPASS failed to ru=
n
>
> My understanding is, that git under cygwin needs this patch (so to say)=
,
> but isn't it so, that even Git for Windows has the same issue ?
> The headline of the patch and the indicate so.

Yes, I agree that the commit is mistitled.  It is not specific to
Windows (it only is Cygwin, as the support for native Windows goes a
separate codepath), and it is not specific to GIT_ASKPASS, either.
