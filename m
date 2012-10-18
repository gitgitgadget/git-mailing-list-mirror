From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
Subject: [PATCH v2 0/7] Cure some format-patch wrapping and encoding issues
Date: Thu, 18 Oct 2012 16:43:27 +0200
Message-ID: <1350571414-17907-1-git-send-email-schnhrr@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 16:44:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOrKq-00047d-KZ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 16:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756352Ab2JROoU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2012 10:44:20 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:57983 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962Ab2JROoT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 10:44:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 8DCBF6181
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 16:44:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id rlOtBaO2tjjt 18578-18;
	Thu, 18 Oct 2012 16:44:06 +0200 (CEST) 13855
Received: from asahi.kbs.tu-berlin.de (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Thu, 18 Oct 2012 16:44:06 +0200 (CEST)
X-Mailer: git-send-email 1.7.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208007>

Hi all.

[This is the second version of this series. If you still remember
the first version, you might want to jump directly to the summary
of changes below.]

The main point of this series is to teach git to encode my name
correctly, see patches 5+6, so that the decoded version is actually
my name, so that send-email does not insist on adding a wrong
superfluous From: line to the mail body.

The other patches more mostly by-products that fix other issues
I came across.

Patch 1 fixes an old off-by-one error, so that wrapped text may
now use all available columns.

Patches 2 and 3 make the wrapping of header lines more correct,
i. e., neither too early nor too late.

Patch 4 does some refactoring, which is too unrelated to be included
in one of the later patches.

Patch 5 improves RFC 2047 encoding; patch 6 removes an old non-RFC
conform workaround.

Patch 7 is more an RFC, which seems to be a good idea from my point
of view. Indeed, I thought the current implementation is erroneous,
until Junio C Hamano pointed out, that this might be desired behavior.
Thus, make up your mind about this one.


The series is currently based on the maint branch, but it applies
to master as well. It does also apply to next, but then my
implementation of isprint() has to be dropped from patch 5.


Changes in v2:
- patch 1 is new and is a result of the v1 discussion
- patch 5+6 split the old patch 4 into two patches
- use of constants for maximum line lengths
- even better adherence to RFC 2047 than v1
- updated commit messages/comments


Regards
Jan

Jan H. Sch=C3=B6nherr (7):
  utf8: fix off-by-one wrapping of text
  format-patch: do not wrap non-rfc2047 headers too early
  format-patch: do not wrap rfc2047 encoded headers too late
  format-patch: introduce helper function last_line_length()
  format-patch: make rfc2047 encoding more strict
  format-patch: fix rfc2047 address encoding with respect to rfc822
    specials
  format-patch tests: check quoting/encoding in To: and Cc: headers

 git-compat-util.h       |   2 +
 pretty.c                | 149 +++++++++++++++++++++++--------
 t/t4014-format-patch.sh | 231 ++++++++++++++++++++++++++++++----------=
--------
 t/t4202-log.sh          |   4 +-
 utf8.c                  |   2 +-
 5 Dateien ge=C3=A4ndert, 262 Zeilen hinzugef=C3=BCgt(+), 126 Zeilen en=
tfernt(-)

--=20
1.7.12
