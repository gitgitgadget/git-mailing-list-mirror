Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF8BC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 16:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351452073B
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 16:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vt+7ilEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCFQHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:07:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62322 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgCFQHL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 11:07:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D765B0A50;
        Fri,  6 Mar 2020 11:07:09 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=2+JzeJTVpkcZMSeT+Cy/4POabGA=; b=vt+7ilE
        hFLbnzZbU0dUB6afke93g3bHBsDMM9CgmbB5G64TLkyuxEfBryOY7GeQMoj0gETp
        TLxjxgo/OIWdSFIN2+mYXI1TsO+mronzoG1FSvS9BC3nNRsRaSRNRj5V3ytQGux2
        KmsREJ98VInTLO/IsEIwo/EML6Cs6JVOajRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=EpUAgTCWuffB0OlUvb8sQpYO+kv8XVRoV
        JL1jsFs81qx82SR4MTWmIH+Vk0L2N3AK4GsNESVXoAl9nJQxxhCFI8bLgZuiHcrJ
        s1n9DekmOBkedP1YfnW5hYIdO1u2Hi/VL39e/AKuOw6MFK6NSbdf3p581Irk0GTA
        p+MuH3tMGk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34E7FB0A4F;
        Fri,  6 Mar 2020 11:07:09 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.198.29])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE072B0A4D;
        Fri,  6 Mar 2020 11:07:05 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Fri, 6 Mar 2020 11:07:03 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.26.0-rc0
Message-ID: <20200306160703.GK13045@pobox.com>
References: <xmqq5zfi4g0p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zfi4g0p.fsf@gitster-ct.c.googlers.com>
X-Pobox-Relay-ID: 86667682-5FC4-11EA-A256-B0405B776F7B-09356542!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[-cc: linux-kernel@vger.kernel.org]

Junio C Hamano wrote:
> An early preview release Git v2.26.0-rc0 is now available for
> testing at the usual places.  It is comprised of 426 non-merge
> commits since v2.25.0, contributed by 43 people, 7 of which are
> new faces.

I've built rc0 for Fedora and RHEL/CentOS across a decent
variety of architectures without any issues.

One thing of note, which isn't new in rc0 nor is it a Git
issue: with gcc-10 on s390x, diff.c is miscompiled when
built with '-O2 -march=zEC12 -mtune=z13' options.  It's
fixed in gcc's git, with thanks to Jakub Jelinek for the
diagnosis, work-around, and patch.

A work-around is 's/-mtune=z13/-mtune=zEC12/' for the
compiler flags.  Hopefully if anyone else runs into the
issue, this will save some time.

The gcc bug report is:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93908

-- 
Todd
