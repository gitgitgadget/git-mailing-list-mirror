Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03821F859
	for <e@80x24.org>; Wed,  7 Sep 2016 17:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754903AbcIGRyz (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 13:54:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58652 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751914AbcIGRyx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 13:54:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFEA13BBB7;
        Wed,  7 Sep 2016 13:54:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iy44MuwpRgSVV1spPHjVFUcisV8=; b=Jc/Rzn
        h9IboN5ajpqXYil5HHSehlb+pIV/KN3iCJXOH4btN1Gnq8NzlorHFougFYVtXMAo
        i33bxgOp7Vo3X2NcNbVIW/zf5fGSXXHWt/uzYVc2R1as8RTvj0J4H6iUa82Xe/BF
        CzD7ZV/kw/gfYhDsyvRcKUFCvWJfMolwhjbAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TZmkMVHyFZOEvqrvklFPY6KYsqO60AC8
        Kr63J26ucJvdwdVVAOf6TSi+ixcdflESjNV0rEm+kHzQzslJL9he92lZTgVzndMj
        daqofEgKk3LtaphUOHW7BpINJ7Eg7Ua+2Y0GB4Wj7OTlsml3WrAwiHY0OfyUE2xY
        9U/3DazX+3Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8EB33BBB6;
        Wed,  7 Sep 2016 13:54:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 600923BBB5;
        Wed,  7 Sep 2016 13:54:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCHv3] diff.c: emit moved lines with a different color
References: <20160904234237.10548-1-stefanbeller@gmail.com>
        <CA+P7+xr=Lp36wDw2BRuhQ9Genv4q6iu9beGQe5hzOn5PJYDPfw@mail.gmail.com>
        <CAGZ79ka7VV6Pqw-rcVFv0xU4J4D9dHWPg-oocPPWJdY5JVhT+A@mail.gmail.com>
Date:   Wed, 07 Sep 2016 10:54:49 -0700
In-Reply-To: <CAGZ79ka7VV6Pqw-rcVFv0xU4J4D9dHWPg-oocPPWJdY5JVhT+A@mail.gmail.com>
        (Stefan Beller's message of "Mon, 5 Sep 2016 19:20:07 -0700")
Message-ID: <xmqq7fanoas6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CE84E3E-7524-11E6-9635-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> as we do not want to see dashes ('moved-old'), I think I'l go with
> "movedfrom" and "movedto".

OK.  They would be color.diff.movedFrom and color.diff.movedTo in
the doc, and "movedfrom" and "movedto" in the code (as the caller
already downcased them for you to strcmp()).

> When going through the second pass and actually emitting colored lines
> we only find matches in the hash map if the current line AND the previous line
> match as we lookup by hash code, i.e. if we have a moved line, but the
> previous line
> changed we do not find it in the hashmap and we don't color it, such
> that the reviewer
> can spot a permutation.

Hmph.  Does this have impact on a line that was at the beginning or
the end of a file that got moved to the beginning or the end of a
file (four permutations, of 9 if you throw in "middle"), because
some cases it does not have a "previous" line?
