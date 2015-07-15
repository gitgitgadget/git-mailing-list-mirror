From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] icase match on non-ascii
Date: Wed, 15 Jul 2015 16:39:24 +0700
Message-ID: <CACsJy8BXGt25tGoarry=UQS6E4Q54kicG5oY9uoU6W_hw1wYtg@mail.gmail.com>
References: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
 <1436880280-18194-1-git-send-email-pclouds@gmail.com> <55A53C13.5090405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Plamen Totev <plamen.totev@abv.bg>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 15 11:40:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFJAW-00006o-1r
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 11:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbbGOJj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2015 05:39:56 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35913 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbbGOJjy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jul 2015 05:39:54 -0400
Received: by igbij6 with SMTP id ij6so66847162igb.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/XrW4xKt2JTGygB8lXluvAmj10lW3IcaBxKRLJBRUko=;
        b=zefLEz7MZLcahLSDokb3CkV76zLtdhINFA1JQRaZgk1Wm2y4xdGWSwqnVid2q6g+Wd
         unMGG/Gll1Y8CtIwTc+xI0N8VCRkUwkSNiaIVjLoWPV3Y1Tr8APhUjpYAvgNRxswz76M
         1JjAD4Qp9CkEA+2p1uLti6BQnqtwQW8TLsBqATuq+vonAhLdOENXlTHn43PG1wZTajRD
         Q3pJTahGU5teo8UzC1a53kdnoW7i1sflXN/7K2sUfrK9+235cryQSSmHJqr2DaIcbU8/
         Uhw5GHjA80d2ve8S+O1I6ssNCTdDrq8Yi/Xt1tAN3NPVjOsGUBBM2TWI76QlaLm6UxbE
         dTEg==
X-Received: by 10.50.62.148 with SMTP id y20mr24930399igr.17.1436953193907;
 Wed, 15 Jul 2015 02:39:53 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 15 Jul 2015 02:39:24 -0700 (PDT)
In-Reply-To: <55A53C13.5090405@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273981>

On Tue, Jul 14, 2015 at 11:42 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> (I haven't been able to do more debugging yet,
> but this doesn't fully work on my Mac OS X box:)
>
> Initialized empty Git repository in
> /Users/tb/NoBackup/projects/git/tb.150714_Duy_grep_utf8/t/trash
> directory.t7812-grep-icase-non-ascii/.git/
> # lib-gettext: Found 'is_IS.UTF-8' as an is_IS UTF-8 locale
> # lib-gettext: Found 'is_IS.ISO8859-1' as an is_IS ISO-8859-1 locale
> expecting success:
>     printf "TILRAUN: Hall=C3=B3 Heimur!" >file &&
>     git add file &&
>     LC_ALL=3D"$is_IS_locale" &&
>     export LC_ALL
>
> ok 1 - setup
>
> expecting success:
>     git grep -i "TILRAUN: Hall=C3=B3 Heimur!" &&
>     git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
>
> file:TILRAUN: Hall=C3=B3 Heimur!
> not ok 2 - grep literal string, no -F
> #
> #        git grep -i "TILRAUN: Hall=C3=B3 Heimur!" &&
> #        git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
> #

I don't know if there's an easy way to test if regexec() on your
system supports locale (at least for is_IS). I can reproduce the same
by using compat regex. So it's not a good news because compat regex is
used in a few platforms, so this test will fail on those.

I don't see any way around it, except dropping all the tests. I don't
think there is a way for us to test regex locale support at runtime.
--=20
Duy
