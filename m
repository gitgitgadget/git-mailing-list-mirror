From: Ivan Todoroski <grnch@gmx.net>
Subject: [PATCH v3 0/4] Clone fails on a repo with too many heads/tags
Date: Mon, 02 Apr 2012 17:11:17 +0200
Message-ID: <4F79C195.6090905@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 17:10:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEiuF-0002jV-1p
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 17:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab2DBPKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 11:10:49 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:36309 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751854Ab2DBPKt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 11:10:49 -0400
Received: (qmail invoked by alias); 02 Apr 2012 15:10:47 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.163.38]
  by mail.gmx.net (mp029) with SMTP; 02 Apr 2012 17:10:47 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX19I8TkNAlVIOWuRlRQQGj31CqGk8niL2a3mJxvDq/
	YKV5muysv1jvoz
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194515>

The full description of the problem can be found in the first patch.


Changes since v2:

* fix a bunch of code style and documentation issues spotted by Junio
* tighten ref format checking on stdin to not allow extra whitespace
* make fetch-pack --stdin tests independent of the order of refs
* add test for duplicate refs on stdin
* drop the two ugly and redundant --stateless-rpc tests
* drop the test that tolerated extra whitespace


Changes since the original patch:

* add test cases
* add full commit messages
* fix formatting problem in --stdin doc
* split overly long fetch_pack_usage line
* use strbuf_getline() instead of fgets() for reading refs from stdin
* minor optimization of the pkt-line reading loop, it was using xstrdup()
  even though the string length was already known, use xmemdupz() instead
* rework the remote-curl.c patch to not add new parameters to rpc_service(),
  instead add a new strbuf member to rpc_state to pass the info around

Ivan Todoroski (4):
  fetch-pack: new --stdin option to read refs from stdin
  remote-curl: send the refs to fetch-pack on stdin
  fetch-pack: test cases for the new --stdin option
  remote-curl: main test case for the OS command line overflow

 Documentation/git-fetch-pack.txt |   10 ++++++
 builtin/fetch-pack.c             |   42 +++++++++++++++++++++++-
 fetch-pack.h                     |    1 +
 remote-curl.c                    |   14 ++++++--
 t/t5500-fetch-pack.sh            |   66 ++++++++++++++++++++++++++++++++++++++
 t/t5551-http-fetch.sh            |   31 ++++++++++++++++++
 6 files changed, 161 insertions(+), 3 deletions(-)

-- 
1.7.9.5.4.g4f508
