From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/6] detect dumb HTTP pack file corruption
Date: Thu, 15 Apr 2010 12:09:14 -0700
Message-ID: <1271358560-8946-1-git-send-email-spearce@spearce.org>
References: <20100415141504.GB17883@spearce.org>
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:09:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2URS-0004mb-Ao
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864Ab0DOTJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:09:29 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:38410 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843Ab0DOTJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:09:28 -0400
Received: by bwz25 with SMTP id 25so2034305bwz.28
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 12:09:26 -0700 (PDT)
Received: by 10.204.33.149 with SMTP id h21mr502580bkd.203.1271358565770;
        Thu, 15 Apr 2010 12:09:25 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id x16sm1326644bku.17.2010.04.15.12.09.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 12:09:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100415141504.GB17883@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145003>

This series tries to better detect and avoid corrupted pack and idx
files downloaded over the dumb HTTP transport.  It addresses the
GitHub repository maintainence causing corruption issue reported
today by Christian Halstrick.

Shawn O. Pearce (6):
  http.c: Remove bad free of static block
  t5550-http-fetch: Use subshell for repository operations
  http.c: Tiny refactoring of finish_http_pack_request
  http.c: Drop useless != NULL test in finish_http_pack_request
  http-fetch: Use index-pack rather than verify-pack to check packs
  http-fetch: Use temporary files for pack-*.idx until verified

 cache.h               |    3 +-
 http.c                |  118 +++++++++++++++++++++++++++++++++----------------
 http.h                |    1 -
 pack-check.c          |   15 +++++--
 pack.h                |    1 +
 sha1_file.c           |   17 +++++--
 t/t5550-http-fetch.sh |   37 ++++++++++++++-
 7 files changed, 140 insertions(+), 52 deletions(-)
