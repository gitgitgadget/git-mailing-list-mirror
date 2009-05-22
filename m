From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (lite)] gitweb: Sanitize title attribute in format_subject_html
Date: Fri, 22 May 2009 17:39:32 +0200
Message-ID: <200905221739.35254.jnareb@gmail.com>
References: <200905221735.48310.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 17:39:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Wqa-00086r-Kt
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 17:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303AbZEVPjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 11:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756145AbZEVPjl
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 11:39:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:57132 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700AbZEVPjk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 11:39:40 -0400
Received: by fg-out-1718.google.com with SMTP id 16so642073fgg.17
        for <git@vger.kernel.org>; Fri, 22 May 2009 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=M6d2h76pfx2NIRPcwxrZLDAs4p6zxAdOX5pvbzPJV70=;
        b=W5xo6aQj5+mkdv8QY8w1DZX0lSN9MYmXQws1VQ0rhfRvrawXUKIN4DLCqvEOLXapT+
         eRzJgmmmkF+y5Nz0FgPd+a/PxhUhZkfqS+Ozw1857UzHUv+dxGDllQracWunk5FtS2Q0
         xaRD1OYk1QhwDVOfeB+WMv1tIbsh46EP0v0JA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ufywIKzMx1vakb91VhQD5sy6N5PYWd1HlZO9u/eFkp035RoDjvRy+7DCT6PwYYQ2Si
         94zFAkfRu6EvazbE/v8x7bK6IXfh2Pn3qPB2gy+wHytQvezzE+hL3ZEDluCSAUz2CvBr
         8JYUiGDeM+K/9NtynqAijO/eeer6l344J3QV8=
Received: by 10.86.27.6 with SMTP id a6mr3225334fga.18.1243006780538;
        Fri, 22 May 2009 08:39:40 -0700 (PDT)
Received: from ?192.168.1.13? (abwq183.neoplus.adsl.tpnet.pl [83.8.240.183])
        by mx.google.com with ESMTPS id 4sm5744732fgg.23.2009.05.22.08.39.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 May 2009 08:39:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905221735.48310.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119737>

Replace control characters with question mark '?' (like in
chop_and_esc_str).

While at it: chop_and_escape_str doesn't need capturing group.

Noticed-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This version has more sane ratio of commit message length to actual
change...

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 05702e4..1e7e2d8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1236,7 +1236,7 @@ sub chop_and_escape_str {
 	if ($chopped eq $str) {
 		return esc_html($chopped);
 	} else {
-		$str =~ s/([[:cntrl:]])/?/g;
+		$str =~ s/[[:cntrl:]]/?/g;
 		return $cgi->span({-title=>$str}, esc_html($chopped));
 	}
 }
@@ -1459,6 +1459,7 @@ sub format_subject_html {
 	$extra = '' unless defined($extra);
 
 	if (length($short) < length($long)) {
+		$long =~ s/[[:cntrl:]]/?/g;
 		return $cgi->a({-href => $href, -class => "list subject",
 		                -title => to_utf8($long)},
 		       esc_html($short) . $extra);
-- 
1.6.3.1
