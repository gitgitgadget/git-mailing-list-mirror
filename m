From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 00/15] Towards a more awesome git-branch
Date: Tue,  4 Jun 2013 18:05:22 +0530
Message-ID: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRD-0006cZ-IS
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab3FDMdy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 08:33:54 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56981 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab3FDMdu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:33:50 -0400
Received: by mail-pd0-f182.google.com with SMTP id g10so175189pdj.13
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=wQUavHTF8ZW1z7sH2iuFfZs2ImzTuXRXEXtY/Cjn0fg=;
        b=FWLcC+6r7X36C2QMq+st9q5vzK4YavpLjfGTzBZ6HZ2OiFwyccXVxRkCpi2uIkBEgR
         L/MFVhlGfaB9jHhcdqAXGRZO/C0Il2NDQ93EU7kK6Jn6WCzLVDjhOXv4R8x80nTnKumO
         uo5l2Kr8REFLTR7PtCHu4iisn1zoLua1rnx8Wra/w161RF6KIV68lHjQwVywDkP3y7Fl
         JUN7QW5UaCEtMnW+S4wLxDwvVoT7GME5vSrBJJk1BaodozEDEEFhiwvHXTu2g+DOnf4v
         B/A68jOi6MQgGOpJJFcwKePL2AALxF/JD9FbeO2SDJfyu3qm8hKuD88+jBrtsLe3jICF
         St+w==
X-Received: by 10.68.125.135 with SMTP id mq7mr27945464pbb.159.1370349229520;
        Tue, 04 Jun 2013 05:33:49 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.33.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:33:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226343>

Hi,

Duy and I have been working on this topic for some time now.  Here's a
review candidate.  Duy did most of the chunky work, and I mostly
did review/documentation.  The key patches are:

[5/15]  is a brilliant patch that made this entire thing possible.
[10/15] is another brilliant patch to auto-calculate widths.

Duy is currently writing code to factor out -v[v] and adding --sort,
--count to git-branch, but I'm having a lot of difficulty working with
a series of this size.  I'm leaning towards getting this merged before
tackling branch (who wants to review a 40-part series?).  Especially
after [14/15] and [15/15], git for-each-ref should be usable in its
own right.  I currently have:

[pretty]
hot =3D %C(red)%(HEAD)%C(reset) %C(green)%(refname:short)%C(reset)%(ups=
tream:trackshort)
[alias]
hot =3D for-each-ref --pretty=3Dhot --count 10 --sort=3D'-committerdate=
' refs/heads

Which is really useful and manageable until we port these options to
branch and get nice configuration variables.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  for-each-ref, quote: convert *_quote_print -> *_quote_buf
  for-each-ref: don't print out elements directly
  pretty: extend pretty_print_context with callback
  pretty: allow passing NULL commit to format_commit_message()
  for-each-ref: get --pretty using format_commit_message
  for-each-ref: teach verify_format() about pretty's syntax
  for-each-ref: introduce format specifier %>(*) and %<(*)
  for-each-ref: improve responsiveness of %(upstream:track)

Ramkumar Ramachandra (7):
  tar-tree: remove dependency on sq_quote_print()
  quote: remove sq_quote_print()
  pretty: limit recursion in format_commit_one()
  for-each-ref: introduce %(HEAD) marker
  for-each-ref: introduce %(upstream:track[short])
  pretty: introduce get_pretty_userformat
  for-each-ref: use get_pretty_userformat in --pretty

 Documentation/git-for-each-ref.txt |  42 +++++-
 builtin/for-each-ref.c             | 274 +++++++++++++++++++++++++++++=
+-------
 builtin/tar-tree.c                 |  11 +-
 commit.h                           |   9 ++
 pretty.c                           |  77 ++++++++++-
 quote.c                            |  61 +++------
 quote.h                            |   8 +-
 7 files changed, 372 insertions(+), 110 deletions(-)

--=20
1.8.3.GIT
