Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C7EC433E0
	for <git@archiver.kernel.org>; Sun, 31 May 2020 16:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85162074A
	for <git@archiver.kernel.org>; Sun, 31 May 2020 16:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Io64GjpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgEaQsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 12:48:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62629 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaQsp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 12:48:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 51D4DD2344;
        Sun, 31 May 2020 12:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9jgtGJ5GhhbOOcblw7nvMqzlTyA=; b=Io64Gj
        pZS5nkyVTpm82TYaaQf4w8wKTtkUBB98vZDeW4zacjsUtwy8FWt4us8vA71gZLQ/
        s5mll6oeqVRKqEZKuhs2qwcgETzldABiq2Oos2S13thOJcFbNc/ZTbVe40RreAlQ
        xr0Aj6A/rhCPTkm3uh59dy0IsJrAjO17326Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Doloz14ud7S6WpnYwDggv7+xbPCFZ9rJ
        Yc+qtCpKfzir0O3UG/oeAeMxln9/bcCVWwKTvcatj15uy6fgehvhlL/Bk4I1SrC3
        6PIPD8kNiQCzhmAVHLBIfRH29Mz3EtCHj6wEpYKMxzxauGob+Vy3/0y1VhQvQTXt
        sahPVt2SC1Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 492EFD2343;
        Sun, 31 May 2020 12:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E108D2332;
        Sun, 31 May 2020 12:48:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] sparse: allow '{ 0 }' to be used without warnings
References: <20200522002502.9010-1-luc.vanoostenryck@gmail.com>
        <xmqqa71xqpd2.fsf@gitster.c.googlers.com>
        <20200530162432.a7fitzjc53hsn2ej@ltop.local>
Date:   Sun, 31 May 2020 09:48:40 -0700
In-Reply-To: <20200530162432.a7fitzjc53hsn2ej@ltop.local> (Luc Van
        Oostenryck's message of "Sat, 30 May 2020 18:24:32 +0200")
Message-ID: <xmqqh7vwvymv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95EFBD60-A35E-11EA-9B8F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> I've now changed Sparse's default to not warn when using '{ 0 }'.
> This flag is thus now unneeded for Git and can be dropped
> (but it won't hurt to keep it).

Nice.  Thanks.
