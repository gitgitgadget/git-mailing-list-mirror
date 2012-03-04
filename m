From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (for maint)] gitweb: Fix fixed string (non-regexp) project search
Date: Sun, 4 Mar 2012 10:35:02 +0100
Message-ID: <201203041035.03133.jnareb@gmail.com>
References: <20120228183919.26435.86795.stgit@localhost.localdomain> <7vwr72a6m6.fsf@alter.siamese.dyndns.org> <201203031156.00948.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 10:35:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S47qd-00010w-72
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 10:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab2CDJfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 04:35:16 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62445 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab2CDJfO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 04:35:14 -0500
Received: by eaaq12 with SMTP id q12so1059343eaa.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 01:35:12 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.17.132 as permitted sender) client-ip=10.213.17.132;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.17.132 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.17.132])
        by 10.213.17.132 with SMTP id s4mr1242515eba.207.1330853712987 (num_hops = 1);
        Sun, 04 Mar 2012 01:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=GCYXQ7rSqSutWtwt7q+R0fVGwvQQR3pBI0uo0A9uDKY=;
        b=zdX6kEzugFycLylSl+rsgl9Vx8NnbesHjBZqXR8adATJH08NC8IRFZFWg4vCDKYn4J
         OPeK6jFL9J3IhUqUBIAR/bPbOXwhdsPiUZudbLMFeJO8+W/+ahYsVETQ0ZQW2RdfTYUH
         mSSY4Q6uJhwyXaqnJRTKMQZZlmoPsZt65iIoZglFwgOK5pF9mK5+swRf71MkRNlrYa3H
         O96rcW+AfeasNhyZkC0c4tAqP5Sf1diqQkEMnOIIMswlNGdExXcD8SayQTQe0seSn4Dn
         kbIp9fUuilu/VF+kyOMF5p/SDL8m0F4m4GLXlpHn/mP75buFybjC12RbTrcGziYhYbg6
         +HzA==
Received: by 10.213.17.132 with SMTP id s4mr955014eba.207.1330853712908;
        Sun, 04 Mar 2012 01:35:12 -0800 (PST)
Received: from [192.168.1.13] (abwo57.neoplus.adsl.tpnet.pl. [83.8.238.57])
        by mx.google.com with ESMTPS id u9sm45695834eem.11.2012.03.04.01.35.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 01:35:11 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201203031156.00948.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192147>

On Sat, 3 Mar 2012, Jakub Narebski wrote:
> On Sat, 3 Mar 2012, Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> Use $search_regexp, where regex metacharacters are quoted, for
>>> searching projects list, rather than $searchtext, which contains
>>> original search term.
>>>
>>> Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>>> ---
>>> I think this bug was here from the very beginning of adding project
>>> search, i.e. from  v1.6.0.2-446-g0d1d154 (gitweb: Support for simple
>>> project search form, 2008-10-03)  which was present since 1.6.1
>>>
>>> On Fri, 2 Mar 2012, Ramsay Jones wrote:
>>> 
>>>> This patch solves the problem for me when using a regex search
>>>> (re checkbox checked), but *not* for a non-regex search.
>>>> 
>> 
>> This patch depends on the more recent changes than the regexp fix, no?  I
>> was hoping that we could merge the earlier fix for the regexp case to
>> older maintenance tracks later, but if we were going to do so, we would
>> want to do the same for a fix for fixed-string case.
> 
> The regexp and non-regexp bugs and fixes are different.
[...]
> The non-regexp project search bug was using $searchtext instead of
> $search_regexp as search regexp in gitweb.  The bug was present from
> the very addition of project search, namely commit 0d1d154 (gitweb:
> Support for simple project search form, 2008-10-03), which was present
> in v1.5.1 if I have checked correctly.  Unfortunately the fix affects
> code that was changed recently in a1e1b2d (gitweb: improve usability
> of projects search form, 2012-01-31); I'll try to come up with equivalent
> patch to 'maint' soon (if the current one does not apply, and I guess it
> doesn't).

And here is the patch for maint
-->8-- -------------------------------------------------------- -->8--
Subject: gitweb: Fix fixed string (non-regexp) project search

Use $search_regexp, where regex metacharacters are quoted, for
searching projects list, rather than $searchtext, which contains
original search term.

Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d5dbd64..e248792 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2968,11 +2968,11 @@ sub filter_forks_from_projects_list {
 # for 'descr_long' and 'ctags' to be filled
 sub search_projects_list {
 	my ($projlist, %opts) = @_;
-	my $tagfilter  = $opts{'tagfilter'};
-	my $searchtext = $opts{'searchtext'};
+	my $tagfilter = $opts{'tagfilter'};
+	my $search_re = $opts{'search_regexp'};
 
 	return @$projlist
-		unless ($tagfilter || $searchtext);
+		unless ($tagfilter || $search_re);
 
 	my @projects;
  PROJECT:
@@ -2984,10 +2984,10 @@ sub search_projects_list {
 				grep { lc($_) eq lc($tagfilter) } keys %{$pr->{'ctags'}};
 		}
 
-		if ($searchtext) {
+		if ($search_re) {
 			next unless
-				$pr->{'path'} =~ /$searchtext/ ||
-				$pr->{'descr_long'} =~ /$searchtext/;
+				$pr->{'path'} =~ /$search_re/ ||
+				$pr->{'descr_long'} =~ /$search_re/;
 		}
 
 		push @projects, $pr;
@@ -5290,9 +5290,11 @@ sub git_project_list_body {
 	@projects = fill_project_list_info(\@projects);
 	# searching projects require filling to be run before it
 	@projects = search_projects_list(\@projects,
-	                                 'searchtext' => $searchtext,
-	                                 'tagfilter'  => $tagfilter)
-		if ($tagfilter || $searchtext);
+	                                 'search_regexp' => $search_regexp,
+	                                 'tagfilter' => $tagfilter)
+		if ($tagfilter || $search_regexp);
+	# fill the rest
+	@projects = fill_project_list_info(\@projects);
 
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
-- 
1.7.9
