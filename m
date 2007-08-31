From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Fri, 31 Aug 2007 11:00:02 +1000
Message-ID: <ee77f5c20708301800s7fbaec17sa9a58b40826ff8a2@mail.gmail.com>
References: <20070831000149.GK1219@pasky.or.cz>
	 <ee77f5c20708301756k60b4d295j907da463af477982@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com, ltuikov@yahoo.com
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 31 03:00:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQuro-0006mq-Qz
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 03:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbXHaBAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 21:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754234AbXHaBAF
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 21:00:05 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:12289 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbXHaBAD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 21:00:03 -0400
Received: by rv-out-0910.google.com with SMTP id k20so289587rvb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 18:00:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dcz+j5Y894wdyZ6tkeUaowBD5cSqLt+us263qEi7b9/3NNMJuZNXOwqRAIp3XAl3j45TthExfCVanzgHi7+aLAmZqC1ZM4OL7QEqVg6MYlrVgVCpVKpaFym8f2uUcTY6dLQ/FSC4Op4UTmh1m4+25uuDpfMhCjs38EAMA5yK6/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NvrbHZS6bio6k6Yu4S2Vzvvl/j4IEst2la9P+HP8BCSEKRX5Ta921kEjjD0wiZJYgvXMjQ9I5ujpZqCScb+AcG0SxhBtEyqe0uYWk+C68r5rGBfxaoaQY/Q7/yuuRc7KOqioiOKSA1KMU+OaxI/N4X5my6lQxLhQg77PE7R2eCg=
Received: by 10.141.177.2 with SMTP id e2mr469008rvp.1188522002312;
        Thu, 30 Aug 2007 18:00:02 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Thu, 30 Aug 2007 18:00:02 -0700 (PDT)
In-Reply-To: <ee77f5c20708301756k60b4d295j907da463af477982@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57099>

On 31/08/2007, David Symonds <dsymonds@gmail.com> wrote:
> On 31/08/2007, Petr Baudis <pasky@suse.cz> wrote:
> >   Please feel encouraged to make random forks for your development
> > efforts, or push your random patches (preferrably just bugfixes,
> > something possibly controversial should be kept in safe containment like
> > a fork or separate branch) to the mob branch.
>
> Sorry, I'm still relatively new to git, and couldn't work out how to
> push to the mob branch, so it's inline below. It's fairly minor, just
> adding <span title="foo">..</span> around author names when they get
> abbreviated.

Darn, looks like I suck at copy-n-paste, too. Here's an unwrapped patch:


>From 37c85462393d3e83d83dbdc9362cd9ff7587574c Mon Sep 17 00:00:00 2001
From: David Symonds <dsymonds@gmail.com>
Date: Fri, 31 Aug 2007 10:49:53 +1000
Subject: [PATCH] gitweb: Provide title attributes for abbreviated author names.

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 gitweb/gitweb.perl |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b2bae1b..3112fd4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3461,9 +3461,15 @@ sub git_shortlog_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
+		my $author = chop_str($co{'author_name'}, 10);
+		if ($author ne $co{'author_name'}) {
+			$author = "<span title=\"$co{'author_name'}\">" .
esc_html($author) . "</span>";
+		} else {
+			$author = esc_html($author);
+		}
 		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n"
.
-		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) .
"</i></td>\n" .
+		      "<td><i>" . $author . "</i></td>\n" .
 		      "<td>";
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
@@ -3511,9 +3517,15 @@ sub git_history_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
+	# shortlog uses      chop_str($co{'author_name'}, 10)
+		my $author = chop_str($co{'author_name'}, 15, 3);
+		if ($author ne $co{'author_name'}) {
+			"<span title=\"$co{'author_name'}\">" . esc_html($author) . "</span>";
+		} else {
+			$author = esc_html($author);
+		}
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n"
.
-		      # shortlog uses      chop_str($co{'author_name'}, 10)
-		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 3)) .
"</i></td>\n" .
+		      "<td><i>" . $author . "</i></td>\n" .
 		      "<td>";
 		# originally git_history used chop_str($co{'title'}, 50)
 		print format_subject_html($co{'title'}, $co{'title_short'},
@@ -3667,8 +3679,14 @@ sub git_search_grep_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
+		my $author = chop_str($co{'author_name'}, 15, 5);
+		if ($author ne $co{'author_name'}) {
+			$author = "<span title=\"$co{'author_name'}\">" .
esc_html($author) . "</span>";
+		} else {
+			$author = esc_html($author);
+		}
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n"
.
-		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) .
"</i></td>\n" .
+		      "<td><i>" . $author . "</i></td>\n" .
 		      "<td>" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
-class => "list subject"},
 			       esc_html(chop_str($co{'title'}, 50)) . "<br/>");
@@ -5181,8 +5199,14 @@ sub git_search {
 						print "<tr class=\"light\">\n";
 					}
 					$alternate ^= 1;
+					my $author = chop_str($co{'author_name'}, 15, 5);
+					if ($author ne $co{'author_name'}) {
+						$author = "<span title=\"$co{'author_name'}\">" .
esc_html($author) . "</span>";
+					} else {
+						$author = esc_html($author);
+					}
 					print "<td
title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n"
.
-					      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5))
. "</i></td>\n" .
+					      "<td><i>" . $author . "</i></td>\n" .
 					      "<td>" .
 					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
 					              -class => "list subject"},
-- 
1.5.2.4
