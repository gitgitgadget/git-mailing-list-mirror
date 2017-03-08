Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F571FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 01:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756534AbdCHBJV (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 20:09:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63190 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756614AbdCHBJS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 20:09:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78D8D8255B;
        Tue,  7 Mar 2017 20:08:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fqVFj27F6ZXzLGBtvUa5A5TgY04=; b=hjcYfH
        qw7m9ey2wPemm6hrObSNhvazrYgrwDQEnsebRPVUqPrwq8O/bNcP/3sMv0eqdHr+
        UDN3KC1FZnGiQnhQBaYonYHoK6Ea/0ZNBpYZQqptL2FYVgDdHZJsGIDHTKRMoECW
        PCE5zODkcmvyZ0clcJ6hgPfhIkcpI9nWtszUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ltMLEROFmKHy34utX3FO1BNJyVpfinxO
        eooVDt3zfW6CNXGkcieDNqhqsaqJ4P/MdIvKIi58TRdm4/tSeNglLizSLwqF6m4N
        k0mQCeXyhY0gPM7Dr4TmOGOr1ilntk0eydrwyUE5hMH9lOzN1ZKGejmN8dLbSukd
        8xJ6rwQNBrw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7178F8255A;
        Tue,  7 Mar 2017 20:08:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D57BF82557;
        Tue,  7 Mar 2017 20:08:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 16/18] entry.c: update submodules when interesting
References: <20170302004759.27852-1-sbeller@google.com>
        <20170306205919.9713-1-sbeller@google.com>
        <20170306205919.9713-17-sbeller@google.com>
        <xmqqtw746758.fsf@gitster.mtv.corp.google.com>
        <xmqqy3wg4rko.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYmaAY-ASa672eXmQapxJns+a3dEC_BiEmH7ti==arLtw@mail.gmail.com>
Date:   Tue, 07 Mar 2017 17:08:31 -0800
In-Reply-To: <CAGZ79kYmaAY-ASa672eXmQapxJns+a3dEC_BiEmH7ti==arLtw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 7 Mar 2017 15:08:21 -0800")
Message-ID: <xmqqpohs4ltc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFB933D0-039B-11E7-9678-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> In addition to mkdir(), would we also need the .git file that point
>> into superproject's .git/modules/ too?
>
> The move_head function takes care of it
> Both creation as well as deletion are handled in the move_head function,
> when either new or old is NULL.

Oh, if it does the creation of directory and adjusting of .git
gitfile, and handles other anomalies, I have no problem with it.

It was just that this codepath tried to handle some kind of anomaly
(namely, the user originally thought the submodule needs to be
changed to a regular file and then changed mind and wants to restore
it from the index) and yet not doing the full anomaly handling (like
"not even an empty directory exists" case) that confused me.

