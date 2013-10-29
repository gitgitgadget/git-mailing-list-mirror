From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #06; Fri, 25)
Date: Tue, 29 Oct 2013 10:09:11 +0100
Message-ID: <CAH7EuMHgH6Oe_SvjyutBaakRfyZGHpp_iimaAzpV09AnHTYntw@mail.gmail.com>
References: <xmqqeh79hr3o.fsf@gitster.dls.corp.google.com>
	<CACsJy8A3s4TUmUOC+i-k97GxxvBQ7mQmdoPJizfy1yS3rqLEkA@mail.gmail.com>
	<xmqq61shgzvn.fsf@gitster.dls.corp.google.com>
	<CAFFjANSnuS6_+uAd43AayojJyK-wj2wMxQ6DBD6JyN=A7xh2_A@mail.gmail.com>
	<526EBEE8.7070807@gmail.com>
	<CAFFjANRaphYdg6VM8cqJY3NmPz+gNE7S9S1jAgPPctUZio7+Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <blees@dcon.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: =?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 10:09:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb5Ic-0005y6-UZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 10:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab3J2JJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Oct 2013 05:09:14 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:55653 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab3J2JJM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Oct 2013 05:09:12 -0400
Received: by mail-ob0-f177.google.com with SMTP id vb8so4907249obc.36
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=MwqH9FvuBafgi8ZRjje7ARfOX1wQH3La56xMvof3U1s=;
        b=ftXPMRkKGtO25foZbO38R/leJrh99HwhpxzqpyQNgEfMeItCG/D736EpQwEMZoTr/y
         lM0BSFZiJZMWaxDPZUrNZreN4mJoVhPUIaTb8yjAj213zWLWaXwggLQnKEdYYmxY7zHu
         q2lPeCgXR+62XkeXZVzSPa/lOkcxr1/VGq2xbD5oN38AkQm3CJsMJwIxzPp9mMXrIJeo
         Bg2Hs/niKpVGT2J5y66qnbWCINFvdOqtVOtT5mkuicikyOv+VSipZgcxYyHgOn55l7mm
         foIXX6k4h9zb0qD/Gp8Gjb6pO0bF+F3O0gBe3BQIJsjYU7puho+oD/Z0q0/EXMlGl5WS
         CAdA==
X-Received: by 10.182.101.134 with SMTP id fg6mr2033194obb.30.1383037751262;
 Tue, 29 Oct 2013 02:09:11 -0700 (PDT)
Received: by 10.76.24.165 with HTTP; Tue, 29 Oct 2013 02:09:11 -0700 (PDT)
In-Reply-To: <CAFFjANRaphYdg6VM8cqJY3NmPz+gNE7S9S1jAgPPctUZio7+Tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236918>

On Mon, Oct 28, 2013 at 10:04 PM, Vicent Mart=ED <tanoku@gmail.com> wro=
te:
>
> On Mon, Oct 28, 2013 at 8:45 PM, Karsten Blees <karsten.blees@gmail.c=
om> wrote:
>
> > Regarding performance, khash uses open addressing, which requires m=
ore key comparisons (O(1/(1-load_factor))) than chaining (O(1+load_fact=
or)). However, any measurable differences will most likely be dwarfed b=
y IO costs in this particular use case.
>
> I don't think this is true. If you actually run a couple insertion an=
d
> lookup benchmarks comparing the two implementations, you'll find khas=
h
> to be around ~30% faster for most workloads (venturing a guess from
> past experience). I am obviously not the author of khash, but I've
> found that the theoretical increase in key comparisons is completely
> dwarfed by the benefit of increased cache locality during the probing
> fase. I still haven't found a faster C hash table implementation than
> khash for the general case, that's why I normally use it despite the
> worrisome preprocessor crash-party going on in that header file.

Yes, cache locality is where open addressing shines, however, you
loose that benefit when the keys are pointers (e.g. sha1's).

>
>
> > Btw., pack-objects.c::rehash_objects() in patch 03 unnecessarily ch=
ecks for duplicates. That's probably the reason for the high hashcmp ti=
mes you found in the first round of the patch series.
>
> Patch 03 is a refactoring -- the duplicate checking code has been in
> pack-objects.c for years. I am not sure duplicate checking is
> superfluous at all, there are many cases where you could be
> double-inserting objects in a pack-objects run, and you really don't
> want to generate packfiles with dupe objects.

The point is that its in _rehash_. Duplicate checking should be in
add/put. Rehash only rearranges entries that are alread _in_ the map,
and it usually only needs the hash code for that. So pack-objects
implements rehash in terms of a full clear + add-all instead, which is
of course slower than what khash, hashmap etc. would do.

Ciao,
Karsten
