From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH -1/3 (amend)] gitweb: Always call parse_date with timezone parameter
Date: Sat, 19 Mar 2011 23:53:55 +0100
Message-ID: <201103192353.56841.jnareb@gmail.com>
References: <4f21902cf5f72b30a96465cf911d13aa@localhost> <201103192318.45925.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 23:54:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q152B-0004hV-Jx
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 23:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041Ab1CSWyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 18:54:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41769 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab1CSWyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 18:54:05 -0400
Received: by wwa36 with SMTP id 36so6121414wwa.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 15:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=4gt97MoaPlQk5syuzCey2EZaSI1zEsB+Azac1lIhYR8=;
        b=rOpjDwFzTQ4KWtCR5wFnvMrjmLDu3sgOJXnE2wk9gnEf8XNxtWvwcjovHdcyaEsINy
         ZIg2DVTH+WtMVhZiAcZe512oSFlj36VAtoPq6jAWYLXqY1TFOKA3c02y7j/wrHqgU33J
         BpdxAojlet3p3Evqui8ba+LD7y+iP4IJzF8Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=N1ZPZ+9XZV8fd8dy3aLG40CRgE0J+Sz22L2+RRvD6N3z9GgUR1WL8bH3zduKa3lcst
         x1AGrlOA5JYJQM99D3YiJfXB5XX/tUIWJo++IZLPBiFS6YbTojgJd97GC35LK9uQcF81
         iegbREYIpBzpQcgGI2eTJydQM6tLE/M8cSEDc=
Received: by 10.216.131.230 with SMTP id m80mr2706489wei.48.1300575243180;
        Sat, 19 Mar 2011 15:54:03 -0700 (PDT)
Received: from [192.168.1.13] (abrz59.neoplus.adsl.tpnet.pl [83.8.119.59])
        by mx.google.com with ESMTPS id b54sm2061780wer.21.2011.03.19.15.54.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 15:54:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201103192318.45925.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169474>

Timezone is required to correctly set local time, which would be needed
for future 'localtime' feature.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I am very sorry, a typo snuck in in previous version

BTW. Kevin, when there is series of patches which are dependent on each
other and create together a logical whole, it is recommended to provide
cover letter for such "true series".

 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b04ab8c..16abd4c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4906,7 +4906,7 @@ sub git_log_body {
 		next if !%co;
 		my $commit = $co{'id'};
 		my $ref = format_ref_marker($refs, $commit);
-		my %ad = parse_date($co{'author_epoch'});
+		my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 		git_print_header_div('commit',
 		               "<span class=\"age\">$co{'age_string'}</span>" .
 		               esc_html($co{'title'}) . $ref,
@@ -7064,7 +7064,7 @@ sub git_feed {
 	if (defined($commitlist[0])) {
 		%latest_commit = %{$commitlist[0]};
 		my $latest_epoch = $latest_commit{'committer_epoch'};
-		%latest_date   = parse_date($latest_epoch);
+		%latest_date   = parse_date($latest_epoch, $latest_commit{'comitter_tz'});
 		my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
 		if (defined $if_modified) {
 			my $since;
@@ -7195,7 +7195,7 @@ XML
 		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
 			last;
 		}
-		my %cd = parse_date($co{'author_epoch'});
+		my %cd = parse_date($co{'author_epoch'}, $co{'author_tz'});
 
 		# get list of changed files
 		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-- 
1.7.3
