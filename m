From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Q] Mark files for later commit?
Date: Tue, 29 Mar 2011 09:09:03 +0200
Message-ID: <4D91858F.7030404@drmicha.warpmail.net>
References: <AANLkTi=rPAQas3gvHJ+EFYTXP_YXuULQMk8o8pgkj=9T@mail.gmail.com> <7voc4uto9o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?RGFuaWVsIE55c3Ryw7Zt?= <daniel.nystrom@timeterminal.se>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 09:12:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4T6c-0000zA-HJ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 09:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab1C2HMl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 03:12:41 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56028 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753763Ab1C2HMk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 03:12:40 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4B39320A87;
	Tue, 29 Mar 2011 03:12:40 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 29 Mar 2011 03:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=2S0t59OxhUva+VENHZD9l60/F2g=; b=TlLYauCF59oQihIAZaKeozBhKhlgPmNH1YAp7BZ6mhPT/fBs6eS42fyJj3dS2hMglf8tnHrPI5f9eqhicSIXxf+c4xxXhhDTHE9nBp2ZhBMYkaBC7g1lsKCBlJLH8E7ad9UGGS0TmnT4gemt+j+VQZU1h/u1XjIpJGMfqB1F97E=
X-Sasl-enc: 4OiKNwPB/WQ6sXLHnl0putR1jo8i8+dofKuUMJOkT7ps 1301382760
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AA55640E23E;
	Tue, 29 Mar 2011 03:12:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7voc4uto9o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170238>

Junio C Hamano venit, vidit, dixit 29.03.2011 08:49:
> Daniel Nystr=C3=B6m <daniel.nystrom@timeterminal.se> writes:
>=20
>> So this makes me wonder, is there a way to mark certain files for
>> being committed later on? Which does not automatically get added to
>> the staging area (on "git commit -a" or "git add ." and so on) unles=
s
>> it's specifically mentioned by "git add"?
>>
>> We've discussed making it generated automatically, but that's not as
>> easy as it may sound.
>>
>> How would you like a git feature like described above, marking files
>> for later inclusion?
>=20
> That does not sound like a feature but merely a source of confusion.
>=20
> So far, "commit -a", "add", "add ." etc have _all_ been a way to tell=
 git
> to add the current state of the content to the index.  What is the po=
int
> of making it more complex by letting the user say "I am telling you t=
o add
> everything in the working tree by explicitly saying 'git add .', but =
I do
> not really mean it"?
>=20
> In the meantime, some misguided souls might suggest assume-unchanged,=
 but
> that is not guaranteed to work for this purpose, so ignore them.  Thi=
s is
> because assume-unchanged is a promise you make git that you will _not=
_
> change the working tree files, and that promise implies a permission =
for
> git to use blob object recorded in the index that corresponds to such=
 a
> path instead of reading from the working tree files while doing certa=
in
> operations (such as "git diff") if it is more convenient.
>=20

While I've used assume-unchanged before, it really is a great foot-gun
(to shoot yourself into...) to be used only when circumstances force yo=
u.

In your case, if you really can't use shortlog or the like, a "light"
way of generating a changelog might be using notes. Attach changelog
notes to each commit (maybe in refs/notes/changelog rather than the
standard). Then, when you need to create the changelog between vX and
vY, you can do

git log --pretty=3D"%N%n" vX..vY

(and go wild on the pretty format, of course). Note that you can share
notes when you set up refspecs etc in a push/pull based workflow. (I'm
not sure how well we support merging/pulling notes refs yet.) This does
not work well in a patch/e-mail-based workflow.

Michael
