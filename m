Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CE32207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161759AbcIZRzR (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:55:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64489 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1161042AbcIZRzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:55:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E180B413AC;
        Mon, 26 Sep 2016 13:55:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WfVqpcq0HVhz4LLDO/IglJkpUgA=; b=pS5CPT
        f5PnGKqyoJGfTFvCmIxShzrTiIhQAsQjJJYE7XpxlDewiJcnPoN8JCB74iOz79lc
        thngb1M5EOVoQ39L6JX9NkPQ2HOTRuMNA0D9Q8qidbR0bp2YZ0xe8QS6UknPletz
        XMJUlygHORM8uiyVKCGLVKQjM5l3uTUJA4uB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ejoykDUR0tHtT2+/ZwZHLOesYb7kj5DV
        FBSlh1FC6DpSeOEJyKxtpsf99HWmFAgxZgpREUpxM6Fo9vrJj0PDEaJECMRil4NM
        q8rX4qC36aFogTJMGMLrzKAySubZ8I3ehcRzN1x0EhZPZSkQqe16eSuSCvsr8AWP
        ANkE4RtEaj0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5812413AA;
        Mon, 26 Sep 2016 13:55:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35A2A413A9;
        Mon, 26 Sep 2016 13:55:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gustavo Grieco <gustavo.grieco@imag.fr>
Cc:     git@vger.kernel.org
Subject: Re: Stack read out-of-bounds in parse_sha1_header_extended using git 2.10.0
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
        <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
        <790613313.8353074.1474912139102.JavaMail.zimbra@imag.fr>
Date:   Mon, 26 Sep 2016 10:55:12 -0700
In-Reply-To: <790613313.8353074.1474912139102.JavaMail.zimbra@imag.fr>
        (Gustavo Grieco's message of "Mon, 26 Sep 2016 19:48:59 +0200 (CEST)")
Message-ID: <xmqq37kmtukf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 605C4458-8412-11E6-B2C0-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gustavo Grieco <gustavo.grieco@imag.fr> writes:

> Now that the cause of this issue is identified, i would like to
> know if there is an impact in the security, so i can request a CVE
> if necessary.

I am inclined to say that it has no security implications.  You have
to be able to write a bogus loose object in an object store you
already have write access to in the first place, in order to cause
this read-only access that goes beyond what is allocated, so at the
worst, what you can do is to hurt yourself, and you can already hurt
yourself in various other ways.
