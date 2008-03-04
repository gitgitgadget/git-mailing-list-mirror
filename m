From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 0/3] Server side automatic tag following
Date: Mon, 3 Mar 2008 22:26:48 -0500
Message-ID: <20080304032648.GP8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 04:27:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNoR-00010U-SZ
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 04:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbYCDD0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 22:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756364AbYCDD0x
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 22:26:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42747 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbYCDD0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 22:26:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWNna-0007cn-45; Mon, 03 Mar 2008 22:26:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B7DA420FBAE; Mon,  3 Mar 2008 22:26:48 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76025>

This series replaces my prior one from this evening based on
Nico's suggestion to use "--auto-include-tag" as the option name.
Its effectively the same series, but every commit is different due
to the change in option name and protocol extension.

For those new to the series, it avoids the second connection
needed to download new annotated tags.  Instead the server side
automatically sends the tag if the client signals it would do
automated tag following.  This lightens the load on the server
and on the client as its one less connection required to per
client requesting updates.

  1)  git-pack-objects: Automatically pack annotated tags if object was packed
  2)  Teach fetch-pack/upload-pack about --auto-include-tag
  3)  Teach git-fetch to exploit server side automatic tag following

 Documentation/git-fetch-pack.txt   |    8 +++-
 Documentation/git-pack-objects.txt |    5 ++
 builtin-fetch-pack.c               |    9 +++-
 builtin-fetch.c                    |    3 +
 builtin-pack-objects.c             |   24 +++++++++-
 fetch-pack.h                       |    3 +-
 t/t5305-auto-include-tag.sh        |   84 ++++++++++++++++++++++++++++++++++++
 t/t5503-tagfollow.sh               |   26 +++++++++++
 transport.c                        |    5 ++
 transport.h                        |    3 +
 upload-pack.c                      |   10 +++-
 11 files changed, 172 insertions(+), 8 deletions(-)

-- 
Shawn.
