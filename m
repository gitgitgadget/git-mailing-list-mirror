From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (backport for warthog9/gitweb.git)] gitweb: Separate search regexp from search text
Date: Thu, 30 Apr 2009 12:17:25 +0200
Message-ID: <200904301217.27154.jnareb@gmail.com>
References: <337ECD47-D343-40F2-9E41-9E7D8531C5DF@aepfle.de> <200904292136.36987.jnareb@gmail.com> <49F8DEB4.40909@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Olaf Hering <olaf@aepfle.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 12:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzTKo-0001F9-DF
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 12:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbZD3KRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 06:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZD3KRf
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 06:17:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:47275 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbZD3KRe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 06:17:34 -0400
Received: by yw-out-2324.google.com with SMTP id 5so992886ywb.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=x8U7mxMrHK881IyE1P5HZk7QE4G3q4Har/ujYU9KTX0=;
        b=UW1PD6raWW+ZEXM9n8cFFbsXNMjzBcEiUoi00vKPug43IxhFrrd/FCWDVTfuRbV0ml
         bikuA3q38N9aoYmxmMf1CgF4nLrCsWhoFjFRsNlBWy2jlkH6jD5fCv6geJ4VSpAP1ZMj
         +RfjgN7HhR9nq47xlJuO8A8wdYZH3z8sJMFww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AOvn5+0tguw4wE6cv3fLo3NvFf8wgKohtnEGFs2YQ+dCqWf8+YTIQLxwT8vA3wt8zq
         L3xkxMv5G+APSIpbQ0NyOiU+aagyMdTk+I//MQHR1ugDI1mT7fCC4sbeUp+hRtZdRujD
         9viFbglSfmphwt7JUvxdX2d3fo4w63Fp78XPc=
Received: by 10.90.75.13 with SMTP id x13mr1107277aga.71.1241086653661;
        Thu, 30 Apr 2009 03:17:33 -0700 (PDT)
Received: from ?192.168.1.13? (abwf75.neoplus.adsl.tpnet.pl [83.8.229.75])
        by mx.google.com with ESMTPS id 39sm3329479agb.31.2009.04.30.03.17.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Apr 2009 03:17:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <49F8DEB4.40909@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118012>

Separate search text, which is saved in $searchtext global variable,
and is used in links, as default value for the textfield in search
form, and for pickaxe search, from search regexp, which is saved in
$search_regexp global variable, and is used as parameter to --grep,
--committer or --author options to git-rev-list, and for searching
commit body in gitweb.  For now $search_regexp is unconditionally
equal to quotemeta($searchtext), meaning that we always search for
fixed string.

This fixes bug where 'next page' links for 'search' view didn't work
for searchtext containing quotable characters, like `@'.

(manually cherry picked from 7e431ef9ab933d7ff899a999e40627ab49774f3a)

Olaf Hering noticed that this bug was still present, and this bugfix
was not ported to kernel.org's fork of gitweb.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Thu, 30 Apr 2009, J.H. wrote:
> Jakub Narebski wrote:
 
> > I have just checked that current gitweb (1.6.2.rc1.20.g8c5b)
> > does not have this bug...
[...]
> > ... so J.H., or Lea Wiemann, or whoever manages gitweb on kernel.org
> > should backport this fix to kernel.org's fork of gitweb sources.
> 
> Patches, as always, are welcome - I've got a few queued up already, but 
> if I have to do it I won't be getting back around to it for a bit (there 
> are other things on my priority list right now).

Here you have backport of 7e431ef (gitweb: Separate search regexp from 
search text) on top of 'master' branch of kernel.org's fork of gitweb:
  git://git.kernel.org/pub/scm/git/warthog9/gitweb.git

The only difference is that git_search_grep_body is in separate
gitweb/gitweb/search.pm file in kernel.org's fork.  The change
is otherwise identical.

Not tested!

 gitweb/gitweb.perl      |    5 +++--
 gitweb/gitweb/search.pm |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 984161c..aee9239 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -231,6 +231,7 @@ if (defined $page) {
 }
 
 our $searchtext = $cgi->param('s');
+our $search_regexp;
 if (defined $searchtext) {
 	if ($searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
 		die_error(undef, "Invalid search parameter");
@@ -238,7 +239,7 @@ if (defined $searchtext) {
 	if (length($searchtext) < 2) {
 		die_error(undef, "At least two characters are required for search parameter");
 	}
-	$searchtext = quotemeta $searchtext;
+	$search_regexp = quotemeta $searchtext;
 }
 
 our $searchtype = $cgi->param('st');
@@ -1702,7 +1703,7 @@ sub git_search {
 		} elsif ($searchtype eq 'committer') {
 			$greptype = "--committer=";
 		}
-		$greptype .= $searchtext;
+		$greptype .= $search_regexp;
 		my @commitlist = parse_commits($hash, 101, (100 * $page), $greptype);
 
 		my $paging_nav = '';
diff --git a/gitweb/gitweb/search.pm b/gitweb/gitweb/search.pm
index f1aea0a..a381f4e 100644
--- a/gitweb/gitweb/search.pm
+++ b/gitweb/gitweb/search.pm
@@ -33,7 +33,7 @@ sub git_search_grep_body {
 				esc_html(chop_str($co{'title'}, 50)) . "<br/>");
 		my $comment = $co{'comment'};
 		foreach my $line (@$comment) {
-			if ($line =~ m/^(.*)($searchtext)(.*)$/i) {
+			if ($line =~ m/^(.*)($search_regexp)(.*)$/i) {
 				my $lead = esc_html($1) || "";
 				$lead = chop_str($lead, 30, 10);
 				my $match = esc_html($2) || "";
-- 
1.6.2
