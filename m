From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Simplify (and fix) chop_str
Date: Wed, 3 Feb 2010 12:28:28 +0100
Message-ID: <201002031228.31324.jnareb@gmail.com>
References: <1265147814-13284-1-git-send-email-warthog9@eaglescrag.net> <m3mxzr9pcz.fsf@localhost.localdomain> <4B68BB4D.20105@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 12:28:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcdPg-0005Qm-RG
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 12:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab0BCL2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 06:28:44 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:37653 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab0BCL2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 06:28:43 -0500
Received: by fg-out-1718.google.com with SMTP id e21so33542fga.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 03:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+Y7uLAq8et676NxR6B46xwnP7/i+l0b9jiCDeKafexA=;
        b=kyt9K0gGgaskTQHAbrihVUgibvKK6jYxVL2un7UGUnz9e8kfN4LSN5JDsOYYYTQjbt
         BHzHYE/IYJsWH+uFLc2dGc4YF5cOp414JlDHMyDSuSsZTVPE3Z6jda/rwFdol3+P+i47
         Tyavlp952Iw6M7zilPsD5aHb3Lqo+eOd+Zu7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cNFoesHkALsDlIQY2PUNgyxPvk7P6I1gD+qWFd/qpGahblCIWmqWoz7l0HaIuhzphK
         HtSUkj6kWJ4qxvTmnabAbgKa2//6oE9Pc593QplDxwkZ4mxvzm8UfJVlHEw6KeA8bDY4
         /ILk5h9l1lD8Q3MKvMjt/EQnfmhJnyofSKh5w=
Received: by 10.86.88.28 with SMTP id l28mr12731914fgb.25.1265196521478;
        Wed, 03 Feb 2010 03:28:41 -0800 (PST)
Received: from ?192.168.1.13? (abvx213.neoplus.adsl.tpnet.pl [83.8.221.213])
        by mx.google.com with ESMTPS id l19sm13868492fgb.25.2010.02.03.03.28.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 03:28:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B68BB4D.20105@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138829>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

The chop_str subroutine is meant to be used on strings (such as commit
description / title) *before* HTML escaping, which means before
applying esc_html or equivalent.

Therefore get rid of the failed attempt to always remove full HTML
entities (like e.g. &amp; or &nbsp;).  It is not necessary (HTML
entities gets added later), and it can cause chop_str to chop a string
incorrectly.

Specifically:

     API & protocol: support option to force written data immediately to disk

from http://git.kernel.org/?p=daemon/distsrv/chunkd.git;a=commit;h=3b02f749df2cb1288f345a689d85e7061f507e54

The short version of the title gets chopped to

     API ...

where it should be

     API & protocol: support option to force written data...

Noticed-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I have retained J.H. authorship of this patch.  I have rewritten
commit message, added signoffs, and removed all instances of failed
attempt of removing HTML entities whole, even though only one of them
is used.

 gitweb/gitweb.perl |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d0c3ff2..1f6978a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1330,7 +1330,6 @@ sub chop_str {
 		$str =~ m/^(.*?)($begre)$/;
 		my ($lead, $body) = ($1, $2);
 		if (length($lead) > 4) {
-			$body =~ s/^[^;]*;// if ($lead =~ m/&[^;]*$/);
 			$lead = " ...";
 		}
 		return "$lead$body";
@@ -1341,8 +1340,6 @@ sub chop_str {
 		$str =~ m/^(.*?)($begre)$/;
 		my ($mid, $right) = ($1, $2);
 		if (length($mid) > 5) {
-			$left  =~ s/&[^;]*$//;
-			$right =~ s/^[^;]*;// if ($mid =~ m/&[^;]*$/);
 			$mid = " ... ";
 		}
 		return "$left$mid$right";
@@ -1352,7 +1349,6 @@ sub chop_str {
 		my $body = $1;
 		my $tail = $2;
 		if (length($tail) > 4) {
-			$body =~ s/&[^;]*$//;
 			$tail = "... ";
 		}
 		return "$body$tail";
-- 
1.6.6.1
