From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git log -Sfoo ignores indentation (whitespace?) changes...
Date: Tue, 03 Mar 2009 17:02:06 +0100
Message-ID: <49AD547E.7030703@drmicha.warpmail.net>
References: <49AD3E78.1050706@sneakemail.com> <20090303152333.GB24593@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?IlBldGVyIFZhbGRlbWFyIE3DuHJjaCAoTGlzdHMpIg==?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:03:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeX5u-0003KA-8u
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbZCCQCR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 11:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbZCCQCR
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:02:17 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39385 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751584AbZCCQCQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 11:02:16 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 94B962D368E;
	Tue,  3 Mar 2009 11:02:14 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 03 Mar 2009 11:02:14 -0500
X-Sasl-enc: oAcu+K3D0Bn+JOzw1rHCJc6RXBDXbfuwaqnL7AH0NE/d 1236096134
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DC50A27F33;
	Tue,  3 Mar 2009 11:02:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090303 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090303152333.GB24593@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112097>

Jeff King venit, vidit, dixit 03.03.2009 16:23:
> On Tue, Mar 03, 2009 at 03:28:08PM +0100, "Peter Valdemar M=C3=B8rch =
(Lists)" wrote:
>=20
>> Commits where only the indentation of 'foo' is changed are not shown=
 with=20
>> "git log -Sfoo". Is there any way to force showing them along with o=
ther=20
>> changes involving foo? (E.g. for python, indentation matters!)
>>
>> Why doesn't the second commit show up in the following?
>=20
> Because you misunderstand how "-S" works (but don't worry, it's not y=
our
> fault -- the documentation is somewhat misleading). The documentation=
 says:
>=20
>   -S<string>
>     Look for differences that contain the change in <string>.
>=20
> but what it actually does is find changes where the string was introd=
uced
> or removed. So it literally counts the number of occurences before an=
d
> after the commit, and the commit is interesting if they are not equal=
=2E

Hmm. The diffcore doc sounds more like if the filepair is picked if
#before > 0 and #after =3D 0, but not if #after > 0.

In any case, the pickaxe can't detect moving around of strings, right?

>> # Create text containing 'line' without whitespace
>> $ echo 'line' > text
>> $ git add text
>> $ git commit -m "first" text
>>
>> # Here, I add one space of indentation in front of 'line'
>> $ echo ' line' > text
>> $ git commit -m "second" text
>=20
> So "line" wasn't actually changed. It just happens to be on a line wh=
ich
> _did_ change.
>=20
>> I would like to see both "first" and "second" somehow - can I do tha=
t?
>=20
> I don't think there's an easy way to do this right now; you would nee=
d
> to do "git log -p" and search through the output to get what you want=
 (I
> often do this just using the pager's search function).

If you know what your are looking for you can do variations on

git log -S'line| line' --pickaxe-regex

which seems to be different from

git log -S'line' -S' line'

which was my first attempt...

Michael
