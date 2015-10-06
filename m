From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG?] parallel make interdepencies
Date: Tue, 6 Oct 2015 16:24:12 +0200
Message-ID: <5613D98C.1020103@drmicha.warpmail.net>
References: <56138273.6010204@drmicha.warpmail.net>
 <e76ba2a01053392526a499ec9bff0d37@dscho.org>
 <20151006133341.GS17201@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 16:24:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjTAF-0002k8-7p
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 16:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbbJFOYR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 10:24:17 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52572 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752509AbbJFOYO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2015 10:24:14 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 20171203DC
	for <git@vger.kernel.org>; Tue,  6 Oct 2015 10:24:14 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 06 Oct 2015 10:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=A28uv7b/cMRLSaw/drZpp4sNKJ8=; b=h2bVNu
	4oDC6sUDLunBN2fep3gmosbuANlSHCnngaL9EVuY5/EIVGxYvwa6UjwAj7FJlbqb
	M3FzjlmLY0noo0lLyEsIk3NdtC4893aRt1jLxcFtAwPtPy+C8g7hPENmxR5atLAw
	z0r43ZZ36MpvWnqbpnn7i4Cpoa/3p/geaDM3U=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=A28uv7b/cMRLSaw
	/drZpp4sNKJ8=; b=hwUpIj9HYqYJL7Yb4X2McwA463VzXEI50Fjsuawd8LGqhZv
	tBI4fHoXD4/Yu+0NV/cGzrfEq96fP21a7aPvN4Pa9IsfLZez9IkpWPTwP7PhiKjs
	G+zHWVrZarAei6+FskKAkjAS2wBzCsdaPXZhShqPlwH6UgFtM5vD/MM/jNss=
X-Sasl-enc: qhUyKVnwu3EptyLoFARFsiX5/EPkeFNW0424IcoBQ1X6 1444141453
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 753F66800DB;
	Tue,  6 Oct 2015 10:24:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151006133341.GS17201@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279149>

John Keeping venit, vidit, dixit 06.10.2015 15:33:
> On Tue, Oct 06, 2015 at 03:13:05PM +0200, Johannes Schindelin wrote:
>> Hi Michael,
>>
>> On 2015-10-06 10:12, Michael J Gruber wrote:
>>> "make -j3" just errored out on me, a follow-up "make" succeeded". T=
his
>>> looks like an interdependency issue, but I don't know how to track =
it:
>>>
>>>     GEN git-web--browse
>>>     GEN git-add--interactive
>>>     GEN git-difftool
>>> mv: der Aufruf von stat f=C3=BCr =E2=80=9Eperl.mak=E2=80=9C ist nic=
ht m=C3=B6glich: Datei oder
>>> Verzeichnis nicht gefunden
>>>
>>> (cannot stat "perl.mak")
>>
>> This one sounds awfully familiar. Although I only encountered this i=
f
>> I specified `make -j15 clean all`, i.e. *both* "clean" and "all"...
>=20
> I've seen something like this after upgrading perl (I can't remember =
the
> exact error, so it may not be the same problem but I'm pretty sure it
> involves perl.mak).  The problem was a result of the perl library pat=
h
> changing, but I never got around to creating a patch.
>=20
> I thought I remembered someone else posting a patch to address this, =
but
> I can't find it so perhaps I'm remembering commit 07981dc (Makefile:
> rebuild perl scripts when perl paths change, 2013-11-18).
>=20

At least I'm in good company, then. The statistical evidence is 100%
clear: It's a John-related issue.

Michael J(ohannes)
