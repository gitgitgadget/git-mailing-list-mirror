From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH v3] gitweb: Better cutting matched string and its context
Date: Mon, 25 Feb 2008 21:07:57 +0100
Message-ID: <200802252107.59366.jnareb@gmail.com>
References: <200802222014.13205.jnareb@gmail.com> <20080224125920.24448.2179.stgit@localhost.localdomain> <7v8x19st7x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jean-Baptiste Quenot <jbq@caraldi.com>,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:08:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTjcz-0002xO-8q
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775AbYBYUII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 15:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbYBYUIH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:08:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:19737 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbYBYUIG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 15:08:06 -0500
Received: by ug-out-1314.google.com with SMTP id z38so943304ugc.16
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 12:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=9DaSLurPxz2iQhhWLYf0LcfTSXhZ03CIrP0Y7x0BH8c=;
        b=XuPFBA+MzWKkxICm1S4MeFgpSHka3g9JRIs/vYc74TwJTIv6+wCErz04Fq76dl95FkF0nzplGqN6QfD9zsxTK6r3j0Xu+YKxSOuLp9dFyneU+Aq9WxrBGeD+FftEMvilkq0akSAavYtvXAf/Vddrjk/+z5gm2LewJH0sdjyiaXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ogmrivc3CD0OL2rrM943W9MGXmf8zNG9/e9Bm4KYxsUlpSaNg5fJmWYCTOAfaBPVvKdUUjk4hoM9x2lNpxAi6uyXbISH0ijqcIMjORxed3V5AATItYVZft3sdn2ratjV/NR0rScv79d2ZWI3E1V10Sic3F5XaBGdH3B3eawBaZw=
Received: by 10.67.29.4 with SMTP id g4mr3700526ugj.82.1203970084061;
        Mon, 25 Feb 2008 12:08:04 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.199.10])
        by mx.google.com with ESMTPS id g30sm5974610ugd.54.2008.02.25.12.08.01
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Feb 2008 12:08:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8x19st7x.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75057>

On Mon, 25 Feb 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Make use of new feature of chop_str to better cut matched string and
>> its context in match info for searching commit messages (commit
>> search), as proposed by Junio C Hamano.  For example, if you are
>> looking for "very long ... and how" in the first paragraph of this message
>> (if it were all on a single line), you would now see:
>>
>>     ...st this with <<very long ... and how>> the actual out...
>>
>> instead of:
>>
>>     Could som... <<very long search stri...>> the actual out...
>>
>> (where <<something>> denotes emphasized / colored fragment).
> 
> This part needs rewritten; the first paragraph of what message is that?  

Ooops. Sorry about that. I have forgot to transport context when
doing copy'n'paste.

BTW. the example was subtly wrong: you can search _lines_, like grep,
you cannot search multiline.
 
> Also I think the subject is wrong.  Yes, it is adding an option
> to an internal subroutine but who cares?  The net effect the
> "gitweb" users see is that the way the grep result is shown
> differently, hopefully in a more understandable way, and that
> change is not _optional_ at all.

Below there is corrected commit message (rewritten to match code).

> The code looks easier to read than before, but I may be partial
> ;-)

Further improved, IMVHO.


BTW. I have queued 3-patch series further improving gitweb search,
to be sent soon...

.....................................................................
-- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Better cutting matched string and its context

Improve look of commit search output ('search' view) by better cutting
of matched string and its context in match info, as proposed by Junio
Hamano.  For example, if you are looking for "very long search string"
in the following line:

    Could somebody test this with very long search string, and see how

you would now see:

    ...this with <<very long ... string>>, and see...

instead of:

    Could som... <<very long search...>>, and see...

(where <<something>> denotes emphasized / colored fragment; matched
fragment to be more exact).


For this feature support for fourth [optional] parameter to chop_str
subroutine was added.  This fourth parameter is used to denote where
to cut string to make it shorter.  chop_str can now cut at the
beginning (from the _left_ side of the string), in the middle
(_center_ of the string), or at the end (from the _right_ side of
the string); cutting from right is the default:

  chop_str(somestring, len, slop, 'left')    ->  ' ...string'
  chop_str(somestring, len, slop, 'center')  ->  'som ... ing'
  chop_str(somestring, len, slop, 'right')   ->  'somestr... '

If you want to use default slop (default additional length), use undef
as value for third parameter to chop_str.

While at it, return from chop_str early if given string is so short
that chop_str couldn't shorten it.  Simplify also regexp used by
chop_str.  Make ellipsis (dots) stick to shortened fragment for
cutting at ends, to better see which part got shortened.

