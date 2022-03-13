Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C603C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 05:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiCMFoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 00:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiCMFoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 00:44:16 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C58A32044
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 21:43:09 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2578C197EDA;
        Sun, 13 Mar 2022 00:43:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gpOBHbF+1nuj
        7cRonpRm+RDvQODLxyry6TiqJjeK2AY=; b=NUEBcXMC7v5ovcupx9ISm2cctjZG
        zLPCEfjYO3p/KouLFBRVyPYZEdsP0g51W4NYfenGxZGg54B17h5NH+sqQBfv6OQd
        a1A4r9Mz8H9kIaps/TMxJ4ebBISWM3l4tiD0n4xBk0YqZZtuzwB7CwpL62vyugrm
        eLQH3Ix4k6X17Fo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CF18197ED9;
        Sun, 13 Mar 2022 00:43:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.78.140.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4DF05197ED8;
        Sun, 13 Mar 2022 00:43:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v9 0/3] teach submodules to know they're submodules
References: <20220301002613.1459916-1-emilyshaffer@google.com>
        <20220310004423.2627181-1-emilyshaffer@google.com>
        <220311.8635joj0lf.gmgdl@evledraar.gmail.com>
Date:   Sat, 12 Mar 2022 21:43:03 -0800
In-Reply-To: <220311.8635joj0lf.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 11 Mar 2022 10:09:50 +0100")
Message-ID: <xmqqpmmql860.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 74FCBEE0-A290-11EC-AF9A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But now it's a boolean indicating "it's there, discover it", and the
> implied (but not really explicitly stated) reason in 2/3 is that it's
> purely for optimization purposes at this point.

You may know that I have a separate checkout of the 'todo' branch at
path "Meta" in my working tree.

I could use the hasSuperproject=3Dfalse setting there, to say "this is
*NOT* a submodule, even the parent directory is a working tree of a
different repository, it is not our superproject, so do *NOT* bother
to go up to discover anything".

If that configuration weren't there in the "Meta/.git/config", the
parent directory of "Meta" (which has its own ".git") cannot tell if
that "Meta" thing is a submodule being prepared that hasn't been
added yet, or it will never intended to be a submodule.  I would
imagine that "git add X" can later be taught to refuse to add X if
there is X/.git and X/.git/config says it explicitly says that it
does not have a superproject.

So, I am not sure if it is a good characterization that it is for
optimization at all.
