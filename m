From: Zenaan Harkness <zen@freedbms.net>
Subject: custom diff - text file diary entries
Date: Thu, 30 Dec 2010 22:33:07 +1100
Message-ID: <AANLkTimPTYEWr0qQwYM4jmJSLcrLRt27GC0nTVgVzHK2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 30 12:33:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYGlM-0002wy-9o
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 12:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab0L3Ldj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 06:33:39 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33427 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab0L3Ldi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 06:33:38 -0500
Received: by bwz15 with SMTP id 15so11639021bwz.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 03:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=pkvjLiuYvBpbVtl2IXpLr8StMEuIG+3Mg00ARSNDVAg=;
        b=GRLWU3kSFXUkabdhc+qS0DNPoAv+NAgr+qh10+c4EeOpCyc5OtGuf1wDYCTFgZAd5J
         YvY1G5Xs2Xw6dHiZtnXYfLAJS+FR2Jzb9+PiNliWcvcVUT4st2Kh7zPqAzinoc0mxOUs
         31Ge2wD8vWgJmqqDrwsH4728Bdf1ydO9TnraI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=VpM6APWSG+moPdqiUFLfLL9b86HPsOs2ptjNL05YxDL00SpzHBX5Vu3XLcKiPqeKKg
         VJylQZZADnKvaCEZsEZ274ZPtKlF00rgr3pxmOR3ojL/WT4HIHbzbVZff922v+CZhje9
         e7SynUMDu9mEuuyAQ9F+hTJ6n7FJmJpU51v2M=
Received: by 10.204.76.145 with SMTP id c17mr197468bkk.52.1293708817284; Thu,
 30 Dec 2010 03:33:37 -0800 (PST)
Received: by 10.204.112.210 with HTTP; Thu, 30 Dec 2010 03:33:07 -0800 (PST)
X-Google-Sender-Auth: vtqh1UjnZDGkbOUs55oVMTvY3ZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164354>

Problem:
Separate text file diary entries, committed in separate repos,
cause merge clash when pushed to central repo,
since git thinks the two entries are a single conflicting entry
(since they begin at the same location in the same file).

What we need is two diary entries automatically detected and inserted
into the one file, one above the other (ordering is not so important).


Detail:
I have a repo of diary text files;
each diary entry is separated by three blank lines
and has an asterisked + dated header, and a body.
Here is an example diary file contents:
----
*20101230 by sarah, @~3:00pm
Phoned James and asked why he took so long shopping.
He said he had planned a one day trip, but got lost in Bunnings.
I told him 'yeah sure, like I believe that'. I asked him what he got.

This is the list he told me:
 - pliers
 - hammer
 - nails



*20101229 by james
Today I went shopping.
Bought some eggs.
----

Each new diary entry gets added in the appropriate diary file
in reverse chronological order.

james, sarah and others each share a few diary files
(different diaries have different purposes).

The problem is:
james and sarah, each in their own clone of the central repo;
they each add a new diary entry to the same file, then commit, then push;

the second person to push will fail,
since each new diary entry occurs in the same location, the top of the file;
this requires a pull: result is git gives me the following (james pushed 2nd)
extract:

<<<<<<< HEAD
*20101231 by james
I took a day off today.
Didn't do much at all.
=======
*20101231 by sarah
James told me this morning he was taking a day off,
so bugger it, I decided to take a day off too.

I switched on the answering machine.
>>>>>>> a55d55a7a074bed5dbc24416f20a1d9391f2bb40


Desired outcome:
Two new diary entries - two separate insertions into the text file,
not the conflict.

Is there an easy way I can automate this diary entry merging, so my
users don't have to manually resolve the conflict?

Please note: SOMETIMES, one user will go and correct spelling and/ or
grammar fixes in another person's diary entry, or in their own older
diary entry - this is quite common.

TIA
Zen
