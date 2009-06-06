From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 00/23] http*: refactor (v6)
Date: Sat, 6 Jun 2009 16:42:53 +0800
Message-ID: <20090606164253.65a945ba.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:48:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrZd-0003VA-LW
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbZFFIsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbZFFIsN
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:48:13 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:57058 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbZFFIsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:48:12 -0400
Received: by pzk1 with SMTP id 1so1305125pzk.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=VQrEOLAAIAlYoqoLn4h8DYO3oj+KHOCqaZbHcxR45y4=;
        b=PaVb16JLSOUCkK/UAXc42KY5fETPMm47knasHU43/eRA9onSu2qFVbwdLrD7/DxGNl
         VQcZpiTiy3mivhTDo0ufm8iyyK8wPYp3FKMcT4DkcJkqfKDln3Ts0/j8fnfE0xYS1Ch4
         +fuvIgjh/UZr4Q92ATojh76K1wCPqPyyZbF50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=oqKJ+6z64c2Ttop47rVkfOR+JY66rzkz+EjqYMIK1TUNFijrScw+8uY9qDLikcLZj5
         1gje1g9El4wFZZP10J8i+kx6wW4yO0biE3bc0h+3vUkXYxf2a8JuoiqLMq86AczxEmQS
         BEaGS1AYbRNOiXaYxSVzNYA51HrScqtvlQft0=
Received: by 10.142.43.7 with SMTP id q7mr1593613wfq.160.1244278093400;
        Sat, 06 Jun 2009 01:48:13 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 22sm2717099wfi.12.2009.06.06.01.48.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:48:13 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120882>

Junio, this replaces the entire 'rc/http-push' topic.

Changes from the previous patch series:

- add a list of functions added (patch #15)

- use back the die()'s like in the original (patch #16)

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
 transport.c           |   36 ++--
 8 files changed, 905 insertions(+), 981 deletions(-)
