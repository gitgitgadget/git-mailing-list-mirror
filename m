From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 00/26] Return of smart HTTP
Date: Wed, 28 Oct 2009 17:00:22 -0700
Message-ID: <1256774448-7625-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:01:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3IRo-0000RN-Ft
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbZJ2AAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbZJ2AAp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:00:45 -0400
Received: from george.spearce.org ([209.20.77.23]:36213 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282AbZJ2AAo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:00:44 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6B38638215; Thu, 29 Oct 2009 00:00:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AB7793811E
	for <git@vger.kernel.org>; Thu, 29 Oct 2009 00:00:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131514>

I think this is the final spin of the smart HTTP series.  I've
collected patches from a few others (thanks folks!)  and added
tests specific to the smart variant of the HTTP transport.

At this point, I think it is "next ready"... but would appreciate
any additional feedback if folks identify something we should
address before hitting next.


Clemens Buchacher (1):
  remote-helpers: return successfully if everything up-to-date

Mark Lodato (5):
  http-backend: add GIT_PROJECT_ROOT environment var
  http-backend: reword some documentation
  http-backend: use mod_alias instead of mod_rewrite
  http-backend: add example for gitweb on same URL
  http-backend: more explict LocationMatch

Shawn O. Pearce (18):
  pkt-line: Add strbuf based functions
  pkt-line: Make packet_read_line easier to debug
  fetch-pack: Use a strbuf to compose the want list
  Move "get_ack()" back to fetch-pack
  Add multi_ack_detailed capability to fetch-pack/upload-pack
  remote-curl: Refactor walker initialization
  fetch: Allow transport -v -v -v to set verbosity to 3
  remote-helpers: Fetch more than one ref in a batch
  remote-helpers: Support custom transport options
  Move WebDAV HTTP push under remote-curl
  Git-aware CGI to provide dumb HTTP transport
  Add stateless RPC options to upload-pack, receive-pack
  Smart fetch and push over HTTP: server side
  Discover refs via smart HTTP server when available
  Smart push over HTTP: client side
  Smart fetch over HTTP: client side
  Smart HTTP fetch: gzip requests
  test smart http fetch and push

Tay Ray Chuan (2):
  http-push: fix check condition on http.c::finish_http_pack_request()
  t5540-http-push: remove redundant fetches

 .gitignore                           |    1 +
 Documentation/config.txt             |    8 +
 Documentation/git-http-backend.txt   |  170 ++++++++
 Documentation/git-remote-helpers.txt |   85 ++++-
 Makefile                             |    1 +
 builtin-fetch-pack.c                 |  210 ++++++++--
 builtin-fetch.c                      |    2 +-
 builtin-receive-pack.c               |   26 +-
 builtin-send-pack.c                  |  116 +++++-
 cache.h                              |    1 -
 commit.c                             |   10 +-
 commit.h                             |    2 +-
 connect.c                            |   21 -
 fetch-pack.h                         |    3 +-
 http-backend.c                       |  627 ++++++++++++++++++++++++++++
 http-push.c                          |   31 ++-
 http.c                               |   13 +-
 http.h                               |    2 +
 pkt-line.c                           |   86 ++++-
 pkt-line.h                           |    4 +
 remote-curl.c                        |  759 ++++++++++++++++++++++++++++++++--
 send-pack.h                          |    3 +-
 sideband.c                           |   11 +-
 t/lib-httpd/apache.conf              |   20 +
 t/t5540-http-push.sh                 |   18 +-
 t/t5541-http-push.sh                 |  103 +++++
 t/t5550-http-fetch.sh                |    8 +-
 t/t5551-http-fetch.sh                |   87 ++++
 transport-helper.c                   |  264 +++++++++++-
 transport.c                          |   32 +--
 transport.h                          |    2 +-
 upload-pack.c                        |   71 +++-
 32 files changed, 2574 insertions(+), 223 deletions(-)
 create mode 100644 Documentation/git-http-backend.txt
 create mode 100644 http-backend.c
 create mode 100755 t/t5541-http-push.sh
 create mode 100755 t/t5551-http-fetch.sh
