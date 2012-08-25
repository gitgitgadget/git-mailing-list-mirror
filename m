From: mhagger@alum.mit.edu
Subject: [PATCH v2 00/17] Clean up how fetch_pack() handles the heads list
Date: Sat, 25 Aug 2012 08:44:10 +0200
Message-ID: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:52:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5ADz-0001Io-E9
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab2HYGv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:51:56 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:51639 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753586Ab2HYGvy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:51:54 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Aug 2012 02:51:54 EDT
X-AuditID: 1207440d-b7f236d000000943-9d-50387463ee6b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 69.13.02371.36478305; Sat, 25 Aug 2012 02:44:51 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSb011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:44:49 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsUixO6iqJtcYhFgsP2OlkXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M74t72Qt+MRdcfPINKYGxoOcXYycHBICJhL3Vs5hhbDFJC7cW88GYgsJXGaUOLBeqouR
	C8g+yySxf/Z5sCI2ASmJl4097CC2iICaxMS2QywgRcwCXYwSy9f9AusWFvCSOHN8FVgDi4Cq
	xKT3EM28Ai4Sqxs2M0JsU5T48X0N8wRG7gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30
	cjNL9FJTSjcxQkKEdwfj/3UyhxgFOBiVeHhvnDEPEGJNLCuuzD3EKMnBpCTKK1ZoESDEl5Sf
	UpmRWJwRX1Sak1p8iFGCg1lJhPc7A1CONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUg
	tQgmK8PBoSTBW1sM1ChYlJqeWpGWmVOCkGbi4AQRXCAbeIA2zAcp5C0uSMwtzkyHKDrFqCgl
	zjsbJCEAksgozYMbAIvmV4ziQP8I884sAqriASYCuO5XQIOZgAaXu5qDDC5JREhJNTD6bboQ
	uXqBU8iq5YpzvNxmSt8SiCtTCL/pyvQygFPSY8rTWzNe/C9xbDyY0Xcp7lmE85YD7+M8hXfy
	nPP7X+/7sqq20mPXdfbEN6Vs6c9MFr9WbGM2mFLv73VL+NZzgQ7OQzZm1bl+fz1SaxfJtu91
	unimRGM2e8vxE481AprfXb7qvXnaVy4lluKMREMt5qLiRACBz/H/wQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204261>

From: Michael Haggerty <mhagger@alum.mit.edu>

Re-roll, incorporating Jeff's suggestions.  Some commit messages have
also been improved, but the only interdiff is that match_pos is
renamed to head_pos in filter_refs().

This patch series applies to the merge between master and
jc/maint-push-refs-all, though the dependency on the latter is only
textual.

Michael Haggerty (17):
  t5500: add tests of error output for missing refs
  Rename static function fetch_pack() to http_fetch_pack()
  Fix formatting.
  Name local variables more consistently
  Do not check the same head_pos twice
  Let fetch_pack() inform caller about number of unique heads
  Pass nr_heads to do_pack_ref() by reference
  Pass nr_heads to everything_local() by reference
  Pass nr_heads to filter_refs() by reference
  Remove ineffective optimization
  filter_refs(): do not leave gaps in return_refs
  filter_refs(): compress unmatched refs in heads array
  cmd_fetch_pack: return early if finish_connect() returns an error
  Report missing refs even if no existing refs were received
  cmd_fetch_pack(): simplify computation of return value
  fetch_pack(): free matching heads
  filter_refs(): simplify logic

 builtin/fetch-pack.c  | 128 ++++++++++++++++++++------------------------------
 fetch-pack.h          |  19 +++++---
 http-walker.c         |   4 +-
 t/t5500-fetch-pack.sh |  32 ++++++++++++-
 transport.c           |   8 ++--
 5 files changed, 101 insertions(+), 90 deletions(-)

-- 
1.7.11.3
