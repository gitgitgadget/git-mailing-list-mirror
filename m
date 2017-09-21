Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838F12047F
	for <e@80x24.org>; Thu, 21 Sep 2017 06:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbdIUG1L (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 02:27:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60298 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751485AbdIUG1K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 02:27:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E2B196367;
        Thu, 21 Sep 2017 02:27:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+OvIq9u9Slvf7/P2eDmAFtwCdrg=; b=VQEK3F
        /5eblQkiQHTsy9h/VdqQSSTYFRXxKnq5zlqIe95oCMII2WpWKoexeqJxluqlc41S
        gEyzRlBbwrs/oHfym34UYHFv2bYacZ08A89uyU33sbWZwwf9TSH7yZ105gVi9whh
        Dgc0YkbeBE7sWwU+Cm4BF2JvTypOpvzeThimQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kVlrdR/VWa0HHK8AyvpA0fKPOEUrQoa1
        bpX/DxisoV1GhwxDaAm71di6BlYQSEEY1Nek0coJlS02S868dT7+mfNzSD6ZXkba
        cnrLJsPA01PJ8Ey7FyIuXafzG3AfcScEpSFqbgIxDywYMuQPUGdPlkce9XTpAzo2
        oAFvHiUce0U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1667096365;
        Thu, 21 Sep 2017 02:27:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81B9696364;
        Thu, 21 Sep 2017 02:27:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
        <cover.1505394278.git.git@grubix.eu>
        <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
        <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
        <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu>
        <xmqqshfnx1kl.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 21 Sep 2017 15:27:08 +0900
In-Reply-To: <xmqqshfnx1kl.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 16 Sep 2017 03:24:10 +0900")
Message-ID: <xmqqshfgk1mr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E57B5446-9E95-11E7-A133-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  I agree that there is a value in what your patch 2/3
> wants to do when the current one that is more strict would say
> "there is no known fork-point"---we would gain a way to say "... but
> this is the best guess based on available data that may be better
> than getting no answer." which we lack.
>
> Having said all that, I do not agree with your last sentence in the
> paragraph I quoted above.  It is a mere implementation detail to
> consult the reflog to find out the set of "historical tips of the
> Branch"; the current tip by definition is among the commits in that
> set, even when the reflog of Branch is missing.  What 4f21454b55 did
> was a reasonable "fix" that is still in line with the definition of
> "--fork-point" from that point of view.
>
> Whether we add a "looser" version of "--fork-point" to the system or
> not, the more strict version should still use the current tip as one
> of the historical tips (i.e. those that we would take from the
> reflog if the reflog were not empty) in the more "strict" mode.  The
> looser version may also want to do so as well.

So, should I mark this in What's cooking report as "expecting a
reroll", anticipating that a new option would be added to trigger
the new & looser behaviour?

