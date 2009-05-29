From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 00/17] http*: refactor (v4)
Date: Sat, 30 May 2009 01:58:28 +0800
Message-ID: <20090530015828.2de63b0a.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:00:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6Nu-0008Tp-5g
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbZE2SAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754072AbZE2SAb
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:00:31 -0400
Received: from mail-pz0-f109.google.com ([209.85.222.109]:56012 "EHLO
	mail-pz0-f109.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbZE2SAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:00:30 -0400
Received: by pzk7 with SMTP id 7so4912264pzk.33
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=8AUPwFKKoW7c6UoQN8L2De4Nve0NEfS45X0DndSoLhw=;
        b=L8OshQOn7a85VNwL5FKSq3650kVlKgxBSi6f65y4PW4t81DWYAzuiEmN2lBhc4ki64
         LvXdemabypGRVlbcz3MuwhHX/wqrpUcKkJK+9NHg/1yZsP7aiarao4pblxyKljtpl7LN
         qct4bXipfAatSA6yLCwc4TlNbSyhJaY9rOL7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=WHTVnTUASeeL6p1NNDotIQ2uPTBQ3ziZ2h2wWD+vuXyz1ZA9880MZ54+S71NiVhnGN
         bg3u3uMFttCCUcKrZ+r49bTaFu9kz/YYGl1fMmfwBAQqTKbvCQ1HDLVGPweNHVycLN1F
         wpQn50ZxACDVvmZlaL9ewZPbDWRSoGN/6akGo=
Received: by 10.115.23.19 with SMTP id a19mr4625943waj.63.1243620032157;
        Fri, 29 May 2009 11:00:32 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id m34sm2494690waf.56.2009.05.29.11.00.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:00:31 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120291>

Junio: this replaces rc/http-push~10 in pu. I've included your
suggestions and changes.

Mike: I've only taken some of your patches from your WIP patch series
dated Jan 18 (http://kerneltrap.org/mailarchive/git/2009/1/18/4757804).

Here's a list of changes from Mike's patches:

- the contentious http_cleanup has been removed in patch #6 (cleanup).

- a new http_request return state, HTTP_START_FAILED, has been added.

- http_request prints an error message ("Unable to start request") when
  start_active_slot fails.

- a new http API method, http_error, has been added.

- in patch #11 (http_fetch_ref), the error ("Unable to start request")
  is still removed, like Mike did, since http_request already handles 
  it.

- in patch #12 (remote_exists), the patch has been re-titled from
  update_remote_info_refs.

Mike Hommey (7):
  Don't expect verify_pack() callers to set pack_size
  transport.c::get_refs_via_curl(): do not leak refs_url
  http.c: new functions for the http API
  transport.c::get_refs_via_curl(): use the new http API
  http.c::http_fetch_ref(): use the new http API
  http-push.c::remote_exists(): use the new http API
  http-push.c::fetch_symref(): use the new http API

Tay Ray Chuan (10):
  http-push, http-walker: style fixes
  http-walker: verify remote packs
  http*: copy string returned by sha1_to_hex
  http-push: do not SEGV after fetching a bad pack idx file
  http*: move common variables and macros to http.[ch]
  http: create function end_url_with_slash
  http*: add http_get_info_packs
  http: use new http API in fetch_index()
  http*: add helper methods for fetching packs
  http*: add helper methods for fetching objects (loose)

 http-push.c   |  536 ++++++---------------------------------------------
 http-walker.c |  530 ++++++++------------------------------------------
 http.c        |  598 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 http.h        |   85 ++++++++
 pack-check.c  |    8 +-
 transport.c   |   33 +--
 6 files changed, 820 insertions(+), 970 deletions(-)

-- 
Cheers,
Ray Chuan
