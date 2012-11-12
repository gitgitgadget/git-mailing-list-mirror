From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git merge commits are non-deterministic? what changed?
Date: Mon, 12 Nov 2012 12:27:31 +0100
Message-ID: <50A0DD23.4040800@drmicha.warpmail.net>
References: <20121109133132.GK69724@acme.spoerlein.net> <m2y5iarf5s.fsf@igel.home> <20121109154245.GP69724@acme.spoerlein.net> <vpq390idb8v.fsf@grenoble-inp.fr> <20121109161647.GB19725@sigill.intra.peff.net> <20121109182753.GQ69724@acme.spoerlein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: =?UTF-8?B?VWxyaWNoIFNww7ZybGVpbg==?= <uqs@spoerlein.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 12:27:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXsBA-0006ah-Nv
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 12:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab2KLL1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2012 06:27:34 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48380 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752467Ab2KLL1d (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2012 06:27:33 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5CA9320A35;
	Mon, 12 Nov 2012 06:27:33 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 12 Nov 2012 06:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=doflAe/FZhMFuJKcf9Iq1y
	OAWSs=; b=eSj7suQL+BfgpU3hHQ4wBDFDAOlfGILwIaMOk15Oj9K+LC6L1Q75vA
	7Db4LWp2oVeu/EFDjrOlO3ZC6gQwZGY/hi89A4bDss1124tshAjIMhs3gxorl1pA
	OOPJn2SaJ8qb9/stAKc2j6rF5A01R50vroYCWfA6G7qoQMYaQiTuI=
X-Sasl-enc: SpDo+k288BEkHEoZ/K4P83KbMEgdQJrNYPy/fmOe52iJ 1352719653
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8B00E482786;
	Mon, 12 Nov 2012 06:27:32 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <20121109182753.GQ69724@acme.spoerlein.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209475>

Ulrich Sp=C3=B6rlein venit, vidit, dixit 09.11.2012 19:27:
> On Fri, 2012-11-09 at 11:16:47 -0500, Jeff King wrote:
>> On Fri, Nov 09, 2012 at 04:52:48PM +0100, Matthieu Moy wrote:
>>
>>> Ulrich Sp=C3=B6rlein <uqs@spoerlein.net> writes:
>>>
>>>>>> 2. Why the hell is the commit hash dependent on the ordering of =
the
>>>>>> parent commits? IMHO it should sort the set of parents before
>>>>>> calculating the hash ...
>>>>>
>>>>> What would be the sort key?
>>>>
>>>> Trivially, the hash of the parents itself. So you'd always get
>>>>
>>>> ...
>>>> parent 0000
>>>> parent 1111
>>>> parent aaaa
>>>> parent ffff
>>>
>>> That would change the behavior of --first-parent. Or you'd need to
>>> compute the sha1 of the sorted list, but keep the unsorted one in t=
he
>>> commit. Possible, but weird ;-).
>>
>> Right. The reason that merge parents are stored in the order given o=
n
>> the command line is not random or because it was not considered. It
>> encodes a valuable piece of information: did the user merge "foo" in=
to
>> "bar", or did they merge "bar" into "foo"?
>>
>> So I think this discussion is going in the wrong direction; git shou=
ld
>> never sort the parents, because the order is meaningful. The origina=
l
>> complaint was that a run of svn2git produced different results on tw=
o
>> different git versions. The important question to me is: did svn2git
>> feed the parents to git in the same order?
>>
>> If it did, and git produced different results, then that is a seriou=
s
>> bug.
>>
>> If it did not, then the issue needs to be resolved in svn2git (which
>> _may_ want to sort the parents that it feeds to git, but it would de=
pend
>> on whether the order it is currently presenting is meaningful).
>=20
> Yeah, thanks, looks like I have some more work to do. I don't quite g=
et
> how it could come up with a different order, seeing that it is using =
svn
> as the base.
>=20
> Will run some more experiments, thanks for the info so far.

There was a change in the order in which "git cherry-pick A B C" applie=
s
the commits. It's the only odering affecting change in 1.8.0 that I can
think of right now.

Michael
