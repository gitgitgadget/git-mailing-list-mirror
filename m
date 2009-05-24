From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 00/18] http*: refactor (v3)
Date: Sun, 24 May 2009 22:21:01 +0800
Message-ID: <20090524222101.3e6f0496.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Eai-0005ol-Ry
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbZEXOVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbZEXOVQ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:21:16 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:48930 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbZEXOVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:21:15 -0400
Received: by pxi1 with SMTP id 1so2153790pxi.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=fC/i9fYT0BpT2wt+FuV/UoVRcidXta+kvV8QE7bVbgI=;
        b=SbHPcMRIRKWdFyIEXy9frjbBmNqtqxRfjRCkJqXTl4awxLbvHKMDdoO9pk5jhpTj0w
         3YQGy1UD7KTUqZjE8Z6+WXSdwzdSsrfdwqJOIwqHMg8jqac9u5cYXsVXpknmnb6KEjqP
         XnjKXhB8Ll0nUBZ0aOOB9Guf8Uv592B8l2Nrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=AbXXIU9WuxpHd700nLhft4hRqgEbnqqZuMO+1pDQlEYjZlOab3PDzSQW4KwCsqRJh+
         0CmWruZR7taL4DKiYdNLpt8tkk6uoJAmcb1l6bTc1Z8fHMPP86fGjaApdaMATEoinWK0
         Z9DkmppkpUtciVTSv0Eigd2lXOQUCnwMgqRFo=
Received: by 10.115.89.18 with SMTP id r18mr12572767wal.111.1243174877486;
        Sun, 24 May 2009 07:21:17 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id m30sm4035428wag.53.2009.05.24.07.21.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:21:16 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119834>

Junio, I've reworked the patches after "http-push: fix missing "#ifdef
USE_CURL_MULTI" around "is_running_queue" in rc/http-push. (I thought
resending everything would clutter things up, but I could for your
convenience if you want me to.)

Mike, I've only taken some of your patches from your WIP patch series
dated Jan 18 (http://kerneltrap.org/mailarchive/git/2009/1/18/4757804),
because the rest are more problematic to apply.

Here's a list of changes from Mike's patches and from my previous patch
series:

 *I removed the contentious http_cleanup in the cleanup patch #7.

 *a new http_request return state, HTTP_START_FAILED, has been added.

 *http_request prints an error message ("Unable to start request") when
  start_active_slot fails.

 *a new http API method, http_error, has been added.

 *in patch #12 (http_fetch_ref), the error ("Unable to start request")
  is still removed, like Mike did, since http_request already handles it.

 *in patch #13 (remote_exists), the patch has been re-titled from
  update_remote_info_refs.

 *the patches for fetch_http_pack_index and objects/info/packs have
  been reworked into http_get_info_packs.

 *fetch_http_pack_index has been made private.

Mike Hommey (6):
  Don't expect verify_pack() callers to set pack_size
  Some cleanup in get_refs_via_curl()
  http: new functions for the http API
  transport: use the new http API in get_refs_via_curl()
  http: use the new http API in http_fetch_ref()
  http-push: use the new http API in fetch_symref()

Tay Ray Chuan (12):
  t5550-http-fetch: test fetching of packed objects
  http-push, http-walker: style fixes
  http-walker: verify remote packs
  http*: copy string returned by sha1_to_hex
  http-push: do not SEGV after fetching a bad pack idx file
  http*: move common variables and macros to http.[ch]
  http: create function end_url_with_slash
  http-push: use the new http API in remote_exists()
  http*: add http_get_info_packs
  http: use new http API in fetch_index()
  http*: add helper methods for fetching packs
  http*: add helper methods for fetching objects (loose)

 http-push.c           |  533 +++++--------------------------------------
 http-walker.c         |  528 +++++++------------------------------------
 http.c                |  602 +++++++++++++++++++++++++++++++++++++++++++++++--
 http.h                |   85 +++++++
 pack-check.c          |    8 +-
 t/t5550-http-fetch.sh |    8 +
 transport.c           |   33 +--
 7 files changed, 832 insertions(+), 965 deletions(-)
