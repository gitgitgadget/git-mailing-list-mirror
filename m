From: Richard Lowe <richlowe@richlowe.net>
Subject: [PATCH] diffcore.h: be explicit about the signedness of is_binary
Date: Sun, 23 Feb 2014 19:54:47 -0500
Message-ID: <m2ob1xba94.fsf@richlowe.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 02:01:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHjve-0002wz-Ot
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 02:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbaBXBBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 20:01:49 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:51828 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbaBXBBs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 20:01:48 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so8441736qcy.39
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 17:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=richlowe.net; s=mail;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=xmUguPtI0c1ABuhvzrNMWwYKQhjsn5z/dK/Np5pZq5g=;
        b=fYh0+ck1rI6aMgns4Uuje0k73LXWaPonp1H6dAACu66ZX1jF7Qyqs5P6myBedorBQp
         GX+PUu9ylnVu69IwEOt4ntKKvJ9e7fCbnnKX7FK2EtsS1xpE5s7yEo2f5bGO8teMd+e1
         knQLrU1EpVE2WsBXT86GrCSWO//DEjK72c4aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :mime-version:content-type;
        bh=xmUguPtI0c1ABuhvzrNMWwYKQhjsn5z/dK/Np5pZq5g=;
        b=dAuU5ZIZKF0prosQoBHugU8hIwcrc6zKnlLhD9eC2fQTODSrCzf3Th2OX4FucB2lGg
         xaAx1eRngGAF0+bQONL26o+q4S1HpXOMSDs2tlr3VBHlPw9UuvirXDbx0LVwL91PltbZ
         35BDQsFdVvfRdqSwRgTmIglDXklz8bAN9oUklhLuK5PNBeZIJoQaOhKdmPfNBbMzE0fY
         7hEEoEMCyW6THE6Nv9I1DjTvatVrsDfML1o0l292BgRhqgWT/OKSyuee6mHG2PnmuYxA
         KjaZhJn5Y1c407uXgIYnQb037ZQRf7YKOoSqhK6930Dfak7Ueh6spvWq7bcQzc1bot0E
         elLg==
X-Gm-Message-State: ALoCoQnRSL0ndsMtjdJfla0T/xtm1i9uIiii+4t73ZwNh1UKvHoN7g1Fx4klCR3Ge483u5Bb7Sjw
X-Received: by 10.224.167.84 with SMTP id p20mr26387006qay.24.1393203289699;
        Sun, 23 Feb 2014 16:54:49 -0800 (PST)
Received: from quisling.home.richlowe.net (pool-108-48-40-195.washdc.fios.verizon.net. [108.48.40.195])
        by mx.google.com with ESMTPSA id q10sm44864757qah.22.2014.02.23.16.54.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2014 16:54:49 -0800 (PST)
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.3 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242552>

Bitfields need to specify their signedness explicitly or the compiler is
free to default as it sees fit.  With compilers that default 'unsigned'
(SUNWspro 12 seems to do this) the tri-state nature of is_binary
vanishes and all files are treated as binary.

Signed-off-by: Richard Lowe <richlowe@richlowe.net>
---
 diffcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore.h b/diffcore.h
index 79de8cf..7c6f391 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -46,7 +46,7 @@ struct diff_filespec {
 	unsigned is_stdin : 1;
 	unsigned has_more_entries : 1; /* only appear in combined diff */
 	/* data should be considered "binary"; -1 means "don't know yet" */
-	int is_binary : 2;
+	signed int is_binary : 2;
 	struct userdiff_driver *driver;
 };
 
-- 
1.8.5.5
