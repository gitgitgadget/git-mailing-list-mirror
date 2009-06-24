From: Brian Foster <brian.foster@innova-card.com>
Subject: [Q] `git push', branch management, and "(forced update)"?
Date: Wed, 24 Jun 2009 10:34:18 +0200
Message-ID: <200906241034.18550.brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 10:36:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJNxX-00043m-Qc
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 10:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbZFXIfs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jun 2009 04:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbZFXIfs
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 04:35:48 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:46026 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbZFXIfp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2009 04:35:45 -0400
Received: by bwz9 with SMTP id 9so567934bwz.37
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dIPJtL58Hm7bni8bgZuMChCJjHqxJtr/2f1+Pox+z4Q=;
        b=GjohrVxqbFzZt1w3O6r2G9DXU5qcWENsYSW7g66Vv6oBU6K+C68tlexL1z4aGIGV7g
         SoyYeYKDbJXtJyyNusO8nQWlJq5lgNZcuJYWvted2ZrraxjOuiQpm/NDNuVBOsiQ1RQk
         taCjOO0EymXQMdyvIRQ6xPQLTmvc8C/lgaxAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=K6oBjv9E90zJeL8ULkS6F8B7CAyMdSJCIDXckGFkAQW12g64JM1ssBnMOXBEDO9wMd
         a8h9xwJy41qIjvgO9TdNwUDNj03OCtRg0oqrobcINr9ZaIaHuvEDq+rDlwRiKhKDNM2K
         Dw37X8NPvO2VNoONMP5PjmO9E0NQryzs0kiho=
Received: by 10.204.117.141 with SMTP id r13mr1012887bkq.207.1245832547232;
        Wed, 24 Jun 2009 01:35:47 -0700 (PDT)
Received: from innova-card.com (LRouen-152-82-23-47.w80-13.abo.wanadoo.fr [80.13.118.47])
        by mx.google.com with ESMTPS id 1sm259970bwz.8.2009.06.24.01.35.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 01:35:45 -0700 (PDT)
User-Agent: KMail/1.10.4 (Linux/2.6.27-14-generic; KDE/4.1.4; x86_64; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122131>

Hello,

   A colleague of mine will be asking for my help when he
  returns later this week, and I'm not too certain what's
  going on.  My instant reaction is what he's doing may not
  be a good idea (an example of rebasing a branch that others
  pull, which I understand should be avoided).  However, I'm
  not a gitpert, and am also sufficiently confused it's worth
  asking for help/advice.  My apologies for the length....

   What we have is four (4) repositories, L, B, R, and M:

     L is my colleague's (local) working repository.
     B is a bare repository.
     R is one (or more?) remote repositories.
     M is a bare repository.

  The model is work is done in R, patches are sent (by e-mail)
  to my colleague, who applies them to L, often does some fixes
  (in L), pushes the resultant applied-patch-plus-fixes to B;
  and R pulls every now and then from B.  The cycle repeats.
  (M, as such, does not enter the picture at this point.)

   More specifically, what my colleague does (I think, I may
  not have this completely correct) is apply the patches to
  a topic branch TOPIC.  His fixes are separate commits, also
  on TOPIC, so (in theory) TOPIC grows in a nice linear manner
  (`r' came from R via e-mail, `f' is a local fix):

     o--o--o--o master
               \
                r--r--f--f TOPIC

   L is a clone of M, where other work has also been committed,
   in master.  So now-and-then my colleague pulls M into L:

     o--o--o--o--*--* master
               \
                r--r--f--f TOPIC

  My colleague then pushes the result to B.  End result is B
  is essentially M plus TOPIC.

   As it happens (mostly by design), the changes on TOPIC
  are independent of the `*' ones on master.  So, working
  in L, my colleague often rebases, and this is (always?)
  a fast-forward:

     o--o--o--o--*--* master
                     \
                      r--r--f--f TOPIC

  He now wants to push that structure to B, so that R can
  later pull the updated world.  Based on some experiments,
  he does (in L):

     $ git checkout master
     $ git push --tags ssh://.../B.git  +:

  (I'm not sure why he is using `--tags', or `+:' instead
  of a simple `:') but reports what happens is the `push'
  gets the error(?):

     fatal: remote part of refspec is not a valid name in +:

   Given that `git help push' (1.6.2.2) lists/describes the
  `+:' <refspec>, I'm (extra) baffled.  What's going on?

   Each of the repositories L, B, R, and M are on different
  machines, and it is highly probable different versions of
  git are being used.

   In a simple simulation test I tried, it not only worked
  for me, but the subsequent pull from simulated-B into
  simulated-R said the TOPIC was a "(forced update)".
  What does that mean?

   And what is it my colleague should consider doing (or,
  reading?)?

  Again, apologies for the length!

cheers,
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
