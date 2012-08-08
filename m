From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v3 0/13] Introduce index file format version 5
Date: Wed,  8 Aug 2012 13:17:48 +0200
Message-ID: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 13:26:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz4Pd-0004pP-TS
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 13:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab2HHL03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 07:26:29 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:36949 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755884Ab2HHL01 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 07:26:27 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id 5A5CE4EF8E; Wed,  8 Aug 2012 13:18:47 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203074>

Previous rounds of this series were on $gmane/202752 and $gmane/202923.

This round includes a major change, as it is splitting up read-cache.c
into read-cache.c, read-cache-v2.c and read-cache-v5.c.  It uses
index->ops to call the specific functions as suggested by Duy.

It also changes the index format slightly, removing the size from the
stat_crc and adding it as separate field, as suggested by Robin.  This
makes the format incompatible with the one in the previous two series.

[PATCH/RFC 01/13] Move index v2 specific functions to their own file
This previously was patch 1/2/3/4, but since the code is now moved
to a different file, it seems to make more sense to do it in one patch.
Also moved the size check to the verify_hdr functions for the respective
index formats.

[PATCH/RFC 02/13] t2104: Don't fail for index versions other than
Do the update index at the very beginning.

[PATCH/RFC 03/13] t3700: Avoid interfering with the racy code
Instead of sleeping for a second, test-chmtime now uses an absolute
time, to avoid the racy code.

[PATCH/RFC 04/13] Add documentation of the index-v5 file format
Added the size to the cache-entries.

[PATCH/RFC 05/13] Make in-memory format aware of stat_crc
Removed size from the stat_crc.

[PATCH/RFC 06/13] Read index-v5
Changed the pointer arithmetic to not use void * directly, by
casting it to a char * first.

[PATCH/RFC 07/13] Read resolve-undo data
[PATCH/RFC 08/13] Read cache-tree in index-v5
[PATCH/RFC 09/13] Write index-v5
[PATCH/RFC 10/13] Write index-v5 cache-tree data
[PATCH/RFC 11/13] Write resolve-undo data for index-v5
[PATCH/RFC 12/13] update-index.c: always rewrite the index when
Instead of using a force-rewrite option, always rewrite the index
if a index-version is given.

[PATCH/RFC 13/13] p0002-index.sh: add perf test for the index
Instead of using the force-rewrite option, which was removed from
update-index, use git update-index --index-version=n for doing the
preformance testing.
