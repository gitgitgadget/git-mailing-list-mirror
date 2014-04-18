From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 2/4] Submodules: Add the lib-submodule-update.sh
 test library
Date: Fri, 18 Apr 2014 14:31:05 +0200
Message-ID: <53511B09.1010700@web.de>
References: <5331B6F6.60501@web.de> <5331B741.6000606@web.de> <20140417164138.GP21805@odin.tremily.us> <535042B6.7040800@web.de> <20140417215531.GY21805@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Apr 18 14:31:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wb7wp-0001fW-6T
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 14:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbaDRMbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2014 08:31:11 -0400
Received: from mout.web.de ([212.227.15.14]:55090 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbaDRMbI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 08:31:08 -0400
Received: from [192.168.178.41] ([79.193.66.64]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M5Oct-1Ws5Ej277X-00zalW; Fri, 18 Apr 2014 14:31:06
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140417215531.GY21805@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:hfAyiBcF+w18Guf/XhXObQdaygijtOIAgvq1ivIbfQOYKSu+Bcf
 xgVJQjGC2Sehu6LkQ9UmTT5snzZtWxaT4ZC4baOQZBV4icRnLf+a+x5iQ6GMB5PF8Rgp+GW
 2ol2mK5yKQw2OPUW4uTPKJ/nb7cR1a7K779W0pzF0cAr2M2K5HsfVDyIxge6oCP0YYAJM5s
 2WXy/C9rPxkeqPXx2/q/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246468>

Am 17.04.2014 23:55, schrieb W. Trevor King:
> On Thu, Apr 17, 2014 at 11:08:06PM +0200, Jens Lehmann wrote:
>> Am 17.04.2014 18:41, schrieb W. Trevor King:
>>> On Tue, Mar 25, 2014 at 06:05:05PM +0100, Jens Lehmann wrote:
>>>> *) When a submodule is replaced with a tracked file of the same na=
me
>>>>    the submodule work tree including any local modifications (and
>>>>    even the whole history if it uses a .git directory instead of a
>>>>    gitfile!) is simply removed.
>>>> =E2=80=A6
>>>> I think the first bug really needs to be fixed, as that behavior i=
s
>>>> extremely nasty. We should always protect work tree modifications
>>>> (unless forced) and *never* remove a .git directory (even when
>>>> forced).
>>>
>>> I think this should be covered by the usual =E2=80=9Cdon't allow ch=
eckouts
>>> from dirty workdirs unless the dirty-ing changes are easily applied=
 to
>>> the target tree=E2=80=9D.
>>
>> Nope, the target tree will be removed completely and everything in
>> it is silently nuked. It should be allowed with '-f', but only if
>> the submodule contains a gitfile, and never if it contains a .git
>> directory (which is just what we do for rm too).
>=20
> I think it's not covered *now* because of a flaw in our =E2=80=9Care =
dirty-ing
> changes easily applied to the target tree=E2=80=9D detection logic, a=
nd the
> solution should involve updating that logic to hit on this case.

Yup.

>> b) recursive checkout is the place to consistently care about
>> submodule modifications (the submodule script doesn't do that and it
>> is impossible to change that without causing trouble to a lot of
>> users.
>=20
> I agree that the submodule script is not the place for this, and the
> core checkout code is.  I'd like checkouts to always be recursive, an=
d
> see --[no-]recurse-submodules as a finger-breaking stop-gap until we
> can complete that transition for checkout, bisect, merge, reset, and
> other work-tree altering commands.  I think this is one reason why
> some folks prefer the stiffer joints you get from a subtree approach.

We are definitely in the same boat here :-)
