Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1AD203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 09:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbcLJJ3f (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 04:29:35 -0500
Received: from tschil.ethgen.ch ([5.9.7.51]:41039 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbcLJJ3c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 04:29:32 -0500
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <klaus@ethgen.de>)
        id 1cFdyD-0004Hs-3w
        for git@vger.kernel.org; Sat, 10 Dec 2016 10:29:29 +0100
Received: from klaus by ikki.ket with local (Exim 4.88)
        (envelope-from <klaus@ikki.ethgen.ch>)
        id 1cFdyC-0008BK-Ib
        for git@vger.kernel.org; Sat, 10 Dec 2016 10:29:28 +0100
Date:   Sat, 10 Dec 2016 10:29:28 +0100
From:   Klaus Ethgen <Klaus@Ethgen.ch>
To:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
Message-ID: <20161210092928.jkaf2rwxhicafmxr@ikki.ethgen.ch>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
In-Reply-To: <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello,

Am Fr den  9. Dez 2016 um 20:07 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> > (One other option is to just declare that the quarantine feature doesn't
> > work with colons in the pathname, but stop turning it on by default. I'm
> > not sure I like that, though).
> 
> I think we long time ago in 2005 have declared that a colon in a
> directory name would not work for Git repositories because of things
> like GIT_CEILING_DIRECTORIES, GIT_ALTERNATE_OBJECT_DIRECTORIES; so I
> do not think we terribly mind that direction.

That is the first I hear and I really wonder about.

A colon a perfectly allowed character in POSIX filesystems.

Moreover, it was no problem before and was introduced as a problem just
in that version. Even more, a pull (and so a clone I believe) of such a
path is absolutely ok. Just the push fails.

> > Here's a rough idea of what the quoting solution could look like. It
> > should make your case work, but I'm not sure what we want to do about
> > backwards-compatibility, if anything.
> 
> Yes, obviously it robs from those with backslash in their pathnames
> to please those with colons; we've never catered to the latter, so I
> am not sure if the trade-off is worth it.

As I quote above, a colon is perfect common in POSIX filesystems. A
backslash is at least uncommon and always needed to quote as it, most
often, has special meaning to os/shell.

I cannot see why a tool (as git is) should decide what characters are
"bad" and what are "good". If the filesystem beneath supports it...

By the way, I didn't find anywhere in git documentation that there are
"bad" chars around.

> I can see how adding a new environment variable could work, though.
> A naive way would be to add GIT_ALT_OBJ_DIRS that uses your quoting
> when splitting its elements, give it precedence over the existing
> one (or allow to use both and take union as the set of alternate
> object stores) and make sure that the codepaths we use internally
> uses the new variable.  But if the quarantine codepath will stay to
> be the only user of this mechanism (and I strongly suspect that will
> be the case), the new environment could just be pointing at a single
> directory, i.e. GIT_OBJECT_QUARANTINE_DIRECTORY, whose value is
> added without splitting to the list of alternate object stores, and
> the quarantine codepath can export that instead.

I didn't get it, why is there a need to split? I mean, it is not
possible to push to two locations at the same time, so why is there
splitting at all?

Regards
   Klaus
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlhLyvIACgkQpnwKsYAZ
9qyBzgv9EzMEWrEgsTd1Z0gjpzpJlhpO8R2I7H4mGvEjlxoTXtUNwjvM+ojAYzaI
F34IBRv9BCha+h7I6ccoaAsfmurz73lA1AKy1IFPrYAoxompYLomC9exY+8+ggdN
G2uVbMTmiL+CxJGo0ItxmiQCcv7himVoyto70Dekc7se+panbzCq/vG4+Rz7pwRn
sWnlKs0tQomi6QXbibo8992v4ECkAXzE2Xc/l5DvosSwNNPsqgdeeiNHEMDTbQq8
jqencfOruCfyMnQ0ejCaTWNbYY5SVUtfWikwta12jB06D1BgHTCRVKZCfhoHJx5+
Ffqj8uuiCJuZGQcopzJWiYU5X+SUHz7Ya+iA3VQOxNEKsGAZgq6QQqDcd0y9fyPt
pzMAYo26GRioDiuQZzZ4CzA5eC0wWozv3oESsKLD5RsbWHV/9ODbpr7lHMW2TmUp
H2vZhre1K/ZX2bODQByJoRNtDUqKvZmI6GsbXrvRAFKF4aCLByFIgcrZprmj++DH
jlb25tjq
=jOGb
-----END PGP SIGNATURE-----
