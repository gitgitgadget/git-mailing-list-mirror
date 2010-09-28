From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/6] Introduce pathspec struct
Date: Wed, 29 Sep 2010 08:31:08 +1000
Message-ID: <AANLkTinZ=dx1nBXTw0E=nLOmncsgNb7wv1-+ddWzPU+e@mail.gmail.com>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
	<7v7hi6us35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	David Ripton <dripton@ripton.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 00:31:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ihn-0002Kr-QP
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165Ab0I1WbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 18:31:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35740 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab0I1WbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 18:31:09 -0400
Received: by wwd20 with SMTP id 20so53134wwd.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 15:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p0V4lrBNACsIJIhXsjS53iOvVIPD0xLr5L27L5Gxh6s=;
        b=aP+bhiPAd//nsxn5GCVvZH4pWKJgEB+l8QOwEIo7gCUn24DNNbOXlSj2VHO9QOJkXS
         KdSrAWXK/Z/v8OLDG+CZyC+8pkgkN4o6mUcgKbaLDhvhFXv0nXRe1ZHkQk7KOBhCvsKL
         8Twm6r4tBMJK1Mp2ZJ+QiYVO624NmQxbelPwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QnwD+VOoelfJMDfC2h4MOopQz5vIybFOddQ97YJIQRXhoW8DLbD6fRH28htKhwPR7w
         rgXc5JKXo9fthOr51CpF2QOiaQJZZOuvJszO3YvM3Eqz7v2iu3pzA8pel9SQ2JipvyKW
         apmqRlpNYHZ+JZvxLNMzA1vjxpJE4XIJjZzcM=
Received: by 10.216.20.18 with SMTP id o18mr604552weo.31.1285713068219; Tue,
 28 Sep 2010 15:31:08 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Tue, 28 Sep 2010 15:31:08 -0700 (PDT)
In-Reply-To: <7v7hi6us35.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157485>

2010/9/28 Junio C Hamano <gitster@pobox.com>:
> Just a couple of quick notes.
>
> =C2=A0- I had to eject Bo's "log -L range path" series in order to pu=
sh this
> =C2=A0 out on 'pu' as the range stuff adds new callsites to the old p=
athspec
> =C2=A0 API.
>
> =C2=A0 This is tentative and does not mean Bo's series is getting rej=
ected;
> =C2=A0 I'd want to get its command line parsing around the pathnames =
fixed
> =C2=A0 anyway but I suspect the affected codepath would overlap betwe=
en the
> =C2=A0 two series. =C2=A0Help is appreciated.

I'll have a look.

> =C2=A0- I do not think either !pattern nor ^pattern is particularly a=
 good way
> =C2=A0 to express negative pathspecs. =C2=A0My gut feeling is (I have=
 not thought
> =C2=A0 this through nor clearly enough; note the time of this message=
) that it
> =C2=A0 would be the cleanest at the UI level to introduce negative pa=
tterns as
> =C2=A0 arguments to a separate command line flag, e.g.
>
> =C2=A0 $ git log --exclude "Doc*" master..pu -- '*.txt'
> =C2=A0 $ git grep --exclude "t/" -e 'test .*-L' -- '*.sh'

I was writing "but you would lose the ability to mix negative and
positive pathspecs together, something like 'exclude Documentation
except Documentation/technical'", but then we can have negative
excludes too:

$ git log --exclude Documentation --exclude "!Documentation/technical"
master..pu -- '*.txt'

does not sound too twisted to understand (I hope).

> =C2=A0- David's "git grep --exclude-dir D" topic should be able to in=
ternally
> =C2=A0 use the same negative pathspec mechanism. =C2=A0At the command=
 line level,
> =C2=A0 it allows (and needs to allow) only the leading prefix (which =
is how
> =C2=A0 GNU grep's --exclude-dir works), but it makes tons of sense fo=
r us to
> =C2=A0 allow "--exclude $pattern" from the command line, and share th=
e
> =C2=A0 mechanism internally between the two.

Yes, eventually. But
 - tree_entry_interesting() needs (a bit complex) rework to have
wildcard matching capability
 - then I am still not sure how negative pathspecs should be done prope=
rly

Both may take me weeks to come up with something sensible. If David
needs "git grep --exclude-dir" now, he should keep working on
builtin/grep.c as he's doing now (maybe change --exclude-dir to
--exclude). If my work on negative pathspec has a result, sure I will
remove pathspec_matches() from builtin/grep.c, but his work on the
command line interface _and tests_ won't be wasted.
--=20
Duy
