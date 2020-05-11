Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3711C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 18:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BC520736
	for <git@archiver.kernel.org>; Mon, 11 May 2020 18:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uC6H6DBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgEKSuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 14:50:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58226 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbgEKSuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 14:50:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8134ED2FBF;
        Mon, 11 May 2020 14:50:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tXkBOz5LCW5M4CgUZl2ljTqsy+c=; b=uC6H6D
        Be/tgqXE5QMVZSKIKcX4W7QYgImH5iZxl6h29LUs6TAN/0Vrj/xzqCqfhKwbFBNN
        iSwqMsheC+PDjtH+eIf6K8G7NK2r4bWTlDtR2PX66mC1F/rCza0QhF3jTVd2Jx5T
        GgU3NfJ8NbKboOeU6qCwgDRQQ50W+o/+I/YGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gBtWzwcqUAvAzE9P6ezmOXS9kODd2A6l
        oQeuMCPGgnxSQjFPF1he3orWYlTjX13FAr0zRP8gBRTEstWcktX0G+YW5RxMIxNs
        wKhmlBfYMPKVE1nZk3ORrpOa7JNnd1d2NaZu/x3IEtKtVCi1bvLd7gKEAcy5FRUJ
        R/WZvwhr7mY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78B68D2FBE;
        Mon, 11 May 2020 14:50:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1F12D2FBD;
        Mon, 11 May 2020 14:50:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: How to move forward with Reftable
References: <CAFQ2z_Ne-1TWMRS88ADhzQmx4OfzNEkVUJ1anjf57mQD4Gdywg@mail.gmail.com>
        <20200511183602.GA141481@google.com>
Date:   Mon, 11 May 2020 11:50:15 -0700
In-Reply-To: <20200511183602.GA141481@google.com> (Jonathan Nieder's message
        of "Mon, 11 May 2020 11:36:02 -0700")
Message-ID: <xmqqpnbaqpaw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4152F7AA-93B8-11EA-8D0B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> (+cc: a few people I'm particularly interested in feedback from)
> ...
> There's been some discussion about use of strbuf versus the module's
> own growing-buffer "struct slice".  Is that the only instance of this
> kind of infrastructure duplication or are there others?

Yeah, that is a very important question.  If there are own APIs that
are similar to what we have but impedance mismatch can not be easily
abstracted away, that would be a huge problem.

