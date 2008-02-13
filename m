From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: [PATCH] Do not chop HTML tags in commit search result
Date: Wed, 13 Feb 2008 18:37:24 +0100
Message-ID: <ae63f8b50802130937mddf9df9re2a95bee44661ee3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 18:38:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPLZ2-0008F6-V0
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 18:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763093AbYBMRhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 12:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762803AbYBMRhb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 12:37:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:56204 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760628AbYBMRh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 12:37:28 -0500
Received: by nf-out-0910.google.com with SMTP id g13so58596nfb.21
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=OfWfowQx1RDQPNpov41v+MC31Lcj1owVHCVpkRClvkA=;
        b=VVBGC8W9e7I2XjkvexorTQ8pGWJcMdwx660pMhKKoY6WBHnw0t2mySb9/SqYFyq3c0PL5KBRLYv1nZTlIvgRGP6l1tY9BttrTfLRk5ea30EubCS3pXn9B2hw2dTz3bFt4le8OP9dWhX6Toz3Md311k9cEXaB2CgjJq6yoAyBDvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=WqVVItTuzw8v4KjUInZVStabGFHMmHxK53Tf+LCvo3N2NRngm0TwCl5C91BW/t7UsSW/1TLdeRy8Oxv9Q0Vhytw3aPBgybm73TVWWOR+/pyKqtQnibN98dFTiq3tycRp66zbpxxlXaWcK61g5Jcbd+6CtEhQt4ljz2yKNRu35ow=
Received: by 10.78.170.6 with SMTP id s6mr334325hue.50.1202924244825;
        Wed, 13 Feb 2008 09:37:24 -0800 (PST)
Received: by 10.78.130.20 with HTTP; Wed, 13 Feb 2008 09:37:24 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 6c76543d9a424507
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73803>

Hi there,

Thanks for Git! It's a great program.  I encountered an annoying bug
with gitweb 1.5.4.1, when searching for commits, if the search string
is too long, the generated HTML is munged leading to an ill-formed
XHTML document.

Here is the patch, hope it helps:

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ae2d057..2c0b990 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3780,7 +3780,10 @@ sub git_search_grep_body {
                                my $trail = esc_html($3) || "";
                                $trail = chop_str($trail, 30, 10);
                                my $text = "$lead<span
class=\"match\">$match</span>$trail";
-                               print chop_str($text, 80, 5) . "<br/>\n";
+                               # Do not chop $text as match can be
long, and we don't want to
+                               # munge HTML tags!
+                               #print chop_str($text, 80, 5) . "<br/>\n";
+                               print $text . "<br/>\n";
                        }
                }
                print "</td>\n" .
-- 
1.5.4.1-dirty
