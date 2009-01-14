From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Fix nested links problem with ref markers
Date: Wed, 14 Jan 2009 01:17:37 +0100
Message-ID: <200901140117.38803.jnareb@gmail.com>
References: <200901120215.13668.jnareb@gmail.com> <200901130113.54517.jnareb@gmail.com> <cb7bb73a0901121659h7277c074ia73786b15d66b804@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 01:19:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMtTR-0004iF-MG
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 01:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941AbZANARo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 19:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756045AbZANARo
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 19:17:44 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:58329 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472AbZANARm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 19:17:42 -0500
Received: by ewy10 with SMTP id 10so365029ewy.13
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 16:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dVMt0jfipUELwIF7ocKyT5uSYcoOgab1njWHE/eh3vo=;
        b=J9ENqoO1H7OChHIT3wn+7TftW5qr5/f5O45H4bFjCCpxV/QF9yW1kVd6Eod8ih2JUk
         7LxCepJWNJ9j8W4PIfwSpEpmtNoEa93gKAtur/aro7JVRYTU8BpjpWEiUuhZdCPtx8Fi
         n0fw5gGuvHBWjqSB1ROfEku0Gy6hGZZRFVZ10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MOZQ5ySzIV05OoQuEdfyjX44i5k6+6+q2kYEUXJXD2AKl3sEYgZm/zsij8mvD77C76
         ft1PWuIgqnAxb6/VRSWt8bKpiYJ1ZtkaTu5AZpcBGmSx+ds32NfqeXg5ZceejmxbJ1XW
         hmMnhn/meOWNv5VRa/fxTIkA0WtiSmacRay+w=
Received: by 10.210.34.19 with SMTP id h19mr6661622ebh.132.1231892260447;
        Tue, 13 Jan 2009 16:17:40 -0800 (PST)
Received: from ?192.168.1.11? (abvd199.neoplus.adsl.tpnet.pl [83.8.201.199])
        by mx.google.com with ESMTPS id 10sm1918500eyd.56.2009.01.13.16.17.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jan 2009 16:17:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0901121659h7277c074ia73786b15d66b804@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105565>

On Tue, 13 Jan 2009, Giuseppe Bilotta wrote:
> On Mon, Jan 12, 2009 at 7:13 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Mon, 12 Jan 2009, Giuseppe Bilotta wrote:
>>> On Sun, Jan 11, 2009 at 8:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:

[...]
> Notice that nested links are actually valid *XML*. Indeed, I asked on
> www-style and they suggested leaving the problem as-is, serving as
> html+xml which is what we do.

But nested links are neither valid HTML nor valid XHTML.  This
restriction (no nested links) is IMVHO quite sensible, but IIRC
it simply cannot be expressed as pure XML restriction (DTD, XML Schema,
Relax-NG... perhaps Sablotron can express this restriction).

>>>>  * Revert 4afbaef (we lose feature, but how often used is it?)
>>>>  * Always use quirks mode, or check browser and use quirks mode if it
>>>>    would break layout
>>>>  * Use extra divs and links and CSS positioning to make layout which
>>>>    looks like current one, and behaves as current one, but is more
>>>>    complicated.
>>>
>>> I'm asking on #html, hopefully I'll get some interesting idea to try for this.
>>
>> I have found _a_ solution. Perhaps not the best one, but it works.
>> And IMHO gives / can give even better visual.
>>
>> Current version (line wrapped for better visibility):
[...]
>> Proposed code (line wrapped for better visibility, with CSS embedded,
>> which would change in final version of course). Only parts of style
>> related to positioning are shown.
>>  <div class="header">
>>  <a href="..." style="float: left; margin: 6px 1px 6px 8px;">GIT 1.6.1</a>
>>  <div style="float: left; margin: 6px 1px;">
>>    <span class="refs">
>>      <span class="tag indirect" title="tags/v1.6.1">
>>      <a href="...">v1.6.1</a>
>>      </span>
>>    </span>
>>  </div>
>>  <a href="..." style="display: block; padding: 6px 8px;">&nbsp;</a>
>>  </div>

[...]
>> What do you think?
> 
> The float thing was the second suggestion I was given on www-style.

What was the first suggestion? And what is www-style?

> Can you provide a patch I can apply to my tree for testing to see how
> it comes up?

Here it is. Note that CSS could be I think reduced. The size of
gitweb.perl changes is affected by changing calling convention for
git_print_header_html subroutine.

There is also strange artifact at least in Mozilla 1.17.2: if I hover
over ref marker, the subject (title) gets darker background. Curious...

-- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Date: Wed, 14 Jan 2009 01:07:30 +0100
Subject: [RFC/PATCH] gitweb: Fix nested links problem with ref markers

