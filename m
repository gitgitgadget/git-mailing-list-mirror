From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix mimetype_guess_file for files with multiple extensions
Date: Tue, 19 Sep 2006 13:57:03 +0200
Message-ID: <200609191357.03796.jnareb@gmail.com>
References: <20060916210933.GX17042@admingilde.org> <eej0l8$36t$1@sea.gmane.org> <20060919082925.GC31940@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 13:57:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPeDL-0002tA-1l
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 13:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWISL4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 07:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWISL4S
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 07:56:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:30725 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751921AbWISL4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 07:56:17 -0400
Received: by nf-out-0910.google.com with SMTP id o25so129369nfa
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 04:56:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R4F5fijDZxwWv+haY50Bn24T5QVWfTbqI7eMj3vUblNhD6RyUi0+mN9qVK980ETsRbLLA+2CQ96+Tip1wFBvTXgF/Rktl2Si7i/lBzOrEECMtYcrZK3iyJNENgn+XhzjkISqBqmfuZmH817NffbGuZgD6c88U+82uDpkQOtoeU0=
Received: by 10.78.123.5 with SMTP id v5mr3871272huc;
        Tue, 19 Sep 2006 04:56:15 -0700 (PDT)
Received: from host-81-190-25-93.torun.mm.pl ( [81.190.25.93])
        by mx.gmail.com with ESMTP id 32sm5121868hui.2006.09.19.04.56.13;
        Tue, 19 Sep 2006 04:56:14 -0700 (PDT)
To: Martin Waitz <tali@admingilde.org>
User-Agent: KMail/1.9.3
In-Reply-To: <20060919082925.GC31940@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27271>

Fix getting correct mimetype for "blob_plain" view for files which have
multiple extensions, e.g. foo.1.html; now only the last extension
is used to find mimetype.

Noticed by Martin Waitz.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is much simpler (and faster!) correction to the mentioned problem.
I just don't grok regular expressions, not completly.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 01fae94..034cdf1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1199,7 +1199,7 @@ sub mimetype_guess_file {
 	}
 	close(MIME);
 
-	$filename =~ /\.(.*?)$/;
+	$filename =~ /\.([^.]*)$/;
 	return $mimemap{$1};
 }
 
-- 
1.4.2.1
