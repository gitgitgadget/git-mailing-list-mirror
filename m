From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 00/10] teach replace objects to sha1_object_info_extended()
Date: Sat, 28 Dec 2013 12:00:05 +0100
Message-ID: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 12:01:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwrdw-0007j1-65
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 12:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157Ab3L1LAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 06:00:48 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:34545 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab3L1LAr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 06:00:47 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 9E8BA50;
	Sat, 28 Dec 2013 12:00:45 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239773>

Here is version 4 of a patch series to improve the way
sha1_object_info_extended() behaves when it is passed a
replaced object. The idea is to add a flags argument to it
in the same way as what has been done to read_sha1_file().

This patch series was inspired by a sub thread in this
discussion:

http://thread.gmane.org/gmane.comp.version-control.git/238118

The only changes compared to version 3 are the following:

	- the name of the 'full' format is now 'long'

	- the names of the replace_format enum fields
	have been prepended with 'REPLACE_FORMAT_'. This
	avoids a compilation conflict on Windows where
	SHORT is predefined. Thanks to Karsten for
	reporting this problem.

These changes only affect patches 7/10, 8/10, 9/10 and 10/10
that add a new --format option to list replace refs.

Christian Couder (10):
  Rename READ_SHA1_FILE_REPLACE flag to LOOKUP_REPLACE_OBJECT
  replace_object: don't check read_replace_refs twice
  Introduce lookup_replace_object_extended() to pass flags
  Add an "unsigned flags" parameter to sha1_object_info_extended()
  t6050: show that git cat-file --batch fails with replace objects
  sha1_file: perform object replacement in sha1_object_info_extended()
  builtin/replace: teach listing using short, medium or long formats
  t6050: add tests for listing with --format
  builtin/replace: unset read_replace_refs
  Documentation/git-replace: describe --format option

 Documentation/git-replace.txt | 19 +++++++++++-
 builtin/cat-file.c            |  2 +-
 builtin/replace.c             | 67 ++++++++++++++++++++++++++++++++++++++-----
 cache.h                       | 12 ++++++--
 replace_object.c              |  3 --
 sha1_file.c                   | 20 ++++++-------
 streaming.c                   |  2 +-
 t/t6050-replace.sh            | 42 +++++++++++++++++++++++++++
 8 files changed, 141 insertions(+), 26 deletions(-)

-- 
1.8.4.1.616.g07f5c81
