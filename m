From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: Re: Test 17 of `t9119-git-svn-info.sh' fails with svn 1.6.9
Date: Thu, 01 Jul 2010 12:19:38 +0200
Message-ID: <87pqz7ec79.fsf@ft.bewatermyfriend.org>
References: <8739w3fupp.fsf@ft.bewatermyfriend.org>
	<4C2C5D2F.90000@drmicha.warpmail.net>
	<87y6dveekn.fsf@ft.bewatermyfriend.org>
	<4C2C647F.7090909@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Eric Wong <normalperson@yhbt.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 01 12:20:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUGsu-0001zY-04
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 12:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039Ab0GAKUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 06:20:38 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:51530 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914Ab0GAKUh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 06:20:37 -0400
Received: from [212.117.84.72] (helo=bones.voodoo.lan)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1OUGsl-0004mh-Ef; Thu, 01 Jul 2010 12:20:35 +0200
Received: by bones.voodoo.lan (Postfix, from userid 1000)
	id A457C17EED; Thu,  1 Jul 2010 12:19:38 +0200 (CEST)
In-Reply-To: <4C2C647F.7090909@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 01 Jul 2010 11:48:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150026>

Michael J Gruber wrote:
[...]
>> And a unified diff of the two:
>> [snip]
>> --- trash directory.t9119-git-svn-info/actual.info-added-directory 2=
010-07-01 11:22:16.000000000 +0200
>> +++ trash directory.t9119-git-svn-info/expected.info-added-directory=
 2010-07-01 11:22:16.000000000 +0200
>> @@ -1,6 +1,7 @@
>>  Path: added-directory
>>  URL: file:///usr/src/sys/git/t/trash%20directory.t9119-git-svn-info=
/svnrepo/added-directory
>>  Repository Root: file:///usr/src/sys/git/t/trash%20directory.t9119-=
git-svn-info/svnrepo
>> +Repository UUID: 638d0b70-c7df-46bd-9c56-aff8052b4ab8
>
> "Nachtigall, ick h=C3=B6r Dir trapsen." [I really don't know how to t=
ranslate
> this...]

No need. :)

> Anyway, this is something I had fixed previously before realizing it
> doesn't need a fix and something else is wrong:
>
> It indicates that Git's svn-bindings (git-svn) use a different svn
> version than the actual "svn". (There used to be a bug where Git was
> wrong about the version of the bindings but that is fixed.)
>
> Do the following agree for you:
>
> git svn --version
> svn --version
>
> Do you have any private copies of svn/svn bindings in your path or pe=
rl
> path?

Okay, it wasn't really a private copy, but you're otherwise
spot-on. Here's what was wrong:

I didn't realise, `git-svn' was using Perl's subversion bindings. This
happens on my laptop which runs debian stable (lenny). I was upgrading
my subversion package to the one provided by backports.org (a service
that provides backports of newer versions of certain software packages
to debian stable). While that worked nicely, the subversion bindings fo=
r
Perl are provided by a package called `libsvn-perl' which was kept at
the version in stable, which is 1.5.1. Backports.org also provides an
upgrade for that package. Now both "svn --version" and "git svn
--version" report the same subversion version and the test passes again=
=2E


Maybe it would be good if git-svn or maybe just the test suite checked
whether subversion's and the Perl binding's version matched?

Regards, Frank

--=20
In protocol design, perfection has been reached not when there is
nothing left to add, but when there is nothing left to take away.
                                                  -- RFC 1925
