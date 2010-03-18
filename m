From: Michael Witten <mfwitten@gmail.com>
Subject: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 06:23:11 -0700 (PDT)
Message-ID: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 14:29:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsFnD-0003Nz-Ma
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 14:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab0CRN3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 09:29:38 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from qw-out-2122.google.com ([74.125.92.27]:40186 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0CRN3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 09:29:37 -0400
Received: by qw-out-2122.google.com with SMTP id 8so351336qwh.37
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject;
        bh=cveeV227G2jWJTOEGQGtD65iVu1xzjdX+7VTgPCXUCQ=;
        b=MFar5eUS/xm/tlfCToVAYAm4MK6LGTQfp625qR7knOIjR9ATDqcFm1f+Zn5IIwQ3EI
         OB7ZtYIr3jYoCA3mSh8H+HPobMbTodhgv2vG6HShdk7t0IMFFgOb1pyfN9uMskKqTBli
         hNhBJE4YNY2oLj1eG/O9faMWqA3rmYg88/OnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject;
        b=TnOg9yFC9hs/n3PBAZXYbwdgAJ9PGM5esCOhW8vuRSPKur2J7+gxnOTFVTq0aC1eFa
         YxXWZkt4UfswLtpcW/+FluqJl15yN2V5ZLvtAiJEjvzVQ9A5/SN2Xekx8njZZ1FcxNlx
         opjCcNwDiBNWoNeD5ssXbG2YA9RPW1wcU80t0=
Received: by 10.229.242.85 with SMTP id lh21mr1043652qcb.67.1268918592163;
        Thu, 18 Mar 2010 06:23:12 -0700 (PDT)
Received: from gmail.com (tor.clanspum.net [74.208.184.107])
        by mx.google.com with ESMTPS id 5sm4975890qwh.15.2010.03.18.06.22.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Mar 2010 06:23:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142467>

Short Version:
-------------


Rather than use a (name,email) pair to identify people, let's use
a (uuid,name,email) triplet.

The uuid can be any piece of information that a user of git determines
to be reasonably unique across space and time and that is intended to
be used by that user virtually forever (at least within a project's
history).

=46or instance, the uuid could be an OSF DCE 1.1 UUID or the SHA-1 of
some easily remembered, already reasonably unique information.

This could really help keep identifications clean, and it is rather
straightforward and possibly quite efficient.


Long Version:
------------


There are 2 reasons why people contribute (pro bono) to projects:

  (0) To improve the project.
  (1) To garner recognition.

and in my experience, (0) is not as sweet without (1).

One of the great boons of distributed systems like git is that they
separate author (contributor) identities from committer identities,
thereby maintaining (some semblance of) proper attribution in an
official, structured format that is amenable to parsing by tools.

While git's use of (name,email) pairs to identify each person is
extremely practical, it turns out that it's rather `unstable';
consider the following information gleaned from a clone of the
official git repository:

    $ git shortlog -se origin/master | grep Linus
         3  Linus Torvalds <torvalds@evo.osdl.org>
       122  Linus Torvalds <torvalds@g5.osdl.org>
       235  Linus Torvalds <torvalds@linux-foundation.org>
       276  Linus Torvalds <torvalds@osdl.org>
         9  Linus Torvalds <torvalds@ppc970.osdl.org.(none)>
       439  Linus Torvalds <torvalds@ppc970.osdl.org>
         9  Linus Torvalds <torvalds@woody.linux-foundation.org>

    $ git shortlog -se origin/master | grep Junio
      3658  Junio C Hamano <gitster@pobox.com>
         2  Junio C Hamano <junio@hera.kernel.org>
         3  Junio C Hamano <junio@kernel.org>
         3  Junio C Hamano <junio@pobox.com>
         8  Junio C Hamano <junio@twinsun.com>
      4167  Junio C Hamano <junkio@cox.net>
         2  Junio C Hamano <junkio@twinsun.com>
         2  Junio Hamano <gitster@pobox.com>

or using a clone of Linus's Linux repo:

    $ git shortlog -se origin/master | grep Linus
         2  Linus Luessing <linus.luessing@web.de>
         2  Linus L=C3=BCssing <linus.luessing@web.de>
         2  Linus Nilsson <lajnold@acc.umu.se>
         2  Linus Nilsson <lajnold@gmail.com>
        32  Linus Torvalds <torvalds@evo.osdl.org>
      1522  Linus Torvalds <torvalds@g5.osdl.org>
      4174  Linus Torvalds <torvalds@linux-foundation.org>
         7  Linus Torvalds <torvalds@macmini.osdl.org>
         2  Linus Torvalds <torvalds@merom.osdl.org>
         8  Linus Torvalds <torvalds@osdl.org>
         4  Linus Torvalds <torvalds@ppc970.osdl.org.(none)>
       166  Linus Torvalds <torvalds@ppc970.osdl.org>
         1  Linus Torvalds <torvalds@quad.osdl.org>
      1606  Linus Torvalds <torvalds@woody.linux-foundation.org>
       174  Linus Torvalds <torvalds@woody.osdl.org>
         1  Linus Walleij (LD/EAB <linus.walleij@ericsson.com>
         3  Linus Walleij <linus.ml.walleij@gmail.com>
         1  Linus Walleij <linus.walleij@ericsson.com>
        81  Linus Walleij <linus.walleij@stericsson.com>
         9  Linus Walleij <triad@df.lth.se>

    $ git shortlog -se origin/master | grep Morton
       581  Andrew Morton <akpm@linux-foundation.org>
       836  Andrew Morton <akpm@osdl.org>
         1  Andrew Morton <len.brown@intel.com>

=46rom these few examples it seems pretty clear that the most volatile
portion of the (name,email) pair is the email, which is unfortunate
because the email is the most uniquely identifying information. Are
we really reasonably certain that these two are the same person?

    Linus Walleij <linus.ml.walleij@gmail.com>
    Linus Walleij <linus.walleij@ericsson.com>

Thus, I propose a more stable form of identification; rather than
using just a (name,email) pair, let's use a (uuid,name,email) triplet,
where the uuid can be any piece of information that a user of git
determines to be reasonably unique across space and time and that is
intended to be used by that user virtually forever (at least within a
project's history).

=46or instance, Linus is always stuck in his basement with the same
ancient computers, so he chooses to set up his few ~/.gitconfig
files with an OSF DCE 1.1 conforming UUID (generated by, say, uuidgen):

Linus Torvalds <torvalds@linux-foundation.org>

    [user]
        uuid  =3D 6b202ed1-e8ec-4048-84c2-ae0dd3b2df47
        name  =3D Linus Torvalds
        email =3D torvalds@linux-foundation.org

On the other hand, Junio is infatuated with the latest palmtop
computing gadgets and finds himself setting up a ~/.gitconfig file
several times each month; he doesn't want to bother remembering
some long human-hostile string, so he adopts as his uuid the
SHA-1 of some easily remembered piece of information like the
very first (name,email) pair that he used for git
(Junio C Hamano <junkio@cox.net>):

    [user]
        uuid  =3D 6e99d26860f0b87ef4843fa838df2a918b85d1f7
        name  =3D Junio C Hamano
        email =3D gitster@pobox.com

I'm sure that some optimizations could made for certain choices like
UUID and SHA-1 strings.

Anyway, I think this could really help keep identifications clean,
and it is rather straightforward and possibly quite efficient.

Sincerely,
Michael Witten
