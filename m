From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass under
 Mac OSX
Date: Wed, 7 Mar 2012 22:03:49 +0100
Message-ID: <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5O1w-00008p-Cn
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 22:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab2CGVEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 16:04:12 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43188 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab2CGVEK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 16:04:10 -0500
Received: by eekc41 with SMTP id c41so2485613eek.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 13:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ux4TCBDd1d6JopLYmzCaExexFSXb4COcGABbewlEWho=;
        b=I1nRnQ0G6dZ9DDZjWlfYEDeAp8pZUGbC4vqvTGm+z270I8QkTaejprKEuzMxfgLOY7
         xlRKDmAIlXekqlqlX9XBWMNU+CqZjoYucFaTfLlN2ioDa9gFvmdXkDgWzRMfIylndxM0
         dNiBzRGngH+0YlcwIJe1sKZjGQJ7WYsy6X5+KTbY+aieN3dJOSXHlgCqLpJdomfgMW0/
         9BsSXLba8DCbHYf1QAd04vxI62MukF+pjijYHz/Uqw8ErFptZnBo7+pbGS3LVF3wWMvW
         PKhmXBN6xH4+kNaGVxija+CTlUM4i6ZyPIwhgWnxS7drdgKqW9vHuyYdW5kfX6LoBjwR
         8mcQ==
Received: by 10.213.7.80 with SMTP id c16mr865379ebc.7.1331154249195; Wed, 07
 Mar 2012 13:04:09 -0800 (PST)
Received: by 10.213.2.147 with HTTP; Wed, 7 Mar 2012 13:03:49 -0800 (PST)
In-Reply-To: <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192482>

On Mon, Mar 5, 2012 at 21:39, Junio C Hamano <gitster@pobox.com> wrote:
> I do not see any reason to insist that their fallback behaviour must
> be to fill them with question marks. =C2=A0In other words, I simply d=
o
> not see the point of this test and the original "pass runs of
> question" to begin with, and this patch makes things even worse.
>
> Why not get rid of this single test that only tries to check the
> output for an impossible request?
>
> =C3=86var, am I missing something?

Sorry about the late reply, I think if anything it needs to be
expanded beyond its current scope.

Our gettext implementation is peculiar in two ways:

 * We support 3 different languages, one of which (Perl) is supported
   through a non-GNU package.

 * We have this fantastic hack in gettext.c's init_gettext_charset to
   deal with a glibc bug.

I think in particular re-encoding works completely differently under
the Perl i18n library than it does with GNU gettext (and we don't have
tests for this) and instead of just dropping unknown characters under
non-UTF-8 locales on some platforms everything may turn into complete
gibberish.

When I added this test this was what I was planning to smoke
out. Different behaviors on different platforms. In this case the OSX
behavior seems benign, but I'd much rather patch the test to detect
OSX rather than removing it entirely, maybe other obscure operating
systems (Aix, HP/UX etc.) will behave differently.

We still don't really have any use of the i18n feature, i.e. we
haven't had translations submitted yet, and thus don't have any
users. I think it's important to be pro-active about trying to spot
any issues that might affect end users before they happen.
