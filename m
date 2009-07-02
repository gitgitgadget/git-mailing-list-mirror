From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH] git-cvsexportcommit can't commit files which have been 
	removed from CVS
Date: Thu, 2 Jul 2009 14:50:38 +0100
Message-ID: <e2b179460907020650u672d8724p45f67173668332aa@mail.gmail.com>
References: <4A1F1CF5.8030002@yahoo.co.uk>
	 <e2b179460906100106x2b9c0bb4r931b0a12959d4314@mail.gmail.com>
	 <4A311053.5060802@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nick Woolley <nickwoolley@yahoo.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 15:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMMhG-0005Ds-9p
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 15:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbZGBNum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 09:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756113AbZGBNul
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 09:50:41 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62105 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbZGBNuh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 09:50:37 -0400
Received: by fxm18 with SMTP id 18so1503792fxm.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MzbMQTXyvxB/eJEDfwhuGoC7ttnU6q5J7Yv44rig5QM=;
        b=ZJyc90RPoF2yDYo7y8WN2vrhxgjWiPCGUoyLwVlIQxLxWkTdSPEowS6cLx0wy0aQ5u
         0dYvAURP4I+B2RekZ4ksT7xrEVKsRDPyLUY8V3o/mF5iXiADPamGg1LaJWE61r8gQ3CR
         Ct2dQA/+dH/zDp3KXelfZ23Qj3Em7r1NKkg8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mplxSbK8wsCWAIMk8+poM7F5Jwq9Fo9+Gh/L2a6KgTktQbP8XbXGFlZES1h9wLCjTP
         WN392knVgc928UAGp9RkhMZw+iVSK3qlByE+ABJcpHjCkFQuwO0YtEnOiXs9i1bcEtxc
         I0Kdne1RDFjX/o4JQ063km0f/8Rpds+upSf7E=
Received: by 10.223.126.69 with SMTP id b5mr43842fas.107.1246542638961; Thu, 
	02 Jul 2009 06:50:38 -0700 (PDT)
In-Reply-To: <4A311053.5060802@yahoo.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122645>

2009/6/11 Nick Woolley <nickwoolley@yahoo.co.uk>
>
> Mike Ralphson wrote:
> > Hi Nick, I'm seeing intermittent failures since your new test was
> > added to 'next' on AIX 5.3
> >
> > cvs commit: Up-to-date check failed for ` space'
> > cvs [commit aborted]: correct above errors first!
> > * FAIL 15: re-commit a removed filename which remains in CVS attic
> > * failed 1 among 15 test(s)
> >
> > Let me know if there's anything I can do to help debug it.
> >
>
> I don't know why the =C2=A0" space" file seems to be causing a proble=
m - it shouldn't
> interfere with the test I added (and indeed doesn't for me).
>
> Perhaps you could apply the following patch to t/t9200-git-cvsexportc=
ommit.sh,
> run it, and send the contents of t/debug.out? =C2=A0What I get is app=
ended after the
> patch.

On a failed run, the error is on the commit adding attic_gremlin:

    echo > attic_gremlin &&
    git add attic_gremlin &&
    git commit -m "Added attic_gremlin" &&
        git cvsexportcommit -w "$CVSWORK" -c HEAD &&
    (cd "$CVSWORK"; cvs -Q update -d) &&
    test -f "$CVSWORK/attic_gremlin"

cvs commit: Up-to-date check failed for ` space'
cvs [commit aborted]: correct above errors first!
* FAIL 15: re-commit a removed filename which remains in CVS attic

debug.out contains the following:

# before adding file
cvs status: nothing known about attic_gremlin
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=46ile: no file attic_gremlin             Status: Unknown

   Working revision:    No entry for attic_gremlin
   Repository revision: No revision control file

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=46ile:  space            Status: Needs Patch

   Working revision:    1.1     Thu Jul  2 12:50:17 2009
   Repository revision: 1.2     /usr/local/src/gitbuild/t/trash
directory.t9200-git-cvsexportcommit/cvsroot/ space,v
   Sticky Tag:          (none)
   Sticky Date:         (none)
   Sticky Options:      (none)

=3D=3D=3D

the " space" file in cvswork is:

-rw-rw----    1 mike     staff           6 2009-07-02
13:50:17.000000000 +0100  space

CVS/Entries for the file has
/ space/1.1/Thu Jul  2 12:50:17 2009//

> You might also try commenting out the following part of my test, so t=
hat it
> should trivially work, and see if there's still an error:
>
> # =C2=A0 =C2=A0 =C2=A0rm attic_gremlin &&
> # =C2=A0 =C2=A0 =C2=A0cvs -Q rm attic_gremlin &&
> # =C2=A0 =C2=A0 =C2=A0cvs -Q ci -m "removed attic_gremlin"

It all goes a bit fun if I do that...

RCS file: /usr/local/src/gitbuild/t/trash
directory.t9200-git-cvsexportcommit/cvsroot/attic_gremlin,v
done
Checking in attic_gremlin;
/usr/local/src/gitbuild/t/trash
directory.t9200-git-cvsexportcommit/cvsroot/attic_gremlin,v  <--
attic_gremlin
initial revision: 1.1
done
[master 20999b1] Added attic_gremlin
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 attic_gremlin
\1 better written as $1 at
/usr/local/src/gitbuild/t/../git-cvsexportcommit line 303.
Checking if patch will apply
Huh? Status 'Up-to-date' reported for unexpected file 'attic_gremlin'
Use of uninitialized value in hash element at
/usr/local/src/gitbuild/t/../git-cvsexportcommit line 263.
Use of uninitialized value in hash element at
/usr/local/src/gitbuild/t/../git-cvsexportcommit line 263.
Applying
error: attic_gremlin: already exists in working directory
cannot patch at /usr/local/src/gitbuild/t/../git-cvsexportcommit line 3=
23.
* FAIL 15: re-commit a removed filename which remains in CVS attic

2009/6/12 Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
> CVS har a timestamp in CVS/Entries that has whole second resolution. =
In
> addition it's built-in method for trying to work around the problem b=
y sleeping
> until the next second wraps around is flaky.  cvsexportcommit already=
 has
> one sleep for this. Maybe it's not enough.

=46rom the comment in cvsexportcommit:
# CVS version 1.11.x and 1.12.x sleeps the wrong way to ensure the time=
stamp
# used by CVS and the one set by subsequence file modifications are dif=
ferent.
# If they are not different CVS will not detect changes.
sleep(1);

I tried changing this to 2 seconds, but I still got a failure on the
7th run. Life's too short to try changing it to 3 seconds in case I'm
being bitten by this from the perldoc:

"On some older systems, it may sleep up to a full second less than
what you requested, depending on how it counts seconds. Most modern
systems always sleep the full amount."

And that's not taking into account sleeps being interrupted due to sign=
als.

Would it be acceptable to simply reorder the tests so this previously
unreported error goes away again?

Mike
