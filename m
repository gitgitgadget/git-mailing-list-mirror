From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Fixes handling of --reference argument.
Date: Thu, 25 Oct 2012 23:32:29 +0200
Message-ID: <5089AFED.7060404@web.de>
References: <5088c5a4.L25tOcUVCSwBRpYF%szager@google.com> <20121025083625.GA8390@sigill.intra.peff.net> <20121025104519.GA3816@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, szager@google.com, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Oct 25 23:32:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRV2m-0003Bf-7m
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 23:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188Ab2JYVcg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2012 17:32:36 -0400
Received: from mout.web.de ([212.227.17.11]:54965 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912Ab2JYVcf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 17:32:35 -0400
Received: from [192.168.178.41] ([91.3.191.79]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0Lsy7e-1TGw4A4Aag-012TXs; Thu, 25 Oct 2012 23:32:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121025104519.GA3816@odin.tremily.us>
X-Provags-ID: V02:K0:XQydVzghXC/q0BAIoPuxWMJ5f/4lpZuZvB7Kz51N2ws
 1n2NkHXkZ4l2tl8RCq8kic14JcMsR/p43rjwvfgKaEwVVu+nW5
 Gi43fpyY7+HaKYNE5+n/w+jQgiDY3lvpXI9zadlXB0oWExfRIb
 eYEZvoMyT2/lbxZ4iyH22VtouAQLmXr7uw+OVb1mpj7Tddks4g
 16GgkI/NMF8DJerhR4Scw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208419>

Am 25.10.2012 12:45, schrieb W. Trevor King:
> On Thu, Oct 25, 2012 at 04:36:26AM -0400, Jeff King wrote:
>> On Wed, Oct 24, 2012 at 09:52:52PM -0700, szager@google.com wrote:
>>> diff --git a/git-submodule.sh b/git-submodule.sh
>>> index ab6b110..dcceb43 100755
>>> --- a/git-submodule.sh
>>> +++ b/git-submodule.sh
>>> @@ -270,7 +270,6 @@ cmd_add()
>>>  			;;
>>>  		--reference=3D*)
>>>  			reference=3D"$1"
>>> -			shift
>>>  			;;
>>
>> Is that right? We'll unconditionally do a "shift" at the end of the
>> loop. If it were a two-part argument like "--reference foo", the ext=
ra
>> shift would make sense, but for "--reference=3D*", no extra shift sh=
ould
>> be neccessary. Am I missing something?
>=20
> Both the patch and Jeff's analysis are right.  You only need an
> in-case shift if you consume "$2", or you're on =E2=80=98--=E2=80=99 =
and you're
> breaking before the end-of-case shift.

Right you are. The shift there is wrong, as there is no extra argument
to consume for "--reference=3D<repo>" (opposed to "--reference <repo>",
also see cmd_update() where this is done right).

So tested and Acked-By me, but me thinks the subject should read:

   [PATCH] submodule add: Fix handling of the --reference=3D<repo> opti=
on

and the commit message should begin with:

   Doing a shift there is wrong because there is no extra argument
   to consume when "--reference=3D<repo>" is used (note the '=3D' inste=
ad
   of a space).

Peff, is it ok for you to squash that in or do you want Stefan to resen=
d?
