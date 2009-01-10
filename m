From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH] format-patch: avoid generation of empty patches
Date: Sat, 10 Jan 2009 14:39:03 +0300
Message-ID: <20090110113903.GB25723@myhost>
References: <1231536787-20685-1-git-send-email-nathan.panike@gmail.com> <7vmye0yohu.fsf@gitster.siamese.dyndns.org> <20090110113642.GA25723@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 12:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLcCc-00037u-AW
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 12:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbZAJLjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 06:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbZAJLjF
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 06:39:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:6250 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbZAJLjD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 06:39:03 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3608817fgg.17
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=8Gbu1OPVDMSLWkKu9MRJe2mpMlt2AIotUTNsenIi+jg=;
        b=FMq+rnYdBUd9tNMLHyY7a/4bPsdWk6T7Li7h6ShE1CawxeJDWV4i9duAqiXMJ08DCK
         0pzyk0FEOH6FZ32FzUCqg6yvVlbC0ASXFiyexBMFIEZv8wEtR2WGgkS9nhDXndLcSA68
         PuFCAEz3oriV3F4D9SdCh9Pq1VaLtvHvGchDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ny327j1fqaVTqoKPC1NhoHm8uDYwd551j4MmWHvPvfv+ET4jYXiFUtctheiCBHyVJe
         Hms+3XCWVxCk/TmwbWogIUHhhB7Qz1dO3Vn1PDszIFRgGONqL7/CldeKjABca46kiaM8
         CsFUen9jwgl8YV1WP1Q3yNpeN29RpMxZkjZgw=
Received: by 10.86.4.14 with SMTP id 14mr15437531fgd.76.1231587541618;
        Sat, 10 Jan 2009 03:39:01 -0800 (PST)
Received: from smtp.gmail.com (ppp83-237-189-185.pppoe.mtu-net.ru [83.237.189.185])
        by mx.google.com with ESMTPS id l19sm6667717fgb.29.2009.01.10.03.38.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 03:39:01 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Sat, 10 Jan 2009 14:39:03 +0300
Content-Disposition: inline
In-Reply-To: <20090110113642.GA25723@myhost>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105096>

If 'log.showroot' is not set, format-patch shouldn't even try to create
a patch for the root commit.

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 builtin-log.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 4a02ee9..62134d4 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -972,6 +972,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				has_commit_patch_id(commit, &ids))
 			continue;
 
+		if (!commit->parents && !rev.show_root_diff)
+			break;
+
 		nr++;
 		list = xrealloc(list, nr * sizeof(list[0]));
 		list[nr - 1] = commit;
-- 
1.6.1.77.g569c.dirty