Simplify passing all arguments to chop_str in chop_and_escape_str
subroutine. This was needed to pass additional options to chop_str.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   73 ++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e8226b1..fc95e2c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -848,32 +848,73 @@ sub project_in_list {
 ## ----------------------------------------------------------------------
 ## HTML aware string manipulation
 
+# Try to chop given string on a word boundary between position
+# $len and $len+$add_len. If there is no word boundary there,
+# chop at $len+$add_len. Do not chop if chopped part plus ellipsis
+# (marking chopped part) would be longer than given string.
 sub chop_str {
 	my $str = shift;
 	my $len = shift;
 	my $add_len = shift || 10;
+	my $where = shift || 'right'; # 'left' | 'center' | 'right'
 
 	# allow only $len chars, but don't cut a word if it would fit in $add_len
 	# if it doesn't fit, cut it if it's still longer than the dots we would add
-	$str =~ m/^(.{0,$len}[^ \/\-_:\.@]{0,$add_len})(.*)/;
-	my $body = $1;
-	my $tail = $2;
-	if (length($tail) > 4) {
-		$tail = " ...";
-		$body =~ s/&[^;]*$//; # remove chopped character entities
+	# remove chopped character entities entirely
+
+	# when chopping in the middle, distribute $len into left and right part
+	# return early if chopping wouldn't make string shorter
+	if ($where eq 'center') {
+		return $str if ($len + 5 >= length($str)); # filler is length 5
+		$len = int($len/2);
+	} else {
+		return $str if ($len + 4 >= length($str)); # filler is length 4
+	}
+
+	# regexps: ending and beginning with word part up to $add_len
+	my $endre = qr/.{$len}\w{0,$add_len}/;
+	my $begre = qr/\w{0,$add_len}.{$len}/;
+
+	if ($where eq 'left') {
+		$str =~ m/^(.*?)($begre)$/;
+		my ($lead, $body) = ($1, $2);
+		if (length($lead) > 4) {
+			$body =~ s/^[^;]*;// if ($lead =~ m/&[^;]*$/);
+			$lead = " ...";
+		}
+		return "$lead$body";
+
+	} elsif ($where eq 'center') {
+		$str =~ m/^($endre)(.*)$/;
+		my ($left, $str)  = ($1, $2);
+		$str =~ m/^(.*?)($begre)$/;
+		my ($mid, $right) = ($1, $2);
+		if (length($mid) > 5) {
+			$left  =~ s/&[^;]*$//;
+			$right =~ s/^[^;]*;// if ($mid =~ m/&[^;]*$/);
+			$mid = " ... ";
+		}
+		return "$left$mid$right";
+
+	} else {
+		$str =~ m/^($endre)(.*)$/;
+		my $body = $1;
+		my $tail = $2;
+		if (length($tail) > 4) {
+			$body =~ s/&[^;]*$//;
+			$tail = "... ";
+		}
+		return "$body$tail";
 	}
-	return "$body$tail";
 }
 
 # takes the same arguments as chop_str, but also wraps a <span> around the
 # result with a title attribute if it does get chopped. Additionally, the
 # string is HTML-escaped.
 sub chop_and_escape_str {
-	my $str = shift;
-	my $len = shift;
-	my $add_len = shift || 10;
+	my ($str) = @_;
 
-	my $chopped = chop_str($str, $len, $add_len);
+	my $chopped = chop_str(@_);
 	if ($chopped eq $str) {
 		return esc_html($chopped);
 	} else {
@@ -3791,11 +3832,11 @@ sub git_search_grep_body {
 		foreach my $line (@$comment) {
 			if ($line =~ m/^(.*)($search_regexp)(.*)$/i) {
 				my ($lead, $match, $trail) = ($1, $2, $3);
-				$match = chop_str($match, 70, 5);       # in case match is very long
-				my $contextlen = int((80 - length($match))/2); # for the remainder
-				$contextlen = 30 if ($contextlen > 30); # but not too much
-				$lead  = chop_str($lead,  $contextlen, 10);
-				$trail = chop_str($trail, $contextlen, 10);
+				$match = chop_str($match, 70, 5, 'center');
+				my $contextlen = int((80 - length($match))/2);
+				$contextlen = 30 if ($contextlen > 30);
+				$lead  = chop_str($lead,  $contextlen, 10, 'left');
+				$trail = chop_str($trail, $contextlen, 10, 'right');
 
 				$lead  = esc_html($lead);
 				$match = esc_html($match);
-- 
1.5.4.2
