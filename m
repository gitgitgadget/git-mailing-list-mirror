From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: jgit and ignore
Date: Wed, 04 Mar 2009 18:50:42 +0100
Message-ID: <49AEBF72.3030901@pelagic.nl>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com> <49AAA2B3.40808@gmail.com> <20090301171648.GB14365@spearce.org> <200903012124.46600.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?ISO-8859-1?Q?Tor_Arne_?= =?ISO-8859-1?Q?Vestb=F8?= 
	<torarnv@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 18:53:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LevGT-00022d-N0
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 18:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbZCDRur convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 12:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755959AbZCDRur
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 12:50:47 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:43453 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755936AbZCDRuq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 12:50:46 -0500
Received: from [192.168.0.50] (Paul.internal.Hupie.com [192.168.0.50])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id B10D758BDBA;
	Wed,  4 Mar 2009 18:50:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <200903012124.46600.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112231>

Robin Rosenberg wrote:
> Shawn writes:
>> Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
>>> To me that means that EGit should focus just as much on integrating=
 with
>>> Eclipse properly as it does on keeping command line porcelain
>>> interoperability.
>> Yup, I agree completely.  I think Robin would too.
> 100% (or close).
>=20

Hey guys

I'm currently refactoring the code to accomodate all of your wishes and=
=20
I've already come a long way.

=3D=3D> The one thing that I still need to do is get to the global=20
core.excludefile setting. How can I do that?


How will it work? Read on... :-)

Suppose we have FILE in DIRECTORY and we want to see whether FILE is=20
ignored. (FILE can ofcourse also be a DIR)

The way in which ignores will be evaluated is:
1- See if there is a .gitignore file in DIRECTORY. if so, try to match.=
=20
when a match is found: FILE is ignored. if there is no .gitignore file =
or=20
when no match is found: go one directory up (towards the checkout=20
root/workdir) and repeat until a match is found or until the .gitignore=
 in=20
the checkout root/workdir has been evaluated.
2- use the patterns from .git/info/exclude (if exists) and try to match=
=2E=20
when a match is found: FILE is ignored.
3- use the patterns from .git/config:core.excludesfile (when set) and t=
ry=20
to match. when a match is found: FILE is ignored.
4- when .git/config:core.excludesfile was not set, use the patterns fro=
m
global:core.excludesfile (when set) and try to match. when a match is=20
found: FILE is ignored.
5- try to match against the Eclipse global Team ignores. when a match i=
s=20
found: FILE is ignored.
6- FILE is not ignored


hope this flow is what you want :-)

=46erry
