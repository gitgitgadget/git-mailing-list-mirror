From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH -01/11] git-instaweb: Simplify build dependency on gitweb
Date: Tue, 19 Apr 2011 13:54:16 +0200
Message-ID: <201104191354.17923.jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 13:54:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC9Vq-000156-DF
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 13:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab1DSLy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 07:54:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37959 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab1DSLy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 07:54:28 -0400
Received: by bwz15 with SMTP id 15so4456621bwz.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 04:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=x2xBsGIKrIfZu/hWgW5prsaN+7xP8xo4DdeIFgFvk/s=;
        b=mUkeuULSiMP2HYZ3ipJrA1NJ/LPH7TljqqH6FZiuIVocpCT8jvAUO+Qh6LVVMpnWsq
         TVOS5T9BXHh/ettDIiCg5HwA2ocXRzKp5kDavJmbzf0e4f0pqHZebnNEZElpRP3PClA/
         Yi9+1sfChShXHTviSJQ3hVx/d43QiFjVhME64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=n1UrUZojeVYXcTDZol5UifsRmZd+ghy3AaZR3XssxRQmaOEk6tEYGYO5fnlAjw03Nk
         qmKAiKJk5FKyK42Ijo/sgUe+0I6kWoEfEpA4SMLujcoIcoJD1JdsiyFwTYnCRCN1ijfK
         vkGb2zhI2xkC8rKEnAO8f0FuXfftjCxbMwjfw=
Received: by 10.204.74.167 with SMTP id u39mr5159356bkj.144.1303214067166;
        Tue, 19 Apr 2011 04:54:27 -0700 (PDT)
Received: from [192.168.1.13] (abvx167.neoplus.adsl.tpnet.pl [83.8.221.167])
        by mx.google.com with ESMTPS id b6sm3791092bkb.10.2011.04.19.04.54.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 04:54:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171792>

Since c0cb4ed (git-instaweb: Configure it to work with new gitweb
structure, 2010-05-28) git-instaweb does not re-create gitweb.cgi
etc., but makes use of installed gitweb.  Therefore simplify
git-instaweb dependency on gitweb subsystem in main Makefile from
'gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js'
to simply 'gitweb'.

This is preparation for splitting gitweb.perl script, and for
splitting gitweb.js (to be reassembled / combined on build).  This way
we don't have to duplicate parts of gitweb/Makefile in main
Makefile... it is also more correct description of git-instaweb
dependency.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is to be inserted as first patch in the series.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index cbc3fce..8960cee 100644
--- a/Makefile
+++ b/Makefile
@@ -1773,7 +1773,7 @@ gitweb/static/gitweb.min.css: gitweb/static/gitweb.css
 endif # CSSMIN
 
 
-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js
+git-instaweb: git-instaweb.sh gitweb
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-- 
1.7.3
