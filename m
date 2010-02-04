From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fast-import: count --max-pack-size in bytes
Date: Thu, 04 Feb 2010 11:10:44 -0800
Message-ID: <7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
 <1265255308-20514-3-git-send-email-nico@fluxnic.net>
 <20100204040046.GR14799@spearce.org>
 <7v7hqtty38.fsf@alter.siamese.dyndns.org>
 <7vtytxexjl.fsf@alter.siamese.dyndns.org>
 <20100204172421.GA18548@spearce.org>
 <alpine.LFD.2.00.1002041249200.1681@xanadu.home>
 <20100204175918.GB18548@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:11:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd76a-0007aY-V2
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 20:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099Ab0BDTLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 14:11:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758093Ab0BDTK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 14:10:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E715C967DD;
	Thu,  4 Feb 2010 14:10:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HLAEz5fzZNgk2ChQdzaSDAVY6M0=; b=Z97rdR
	8LYthkGDwt5YddNxP7Z1ZT+DFab+8lq3Xr9plnZZbDETMACRTe8bMjKoUS2UHVPA
	Rrli9pGxWj/EjTZN5vFiLYlxjHRO+H7nGAlBakTJS2M6f9OILNGv6vPQcRrwW2ZE
	4U+V7rbDnlIpzNDgvQizbPbQ0Y30ti3MUXzCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rzTDnPfFFDodtiuvk+geiSyXGJa7ns++
	5eTPZKyRC/oOvsa/60sjdmTmPEP2rghbQ6NHtyZGmS/8ILT0c0GbaFJ3VpacwdZx
	ZA2jMchuvI/PIEiyZ+JYhjiuFaxaNjH9qfP8c3/HvW9AFr+eYU7h3ARIEgwi7lm9
	+Id5YkX47kY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B540C967D5;
	Thu,  4 Feb 2010 14:10:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB704967C2; Thu,  4 Feb
 2010 14:10:46 -0500 (EST)
In-Reply-To: <20100204175918.GB18548@spearce.org> (Shawn O. Pearce's message
 of "Thu\, 4 Feb 2010 09\:59\:18 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 022A96F2-11C1-11DF-95CF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138997>

Similar in spirit to 07cf0f2 (make --max-pack-size argument to 'git
pack-object' count in bytes, 2010-02-03) which made the option by the same
name to pack-objects, this counts the pack size limit in bytes.

In order not to cause havoc with people used to the previous megabyte
scale an integer smaller than 8092 is interpreted in megabytes but the
user gets a warning.  Also a minimum size of 1 MiB is enforced to avoid an
explosion of pack files.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---

 Ok, third-time lucky?  Knock wood...

 Documentation/RelNotes-1.7.0.txt  |    8 ++++----
 Documentation/git-fast-import.txt |    4 ++--
 fast-import.c                     |   17 +++++++++++------
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/RelNotes-1.7.0.txt b/Documentation/RelNotes-1.7.0.txt
index e66945c..255666f 100644
--- a/Documentation/RelNotes-1.7.0.txt
+++ b/Documentation/RelNotes-1.7.0.txt
@@ -46,10 +46,10 @@ Notes on behaviour change
    environment, and diff.*.command and diff.*.textconv in the config
    file.
 
- * The --max-pack-size argument to 'git repack' and 'git pack-objects' was
-   assuming the provided size to be expressed in MiB, unlike the
-   corresponding config variable and other similar options accepting a size
-   value.  It is now expecting a size expressed in bytes, with a possible
+ * The --max-pack-size argument to 'git repack', 'git pack-objects', and
+   'git fast-import' was assuming the provided size to be expressed in MiB,
+   unlike the corresponding config variable and other similar options accepting
+   a size value.  It is now expecting a size expressed in bytes, with a possible
    unit suffix of 'k', 'm', or 'g'.
 
 Updates since v1.6.6
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 2691114..6764ff1 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -44,8 +44,8 @@ OPTIONS
 	not contain the old commit).
 
 --max-pack-size=<n>::
-	Maximum size of each output packfile, expressed in MiB.
-	The default is 4096 (4 GiB) as that is the maximum allowed
+	Maximum size of each output packfile.
+	The default is 4 GiB as that is the maximum allowed
 	packfile size (due to file format limitations). Some
 	importers may wish to lower this, such as to ensure the
 	resulting packfiles fit on CDs.
diff --git a/fast-import.c b/fast-import.c
index a6730d0..b477dc6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2764,11 +2764,6 @@ static void option_date_format(const char *fmt)
 		die("unknown --date-format argument %s", fmt);
 }
 
-static void option_max_pack_size(const char *packsize)
-{
-	max_packsize = strtoumax(packsize, NULL, 0) * 1024 * 1024;
-}
-
 static void option_depth(const char *depth)
 {
 	max_depth = strtoul(depth, NULL, 0);
@@ -2798,7 +2793,17 @@ static void option_export_pack_edges(const char *edges)
 static int parse_one_option(const char *option)
 {
 	if (!prefixcmp(option, "max-pack-size=")) {
-		option_max_pack_size(option + 14);
+		unsigned long v;
+		if (!git_parse_ulong(option + 14, &v))
+			return 0;
+		if (v < 8192) {
+			warning("max-pack-size is now in bytes, assuming --max-pack-size=%lum", v);
+			v *= 1024 * 1024;
+		} else if (v < 1024 * 1024) {
+			warning("minimum max-pack-size is 1 MiB");
+			v = 1024 * 1024;
+		}
+		max_packsize = v;
 	} else if (!prefixcmp(option, "big-file-threshold=")) {
 		unsigned long v;
 		if (!git_parse_ulong(option + 19, &v))
-- 
1.7.0.rc1.199.g9253ab
