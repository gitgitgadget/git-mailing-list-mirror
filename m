From: mhagger@alum.mit.edu
Subject: [PATCH 0/6] Handle extra_refs separately from ref_caches
Date: Tue, 13 Dec 2011 21:06:45 +0100
Message-ID: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 21:07:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaYd1-0001JV-Vz
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 21:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab1LMUHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 15:07:03 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:37192 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab1LMUHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 15:07:00 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RaYUM-0006aj-4b; Tue, 13 Dec 2011 20:58:10 +0100
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187052>

From: Michael Haggerty <mhagger@alum.mit.edu>

Extra refs don't have much to do with real references, and in fact
they have to be handled differently.  For example, they do not support
flags, they might not have unique names (indeed, the names are rather
meaningless), and they are only ever iterated over, never looked up.
So seemingly innocent things that one might want to do with real
references, like check for conflicting duplicates, must not be done
for extra refs.

This patch series creates a new linked-list data structure for the
extra refs, separates iteration over the extra refs into a new
function, and changes a test to actually create multiple extra refs
with the same name.

This patch series applies on top of master.  If this approach is
selected, then the ref-api-D series will have to be rebased on top of
it and touched up to avoid the problems that it has with duplicate
extra refs.

By the way, I have been carrying around the CC list of this email for
quite a while.  If you are tired of being spammed with my patch
series, send me a private email and I will be happy to remove you from
future mailings.

Michael Haggerty (6):
  t5519: push two branches to alternate repo
  add_extra_ref(): remove flag argument
  Extract a function do_for_each_extra_ref()
  Store extra_refs in a separate data structure
  Omit extra_refs except when iterating using for_each_ref()
  do_for_each_extra_ref(): simplify signature

 builtin/clone.c            |    4 ++--
 builtin/receive-pack.c     |    2 +-
 refs.c                     |   44 ++++++++++++++++++++++++++++++++++----------
 refs.h                     |    2 +-
 t/t5519-push-alternates.sh |   10 +++++++++-
 5 files changed, 47 insertions(+), 15 deletions(-)

-- 
1.7.8
