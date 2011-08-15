From: Alexander Pepper <pepper@inf.fu-berlin.de>
Subject: Re: Bug report: git log --[num|short]stat sometimes counts lines wrong
Date: Mon, 15 Aug 2011 17:33:05 +0200
Message-ID: <2E664B37-7447-4697-B6DC-3EAAAFDF2724@inf.fu-berlin.de>
References: <45CC44BC-03FF-4C5F-97B7-7ED03CB68BC2@inf.fu-berlin.de> <91324E9A-3134-455D-B7CA-ABBDA88FC7B7@inf.fu-berlin.de> <1313422005.26123.2.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 17:33:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QszA9-0002vQ-42
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 17:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab1HOPdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Aug 2011 11:33:08 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:52668 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753327Ab1HOPdH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 11:33:07 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtp
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1QszA2-0005QW-42>; Mon, 15 Aug 2011 17:33:06 +0200
Received: from 91-66-162-110-dynip.superkabel.de ([91.66.162.110] helo=apepper.infopark)
          by inpost2.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtpsa
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1QszA1-0006st-Vs>; Mon, 15 Aug 2011 17:33:06 +0200
In-Reply-To: <1313422005.26123.2.camel@bee.lab.cmartin.tk>
X-Mailer: Apple Mail (2.1084)
X-Originating-IP: 91.66.162.110
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179374>

Am 15.08.2011 um 17:26 schrieb Carlos Mart=EDn Nieto:
> On Mon, 2011-08-15 at 10:24 +0200, Alexander Pepper wrote:
>> Am 12.08.2011 um 17:21 schrieb Alexander Pepper:
>>> Hi there.
>>> This is my first contribution to git (if you count a bug report as =
a contribution) and I'm not really familiar where to report bugs. In th=
e irc channel #git at freenode somebody pointed me to this mailing list=
=2E
>>>=20
>>> First of: I'm running git version 1.7.6 on OS X 10.6.8.
>>>=20
>>> Let me describe what I observed.
>>> repository: https://github.com/voldemort/voldemort.git
>>> The command "git log --numstat c21ad764ea1bae7f7bd83b5e2cb015dcbc44=
d586" shows for the commit c21ad764 and file '.../readonly/mr/HadoopSto=
reBuilderReducer.java' 25 lines added and 22 lines removed. But the pat=
ch of HadoopStoreBuilderReducer.java that I get with "git show c21ad764=
ea1bae7f7bd83b5e2cb015dcbc44d586 -- contrib/hadoop-store-builder/src/ja=
va/voldemort/store/readonly/mr/HadoopStoreBuilderReducer.java" adds 30 =
lines and removes 27.
>>>=20
>>> Why does "git log --numstat" drops 5 added lines and 5 removed line=
s? This also holds true for "git log --stat" and "git log --shortstat".
>>>=20
>>> Is this a bug or am I missing an option to git log or git show?
>>>=20
>>> More commits where I observed this problem on the same repository:
>>> 7e00fb6d2cf131dfed59c180f2171952808cc336 src/java/voldemort/client/=
rebalance/MigratePartitions.java
>>> 78ad6f2a6ea327dbae2110f4530a5bd07e5deaac src/java/voldemort/client/=
rebalance/MigratePartitions.java (same commit on another branch)
>>> 7871933f0f0f056e2eeac03a01db1e9cf81f8bda src/java/voldemort/client/=
protocol/admin/AdminClient.java
>>> 2d6f68b09c3bdc23dcf3ae1f91c9285fbd668820 src/java/voldemort/store/r=
eadonly/ExternalSorter.java
>>> 6fcacee866307ec34eb32b268e2c2b885a949319 build.xml
>>>=20
>>> Greetings from Berlin
>>> Alex
>>=20
>> Hello again.
>>=20
>> I also observed this behavior with git version 1.7.4.1 on Gentoo.
>>=20
>> Any ideas how to fix this?
>=20
> I've just checked and `git show --stat` does give different numbers f=
rom
> `git show | diffstat`. Git ignores (or can ignore) empty lines in
> several contexts, have you checked to see if there are 5 empty lines
> added and removed?
>=20
> Cheers,
>   cmn

Hi Charlos.

At least with "git show c21ad764 -- contrib/hadoop-store-builder/src/ja=
va/voldemort/store/readonly/mr/HadoopStoreBuilderReducer.java" there ar=
e 6 removed lines and 5 added empty lines.

If  `git show --stat` ignores empty lines compared to `git show | diffs=
tat`, is there a way or an option to enable, to tell `git show --stat` =
to also count empty lines?

Greetings from Berlin
Alex
