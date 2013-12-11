From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 00/10] teach replace objects to sha1_object_info_extended()
Date: Wed, 11 Dec 2013 08:46:03 +0100
Message-ID: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 08:47:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqeWO-0007lg-SM
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 08:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236Ab3LKHrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 02:47:47 -0500
Received: from [194.158.98.14] ([194.158.98.14]:53284 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751183Ab3LKHrr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 02:47:47 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 1134F3A;
	Wed, 11 Dec 2013 08:47:24 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239170>

Here is version 3 of a patch series to improve the way
sha1_object_info_extended() behaves when it is passed a
replaced object. The idea is to add a flags argument to it
in the same way as what has been done to read_sha1_file().

This patch series was inspired by a sub thread in this
discussion:

http://thread.gmane.org/gmane.comp.version-control.git/238118

The only change compared to version 2 is that a few more
tests have been added to patch 8/10, as suggested by Eric
Sunchine.

As in the previous version, patches 7/10, 8/10, 9/10 and 10/10
add a new --format option to list replace refs. 'short' (which
is the default), 'medium' and 'full' formats are supported.
This could be considered another patch series, but it is also
related, because it uses sha1_object_info() and it fixes its
use in builtin/replace.c by unsetting the global variable
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
 t/t6050-replace.sh            | 42 +++++++++++++++++++++++++++++
 8 files changed, 137 insertions(+), 26 deletions(-)

-- 
1.8.5.1.102.g090758b
