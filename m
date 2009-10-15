From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Wed, 14 Oct 2009 20:36:37 -0700
Message-ID: <1255577814-14745-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 05:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyHFL-0007IV-Iy
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 05:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762126AbZJODhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 23:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761064AbZJODhc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 23:37:32 -0400
Received: from george.spearce.org ([209.20.77.23]:33017 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757438AbZJODhc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 23:37:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0A72A3811E; Thu, 15 Oct 2009 03:36:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B94A23811E
	for <git@vger.kernel.org>; Thu, 15 Oct 2009 03:36:54 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130357>

This v3 series is a respin, and includes fixes to address reviewer
comments from v2.  The protocol specification is still omitted
from the series as I have not yet had a chance to merge reviewer
comments into the draft.

Major changes from v2:

  upload-pack:
  * multi_ack_2 renamed multi_ack_detailed

  helper:
  * options are now global
  * fetch is now a batch command (instead of fetch-multiple)
  * ftp:// no longer tries info/refs?service=git-upload-pack

  http-backend:
  * manual page
  * alternates files are now served as-is
  * uses proper QUERY_STRING parsing
  * GIT_COMMITTER_EMAIL set to REMOTE_USER, for receive-pack reflog
  * receive-pack defaults to *ON* if REMOTE_USER is set

This series is still lacking:

  * The HTTP protocol documentation
  * Tests for the smart http transport code (existing tests pass)

I don't want to rush reviews, but I'm fast running of time to work on
this series right now.  Next week I am offline for vacation... and
then its time for GitTogether '09.  I plan to work on tests for
this series and the HTTP spec document draft, but that's it until
after GitTogether '09.


These commits are also available at:

  git://repo.or.cz/git/fastimport.git v3-smart-http


Shawn O. Pearce (17):
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

 .gitignore                           |    1 +
 Documentation/config.txt             |    8 +
 Documentation/git-http-backend.txt   |  142 +++++++
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
 http-backend.c                       |  603 +++++++++++++++++++++++++++
 http-push.c                          |   43 ++-
 http.c                               |    9 +
 http.h                               |    1 +
 pkt-line.c                           |   86 ++++-
 pkt-line.h                           |    4 +
 remote-curl.c                        |  758 ++++++++++++++++++++++++++++++++--
 send-pack.h                          |    3 +-
 sideband.c                           |   11 +-
 transport-helper.c                   |  262 +++++++++++-
 transport.c                          |   32 +--
 transport.h                          |    2 +-
 upload-pack.c                        |   71 +++-
 27 files changed, 2296 insertions(+), 217 deletions(-)
 create mode 100644 Documentation/git-http-backend.txt
 create mode 100644 http-backend.c
