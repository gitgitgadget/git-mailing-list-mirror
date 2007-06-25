From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] diff: round down similarity index
Date: Mon, 25 Jun 2007 03:29:27 +0200
Message-ID: <467F1A77.3030209@lsrfire.ath.cx>
References: <467EEEE6.3090100@lsrfire.ath.cx> <Pine.LNX.4.64.0706250021250.4059@racer.site> <Pine.LNX.4.64.0706250026400.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, David Kastrup <dak@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 25 03:29:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2dOl-0000Pj-Iu
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 03:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbXFYB3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Jun 2007 21:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbXFYB3p
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 21:29:45 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:44650
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751742AbXFYB3p (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 21:29:45 -0400
Received: from [10.0.1.201] (p508E6397.dip.t-dialin.net [80.142.99.151])
	by neapel230.server4you.de (Postfix) with ESMTP id CF3667406;
	Mon, 25 Jun 2007 03:29:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <Pine.LNX.4.64.0706250026400.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50854>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Mon, 25 Jun 2007, Johannes Schindelin wrote:
>=20
>> On Mon, 25 Jun 2007, Ren=EF=BF=BD Scharfe wrote:
>>
>>> Rounding down the printed (dis)similarity index allows us to use
>>> "100%" as a special value that indicates complete rewrites and
>>> fully equal file contents, respectively.
>>>
>>> [...]
>>>
>>> +static int similarity_index(struct diff_filepair *p)
>>> +{
>>> +	int result =3D p->score * 100.0 / MAX_SCORE;
>>> +
>>> +	/* Paranoia: guard against floating point rounding errors. */
>>> +	if (p->score =3D=3D MAX_SCORE)
>>> +		result =3D 100;
>>> +	else if (result =3D=3D 100)
>>> +		result =3D 99;
>>> +
>>> +	return result;
>>> +}

>> Besides, AFAIR p->score is not even calculated if the files are iden=
tical,=20
>> because that hits a different code path.

True, ->score is set to MAX_SCORE for identical files by a different
code path than the one that actually compares the contents and
calculates a score.  That doesn't matter for printing the "similarity
index nn%" line etc., though.  Or is there a way for identical files to
end up with a ->score of 0 (or some other value !=3D MAX_SCORE) that I =
missed?

In any case, the patch doesn't change the way the score is calculated,
i.e. its value is the same as before.  It only changes how it is displa=
yed.

Ren=C3=A9
