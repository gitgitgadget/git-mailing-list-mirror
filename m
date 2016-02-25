From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/20] Delete directories left empty after ref deletion
Date: Thu, 25 Feb 2016 14:15:59 +0100
Message-ID: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:16:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvma-0003c4-Fk
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760262AbcBYNQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:16:36 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:52843 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759164AbcBYNQf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:16:35 -0500
X-AuditID: 1207440f-d9fff70000007e44-dd-56cefead1766
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 9E.8C.32324.DAEFEC65; Thu, 25 Feb 2016 08:16:29 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPre024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:26 -0500
X-Mailer: git-send-email 2.7.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqLv237kwg893RCzmbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7owz15+zFbQKVnyb1MDWwNjM18XIySEhYCLRe+EU
	SxcjF4eQwFZGiSt901khnBNMErsubGMGqWIT0JVY1NPMBGKLCKhJTGw7BNbBLPCIUaJr/3ZG
	kISwgJfEm+1HgRIcHCwCqhIL16SDmLwC5hIzl3FCLJOTaPmxm3UCI9cCRoZVjHKJOaW5urmJ
	mTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCEBw7+DsWu9zCFGAQ5GJR5ehp9nw4RYE8uKK3MP
	MUpyMCmJ8u55fi5MiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvir9AOd6UxMqq1KJ8mJQ0B4uS
	OK/6EnU/IYH0xJLU7NTUgtQimKwMB4eSBO8mkEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTU
	osTSkox4UEDHFwNDGiTFA7Q3F2xvcUFiLlAUovUUo6KUOK8RSEIAJJFRmgc3FpYGXjGKA30p
	zPsKpIoHmELgul8BDWYCGjxzA9jgkkSElFQDo95sL4vbM7Vml096eyxlu/1M7UlPKpW7L4d4
	H/u1co6xEEdP4fqu1+vynNR1Nnn4y7z6YNIW6LVletCdYydYMsJeHVGPk19Sdo9XdTbHwe23
	vrZUPTcTfblPe1v/Orky/RDRmntSLj91FkiUbUr/mF1nsP4D88/GF8s2Ri76XFff 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287366>

This re-roll addresses a few minor points that were brought up about v1 [1]:

* "safe_create_leading_directories(): set errno on SCLD_EXISTS":
  * Set errno to ENOTDIR rather than EEXIST.

* "raceproof_create_file(): new function":
  * Improve comments.

* "rename_tmp_log(): use raceproof_create_file()":
  * Fix whitespace.

* "rename_tmp_log(): improve error reporting":
  * Fix whitespace.

This patch series is also available from my GitHub account [2] as
branch delete-empty-refs-dirs.

Thanks to Junio and Peff for their feedback about v1.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/286370
[2] http://github.com/mhagger/git

Michael Haggerty (20):
  safe_create_leading_directories_const(): preserve errno
  safe_create_leading_directories(): set errno on SCLD_EXISTS
  raceproof_create_file(): new function
  lock_ref_sha1_basic(): use raceproof_create_file()
  rename_tmp_log(): use raceproof_create_file()
  rename_tmp_log(): improve error reporting
  log_ref_setup(): separate code for create vs non-create
  log_ref_setup(): improve robustness against races
  log_ref_setup(): pass the open file descriptor back to the caller
  log_ref_write_1(): don't depend on logfile
  log_ref_setup(): manage the name of the reflog file internally
  log_ref_write_1(): inline function
  try_remove_empty_parents(): rename parameter "name" -> "refname"
  try_remove_empty_parents(): don't trash argument contents
  try_remove_empty_parents(): don't accommodate consecutive slashes
  t5505: use "for-each-ref" to test for the non-existence of references
  delete_ref_loose(): derive loose reference path from lock
  delete_ref_loose(): inline function
  try_remove_empty_parents(): teach to remove parents of reflogs, too
  ref_transaction_commit(): clean up empty directories

 cache.h               |  52 ++++++-
 refs/files-backend.c  | 370 ++++++++++++++++++++++++++------------------------
 refs/refs-internal.h  |   9 +-
 sha1_file.c           |  77 ++++++++++-
 t/t1400-update-ref.sh |  27 ++++
 t/t5505-remote.sh     |   2 +-
 6 files changed, 351 insertions(+), 186 deletions(-)

-- 
2.7.0
