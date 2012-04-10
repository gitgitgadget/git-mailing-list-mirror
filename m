From: mhagger@alum.mit.edu
Subject: [PATCH 00/15] Hierarchical reference cache (once again)
Date: Tue, 10 Apr 2012 07:30:12 +0200
Message-ID: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTfc-0002Gn-RI
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980Ab2DJFaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:30:52 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59194 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab2DJFau (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:30:50 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXdr000870;
	Tue, 10 Apr 2012 07:30:33 +0200
X-Mailer: git-send-email 1.7.10
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195060>

From: Michael Haggerty <mhagger@alum.mit.edu>

Here is another installment of the "hierarchical refs" saga.  This
patch series (obviously) builds on the changes in master that removed
extra_refs.  This group of patches does some cleanup then makes the
transition to storing reference caches hierarchically.  It also
includes the first benefit of the hierarchical storage scheme, namely
that searching for individual references becomes more efficient
(though as yet all references are read into the cache if any
references are needed, so the benefit is limited).

I will have limited Internet connectivity for the next week, so I
apologize in advance if I don't react quickly to feedback.  But I
wanted to throw at least part of this reworked "ref-api" patch series
back into the ring while the new release cycle is still fresh.

Michael Haggerty (15):
  refs.c: reorder definitions more logically
  refs: manage current_ref within do_one_ref()
  do_for_each_ref_in_array(): new function
  do_for_each_ref_in_arrays(): new function
  repack_without_ref(): reimplement using do_for_each_ref_in_array()
  names_conflict(): new function, extracted from is_refname_available()
  names_conflict(): simplify implementation
  is_refname_available(): reimplement using do_for_each_ref_in_array()
  free_ref_entry(): new function
  check_refname_component(): return 0 for zero-length components
  struct ref_entry: nest the value part in a union
  refs.c: rename ref_array -> ref_dir
  sort_ref_dir(): simplify logic
  refs: store references hierarchically
  do_for_each_ref(): only iterate over the subtree that was requested

 refs.c | 1036 +++++++++++++++++++++++++++++++++++++++++-----------------------
 refs.h |    7 +-
 2 files changed, 670 insertions(+), 373 deletions(-)

-- 
1.7.10
