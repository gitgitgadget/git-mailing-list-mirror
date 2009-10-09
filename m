From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH 0/4] Return of smart HTTP
Date: Thu,  8 Oct 2009 22:22:44 -0700
Message-ID: <1255065768-10428-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 07:26:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw80C-0001sK-KU
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 07:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbZJIFX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 01:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbZJIFX0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 01:23:26 -0400
Received: from george.spearce.org ([209.20.77.23]:37228 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbZJIFXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 01:23:25 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 872C638215; Fri,  9 Oct 2009 05:22:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C8ECD3811F
	for <git@vger.kernel.org>; Fri,  9 Oct 2009 05:22:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.rc3.193.gdf7a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129732>

This is an RFC series to restart the smart HTTP transport work.

Those familiar with the native git:// protocol should be able to
quickly understand what I'm doing here by looking at only the last
two patches.

This time around I actually have the whole thing fully implemented
in JGit (both client and server), and am now trying to port that
over to C git.git, as well as document it in depth.

The JGit series can be found here at Eclipse.org:

  http://egit.eclipse.org/r/
  git://egit.eclipse.org/egit/parallelip-jgit refs/changes/50/50/4

This RFC C Git series only implements the server side, and only
has partial documentation.  I did some limited smoke testing with
the JGit client against this server, it seems to work as expected.

I plan on trying to write the C Git clients tomorrow.  The
send-pack/receive-pack protocol is trivial and shouldn't be
that hard, but the fetch-pack/upload-pack protocol is going
to be somewhat interesting...


Shawn O. Pearce (4):
  Document the HTTP transport protocol
  Git-aware CGI to provide dumb HTTP transport
  Add smart-http options to upload-pack, receive-pack
  Smart fetch and push over HTTP: server side

 .gitignore                                |    1 +
 Documentation/technical/http-protocol.txt |  542 +++++++++++++++++++++++++++++
 Makefile                                  |    1 +
 builtin-receive-pack.c                    |   26 +-
 http-backend.c                            |  394 +++++++++++++++++++++
 upload-pack.c                             |   40 ++-
 6 files changed, 994 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/technical/http-protocol.txt
 create mode 100644 http-backend.c
