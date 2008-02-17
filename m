From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add new option -nohtml to quot_xxx subroutines
Date: Sun, 17 Feb 2008 18:48:13 +0100
Message-ID: <20080217174812.30454.86822.stgit@localhost.localdomain>
References: <20080216191628.GK30676@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Robert Schiele <rschiele@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 18:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQndK-0008Jr-W1
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 18:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbYBQRsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 12:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbYBQRsX
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 12:48:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:14253 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbYBQRsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 12:48:21 -0500
Received: by ug-out-1314.google.com with SMTP id z38so199872ugc.16
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 09:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=rt8bM31HpuIw1S2RK0iBhLm6N6dI8btEK588mOLrKVY=;
        b=sQ+S/hw+D//VcOmJeLStpvNsQMqH+IsE4lSu3YbjPSSOdCsnl0czHHSHOwHmF0EsmcqmUIT2gfiXMZb+QAocb2lQLvP2YAtU/uj+8jajnNpxMk5r7ueMDhMLsdb7ncs7G5LD6Uu3f5G0d9wOeE7DwXwOkRDfRlueRv/+z8AGh3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=OU7JaB549P2ScFFOg3A9iRCu8ggJkxfQFF52AKnI2wjLdiOIuATBMNQlewpY48hz4FXX+b7/vWAhw04F47UHqpJ/7CQjYGhmmvlWDzZj0ewiVNrxvF/1+8WgN2PPqGaYGXATAbXM2roZxUKFp7lYb3V+kzTj0MqEUMExES26+W4=
Received: by 10.66.220.12 with SMTP id s12mr689557ugg.15.1203270499593;
        Sun, 17 Feb 2008 09:48:19 -0800 (PST)
Received: from localhost.localdomain ( [83.8.248.52])
        by mx.google.com with ESMTPS id w40sm1076338ugc.45.2008.02.17.09.48.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Feb 2008 09:48:18 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1HHmDCZ030480;
	Sun, 17 Feb 2008 18:48:13 +0100
In-Reply-To: <20080216191628.GK30676@schiele.dyndns.org>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74142>


Add support for new option -nohtml to quot_cec and quot_upr
subroutines, to have output not wrapped in HTML tags.  This makes
those subroutines suitable to quoting attributes values, and for plain
text output quoting.  Currently this API is not used yet.

While at it fix whitespace, and use ';' as delimiter, not separator.


The option to not wrap quot_cec output in HTML tag were proposed
originally in patch:
  "Don't open a XML tag while another one is already open"
  Message-ID: <20080216191628.GK30676@schiele.dyndns.org>
by Robert Schiele.  Originally the parameter was named '-notag', was
also supportted by esc_html (but not esc_path) which passed it down to
quot_cec.  Mentioned patch was meant to fix the bug Martin Koegler
reported in his mail
  "Invalid html output repo.or.cz (alt-git.git)"
  Message-ID: <20080216130037.GA14571@auto.tuwien.ac.at>
which was fixed in different way (do not use esc_html to escape and
quote HTML attributes).


Signed-off-by: Robert Schiele <rschiele@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/gitweb.perl |   37 ++++++++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 13 deletions(-)


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index acf155c..b598366 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -753,29 +753,40 @@ sub esc_path {
 # Make control characters "printable", using character escape codes (CEC)
 sub quot_cec {
 	my $cntrl = shift;
+	my %opts = @_;
 	my %es = ( # character escape codes, aka escape sequences
-		   "\t" => '\t',   # tab            (HT)
-		   "\n" => '\n',   # line feed      (LF)
-		   "\r" => '\r',   # carrige return (CR)
-		   "\f" => '\f',   # form feed      (FF)
-		   "\b" => '\b',   # backspace      (BS)
-		   "\a" => '\a',   # alarm (bell)   (BEL)
-		   "\e" => '\e',   # escape         (ESC)
-		   "\013" => '\v', # vertical tab   (VT)
-		   "\000" => '\0', # nul character  (NUL)
-		   );
+		"\t" => '\t',   # tab            (HT)
+		"\n" => '\n',   # line feed      (LF)
+		"\r" => '\r',   # carrige return (CR)
+		"\f" => '\f',   # form feed      (FF)
+		"\b" => '\b',   # backspace      (BS)
+		"\a" => '\a',   # alarm (bell)   (BEL)
+		"\e" => '\e',   # escape         (ESC)
+		"\013" => '\v', # vertical tab   (VT)
+		"\000" => '\0', # nul character  (NUL)
+	);
 	my $chr = ( (exists $es{$cntrl})
 		    ? $es{$cntrl}
 		    : sprintf('\%03o', ord($cntrl)) );
-	return "<span class=\"cntrl\">$chr</span>";
+	if ($opts{-nohtml}) {
+		return $chr;
+	} else {
+		return "<span class=\"cntrl\">$chr</span>";
+	}
 }
 
 # Alternatively use unicode control pictures codepoints,
 # Unicode "printable representation" (PR)
 sub quot_upr {
 	my $cntrl = shift;
+	my %opts = @_;
+
 	my $chr = sprintf('&#%04d;', 0x2400+ord($cntrl));
-	return "<span class=\"cntrl\">$chr</span>";
+	if ($opts{-nohtml}) {
+		return $chr;
+	} else {
+		return "<span class=\"cntrl\">$chr</span>";
+	}
 }
 
 # git may return quoted and escaped filenames
@@ -800,7 +811,7 @@ sub unquote {
 			return chr(oct($seq));
 		} elsif (exists $es{$seq}) {
 			# C escape sequence, aka character escape code
-			return $es{$seq}
+			return $es{$seq};
 		}
 		# quoted ordinary character
 		return $seq;