Now that ref markers are links, they create nested links which are not
allowed in HTML, and in strict mode in some browsers it causes layout
errors.

It fixes format_subject_html subroutine (used for example in
'shortlog' view) to put $extra (which currently is formatted ref
marker) outside "subject" link, as $extra can contain links and in
HTML links cannot be nested.

It changes calling convention of git_print_header_div (and accordingly
its calling sites) to provide $ref as separate argument, instead of
concatenating it and putting it in $title, and provides workaround so
links are not nested.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |   25 +++++++++++++++++++++-
 gitweb/gitweb.perl |   56 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index a01eac8..244eea2 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -76,23 +76,44 @@ div.page_body {
 	font-family: monospace;
 }
 
-div.title, a.title {
+div.title, a.block {
 	display: block;
 	padding: 6px 8px;
+	text-decoration: none;
+	background-color: #edece6;
+}
+
+div.title, a.title {
 	font-weight: bold;
 	background-color: #edece6;
 	text-decoration: none;
 	color: #000000;
 }
 
+div.header div.extra,
+div.header a.float {
+	float: left;
+	margin: 6px 1px;
+}
+
+div.header a.float {
+	margin: 6px 1px 6px 8px;
+}
+
 div.readme {
 	padding: 8px;
 }
 
-a.title:hover {
+a.block:hover,
+div.header:hover a.title {
 	background-color: #d9d8d1;
 }
 
+div.header a.title:hover {
+	background-color: #edece6; /* ??? */
+	text-decoration: underline;
+}
+
 div.title_text {
 	padding: 6px 0px;
 	border: solid #d9d8d1;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0ac84d1..9c192ba 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1408,6 +1408,7 @@ sub format_ref_marker {
 }
 
 # format, perhaps shortened and with markers, title line
+# $extra can contain links, and nested links are illegal in HTML
 sub format_subject_html {
 	my ($long, $short, $href, $extra) = @_;
 	$extra = '' unless defined($extra);
@@ -1415,10 +1416,10 @@ sub format_subject_html {
 	if (length($short) < length($long)) {
 		return $cgi->a({-href => $href, -class => "list subject",
 		                -title => to_utf8($long)},
-		       esc_html($short) . $extra);
+		       esc_html($short)) . $extra;
 	} else {
 		return $cgi->a({-href => $href, -class => "list subject"},
-		       esc_html($long)  . $extra);
+		       esc_html($long))  . $extra;
 	}
 }
 
@@ -3146,17 +3147,30 @@ sub format_paging_nav {
 ## functions printing or outputting HTML: div
 
 sub git_print_header_div {
-	my ($action, $title, $hash, $hash_base) = @_;
+	my ($action, $title, $ref, $hash, $hash_base) = @_;
 	my %args = ();
 
 	$args{'action'} = $action;
 	$args{'hash'} = $hash if $hash;
 	$args{'hash_base'} = $hash_base if $hash_base;
 
-	print "<div class=\"header\">\n" .
-	      $cgi->a({-href => href(%args), -class => "title"},
-	      $title ? $title : $action) .
-	      "\n</div>\n";
+	my $href = href(%args);
+	if ($ref) {
+		# $ref can contain links, and nested links are illegal in HTML
+		# that is why we do this trick (see also gitweb.css for style)
+		# of title text, ref markers and 'background' link
+		print "<div class=\"header\">\n" .
+		      $cgi->a({-href => $href, -class => "title float"},
+		              $title ? $title : $action) . "\n" .
+		      "<div class=\"extra\">\n$ref\n</div>\n" .
+		      $cgi->a({-href => $href, -class => "block"}, '&nbsp;') .
+		      "\n</div>\n"; # class="header"
+	} else {
+		print "<div class=\"header\">\n" .
+		      $cgi->a({-href => $href, -class => "title block"},
+		              $title ? $title : $action) .
+		      "\n</div>\n"; # class="header"
+	}
 }
 
 #sub git_print_authorship (\%) {
@@ -3781,7 +3795,7 @@ sub git_patchset_body {
 	while ($patch_line) {
 
 		# parse "git diff" header line
-		if ($patch_line =~ m/^diff --git (\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\"|[^ "]*) (.*)$/) {
+		if ($patch_line =~ m/^diff --git (\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\"|[^ \"]*) (.*)$/) {
 			# $1 is from_name, which we do not use
 			$to_name = unquote($2);
 			$to_name =~ s!^b/!!;
@@ -4523,7 +4537,7 @@ sub git_tag {
 		die_error(404, "Unknown tag object");
 	}
 
-	git_print_header_div('commit', esc_html($tag{'name'}), $hash);
+	git_print_header_div('commit', esc_html($tag{'name'}), undef, $hash);
 	print "<div class=\"title_text\">\n" .
 	      "<table class=\"object_header\">\n" .
 	      "<tr>\n" .
@@ -4591,7 +4605,7 @@ sub git_blame {
 		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
 		        "HEAD");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
+	git_print_header_div('commit', esc_html($co{'title'}), undef, $hash_base);
 	git_print_page_path($file_name, $ftype, $hash_base);
 
 	# page body
@@ -4797,7 +4811,7 @@ sub git_blob {
 				        "raw");
 		}
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
+		git_print_header_div('commit', esc_html($co{'title'}), undef, $hash_base);
 	} else {
 		print "<div class=\"page_nav\">\n" .
 		      "<br/><br/></div>\n" .
@@ -4870,7 +4884,7 @@ sub git_tree {
 			push @views_nav, $snapshot_links;
 		}
 		git_print_page_nav('tree','', $hash_base, undef, undef, join(' | ', @views_nav));
-		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
+		git_print_header_div('commit', esc_html($co{'title'}), $ref, $hash_base);
 	} else {
 		undef $hash_base;
 		print "<div class=\"page_nav\">\n";
@@ -5009,7 +5023,7 @@ sub git_log {
 		my %ad = parse_date($co{'author_epoch'});
 		git_print_header_div('commit',
 		               "<span class=\"age\">$co{'age_string'}</span>" .
-		               esc_html($co{'title'}) . $ref,
+		               esc_html($co{'title'}), $ref,
 		               $commit);
 		print "<div class=\"title_text\">\n" .
 		      "<div class=\"log_link\">\n" .
@@ -5097,9 +5111,9 @@ sub git_commit {
 	                   $formats_nav);
 
 	if (defined $co{'parent'}) {
-		git_print_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
+		git_print_header_div('commitdiff', esc_html($co{'title'}), $ref, $hash);
 	} else {
-		git_print_header_div('tree', esc_html($co{'title'}) . $ref, $co{'tree'}, $hash);
+		git_print_header_div('tree', esc_html($co{'title'}), $ref, $co{'tree'}, $hash);
 	}
 	print "<div class=\"title_text\">\n" .
 	      "<table class=\"object_header\">\n";
@@ -5292,7 +5306,7 @@ sub git_blobdiff {
 		git_header_html(undef, $expires);
 		if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-			git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
+			git_print_header_div('commit', esc_html($co{'title'}), undef, $hash_base);
 		} else {
 			print "<div class=\"page_nav\"><br/>$formats_nav<br/></div>\n";
 			print "<div class=\"title\">$hash vs $hash_parent</div>\n";
@@ -5462,7 +5476,7 @@ sub git_commitdiff {
 
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
-		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
+		git_print_header_div('commit', esc_html($co{'title'}), $ref, $hash);
 		git_print_authorship(\%co);
 		print "<div class=\"page_body\">\n";
 		if (@{$co{'comment'}} > 1) {
@@ -5579,7 +5593,7 @@ sub git_history {
 
 	git_header_html();
 	git_print_page_nav('history','', $hash_base,$co{'tree'},$hash_base, $paging_nav);
-	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
+	git_print_header_div('commit', esc_html($co{'title'}), undef, $hash_base);
 	git_print_page_path($file_name, $ftype, $hash_base);
 
 	git_history_body(\@commitlist, 0, 99,
@@ -5660,13 +5674,13 @@ sub git_search {
 		}
 
 		git_print_page_nav('','', $hash,$co{'tree'},$hash, $paging_nav);
-		git_print_header_div('commit', esc_html($co{'title'}), $hash);
+		git_print_header_div('commit', esc_html($co{'title'}), undef, $hash);
 		git_search_grep_body(\@commitlist, 0, 99, $next_link);
 	}
 
 	if ($searchtype eq 'pickaxe') {
 		git_print_page_nav('','', $hash,$co{'tree'},$hash);
-		git_print_header_div('commit', esc_html($co{'title'}), $hash);
+		git_print_header_div('commit', esc_html($co{'title'}), undef, $hash);
 
 		print "<table class=\"pickaxe search\">\n";
 		my $alternate = 1;
@@ -5735,7 +5749,7 @@ sub git_search {
 
 	if ($searchtype eq 'grep') {
 		git_print_page_nav('','', $hash,$co{'tree'},$hash);
-		git_print_header_div('commit', esc_html($co{'title'}), $hash);
+		git_print_header_div('commit', esc_html($co{'title'}), undef, $hash);
 
 		print "<table class=\"grep_search\">\n";
 		my $alternate = 1;
-- 
1.6.0.4
