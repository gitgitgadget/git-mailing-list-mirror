Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561FD20248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfDLJOY (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:14:24 -0400
Received: from tschil.ethgen.ch ([5.9.7.51]:52206 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDLJOY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:14:24 -0400
Received: from [192.168.17.4] (helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <klaus@ethgen.ch>)
        id 1hEsGL-0007Gp-Fn; Fri, 12 Apr 2019 11:14:21 +0200
Received: from klaus by ikki.ket with local (Exim 4.92)
        (envelope-from <klaus@ethgen.ch>)
        id 1hEsGL-0000ip-7B; Fri, 12 Apr 2019 11:14:21 +0200
Date:   Fri, 12 Apr 2019 10:14:21 +0100
From:   Klaus Ethgen <Klaus@ethgen.ch>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: fatal: unable to read after commit
Message-ID: <20190412091420.GF12669@ikki.ethgen.ch>
References: <20190411164440.GC12669@ikki.ethgen.ch>
 <CAP8UFD0bBBtOOz9ew_2URCp3nY1v0_OHMby1-N+T0nCDW82DRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0bBBtOOz9ew_2URCp3nY1v0_OHMby1-N+T0nCDW82DRg@mail.gmail.com>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Christian,

Am Fr den 12. Apr 2019 um  9:39 schrieb Christian Couder:
> On Thu, Apr 11, 2019 at 7:24 PM Klaus Ethgen <Klaus@ethgen.ch> wrote:
> 
> > I am a heavy user of git now at version 2.20.1 on debian.
> >
> > Since some weeks I have the problem that I get often "fatal: unable to
> > read ..." and a unclear repository after a git commit. The commit itself
> > is correct and so a git reset --hard helps to fix the issue.
> 
> Could you tell us at least which Debian version and file system you use?

Sorry, it is debian unstable and the filesystem is a brfs.

> Would you be ok to bisect it or at least tell us if it happens with
> 2.19.2, 2.20.0 and 2.21.0?

I could try, but from the fact, that it happens not all the time, I am
not sure if it helps.

However, I might have found one repo where it allways happens. In fact,
I am able to reproduce it also in my local geeqie checkout.

> > Any Idea what could be the reason for that problem. I encounter it on
> > different repositories so not limited to one.
> 
> Is it easy to reproduce even on very small test repos? Could you send
> us a small script that reproduces it?

In any case it happens if I modify a file and add+commit or commit -a
it. What happens is that the index seems to be corrupted. The HEAD gets
the correct commit and the checked out version of the file is also
correct. Only the index seems to be corrupt (Until I do git reset).

When I do a git status, I get the following output:
   Auf Branch master
   Ihr Branch ist 1 Commit vor 'origin/master'.
     (benutzen Sie "git push", um lokale Commits zu publizieren)

   Zum Commit vorgemerkte Änderungen:
     (benutzen Sie "git reset HEAD <Datei>..." zum Entfernen aus der Staging-Area)

	   neue Datei:     pending.data

   Änderungen, die nicht zum Commit vorgemerkt sind:
     (benutzen Sie "git add/rm <Datei>...", um die Änderungen zum Commit vorzumerken)
     (benutzen Sie "git checkout -- <Datei>...", um die Änderungen im Arbeitsverzeichnis zu verwerfen)

	   gelöscht:       pending.data

And it seems, that the brocken object is always the same:
   > git diff
   fatal: unable to read 544f4ec5fe7c7b04c73b2c2fe9e3e7779e929819

independent from the repository.

I do not have a pending.data and did not touch this one.

> Could you also run the Git test suite on your machine?

Sure.

But at the moment, I have some more findings that points to another
component in the queue. When I do a "commit -a -m test", the error does
not happens. When I do a "commit -a" and use the editor (vim) to write
the commit message, it happens.

As I use fugitive, I cannot rule out, that the problem is in that vim
addon.

Regards
   Klaus
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlywVuYACgkQpnwKsYAZ
9qybEQv/bn3Bs+e/xgPfWK9yDbBlcmVywAiBty5RgYl5FQNHPb/6rRbZMk9wT6MJ
NkLGTj5sgrtRik+TU8C0j982XBJW6EY8jEIzOisBtm5aQ63KdymSI+q6MQd1C3/R
1dd4IMfM2GylQohhsptUdRwErvjoOKHpqAvJnKMnzUC5YxYZ4QL64LLnjoCAz3mK
1W4VceZVHluD/2nv9HP5aOgqihWJNYhIGP9308X4JXw6qn5wGWGljDsyk4NE+NWr
3O0QBYGJO7AYA1WH6eCrPx7DSrPpArdLIwhQCntIKJIrsf3mn4VBUAVB+uhTLeIa
oFyx9vSX/9KlruL/ni287RCRJBYh4DVDsXligFeUTRe0SOuVPgjku9R2oYKpoeKB
7AhI+rKY6vg3At/6iIcaeSw7+ln8ilSqLmbTAz0ygc16T7+CNK5En+nAM2otiNmU
Fs5upQsVGb6pCFTp6aC8P6v+eTqlvH+l6jMsR/7Lx95U9+yOSdSO5x9sbCasCs/g
Z/XxPGkv
=P22A
-----END PGP SIGNATURE-----
