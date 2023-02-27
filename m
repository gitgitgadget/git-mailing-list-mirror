Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD27C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 20:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjB0U0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 15:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB0U02 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 15:26:28 -0500
Received: from tilde.club (tilde.club [142.44.150.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C621D91A
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 12:26:23 -0800 (PST)
Received: from tilde.club (unknown [103.251.167.10])
        by tilde.club (Postfix) with ESMTPSA id 5EB1D2210D613;
        Mon, 27 Feb 2023 20:26:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 5EB1D2210D613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1677529573; bh=/hJQcDkA3gRTQ4eJLuITdqEGBITrm08jmp4tp83TaYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8rFplrBIx6A+65DIqV1C7qhhx87hV+G04v+2HKKyhqKohruVXgJxQVMKJlmvvpaE
         3Fjd/WMl0eMkiVvAwHswH63GhiX0G/0wP797VHMTtLr/55uXYe5YZX5wJ6aBBnHv3A
         TiPEvmQhmKI/j81uzvB529QwOIKpvgAUdvSowJj4=
Date:   Mon, 27 Feb 2023 20:26:06 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] signature-format.txt: note SSH and X.509 signature
 delimiters
Message-ID: <Y/0R3lDyJrtd4gIZ@tilde.club>
References: <20220120053223.221667-1-gwymor@tilde.club>
 <20230210061611.124932-1-gwymor@tilde.club>
 <230210.86ilg9wzho.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230210.86ilg9wzho.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-10 11:52:42+0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Feb 10 2023, Gwyneth Morgan wrote:
> 
> > This document only explained PGP signatures, but Git now supports X.509
> > and SSH signatures.
> 
> To elaborate a bit, in 1e7adb97566 (gpg-interface: introduce new
> signature format "x509" using gpgsm, 2018-07-17) we added X.509, and in
> 29b315778e9 (ssh signing: add ssh key format and signing code,
> 2021-09-10) we added "ssh", but our docs were never updated.
> 
> Your commit message says as much in briefer terms, but maybe if you
> re-roll having those references would help put this change in context.>

I'll reference those commits in v3.

> > +Signatures begin with an ASCII Armor header line and end with a tail line,
> > +which differ depending on signature type.
> 
> Does the "ASCII Armor header" really add something here, or just confuse
> the user with a reference that's not followed-up or explained here?
> Maybe we should point out OpenPGP's '--armor' option in passing, to note
> to the reader that this isn't some git-specific concept.

I think having a relevant term to search for online and in manpages is
helpful. Mentioning the specific command-line option seems unnecessary,
but I'll put the term "ASCII Armor" in quotes to make it clearer that
this is not a git-specific concept.

> I wonder if structuring it like this wouldn't help make this easier to
> read, and reduce the repetition, as well as making the circular
> references between this & 'gpg.format' more obvious:
> 
> 	The signature start and end marker comes on its own line, and
> 	differs based on the signature type (as selected by
> 	'gpg.format', see linkgit:git-config[1]).
> 
>         Those are, for values of 'gpg.format':
> 
>         gpg: `-----BEGIN PGP SIGNATURE-----` and `-----END PGP
>              SIGNATURE-----`. Or, if GPG has been asked to produce
>              RFC1991 signatures: `-----BEGIN PGP MESSAGE-----` and
>              `-----END PGP MESSAGE-----`
> 
>         x509: `-----BEGIN SIGNED MESSAGE-----` `-----END SIGNED MESSAGE-----`
> 	ssh:`-----BEGIN SSH SIGNATURE-----` and `-----END SSH SIGNATURE-----`

Looks good. I'll do this in v3. I'll reference these by the gpg.format
value, as well as a parenthetical proper name, like "gpg (PGP)"; these
are basically the same the other two formats, but I want it to be clear
that `gpg` signatures don't have to be from the gpg program but could be
from any PGP-supporting program.

> Then for gpg.format in Documentation/config/gpg.txt we could add e.g.:
> 
> 	See linkgit:gitformat-signature[5] for the signature format,
> 	which differs based on the selected 'gpg.format'.

OK.

Thanks.
