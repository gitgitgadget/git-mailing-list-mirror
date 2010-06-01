From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Tue,  1 Jun 2010 16:41:50 +0200
Message-ID: <cover.1275309129.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 16:42:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJSfU-00045q-1d
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 16:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136Ab0FAOmE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 10:42:04 -0400
Received: from mail.roxen.com ([212.247.29.220]:42854 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755744Ab0FAOmB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 10:42:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 874AA62822E
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 16:41:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id faEBP63GPiQZ for <git@vger.kernel.org>;
	Tue,  1 Jun 2010 16:41:59 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 72FA2628209
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 16:41:59 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.14.4+Sun/8.14.4) with ESMTP id o51Efxfm021815;
	Tue, 1 Jun 2010 16:41:59 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.14.4+Sun/8.14.4/Submit) id o51Efwht021814;
	Tue, 1 Jun 2010 16:41:58 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148117>

This is the fourth go at having the git index keep track of
the conversion mode for blobs.

This is useful for repositorys not containing fully normalized files
(eg containing CRLF's or expanded $Id$ strings), where a later attribut=
e
change implies a conversion mode change. Without this set of patches
the user would need to recommit semantically unchanged files to get
a clean index.

Changes since last time:

  o The patch set has been rebased upon 0ed6711 (aka eb/core-eol),
    to be able to take advantage of convert.c:get_output_conversion()
    and convert.c:determine_action().

  o As a consequence of using those functions, the on-disk format for
    the CONV extension has changed slightly. The change should have
    minimal impact, since the index will in most cases self-repair.

  o The t0025-crlf-auto.sh tests have been updated to still test
    the same behaviour.

Junio: This should be close to what you envisioned in
       <7vsk6qio1f.fsf@alter.siamese.dyndns.org>.

Henrik Grubbstr=C3=B6m (Grubba) (5):
  sha1_file: Add index_blob().
  strbuf: Add strbuf_add_uint32().
  cache: Keep track of conversion mode changes.
  cache: Add index extension "CONV".
  t/t0021: Test that conversion changes are detected.

 cache.h               |   12 ++++++
 convert.c             |   46 ++++++++++++++++++++++
 read-cache.c          |  102 +++++++++++++++++++++++++++++++++++++++++=
+++----
 sha1_file.c           |   19 +++++++++
 strbuf.h              |    4 ++
 t/t0021-conversion.sh |   54 ++++++++++++++++++++++++++
 t/t0025-crlf-auto.sh  |   20 ++++++----
 7 files changed, 240 insertions(+), 17 deletions(-)
