From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Experience with Recovering From User Error (And suggestions for
 improvements)
Date: Wed, 18 Feb 2015 10:46:28 +0100
Message-ID: <54E45F74.6080907@drmicha.warpmail.net>
References: <54E1C96D.2080109@active-4.com> <CACBZZX4NkkMymnG5ZWtO1ya2xzVhxuqh4d3tU2U+mPU49n=m8g@mail.gmail.com> <54E1F0AF.1070403@active-4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Armin Ronacher <armin.ronacher@active-4.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZg==?= =?UTF-8?B?asO2csOwIEJqYXJtYXNvbg==?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 10:46:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO1DL-0000CR-8O
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 10:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbbBRJqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Feb 2015 04:46:33 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42236 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751715AbbBRJqa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2015 04:46:30 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id BA9EE20C9D
	for <git@vger.kernel.org>; Wed, 18 Feb 2015 04:46:29 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 18 Feb 2015 04:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=jgF57ndpE7dwQFKTTe57gV
	W8urw=; b=f1OcnYheqHzfPC+g4g0WvTSDv8kcT1eveGeALhF8MviR8grfvo0Qd5
	FO2RjEyPsea7MjOT4au9RdQnB7gjqvsArdV587f5uOJsW5W1iZuupsYsqKH3I0GM
	4gTjtswa9lEmHQNA+Ex56dRxbfHDMzl2BvcYjvf9l3SfFzcTsAFbw=
X-Sasl-enc: xR08+q67c/qitxO3U1JNAR/VkBhYLY4l2HkuIgvqmsSJ 1424252789
Received: from localhost.localdomain (unknown [88.70.121.210])
	by mail.messagingengine.com (Postfix) with ESMTPA id 10008C002A2;
	Wed, 18 Feb 2015 04:46:28 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54E1F0AF.1070403@active-4.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264012>

Armin Ronacher venit, vidit, dixit 16.02.2015 14:29:
> Hi,
>=20
> On 16/02/15 13:09, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> We should definitely make recovery like this harder, but is there a
>> reason for why you don't use "git reset --keep" instead of --hard?
> This was only the second time in years of git usage that the reset wa=
s=20
> incorrectly done.  I suppose at this point I might try to retrain my=20
> muscle memory to type something else :)
>=20
>> If we created such hooks for "git reset --hard" we'd just need to
>> expose some other thing as that low-level operation (and break scrip=
ts
>> that already rely on it doing the minimal "yes I want to change the
>> tree no matter what" thing), and then we'd just be back to square on=
e
>> in a few years when users started using "git reset --really-hard" (o=
r
>> whatever the flag would be).
> I don't think that's necessary, I don't think it would make the=20
> operation much slower to just make a dangling commit and write out a =
few=20
> blobs.  The garbage collect will soon enough take care of that data=20
> anyways.  But I guess that would need testing on large trees to see h=
ow=20
> bad that goes.
>=20
> I might look into the git undo thing that was mentioned.
>=20
>=20
> Regards,
> Armin
>=20

Are you concerned about the index only, not unstaged worktree changes?

In this case, keeping a reflog for the index may help, and it would
somehow fit into the overall concept.

Otherwise, we would basically need a full stash before a hard reset.
That's not the first time where we could need a distinction between
"command run by user" and "command run by script". For the former, we
could allow overriding default options, re-aliasing internal commands,
adding expensive safety hooks. For the latter we can't.

It's just that we don't have such a concept yet (other than checking tt=
y).

Michael
