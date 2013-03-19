From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] add: make warn_pathless_add() a no-op after first call
Date: Mon, 18 Mar 2013 20:46:36 -0700
Message-ID: <20130319034636.GK5062@elie.Belkin>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 04:47:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHnW0-0002Xh-4c
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 04:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531Ab3CSDql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 23:46:41 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:47323 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab3CSDqk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 23:46:40 -0400
Received: by mail-pb0-f48.google.com with SMTP id wy12so39495pbc.35
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 20:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=S3m9z+r5NwSfGB6uj965bo321XTjqgxPwOQ+99WMNbs=;
        b=TJfrE+p0FvnyQSOsHjXK1kVs50c2Thd3eUntwXpR5VPndruJM29kNkS5+SbylY59Wt
         OvrD/LM6o1O5s8z2oKWgJgpyaa/mbQDFQh4YNTPvClXwiQpULXhZnJt2RAUE5mrIw0de
         nfH8nDEXXhuGuW1+zvXk0dYHkqjeOLxM/JWbhPURDxynUn99miLEWRgYEeeg5mX/KrSe
         XmOFlzSNyApkuS0ofcxGfYaBzOQeXYlEv9KYE2HvHIlCPwOXxoWu/VWgkT9oqJgPtujR
         f2Ki96CEwBEyPptYyR88MA716DZv6dje+O7QOX7CvqubB3ZH4kq4Q5HfArwKW3ENkRXv
         fO8w==
X-Received: by 10.66.253.74 with SMTP id zy10mr960166pac.122.1363664800241;
        Mon, 18 Mar 2013 20:46:40 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id zv3sm10718349pab.0.2013.03.18.20.46.38
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 20:46:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130319034415.GI5062@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218475>

Make warn_pathless_add() print its warning the first time it is called
and do nothing if called again.  This will make it easier to show the
warning on the fly when a relevant condition is detected without
risking showing it multiple times when multiple such conditions hold.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index a4028eea..a424e69d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -33,8 +33,13 @@ static const char *short_option_with_implicit_dot;
 
 static void warn_pathless_add(void)
 {
+	static int shown;
 	assert(option_with_implicit_dot && short_option_with_implicit_dot);
 
+	if (shown)
+		return;
+	shown = 1;
+
 	/*
 	 * To be consistent with "git add -p" and most Git
 	 * commands, we should default to being tree-wide, but
-- 
1.8.2.rc3
