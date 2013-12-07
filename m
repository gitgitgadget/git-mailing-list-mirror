From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 00/10] teach replace objects to sha1_object_info_extended()
Date: Sat, 07 Dec 2013 17:20:55 +0100
Message-ID: <20131207160514.21478.72966.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 17:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpKde-0004la-DP
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 17:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792Ab3LGQVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 11:21:50 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:49682 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758600Ab3LGQVs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 11:21:48 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 4020453;
	Sat,  7 Dec 2013 17:21:46 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238989>

Here is version 2 of a patch series to improve the way
sha1_object_info_extended() behaves when it is passed a
replaced object. The idea is to add a flags argument to it
in the same way as what has been done to read_sha1_file().

This patch series was inspired by a sub thread in this discussion:

http://thread.gmane.org/gmane.comp.version-control.git/238118

Patches 1/10, 2/10 and 3/10 are cleanups, among them only 1/10
is new.
Patches 4/10, 5/10 and 6/10 were also in the previous version.

Patches 7/10, 8/10, 9/10 and 10/10 are new. They add a new
--format option to list replace refs. 'short' (which is the
default), 'medium' and 'full' formats are supported. This could
be considered another patch series, but it is also related,
because it uses sha1_object_info() and it fixes its use in
builtin/replace.c by unsetting the global variable
read_replace_refs in cmd_replace().

Christian Couder (10):
  Rename READ_SHA1_FILE_REPLACE flag to LOOKUP_REPLACE_OBJECT
  replace_object: don't check read_replace_refs twice
  Introduce lookup_replace_object_extended() to pass flags
  Add an "unsigned flags" parameter to sha1_object_info_extended()
  t6050: show that git cat-file --batch fails with replace objects
  sha1_file: perform object replacement in sha1_object_info_extended()
  builtin/replace: teach listing using short, medium or full formats
  t6050: add tests for listing with --format
  builtin/replace: unset read_replace_refs
  Documentation/git-replace: describe --format option

 Documentation/git-replace.txt | 19 ++++++++++++-
 builtin/cat-file.c            |  2 +-
 builtin/replace.c             | 63 ++++++++++++++++++++++++++++++++++++++-----
 cache.h                       | 12 ++++++---
 replace_object.c              |  3 ---
 sha1_file.c                   | 20 +++++++-------
 streaming.c                   |  2 +-
 t/t6050-replace.sh            | 32 ++++++++++++++++++++++
 8 files changed, 127 insertions(+), 26 deletions(-)

-- 
1.8.5.1.102.g090758b
