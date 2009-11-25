From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: OS X and umlauts in file names
Date: Wed, 25 Nov 2009 09:50:18 +0100
Message-ID: <4B0CEFCA.5020605@syntevo.com>
References: <4B0ABA42.1060103@syntevo.com> <alpine.LNX.2.00.0911231403100.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Nov 25 09:49:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDDZT-0008UJ-Vn
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 09:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933875AbZKYIto convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 03:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933834AbZKYItn
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 03:49:43 -0500
Received: from syntevo.com ([85.214.39.145]:40391 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933784AbZKYItn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 03:49:43 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 30CE537C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.LNX.2.00.0911231403100.14365@iabervon.org>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133619>

I've did following:

 toms-mac-mini:git-umlauts tom$ ls
 =DCberl=E4nge.txt
 toms-mac-mini:git-umlauts tom$ git status
 # On branch master
 #
 # Initial commit
 #
 # Changes to be committed:
 #   (use "git rm --cached <file>..." to unstage)
 #
  #	new file:   "U\314\210berla\314\210nge.txt"
 #
 toms-mac-mini:git-umlauts tom$ git stage "U\314\210berla\314\210nge.tx=
t"
 fatal: pathspec 'U\314\210berla\314\210nge.txt' did not match any file=
s

Note, that I copy-pasted the file name which 'git status' showed to the
stage command. IMHO, this should work, especially, because different pe=
ople
said Git would treat the file name as byte-array without interpreting i=
t in
some kind.

=46rom the user with the German OS X (for which the staging is said to =
work),
I've got the output of 'env' and hence also tried

 export LANG=3Dde_DE.UTF-8

before doing the above steps, but with the same results. :(

--=20
Tom


Daniel Barkalow wrote:
> On Mon, 23 Nov 2009, Thomas Singer wrote:
>=20
>> I'm on an English OS X 10.6.2 and I created a sample file with umlau=
ts in
>> its name (=DCberl=E4nge.txt). When I try to stage the file in the te=
rminal, I
>> can't complete the file name by typing the =DC and hitting the tab k=
ey, but I
>> can complete it by typing an U and hitting the tab key.
>=20
> You've already got a bug before involving git at all. You create a=20
> file "=DCberl=E4nge.txt", but OS X writes "U:berla:nge.txt" (typing t=
he=20
> combining character umlaut as : so that you can see the difference), =
and=20
> the directory listing doesn't contain any files that start with =DC, =
so the=20
> terminal already can't find the file you created. Obviously, git is g=
oing=20
> to have all the problems that the OS-provided readline library has, a=
nd=20
> you're not going to be able to get predictable results in any case wh=
ere=20
> user-supplied filenames are compared with directory listings.
>=20
> Part of the problem is that OS X does a canonicalization that is not =
what=20
> anybody else does, so you hit the problem every single time, but the=20
> fundamental issue is that there isn't any way to tell, when you creat=
e a=20
> file, what name that file will be listed under.
>=20
> Note that this isn't a matter of characters to byte sequences. OS X=20
> actually uses different characters for the filename in its listings t=
han=20
> you've used.
>=20
> If there's a difference between German and English versions, I suspec=
t=20
> that it's actually that you're not using a German keyboard with a key=
=20
> that, under OS X, produces the two-character sequence U:, but using s=
ome=20
> method that produces the single character =DC. I'd guess that your Sm=
artGit=20
> problem is that Java is converting the U: that the user typed into =DC=
, and=20
> passing it to the OS, which turns it back into U: and then doesn't li=
st=20
> the file that Java thinks the user asked for.
>=20
> 	-Daniel
> *This .sig left intentionally blank*
