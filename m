From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/9] more robustness against pack corruptions
Date: Wed, 29 Oct 2008 19:02:43 -0400
Message-ID: <1225321372-6570-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:05:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK6p-0004tU-Lz
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbYJ2XDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758100AbYJ2XDA
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:03:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758088AbYJ2XC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:02:58 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9I00DV4W0SZRE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Oct 2008 19:02:52 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.3.757.g01be.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99421>

A few months ago I produced a set of patches to allow git to work even
in the presence of pack corruption given that the corrupted objects have
a good duplicate in the object store.  Turns out that this work was
rather incomplete and covered only a limited set of cases.

This series extend coverage to all cases I could think about, and make
repack-objects able to create a good pack in such conditions to "fix"
the corruption without having to perform a full repack.

Yes, this is all about the small and trivial patch I posted a while ago
that I intended to repost with a test case.  Well, the test failed
miserably, resulting in this series before it finally all passed.  ;-)

 builtin-pack-objects.c                |   79 +++++++++++++++++-----
 builtin-unpack-objects.c              |    2 +
 cache.h                               |    2 +-
 index-pack.c                          |    2 +-
 pack-revindex.c                       |    3 +-
 sha1_file.c                           |   85 ++++++++++++++++++-----
 t/t5302-pack-index.sh                 |    3 +-
 t/t5303-pack-corruption-resilience.sh |   96 +++++++++++++++++++++++++--
 8 files changed, 223 insertions(+), 49 deletions(-)


Nicolas
