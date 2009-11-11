From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: t5541-http-push hanging
Date: Wed, 11 Nov 2009 01:28:05 -0500
Message-ID: <B17AB159-E217-4E1F-BEA3-97E5892C13F4@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 07:28:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N86gg-0000dB-B8
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 07:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbZKKG2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 01:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbZKKG2E
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 01:28:04 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:39246 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbZKKG2D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 01:28:03 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id CA32F1FFC087; Wed, 11 Nov 2009 06:27:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 511A61FFC06B
	for <git@vger.kernel.org>; Wed, 11 Nov 2009 06:27:55 +0000 (UTC)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132617>

My build script for git has been hanging at t5541.2 and I haven't had the tuits to discover why.  Here's what I've gotten so far, in case anyone can figure it out faster:

$ ./t5541-http-push.sh -v
Initialized empty Git repository in /Users/brian/dev/git/t/trash directory.t5541-http-push/.git/
* expecting success: 
	cd "$ROOT_PATH" &&
	mkdir test_repo &&
	cd test_repo &&
	git init &&
	: >path1 &&
	git add path1 &&
	test_tick &&
	git commit -m initial &&
	cd - &&
	git clone --bare test_repo test_repo.git &&
	cd test_repo.git &&
	git config http.receivepack true &&
	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
	cd - &&
	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"

Initialized empty Git repository in /Users/brian/dev/git/t/trash directory.t5541-http-push/test_repo/.git/
[master (root-commit) 0c973ae] initial
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 path1
/Users/brian/dev/git/t/trash directory.t5541-http-push
Initialized empty Git repository in /Users/brian/dev/git/t/trash directory.t5541-http-push/test_repo.git/
/Users/brian/dev/git/t/trash directory.t5541-http-push
*   ok 1: setup remote repository

* expecting success: 
	cd "$ROOT_PATH" &&
	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone

Initialized empty Git repository in /Users/brian/dev/git/t/trash directory.t5541-http-push/test_repo_clone/.git/
error: RPC failed; result=22, HTTP code = 500
^CFATAL: Unexpected exit with code 130

brian@hermes t (master)$ cd trash\ directory.t5541-http-push/httpd/
brian@hermes httpd (master)$ cat error.log 
[Wed Nov 11 06:19:39 2009] [notice] Apache/2.2.13 (Unix) configured -- resuming normal operations
[Wed Nov 11 06:19:39 2009] [error] [client 127.0.0.1] git-http-backend(59490) malloc: *** error for object 0x100200340: incorrect checksum for freed object - object was probably modified after being freed.
[Wed Nov 11 06:19:39 2009] [error] [client 127.0.0.1] *** set a breakpoint in malloc_error_break to debug
[Wed Nov 11 06:19:40 2009] [error] [client 127.0.0.1] Premature end of script headers: git-http-backend
[Wed Nov 11 06:24:23 2009] [notice] caught SIGTERM, shutting down