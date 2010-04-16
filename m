From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH RFC 0/5] Patches to avoid reporting conversion changes.
Date: Fri, 16 Apr 2010 18:09:57 +0200
Message-ID: <cover.1271432034.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 18:43:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2odX-00053s-KY
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758128Ab0DPQnV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Apr 2010 12:43:21 -0400
Received: from mail.roxen.com ([212.247.29.220]:60554 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758251Ab0DPQnP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:43:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id CDE2F62824C
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HLKEnLh3Itg3 for <git@vger.kernel.org>;
	Fri, 16 Apr 2010 18:10:04 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 86AC562817E
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:04 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o3GGA4GJ021788;
	Fri, 16 Apr 2010 18:10:04 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o3GGA4vK021787;
	Fri, 16 Apr 2010 18:10:04 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145075>

This is the first go at having the git index keep track of the
conversion mode and corresponding normalized blob for files.

The approach is relatively straight-forward:
  * struct cache_entry has been extended with two fields,
    norm_flags and norm_sha1, to keep track of the data.
  * An accessor function ce_norm_sha1() has been added,
    which checks that the fields seem valid, and otherwise
    recalculates them.
  * run_diff_files() and ce_compare_data() compare against
    the normalized blob.

Still missing is a testsuite, and I may have missed some place
that ought to use ce_norm_sha1().

Thanks to Junio C Hamano for the suggestion.

Henrik Grubbstr=C3=B6m (Grubba) (5):
  sha1_file: Added index_blob().
  cache: Added ce_norm_sha1() and related cache_entry fields.
  cache: Added index extension "NORM".
  reachable: Made the gc aware of the ce_norm_sha1.
  cache: Use ce_norm_sha1().

 cache.h      |   29 +++++++++++++++++++++++++++++
 convert.c    |   35 +++++++++++++++++++++++++++++++++++
 diff-lib.c   |    9 ++++++---
 reachable.c  |    2 ++
 read-cache.c |   51 ++++++++++++++++++++++++++++++++++++++++++++------=
-
 sha1_file.c  |   19 +++++++++++++++++++
 6 files changed, 135 insertions(+), 10 deletions(-)
