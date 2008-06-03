From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH v2] gitweb: Add charset info to "raw" output of 'text/plain' blobs
Date: Tue, 3 Jun 2008 16:47:10 +0200
Message-ID: <200806031647.10982.jnareb@gmail.com>
References: <m3tzgg1a06.fsf@localhost.localdomain> <7vprr2fi5z.fsf@gitster.siamese.dyndns.org> <200806011306.45945.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jan Engelhardt <jengelh@medozas.de>,
	Lea Wiemann <lewiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 16:48:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Xo6-0003fP-I2
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 16:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbYFCOrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 10:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbYFCOrW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 10:47:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:47699 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbYFCOrU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 10:47:20 -0400
Received: by nf-out-0910.google.com with SMTP id d3so599730nfc.21
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=c+WgxZsUBUE1/JdB4NpdtTBsNA/aNF42lUiaQzSNz2M=;
        b=Ds4IKyw/srmpgtu2fYq0KwIF/5A6rY83xdkYyy+VGX8nj43VZv+9fVk+qslpI9bMUwMFMSTYq3eZpE0++0QACi1+p57s3/AidNJ+Au+ftfyWZpqvPuHbmbARwd/gu5UZxVSO6a6ouIEIpt3RRAV74NkC0cDBg3QX6KJpSfuMVHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cfPrX1A5JGBXx4100TRrUc6ychk0gaAIWeg1BWUjbfEkeG8plAByukXjal3ABhOY2S7a+IoKjyAD2xLkPBSxKbR2rUxgX0sWwAi5kxTO900EdXxlNb6+TeGpB3Ydn4hXUdBjYbIPA2zSGkaxtTw+4QH9pnOlHWuRXrCmS3NtSr0=
Received: by 10.86.79.19 with SMTP id c19mr7719867fgb.52.1212504437030;
        Tue, 03 Jun 2008 07:47:17 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id 3sm92174fge.3.2008.06.03.07.47.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 07:47:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200806011306.45945.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83670>

Earlier "blob_plain" view sent "charset=utf-8" only when gitweb
guessed the content type to be text by reading from it, and not when
the MIME type was obtained from /etc/mime.types, or when gitweb
couldn't guess mimetype and used $default_blob_plain_mimetype.

This fixes the bug by always add charset info from
$default_text_plain_charset (if it is defined) to "raw" (a=blob_plain)
output for 'text/plain' blobs.

Generating information for Content-Type: header got separated into
blob_contenttype() subroutine; adding charset info in a special case
was removed from blob_mimetype(), which now should return mimetype
only.


While at it cleanup code a bit: put subroutine parameter
initialization first, make error message more robust (when $file_name
is not defined) if more cryptic, remove unnecessary '"' around
variable ("$var" -> $var).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

On Sun, 1 June 2008, Jakub Narebski wrote:
> On Sat, 31 May 2008, Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> Always add charset info from $default_text_plain_charset (if it is
>>> defined) to "raw" (a=blob_plain) output for 'text/plain' blobs.
>>> Adding charset info in a special case was removed from blob_mimetype().
>> 
>> Looks Ok but it took a bit of digging on the list for me to figure out
>> that something like this was missing from the beginning of your commit log
>> message:
>> 
>> 	Earlier "blob_plain" view sent "charset=utf-8" only when gitweb
>> 	guessed the content type to be text by reading from it, and not
>> 	when the MIME type was obtained from /etc/mime.types.
>> 
>> 	This fixes the bug by always adding....
> 
> I'm sorry that I have forgot to put the "why" in commit message.
> I'd add this when resending v2 of this patch.

Added.

>> But I wonder if moving of this to the calling site is the right thing to
>> do.  Wouldn't it become much more contained and robust if you did it this
>> way?
> [...]
>>  sub blob_mimetype {
> 
> This _might_ be better.  I didn't do this for the following two reasons:
[...]
> So perhaps best of those ways would be to create thin wrapper subroutine,
> blob_contenttype($fd, $file_name, $mimetype), where both $file_name and
> (especially) $mimetype are optional parameters, and ise it in
> git_blob_plain() subroutine...

It is now done this way.  IMHO it is a best solution.

>> +	# Type specific postprocessing can be added as needed...
>> +	if ($mime =~ /^text\//i &&
>> +	    $mime !~ /charset=/i && $default_text_plain_charset) {
>> +		$mime .=  '; charset='.$default_text_plain_charset;
>> +	}
>> +
>> +	return $mime;
> 
> I'm not sure about it.  I worry a bit about text/html, which can, and
> usually do, contain charset info inside the document.  I'm not sure
> what happens when charset information from HTTP headers contradict
> charset information from presented file.  That's why I have limited
> adding charset info purely to 'text/plain', not 'text/*' without
> charset info already present.

Currently for the above reason gitweb adds charset info _only_
for 'text/plain' mimetype.

 gitweb/gitweb.perl |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 57a1905..c6d43bf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2481,8 +2481,7 @@ sub blob_mimetype {
 	return $default_blob_plain_mimetype unless $fd;
 
 	if (-T $fd) {
-		return 'text/plain' .
-		       ($default_text_plain_charset ? '; charset='.$default_text_plain_charset : '');
+		return 'text/plain';
 	} elsif (! $filename) {
 		return 'application/octet-stream';
 	} elsif ($filename =~ m/\.png$/i) {
@@ -2496,6 +2495,17 @@ sub blob_mimetype {
 	}
 }
 
+sub blob_contenttype {
+	my ($fd, $file_name, $type) = @_;
+
+	$type ||= blob_mimetype($fd, $file_name);
+	if ($type eq 'text/plain' && defined $default_text_plain_charset) {
+		$type .= "; charset=$default_text_plain_charset";
+	}
+
+	return $type;
+}
+
 ## ======================================================================
 ## functions printing HTML: header, footer, error page
 
@@ -4377,6 +4387,7 @@ sub git_heads {
 }
 
 sub git_blob_plain {
+	my $type = shift;
 	my $expires;
 
 	if (!defined $hash) {
@@ -4392,13 +4403,13 @@ sub git_blob_plain {
 		$expires = "+1d";
 	}
 
-	my $type = shift;
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
-		or die_error(undef, "Couldn't cat $file_name, $hash");
+		or die_error(undef, "Open git-cat-file blob '$hash' failed");
 
-	$type ||= blob_mimetype($fd, $file_name);
+	# content-type (can include charset)
+	$type = blob_contenttype($fd, $file_name, $type);
 
-	# save as filename, even when no $file_name is given
+	# "save as" filename, even when no $file_name is given
 	my $save_as = "$hash";
 	if (defined $file_name) {
 		$save_as = $file_name;
@@ -4407,9 +4418,9 @@ sub git_blob_plain {
 	}
 
 	print $cgi->header(
-		-type => "$type",
-		-expires=>$expires,
-		-content_disposition => 'inline; filename="' . "$save_as" . '"');
+		-type => $type,
+		-expires => $expires,
+		-content_disposition => 'inline; filename="' . $save_as . '"');
 	undef $/;
 	binmode STDOUT, ':raw';
 	print <$fd>;
-- 
1.5.5.3
