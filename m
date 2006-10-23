From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/1] gitweb: Use fixed string for "next" link in commitdiff view
Date: Tue, 24 Oct 2006 00:08:08 +0200
Message-ID: <200610240008.08325.jnareb@gmail.com>
References: <200610230037.57183.jnareb@gmail.com> <7vd58k0wmx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 00:08:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc7xX-0004uF-Ju
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 00:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbWJWWHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 18:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbWJWWHs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 18:07:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:2680 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752037AbWJWWHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 18:07:47 -0400
Received: by nf-out-0910.google.com with SMTP id c2so2552489nfe
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 15:07:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=m1MU7oESBkGyX3qhjX56gbz/c8wW+Nj2HykXgtd08Cq0Sm5Cul9nN4EJsS8fplOtl1U2ihcEoATLcb8Pzp/hJDv+nYgy8dtwrPRPBJGuSGgNtkgipsHe1dDIE6wk66Snw+ebkmTCZ5jR+mZeHDht9sCh0J1bgpz0lQHFvEdHlxY=
Received: by 10.49.29.3 with SMTP id g3mr15379842nfj;
        Mon, 23 Oct 2006 15:07:45 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id i1sm2830409nfe.2006.10.23.15.07.44;
        Mon, 23 Oct 2006 15:07:44 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vd58k0wmx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29890>

Use fixed string instead of shortened SHA1 identifier of commit
as a name for "mext" link in commitdiff view.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Add a kind of "next" link in the bottom part of navigation bar for
>> "commitdiff" view.
>>
>> For commitdiff between two commits:
>>   (from: _commit_)
>> For commitdiff for one single parent commit:
>>   (parent: _commit_)
>> For commitdiff for one merge commit
>>   (merge: _commit_ _commit_ ...)
>> For commitdiff for root (parentless) commit
>>   (initial)
>> where _link_ denotes hyperlink. SHA1 is shortened to 7 characters on
>> display, everything is perhaps unnecessary esc_html on display.
> 
> Would it even be necessary to use any SHA-1 name in these cases,
> I wonder.  Would it make the page less useful if we replace all
> of the above _commit_ with a fixed string, say, "parent"?
> 
> I always hated gitweb diffs that prefix each filepair with their
> full 40-byte SHA-1 blob object names.  It just adds noise to the
> output without adding any meaningful information.

Here you have. I used patch on top of previous one instead of amending
previous patch because I think it is interesting to have this history
of this feature.

This patch doesn't add any functionality.


 gitweb/gitweb.perl |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4241d5c..255487d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3291,15 +3291,11 @@ sub git_commitdiff {
 
 		if (defined $hash_parent) {
 			# commitdiff with two commits given
-			my $hash_parent_short = $hash_parent;
-			if ($hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
-				$hash_parent_short = substr($hash_parent, 0, 7);
-			}
 			$formats_nav .=
-				' (from: ' .
+				' (' .
 				$cgi->a({-href => href(action=>"commitdiff",
 				                       hash=>$hash_parent)},
-				        esc_html($hash_parent_short)) .
+				        'from') .
 				')';
 		} elsif (!$co{'parent'}) {
 			# --root commitdiff
@@ -3307,19 +3303,19 @@ sub git_commitdiff {
 		} elsif (scalar @{$co{'parents'}} == 1) {
 			# single parent commit
 			$formats_nav .=
-				' (parent: ' .
+				' (' .
 				$cgi->a({-href => href(action=>"commitdiff",
 				                       hash=>$co{'parent'})},
-				        esc_html(substr($co{'parent'}, 0, 7))) .
+				        'parent') .
 				')';
 		} else {
 			# merge commit
 			$formats_nav .=
-				' (merge: ' .
+				' (' .
 				join(' ', map {
 					$cgi->a({-href => href(action=>"commitdiff",
 					                       hash=>$_)},
-					        esc_html(substr($_, 0, 7)));
+					        'parent');
 				} @{$co{'parents'}} ) .
 				')';
 		}
-- 
1.4.2.1
