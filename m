Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F601F667
	for <e@80x24.org>; Tue, 22 Aug 2017 20:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbdHVUDk (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 16:03:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56626 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752063AbdHVUDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 16:03:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 473E28DB1F;
        Tue, 22 Aug 2017 16:03:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MICkNmai+9jH
        r3QdpMEn8OsBczM=; b=sNSTKgzTJWRderb4tF/Nxbwp/vqpYgSi5kflxJAqJxz9
        J/dfPAeAQIeAI9IB/0hY0Lm6DEXyGCqNb0ojvROYTbERkT9miM2AM7/jJ83A2EeV
        E+2Pg0WmGVzXHxERHN3qgZMd+NynrSB146ucONwAWnHuz5ExnbA8jMOQlON0OXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Al84L9
        0eWyxYtinj/UV4QSR1WBrmHaML5w/CvPB930eM5Li1J9Rzvx28SA4o7iawceEAys
        VgZjtspiur7VH1W8/ZEi3sI+RWiF5f7Nk1yNBMAjRu20wF3vtxEV3pM/IoTNiW3A
        RyKgU48m3SBpieh4fMXhodAXIwz93PGJwXpdM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F7068DB1E;
        Tue, 22 Aug 2017 16:03:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BE368DB1D;
        Tue, 22 Aug 2017 16:03:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Ben Boeckel <mathstuf@gmail.com>, git@vger.kernel.org
Subject: Re: Cannot checkout after setting the eol attribute
References: <20170822174918.GA1005@megas.kitware.com>
        <20170822191318.GA22118@tor.lan>
Date:   Tue, 22 Aug 2017 13:03:37 -0700
In-Reply-To: <20170822191318.GA22118@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Tue, 22 Aug 2017 21:13:18 +0200")
Message-ID: <xmqqziar1iau.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FCDFA43A-8774-11E7-9FEA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The following would solve your problem:
>    git init
>    echo $'dos\r' > dos
>    git add dos
>    git commit -m "dos newlines"
>    echo "dos -crlf" > .gitattributes
>    git add .gitattributes
>    git commit -m "add attributes"
>    echo "dos eol=3Dcrlf" > .gitattributes

>    git read-tree --empty   # Clean index, force re-scan of working dire=
ctory
>    git add dos

This is not advisable as a general suggestion, as in a real life (as
opposed to a toy example) there will be paths other than this 'dos'
thing in the working tree.  Perhaps replace "git read-tree --empty"
with "git rm -f --cached dos" or something like that that limits its
damage would prevent mistakes better.

>    git add .gitattributes
>    git commit -m "set eol attribute instead"
>    git ls-files --eol
