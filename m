From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 00/23] http*: refactor (v5)
Date: Fri, 5 Jun 2009 23:59:59 +0800
Message-ID: <20090605235959.f4df6457.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Clemens Buchacher <drizzd@aon.at>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbz7-00053w-RQ
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbZFEQIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbZFEQIF
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:05 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43072 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZFEQID (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:03 -0400
Received: by pzk1 with SMTP id 1so944213pzk.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=I1ibshNX7guTPzyA5VSvJMKmercspBFnnVab9aTyiAw=;
        b=gFTi9dlpRBX4H93tcWocWcI1ptIeAlNISlZmO6HBV4LCkQTSV87c+h/NwoMLlxH0Io
         Vz6OB4RFx2S0tb9XRqoaICNOEBj11CeN35h4QaR5Lvw/SCTIPIFMqLATtgxwKURHJZcu
         METHxvP3Z65lLpb6Pr7pM4sMhDYNfkwv8gRfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Exp3Ip0yJEy3D4e5tTUqOE6CGLD+ZyzwjM2Dr1ez8HIsx6q0EydIhDO4GMDNO92JlU
         lH9GIo1ssEBqzlhddMLXEGpNVVO+TqCVXWAPuOQQiSXTF26kNhNh4XvOJPa0HamIG/sm
         u4wi/nw4P1NNOKvqViO7jRkbEiBJkfyiHaQpQ=
Received: by 10.142.192.3 with SMTP id p3mr1221497wff.147.1244218085402;
        Fri, 05 Jun 2009 09:08:05 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 32sm411192wfa.13.2009.06.05.09.08.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:04 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120783>

Junio, this replaces the entire rc/http-push topic.

Changes from the previous patch series:

- fix return values of fetch_indices() in http-push.c, as highlighted
  by Clemens (patch #20)

- added set slot->local to NULL patch (patch #3)

- set slot->local to NULL in http.c::http_request() (patch #15)

- set slot->local to NULL in http.c::release_http_pack_request() and
  http.c::finish_http_pack_request() (patch #22)


Christian Couder (1):
  http-push: fix missing "#ifdef USE_CURL_MULTI" around
    "is_running_queue"

Mike Hommey (7):
  Don't expect verify_pack() callers to set pack_size
  transport.c::get_refs_via_curl(): do not leak refs_url
  http.c: new functions for the http API
  transport.c::get_refs_via_curl(): use the new http API
  http.c::http_fetch_ref(): use the new http API
  http-push.c::remote_exists(): use the new http API
  http-push.c::fetch_symref(): use the new http API

Tay Ray Chuan (15):
  t5540-http-push: test fetching of loose objects
  t5540-http-push: test fetching of packed objects
  http*: cleanup slot->local after fclose
  http-push: send out fetch requests on queue
  t5550-http-fetch: test fetching of packed objects
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

 http-push.c           |  579 ++++++++---------------------------------------
 http-walker.c         |  533 +++++++------------------------------------
 http.c                |  601 +++++++++++++++++++++++++++++++++++++++++++++++--
 http.h                |   85 +++++++
 pack-check.c          |    8 +-
 t/t5540-http-push.sh  |   36 +++
 t/t5550-http-fetch.sh |    8 +
 transport.c           |   33 +--
 8 files changed, 902 insertions(+), 981 deletions(-)
