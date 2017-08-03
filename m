Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837781F991
	for <e@80x24.org>; Thu,  3 Aug 2017 21:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbdHCVkm (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 17:40:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64031 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751599AbdHCVkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 17:40:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0ABA6A8BAC;
        Thu,  3 Aug 2017 17:40:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U5nPxcjsFsriAtMXUOdcxWK1hTI=; b=yFmfFS
        fAnjddmVHTiZ4JkoSwylgPmMaeQ5xDVdQK9SyoJ/Oao8JHvymyWiUBzA4o1IN1la
        x27b3BsI6ItXutcHfaYkRR3VAcMAtHKCB+Wj+wCCJLZWNKe/BXoOLIPyPRIbG8Y/
        Gzb+LDCYMUcouBS2rLJL3mbGPXoSKPtNiE1kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EZXf1tIA7J/+/fbK61FIAe3tai5XaJTi
        0EcmUvmSPBZcQoiBuTbMoBqPOamVanRpXcaUxK3ZgsXddZj9y5/PtMUjsmaazEWI
        sZD+WIAsnENM+aWAyOc0wNn3fh3M2bRA8cDqiD7VPP/ZfX+UcRAYNytDojZvyURL
        6jAF+XGWkRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E48E6A8BAB;
        Thu,  3 Aug 2017 17:40:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39789A8BAA;
        Thu,  3 Aug 2017 17:40:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 25/40] external-odb: add 'get_direct' support
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
        <20170803091926.1755-26-chriscool@tuxfamily.org>
Date:   Thu, 03 Aug 2017 14:40:32 -0700
In-Reply-To: <20170803091926.1755-26-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 3 Aug 2017 11:19:11 +0200")
Message-ID: <xmqq4ltowcrz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60D5B05A-7894-11E7-B663-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This implements the 'get_direct' capability/instruction that makes
> it possible for external odb helper scripts to pass blobs to Git
> by directly writing them as loose objects files.

I am not sure if the assumption is made clear in this series, but I
am (perhaps incorrectly) guessing that it is assumed that the
intended use of this feature is to offload access to large blobs
by not including them in the initial clone.  So from that point of
view, I think it makes tons of sense to let the external helper to
directly populate the database bypassing Git (i.e. instead of
feeding data stream and have Git store it) like this "direct" method
does.

How does this compare with (and how well does this work with) what
Jonathan Tan is doing recently?
