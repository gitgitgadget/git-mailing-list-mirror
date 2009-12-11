From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 11:44:25 +0100
Message-ID: <4B222289.6000004@drmicha.warpmail.net>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com> <m38wdae4k4.fsf@localhost.localdomain> <7vzl5q71rp.fsf@alter.siamese.dyndns.org> <200912110233.18756.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 11:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ30V-0005CS-Jo
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 11:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501AbZLKKpl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 05:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757264AbZLKKpk
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 05:45:40 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55112 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756914AbZLKKpk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2009 05:45:40 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 98B20C5C03;
	Fri, 11 Dec 2009 05:45:46 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 11 Dec 2009 05:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=1nP2DZe1yn7CO9iCx/q/D34lb7o=; b=HhnEpvOTGf7VyBEDf8mmc1Zm1YoVUGEs6naFyv47m06D+JDhcFE5oOquoQKx4kLRPY6Kj4L0EKrz+fiJjIGltjUV4a5QAINwvAh6mpuhdSz7dFpNn377WirpAUie4KepxXKVpEwTA2kAu9Hq+4znwGLue7uhv334jiRFp+hZkdA=
X-Sasl-enc: 01rqCDS2yXbOyW24BqJjVT6422ZoTSv17LpqDkPfieAR 1260528346
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AA0024ABB98;
	Fri, 11 Dec 2009 05:45:45 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <200912110233.18756.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135076>

Jakub Narebski venit, vidit, dixit 11.12.2009 02:33:
> Dnia pi=B1tek 11. grudnia 2009 02:11, Junio C Hamano napisa=B3:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>>   --unresolve::
>>>         Restores the 'unmerged' or 'needs updating' state of a
>>>         file during a merge if it was cleared by accident.
>>>
>>> Unless "git add foo" not only adds current contents of foo at stage=
 0,
>>> but also removes higher stages from index...
>>
>> By definition, adding anything at stage #0 is to remove higher stage=
s.
>=20
> Hmmm... let's test it:
>=20
>  $ git merge side-branch=20
>  Auto-merging foo
>  CONFLICT (content): Merge conflict in foo
>  Automatic merge failed; fix conflicts and then commit the result.
>  $ git ls-files --stage
>  100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       foo
>  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
>  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
>  $ <edit foo>
>  $ git add foo
>  $ git ls-files --stage
>  100644 a1b58d38ffa61e8e99b7cb95cdf540aedf2a96b3 0       foo
>=20
> Now let's test '--unresolve' option of git-update-index:
>=20
>  $ git update-index --unresolve foo
>  $ git ls-files --stage foo
>  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
>  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
>=20
> WTF? What happened to stage 1 (ancestor)?

2 and 3 are easy (cheap) to recreate from HEAD and MERGE_HEAD, 1 is not=
=2E
I guess that's why --unresolve doesn't even attempt to do anything with=
 1.

>=20
>  $ git checkout --conflict=3Dmerge foo
>  error: path 'foo' does not have all three versions
>=20
> Let's recover it by hand:
>=20
>  $ echo -e "100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1\tfoo" |=
=20
>    git update-index --index-info
>  $ git ls-files --stage foo
>  100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       foo
>  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
>  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
>  $ git checkout --conflict=3Dmerge foo

Yeah, if we knew that sha1...
