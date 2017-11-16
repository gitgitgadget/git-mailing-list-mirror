Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49843201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 02:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755666AbdKPCEN (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 21:04:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60793 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750973AbdKPCEL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 21:04:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A688B4C33;
        Wed, 15 Nov 2017 21:04:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vNXD4xQTZTEJemK6rKwQ6PgMsQ4=; b=FGiYsv
        a43FiwEIxoSUQ0gL2Ima9AxVQtvJU+23IpXZdII39oDCLKE8PQsdlC1dNb0lWzg8
        axbtH3LMATkqQUaT3ZgYppCCORvpYl9FoteVR8q8ArKKuO29IgletL0MA5J1kq4l
        u+f/lj+0nl290s+qyhPD3fnC54Ygdtm2lm9Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bn2MCHrYRYfhP1mFouu7JwRk3/O7E9M/
        lgQRQBFwkPZpmE49l5zItYiBL1ZB+Wh4p4hdQMreXIx+HtIRi+FU5bVAvaJvXVaj
        2Re2O0zwC7uTHigx0VvJSAd3NHzEY+zg7magdq4fEKTGrHBHwMNI2AVcZ6BCuMaW
        BsFa2300Jw8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21D09B4C32;
        Wed, 15 Nov 2017 21:04:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97EA5B4C31;
        Wed, 15 Nov 2017 21:04:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCHv4 7/7] builtin/describe.c: describe a blob
References: <20171115003043.24080-1-sbeller@google.com>
        <20171115003043.24080-8-sbeller@google.com>
        <20171114175207.f23d492045d52b8aa16c00be@google.com>
        <CAGZ79kaum5py=14kdFy1a+K_0MzfaD5boYStixh=1aY2tUCV-Q@mail.gmail.com>
        <xmqq7eurxak0.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY109yTQESzVg69nsibucAhvP0m+vKUH21xB9m7WTGaFg@mail.gmail.com>
Date:   Thu, 16 Nov 2017 11:04:09 +0900
In-Reply-To: <CAGZ79kY109yTQESzVg69nsibucAhvP0m+vKUH21xB9m7WTGaFg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 15 Nov 2017 17:49:01 -0800")
Message-ID: <xmqq375fx9ly.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FA717E2-CA72-11E7-9064-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>     grep "fatal: test-blob-1 is neither a commit nor blob" actual

OK, that might be somewhat unsatisfying from end-user's point of
view (logically "test-blob-1" is already a name based on the 'graph
relations' that is satisfactory).

	[side note] should that grep become test_i18ngrep?

If this machinery is to find an object that is *bad* (in the sense
in one of your earlier messages), I suspect it may be quite easy to
use the new mechanism added by the series to also locate a tree
object and report "that tree appears in this commit at this path"
and it would be equally useful as the feature to find a blob.

Thanks.

