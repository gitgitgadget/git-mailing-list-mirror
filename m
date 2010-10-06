From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv5 08/17] gitweb: Add optional output caching
Date: Wed, 6 Oct 2010 23:16:10 +0000
Message-ID: <AANLkTi=Z6i-89mW8Gom3QQa8R1puV+wksNmh029GaUjS@mail.gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
	<1286402526-13143-9-git-send-email-jnareb@gmail.com>
	<AANLkTi=RFu5PzBfbF0qVjFnSHnf5GGedkgqKAA4v4nVG@mail.gmail.com>
	<201010070106.30864.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:16:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3dDt-0006Rw-O9
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759583Ab0JFXQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 19:16:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49883 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab0JFXQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 19:16:11 -0400
Received: by iwn9 with SMTP id 9so13480iwn.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ScV/D9v1LdLOFdZUcA+8tpWmWGgpA2d3RtaZOPxNehY=;
        b=CdEtLtT0AW0bZqRstiwYqkC37HfR4GJ+ChM12GDEYX8LSc+YIKWzi3Shfk675St2/N
         gBqqWPIiTiSEfiEEm7ag3x0tFCLbRiv4KmbhBEmFVRTrSgm2qmbTzP4PV++aPL4MbBds
         3/JE2LXohkK7EqIR2qBJfiip8LDEG6tyJ5Ps8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FR5Mr3FbkYMl2rIy7pal/rlgdDgxzgeWWgHmne1M+GYERH1W12pBGa6pHeN567U9jv
         3U8IBgJ5PSftN15hSPL4ARfXkIAr0f9w9x4EtYbu9ohZPjXg0pGfDX8CaJ3Y+MiqeCgn
         oRuo9iRQU4NxRwU/zc31slhSXPCtHtnWZx44U=
Received: by 10.231.33.12 with SMTP id f12mr14630248ibd.31.1286406970842; Wed,
 06 Oct 2010 16:16:10 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 6 Oct 2010 16:16:10 -0700 (PDT)
In-Reply-To: <201010070106.30864.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158351>

On Wed, Oct 6, 2010 at 23:06, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 7 Oct 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Oct 6, 2010 at 22:01, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>>
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $cache ||=3D 'G=
itwebCache::SimpleFileCache';
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eval "require $=
cache";
>>
>> Just:
>>
>> =C2=A0 =C2=A0 eval { require $cache };
>>
>> Instead?
>
> Wouldn't work correctly. =C2=A0We want to use 'require BAREWORD' vers=
ion,
> where BAREWORD is name of module, e.g. GitwebCache::SimpleFileCache,
> and which makes Perl to search for GitwebCache/SimpleFileCache.pm
> in @INC.

Ah, I've been using perl5i too much :)

> Well, we could insert hooks into @INC, but I don't think we want to u=
se
> such hack.

There's also:

    eval {
         my $path =3D $cache;
         $path =3D~ s[::][/]g;
         $path .=3D ".pm";
         require $path;
    };

But at that point it's probably easier just to use string eval. Unless =
there's
a performance issue (very unlikely).
