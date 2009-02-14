From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH v3] gitweb: fix wrong base URL when non-root DirectoryIndex
Date: Sat, 14 Feb 2009 11:04:34 +0100
Message-ID: <200902141104.35042.jnareb@gmail.com>
References: <200902122303.37499.jnareb@gmail.com> <7vskmh3gtv.fsf@gitster.siamese.dyndns.org> <200902140342.26270.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 11:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYHPd-0002MK-KM
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 11:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbZBNKEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 05:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbZBNKEv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 05:04:51 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:51299 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbZBNKEu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 05:04:50 -0500
Received: by fk-out-0910.google.com with SMTP id f33so767518fkf.5
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 02:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZRFUMGjY7Mn7Z7IJO+vMcn3BuvYq0BKUBdSYK9599Bc=;
        b=vNzJ8h1AWQC3J1r+XkDCpPDLvgqNypiIIw88WmG+J1Mbn/bKljMpIS7JC5FaQcerUx
         41zP+VMGL82+8PW06cw3TnkivNv+w5ERdpBa4sPncxhWvpo6ro+yHTVM2NKJIZUfzj1B
         81zHGE5NAiQFlrs+KV16iTSnzZEdoaag6y3Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=azeJaisFbXD34sGxXqQ1URECqIAnPsMCqyUopO4UMB5he5WaS3XcFn0nTWhqMGWq/i
         UfXQNQWcJy367ZMlPod/+6Puz+WaEKaBns2iLLbvwZSqa9HzxMTZIC+9tR3ynuDHvWri
         9eHAzK+NKuZ80pxIUG4kjnAxn+UCSXXvposy8=
Received: by 10.103.165.18 with SMTP id s18mr1842715muo.124.1234605887908;
        Sat, 14 Feb 2009 02:04:47 -0800 (PST)
Received: from ?192.168.1.13? (abwj21.neoplus.adsl.tpnet.pl [83.8.233.21])
        by mx.google.com with ESMTPS id s10sm4190403mue.46.2009.02.14.02.04.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Feb 2009 02:04:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200902140342.26270.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109855>

From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

CGI::url() has some issues when rebuilding the script URL if the script
is a DirectoryIndex.

One of these issue is the inability to strip PATH_INFO, which is why
we had to do it ourselves.

Another issue is that the resulting URL cannot be used for the <base>
tag: it works if we're the DirectoryIndex at the root level, but not
otherwise.

We fix this by building the proper base URL ourselves, and improve the
comment about the need to strip PATH_INFO manually while we're at it.

Additionally t/t9500-gitweb-standalone-no-errors.sh had to be modified
to set SCRIPT_NAME variable (CGI standard states that it MUST be set,
and now gitweb uses it if PATH_INFO is not empty, as is the case for
some of tests in t9500).

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Sat, 14 Feb 2009, Jakub Narebski wrote:

> So patch should be squashed with the following improvement to test
> suite:
[...]

Here it is. (And with [PATCH v3] :-)).

Additionally I tried to make it more robust, first by constructing
$base_url _only_ when needed (when we strip PATH_INFO), and second
by checking if SCRIPT_NAME is defined.

Passes test (after its modification), but not testes itself!

P.S. I wonder why Giuseppe's patch failed to apply, and failed
to do fallback 3-way merge...

  Applying: gitweb: fix wrong base URL when non-root DirectoryIndex
  error: patch failed: gitweb/gitweb.perl:2908
  error: gitweb/gitweb.perl: patch does not apply
  fatal: sha1 information is lacking or useless (gitweb/gitweb.perl).
  Repository lacks necessary blobs to fall back on 3-way merge.
  Cannot fall back to three-way merge.
  Patch failed at 0001.

On top of v1.6.2-rc0-64-ge9cc02f, gitweb/gitweb.perl is 54108742...

 gitweb/gitweb.perl                     |   28 ++++++++++++++++++++++------
 t/t9500-gitweb-standalone-no-errors.sh |    6 ++++--
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5410874..83c2ad7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -27,13 +27,29 @@ our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 
-# if we're called with PATH_INFO, we have to strip that
-# from the URL to find our real URL
-# we make $path_info global because it's also used later on
+# Base URL for relative URLs in gitweb ($logo, $favicon, ...),
+# needed and used only for URLs with nonempty PATH_INFO
+our $base_url = $my_url;
+
+# When the script is used as DirectoryIndex, the URL does not contain the name
+# of the script file itself, and $cgi->url() fails to strip PATH_INFO, so we
+# have to do it ourselves. We make $path_info global because it's also used
+# later on.
+#
+# Another issue with the script being the DirectoryIndex is that the resulting
+# $my_url data is not the full script URL: this is good, because we want
+# generated links to keep implying the script name if it wasn't explicitly
+# indicated in the URL we're handling, but it means that $my_url cannot be used
+# as base URL.
+# Therefore, if we needed to strip PATH_INFO, then we know that we have
+# to build the base URL ourselves:
 our $path_info = $ENV{"PATH_INFO"};
 if ($path_info) {
-	$my_url =~ s,\Q$path_info\E$,,;
-	$my_uri =~ s,\Q$path_info\E$,,;
+	if (($my_url =~ s,\Q$path_info\E$,,  ||
+	     $my_uri =~ s,\Q$path_info\E$,,) &&
+	    defined $ENV{'SCRIPT_NAME'}) {
+		$base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
+	}
 }
 
 # core git executable to use
@@ -2908,7 +2924,7 @@ EOF
 	# the stylesheet, favicon etc urls won't work correctly with path_info
 	# unless we set the appropriate base URL
 	if ($ENV{'PATH_INFO'}) {
-		print '<base href="'.esc_url($my_url).'" />\n';
+		print '<base href="'.esc_url($base_url).'" />\n';
 	}
 	# print out each stylesheet that exist, providing backwards capability
 	# for those people who defined $stylesheet in a config file
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 43cd6ee..7c6f70b 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -43,9 +43,11 @@ gitweb_run () {
 	GATEWAY_INTERFACE="CGI/1.1"
 	HTTP_ACCEPT="*/*"
 	REQUEST_METHOD="GET"
+	SCRIPT_NAME="$TEST_DIRECTORY/../gitweb/gitweb.perl"
 	QUERY_STRING=""$1""
 	PATH_INFO=""$2""
-	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD QUERY_STRING PATH_INFO
+	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
+		SCRIPT_NAME QUERY_STRING PATH_INFO
 
 	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
 	export GITWEB_CONFIG
@@ -54,7 +56,7 @@ gitweb_run () {
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings
 	rm -f gitweb.log &&
-	perl -- "$TEST_DIRECTORY/../gitweb/gitweb.perl" \
+	perl -- "$SCRIPT_NAME" \
 		>/dev/null 2>gitweb.log &&
 	if grep "^[[]" gitweb.log >/dev/null 2>&1; then false; else true; fi
 
-- 
1.6.1
