From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: =?iso-8859-1?Q?Re=3A_=5BBUG=5D_git_gui_and_my_=F6?=
Date: Wed, 25 Apr 2007 15:48:47 -0700 (PDT)
Message-ID: <842218.39406.qm@web38910.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Apr 26 00:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgqOa-0005xp-Sm
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 00:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993116AbXDYWz3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 25 Apr 2007 18:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993123AbXDYWz3
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 18:55:29 -0400
Received: from web38910.mail.mud.yahoo.com ([209.191.125.116]:24278 "HELO
	web38910.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S2993116AbXDYWz2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 18:55:28 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Apr 2007 18:55:28 EDT
Received: (qmail 43286 invoked by uid 60001); 25 Apr 2007 22:48:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=cJNRu1Y1s2xsgvm1A2UAzKmkWiP2GHLzkLtCJBlFheS2b3JlWQEph+/VOYW4n67qW1QnI8aMTTgeWCLE1ycOISwtsZcyLD+VxShZ1bFVmJFzzei9Q9ONbTQ5oOq8PrN9Iu+T1jxhtCLQMAEI9SFmPGXxpc8VHE+sq93Sr7JAxag=;
X-YMail-OSG: 6tSL.d4VM1mbm4_A.v6Fq47ZrrbH8GWXAKJHUL.DftJ4JdPzl3diuUNGMAlS8LgTbViziMkHkH7IxDFcZK2JmQ21ttMnGxAxaKWMhR.InQle2VLRBfeX3Uh.VtaqUw--
Received: from [198.205.32.93] by web38910.mail.mud.yahoo.com via HTTP; Wed, 25 Apr 2007 15:48:47 PDT
X-Mailer: YahooMailRC/478 YahooMailWebService/0.7.41.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45592>

sorry for the bad formatting, stupid web email....

If you specify "-translation binary", it will actually set the -encodin=
g to binary as well. From the man page http://tcl.activestate.com/man/t=
cl8.4/TclCmd/fconfigure.htm#M11

"binary
No end-of-line translations are performed.  This is nearly identical to
lf mode, except that in addition binary mode also sets the
end-of-file character to the empty string (which disables it) and sets =
the
encoding to binary (which disables encoding filtering).  See the
description of -eofchar and -encoding for more information."
Note also that Tcl stores strings internally as UTF-8. You might be wor=
king too hard (I'm not sure, I haven't looked at the code).

HTH,
    --brett


----- Original Message ----
=46rom: Shawn O. Pearce <spearce@spearce.org>
To: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
Cc: Git Mailing List <git@vger.kernel.org>
Sent: Monday, April 23, 2007 11:16:52 PM
Subject: Re: [BUG] git gui and my =F6

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Uwe Kleine-K??nig <ukleinek@informatik.uni-freiburg.de> wrote:
> >     commit-tree failed:
> >     Warning: commit message does not conform to UTF-8.

This was starting to bug me, so I went off and found it.  OK, well
the encoding error anyway.  git-gui incorrectly claimed commit-tree
failed when it didn't.  But besides the point, this is the bad line:

>    1294     fconfigure $msg_wt -encoding $enc -translation binary

I have had trouble in the past with trying to use that magic
-encoding flag on fconfigure to get Tcl's file channels to perform
encoding work for me.  Seems it doesn't work right or something...
so other parts of git-gui (e.g. the filename handling parts)
perform the convertfrom/convertto logic on their own... but the
commit message handling parts didn't.

They do now (git gui 0.6.5-11-gf20db5f).

Can you please test my current master branch and see if that fixes
things for you?  repo.or.cz, git-gui.git...

If it does, I'm probably going to tag that as 0.6.6 and let Junio
cut 1.5.2 with that release.

--=20
Shawn.
-
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
