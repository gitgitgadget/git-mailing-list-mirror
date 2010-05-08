From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH/RFC v2 0/4] End-of-line normalization, take 2 (now only slightly scary)
Date: Sat,  8 May 2010 23:46:17 +0200
Message-ID: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
Cc: mat <matthieu.stigler@gmail.com>, hasen j <hasan.aljudy@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 23:46:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OArr6-0005e1-On
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 23:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab0EHVqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 17:46:32 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:40289 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab0EHVqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 17:46:31 -0400
Received: by ewy20 with SMTP id 20so578783ewy.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=AtQjrBzOzoiNoBnEKkjkQB1LxZy/ybuYyialZ5IBdVI=;
        b=dLV0Rq4UL5aQcMkiCRtWLer9QGf/ahOrpfxQo/ORF8OTOGiQWuzGsir3HiZ2CVf774
         mPiJOTGYIftFUGgW3GCJMET7zjpbcpYeTK0iW/Zimn4JMpCEN6PfV/PQR1k08sp9K2v9
         igc8tiEEXev2kOf2rw8zHeJcDs0DX3lMWR3Cw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ryj69E66fLQUhwcrVc8U0CnyB1m6q+KfOg9cdCGtn644KJRyY8eofcNP1RkMG+ZOmj
         //5vEAo38kDQsHzmeK+8vMy+hhLZOQ0K9UKf8MRfofk+8AmlGhaPmoryd/fJHvWFthFK
         ZxlOZAw93XC9R47pY44+uVYHhW9FNP5pKGsjM=
Received: by 10.213.55.74 with SMTP id t10mr473020ebg.78.1273355189157;
        Sat, 08 May 2010 14:46:29 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm1782464ewy.6.2010.05.08.14.46.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 14:46:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.3.gb95c9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146674>

Okay, here's a second shot at my end-of-line conversion sanification
series.  The main change is that instead of introducing a new attribute,
I've added a new mode to the "crlf" attribute: "crlf=auto".

The semantics of "crlf" have also been modified slightly in that the
attribute now enables end-of-line normalization whenever it is set,
instead of simply amending what happens when "core.autocrlf" is enabled
as it did before.

I think this version is a step in a direction that everyone can agree
on.  The new config variable seems to be a point of contention, but
while I'm not married to the name "core.eolStyle" by any means, I don't
think "core.crlf" explains what it is, and I don't think "input" and
"true" are good ways of describing what it does.

I agree with Linus that "crlf=input" seems crazy, and I agree with
Dmitry that "crlf" is a bad name for the attribute to begin with.  This
isn't bikeshedding: git has lost a lot of its sharp edges recently, but
this one remains, and is quite an important one for Windows users.

For now, though, I'd like the focus for this patch series to be creating
a mechanism that allows a project to enforce line ending normalization
for all contributors to the repository, while letting the user decide
what line endings he likes to see in his working directory.  If we end
up not shooting anybody in the head, all the better.

Thanks for all your inputs.  I was worried that nobody would even notice
this series :)  I've expanded the Cc list a bit, hope that's okay.

Eyvind Bernhardsen (4):
    Add "core.eolStyle" variable to control end-of-line conversion
    Add tests for per-repository eol normalization
    Pass eol conv mode as an argument instead of using global auto_crlf
    Add per-repository eol normalization

 Documentation/config.txt        |   11 ++-
 Documentation/gitattributes.txt |   71 +++++++++++-----
 Makefile                        |    3 +
 cache.h                         |   19 ++++
 config.c                        |   16 +++-
 convert.c                       |   52 +++++++++---
 environment.c                   |    1 +
 t/t0025-crlf-auto.sh            |  180 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 317 insertions(+), 36 deletions(-)
 create mode 100755 t/t0025-crlf-auto.sh
