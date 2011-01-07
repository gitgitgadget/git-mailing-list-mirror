From: Zenaan Harkness <zen@freedbms.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Fri, 7 Jan 2011 13:36:31 +1100
Message-ID: <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com> <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 03:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb2Cp-0007gE-U3
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 03:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab1AGChF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jan 2011 21:37:05 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382Ab1AGChD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jan 2011 21:37:03 -0500
Received: by bwz15 with SMTP id 15so16973943bwz.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 18:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=m9W4wXRJbXMDSCtXSvAgQCX7KrDgo7ph80mNZNSTWW0=;
        b=X8/TYKHs53fTQiF8GkypV3peOBn3qg4e72pg99yxKGvhkQ7qxX5juUk2qJZT8/ZZVP
         zYXEiFG03nG8Hx43Sr7gma0drUcObbP4a9ZjrOyjQTbNW744oWhROpldvyuz6jj9xwSy
         J1FVPaJ9CcTvdHyVnUjvEFFb6a0l1SCamEqxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=X55ozu+35Efip9U2kaTMyLeJuI7DKd994/35iooVTHZ8O/ed+XzUwi4op9puNEmnos
         bnVVJpMoJw4sLZiGGuEyRc35YkmMYTsH2FX+C6TJ5zZdnz+dxACeGJl7JOEM5jdbPHx6
         4JpfDpIzjdOnkVA1ShtwBHXa6YPwg/ztWeKB0=
Received: by 10.204.75.193 with SMTP id z1mr3005569bkj.214.1294367822016; Thu,
 06 Jan 2011 18:37:02 -0800 (PST)
Received: by 10.204.112.210 with HTTP; Thu, 6 Jan 2011 18:36:31 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
X-Google-Sender-Auth: J2gShbmY-1QNLS-C6Sw0n_U21Eo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164695>

On Fri, Jan 7, 2011 at 08:09, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 6 Jan 2011, Zenaan Harkness wrote:
>
>> Bittorrent requires some stability around torrent files.
>>
>> Can packs be generated deterministically?
>
> They _could_, but we do _not_ want to do that.
>
> The only thing which is stable in Git is the canonical representation=
 of
> objects, and the objects they depend on, expressed by their SHA1
> signature. =A0Any BitTorrent-alike design for Git must be based on th=
at
> property and not the packed representation of those objects which is =
not
> meant to be stable.
>
> If you don't want to design anything and simply reuse current BitTorr=
ent
> codebase then simply create a Git bundle from some release version an=
d
> seed that bundle for a sufficiently long period to be worth it. =A0Th=
en
> falling back to git fetch in order to bring the repo up to date with =
the
> very latest commits should be small and quick. =A0When that clone get=
s too
> big then it's time to start seeding another more up-to-date bundle.

Thanks guys for the explanations.

So, we don't _want_ to generate packs deterministically.
BUT, we _can_ reliably unpack a pack (duh).

So if my configured "canonical upstream" decides on a particular
compression etc, I (my git client) doesn't care what has been chosen
by my upstream.

What is important for torrent-able packs though is stability over some
time period, no matter what the format.

There's been much talk of caching, invalidating of caches, overlapping
torrent-packs etc.

In every case, for torrents to work, the P2P'd files must have some
stability over some time period.
(If this assumption is incorrect, please clarify, not counting
every-file-is-a-torrent and every-commit-is-a-torrent.)

So, torrentable options:
- torrent per commit
- torrent per pack
- torrent per torrent-archive - new file format

Torrent per commit - too small, too many torrents; we need larger
p2p-able sizes in general.

Torrent per pack - packs non-deterministically created, both between
hosts and even intra-host (libz upgrade, nr_threads change, git pack
algorithm optimization).

A new torrent format, if "close enough" to current git pack
performance (cpu load, threadability, size) is potential for new
version of git pack file format - we don't want to store two sets of
pack files on disk, if sensible to not do so; unlikely to happen - I
can't conceive that a torrentable format would be anything but worse
than pack files and therefore would be rejected from git master.

Can we can relax the perceived requirement to deterministically create
pack files?
Well, over what time period are pack files stable in a particular git?
Over what time period do we require stable files for torrenting?

Can we simply configure our local git to keep specified pack files for
specified time period?
And use those for torrent-packs?
Perhaps the torrent file could have a UseBy date?

Zen
