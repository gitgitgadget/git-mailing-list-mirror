Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8690AC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623AD2078C
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DEWWiXDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406308AbgE1TVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:21:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52731 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406299AbgE1TUy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:20:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE92D7DE35;
        Thu, 28 May 2020 15:20:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F5nqOSf+t/YvOXJze26QDPcWtBo=; b=DEWWiX
        DgmDctw67ozVuBZ9b0auQfgLkp/1oyw2RUUZU8Scx7mk9gmLNrBIOppT6fcH0TXy
        bVXj3Sqnj3jK2fVBzVJvO8MJu0qS+f3AvGiLCL5ym+bjT3Tr/imHQ43CTbVdbTHg
        6YoiRKTg/zXY6+QUnq8ZGBYryfNLsZWFdyjKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x3PYCTrvEPGfnk+GUDTsjBW3QGaJuVmI
        kZISA8b1bGiNDiCvFKaypkwnV9bVAWUrFWlXs2kQ6T3+tT3rI49IurzJCCqQSVpz
        RQKbqEeKX8eotTixrEunxG3GxCEB7GFn2fNbi/AYcTdUMi92E0RktdyY8ogWT5Ob
        7QxJgUJQNHA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E50FA7DE34;
        Thu, 28 May 2020 15:20:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6735B7DE33;
        Thu, 28 May 2020 15:20:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, hji@dyntopia.com
Subject: Re: [PATCH] t: avoid alternation (not POSIX) in grep's BRE
References: <20200528083745.15273-1-carenas@gmail.com>
        <xmqqo8q83x3v.fsf@gitster.c.googlers.com>
        <20200528154349.GA1215380@coredump.intra.peff.net>
        <xmqqh7w03vnq.fsf@gitster.c.googlers.com>
        <20200528165245.GA1223396@coredump.intra.peff.net>
Date:   Thu, 28 May 2020 12:20:49 -0700
In-Reply-To: <20200528165245.GA1223396@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 28 May 2020 12:52:45 -0400")
Message-ID: <xmqqsgfj3lym.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5750BC3C-A118-11EA-B5D2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But I haven't really found a use for "Fixes" in machine-readable format.
> I don't _mind_ people doing it if they do have a use (and I'd even
> consider doing it myself if I were shown that it was useful). In the
> meantime, I don't know if we want to state a project preference against
> it.

I've seen "Fixes: bug number" in projects that maintain bug
databases and automatically updates the status of the named bug when
a commit with such a footer hits certain integration branches; the
utility of such a usecase would be fairly obvious.

But "Fixes: <commit>" makes me nervous.  One reason is because a
commit very often introduces multiple bugs (or no bugs at all), so
which one (or more) of the bug is corrected cannot be read from such
a footer that _only_ blames a particular commit.

	Side note: also "fixes:" footer would cast a claim made when
	a commit was created in stone---which may later turn out to
	be false.  But the issue is not unique to "Fixes: <commit>";
	"Fixes: <bugid>" suffers exactly from the same problem.

An interesting aspect of "Fixes: <commit>" is that we can use it to
easily see who is the buggiest by dividing number of buggy commit by
number of total commits per author ;-)

I'd rather not to see people adding random footers whose utility is
dubious, but for this particular one, I am not against it strongly
enough to be tempted to declare an immediate ban.
