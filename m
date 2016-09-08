Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F3620705
	for <e@80x24.org>; Thu,  8 Sep 2016 17:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758534AbcIHRtm (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 13:49:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51065 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751723AbcIHRtl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 13:49:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81A933B998;
        Thu,  8 Sep 2016 13:49:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gmgi+dqn3Iga
        Qv9Ab/nkvbbbCzs=; b=pbGxV0IkA33LWKI/zadhf8ix/8o5ycDaHll1tY8u2QtF
        XYZ8RAOLiOKBagMCKEcxi8qc8W1aR65UQQ2NF28L8RJzF5o9BrcJ6AakIV5eRE11
        mXUfqn5L3S4Yy35Rs3W8UCH7CGVOhlHCj4V404MceQ69resqZsAxkeSSs2T6W/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=BIAq60
        D20MinZWtXdzuKuQHziM1ml/6YgZ6VySDgBz5/vwodTfpSCT2duizVvJOU22XkqD
        nQfFUHoBfHMyatFCDCzwvY5d7s4xvuJCkXAqRAWpb0EuBXt20o/88CFqDcEjxQn1
        O5fESZorW3JWnfbebyYc29y9AWK6JajK75/2I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AA263B997;
        Thu,  8 Sep 2016 13:49:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED1123B996;
        Thu,  8 Sep 2016 13:49:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
Cc:     Jeff King <peff@peff.net>, Leho Kraav <leho@conversionready.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] versioncmp: pass full tagnames to swap_prereleases()
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
        <20160907151251.30978-1-szeder@ira.uka.de>
        <20160907151251.30978-5-szeder@ira.uka.de>
Date:   Thu, 08 Sep 2016 10:49:36 -0700
In-Reply-To: <20160907151251.30978-5-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 7 Sep 2016 17:12:50 +0200")
Message-ID: <xmqq7fami8nj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9D1A99FA-75EC-11E6-879C-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> - * Note that we don't have to deal with the situation when both p1 and
> - * p2 start with the same suffix because the common part is already
> + * Note that we don't have to deal with the situation when both s1 and
> + * s2 contain the same suffix because the common part is already
>   * consumed by the caller.

"The common part is already consumed" was relevant while the
function was fed p1 and p2, i.e. the first difference, but the whole
point of passing the original s1 and s2 with ofs is so that the
function can look behind ofs as necessary.  Is "already consumed"
still correct (or relevant) with s/p/s/ you did to its calling
convention?

