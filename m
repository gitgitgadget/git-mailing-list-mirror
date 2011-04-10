From: <HH-developing@heigl-online.at>
Subject: Weird behaviour when importing from a subversion repository (empty dir/ambiguous argument)
Date: Sun, 10 Apr 2011 12:28:19 +0200
Message-ID: <003701cbf76a$0329dba0$097d92e0$@heigl-online.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 12:28:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8rsk-0006oB-CX
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 12:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab1DJK2W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 06:28:22 -0400
Received: from xserv02.internex.at ([85.124.51.102]:58366 "HELO
	xserv2.internex.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755826Ab1DJK2W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 06:28:22 -0400
X-PDA-ORIGIN: xserv2.internex.at
Received: (qmail 23857 invoked from network); 10 Apr 2011 10:28:20 -0000
Received: by simscan 1.4.0 ppid: 23843, pid: 23854, t: 0.1015s
         scanners: clamav: 0.97/m:53/d:12965
Received: from unknown (HELO setnbheh) (Harald@heigl-online.at@84.115.25.240)
  by xserv02.internex.at with SMTP; 10 Apr 2011 10:28:20 -0000
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Acv3aef+6zzdY9OUSb+maIVSzV009g==
Content-Language: de-at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171248>

Hi everybody!
I=E2=80=99m a software developer in lower Austria and started introduci=
ng subversion in my company some time ago. It was mainly for myself to =
have a history. Now when I looked for myself I came to git.=20
When I=E2=80=99m more comfortable with it we=E2=80=99ll switch at compa=
ny too.

So I=E2=80=99ve tried to clone our main project and I got an error. I h=
ave to say I cloned some other even bigger subversion projects and it w=
orked, so something must be special here.
I hope you read this long mail, I tried to separate it in sections and =
tried to shorten the output a little bit.


My command:
git svn clone "[subversionrepo]"  [gitclonedir] -T trunk -b branches -t=
 tags --username [subversionuser]



The error:
fatal: ambiguous argument 'a41f9bd5959dde85035bd047bf730cc62eaee12a^..1=
cb281cf44644da76ed94764f7770bb9e11d7424': unknown revision or path not =
in the working tree.
Use '--' to separate paths from revisions
rev-list a41f9bd5959dde85035bd047bf730cc62eaee12a^..1cb281cf44644da76ed=
94764f7770bb9e11d7424: command returned error: 128
if I do the same with --no-follow-parent, it works, but I assume then I=
=E2=80=99m losing the branch/tag connection to the trunk. If I=E2=80=99=
m losing the branches I can live with it (I think I did more branching =
in the last days with git, then with subversion the last year =E2=98=BA=
 ), but I=E2=80=99m interested and if there is a possibility I=E2=80=99=
ll prefer to import the subversion project completely.



I did some further investigation:
=E2=80=9Egit log a41f9bd5959dde85035bd047bf730cc62eaee12a=E2=80=9C work=
s giving me:
    git-svn-id: [subversionrepo]/branches/Pluginstruktur-HEH@158 ebb3a9=
44-7b90-0446-bc25-369ed2d31b3f
git log a41f9bd5959dde85035bd047bf730cc62eaee12a^ (this should be the p=
arent, right?) says =E2=80=9Eunknown revision or path not in the workin=
g tree.=E2=80=9C



I think it=E2=80=99s a failure I did in subversion some months ago:
Rev 158: Created an empty folder 'Pluginstruktur-HEH'.
Rev 159: Deleted folder =E2=80=9A Pluginstruktur-HEH=E2=80=98 (don=E2=80=
=99t ask why)
Rev 160: branched from trunk to branches/Pluginstruktur-HEH

So in Rev 158 there was an empty folder in branches, in Rev 159 no fold=
er and in Rev160 a non empty folder out oft he trunk.
Perhaps this ist the problem, because between Rev 158 and Rev159 there =
was a single empty folder an das I found out git doesn=E2=80=99t track =
empty folders. Perhaps that=E2=80=99s why Rev158 (git: a41f9bd5959dde85=
035bd047bf730cc62eaee12a) doesn=E2=80=99t have a parent here.



Maybe you can shed some led in this and how I may solve this.  Can I ju=
st leave out revision 158 and 159 when doing git svn clone, because it =
was nothing more than creating an empty folder and deleting an empty fo=
lder? I=E2=80=99ve read somewhere on the net you can also use a svndump=
 as base for a git import, perhaps I then may leave rev 158/159 out in =
the dumb, but I don=E2=80=99t know how to use exactly an svndump as a g=
it import and also if this wuld be a solution for me.

Thanks in advance, kind regards,
Harald
