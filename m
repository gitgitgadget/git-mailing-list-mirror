From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] gitweb: git_patchset_body fixes
Date: Mon, 8 Jan 2007 10:03:54 +0100
Message-ID: <200701081003.54991.jnareb@gmail.com>
References: <257061.93025.qm@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 10:04:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3qQB-0006JP-3K
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 10:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbXAHJDy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 8 Jan 2007 04:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbXAHJDx
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 04:03:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:54079 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932639AbXAHJDw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 04:03:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so6173423uga
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 01:03:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tVOb8UOZxSeN9xCsdfnUnk5fI51ceyPyAbq5radglAfN61BBdrcu1A1bAOE4+6G80zgY4hID+On/XL5wJcealX60Th8qmZHCR5ymeYtyZrikCfFfDRO5nRhgZstLPodos40DQ+kLakX6vHTwBB2u6M+gBL327T4bbEwJPzClyB8=
Received: by 10.67.22.2 with SMTP id z2mr33017351ugi.1168247031112;
        Mon, 08 Jan 2007 01:03:51 -0800 (PST)
Received: from host-81-190-18-145.torun.mm.pl ( [81.190.18.145])
        by mx.google.com with ESMTP id l33sm32684432ugc.2007.01.08.01.03.50;
        Mon, 08 Jan 2007 01:03:50 -0800 (PST)
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <257061.93025.qm@web31801.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36243>

Dnia poniedzia=B3ek 8. stycznia 2007 04:50, Luben Tuikov napisa=B3:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
>> Luben Tuikov wrote:

>>> "And while at it" can you please actually *do* "refactor"
>>> git_patchset_body *into smaller functions each one doing
>>> a single particular task*.
>>>=20
>>> It is sad to see git_patchset_body in such despicable state
>>> all the while seeing words like "refactor" in the commit logs
>>> of that function.
>>=20
>> (Perhaps I overuse word "refactor").
>=20
> Perhaps.  Or maybe it is used incorrectly.

That is also possible.

That said git_patchset_body was rewritten from AWK-like event-driven
single loop, with lots of state variables, to few loops following
the structure of patchset, and of git diff.

>>> git_patchset_body is grossly overloaded for what it is
>>> supposed to do to, and being one single huge blob, it is
>>> hard to maintain.
>>=20
>> I'm not sure if splitting git_patchset_body into smaller functions
>> would be worth doing, as 1) such functions would be used only
>> by git_patchset_body, 2) quite a bit of info has to be passed.
>=20
> When things get too complex, they should be done out of
> principle, not out of "how I feel about it", since principles
> can be proved and what they define can be easily tracked.
>=20
> Yes, it is worth doing.  It doesn't matter that those smaller
> functions would be used only by git_patchset_body, when
> (by principle) the workings, logic and justification would
> be clearly exposed by those smaller units of function.  Thus
> it would be possible to prove that the function is correct
> or not, and bugs would be able to be isolated easily.
>=20
> Smaller units of function should do one thing and do it well.
> If you cannot isolate them "because quite a bit of info has
> to be passed" then the logic of git_patchset_body is faulty,
> by _definition_, and needs to be scrapped and re-engineered
> (from scratch).

On first glance it would be easy to separate (refactor) individual
patch parsing and output into separate subroutine; perhaps also
separate parsing and output of diff header.

The problems with this approach are two: empty patches (e.g. pure
rename patch) and split patches (e.g. file to symlink patch).
And we are dealing with two sources of information: "raw" difftree
part, and the patch(set) part.

So it is not that easy. But I can certainly try...

--=20
Jakub Narebski
Poland
