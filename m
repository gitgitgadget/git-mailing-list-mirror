From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack.packSizeLimit, safety checks
Date: Wed, 03 Feb 2010 18:14:03 -0800
Message-ID: <7v1vh1zr10.fsf@alter.siamese.dyndns.org>
References: <loom.20100201T101056-232@post.gmane.org>
 <alpine.LFD.2.00.1002011100550.1681@xanadu.home>
 <7vvdeg50x4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002011240510.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 03:14:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcrEb-0004XJ-2p
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 03:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757828Ab0BDCOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 21:14:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002Ab0BDCOO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 21:14:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47AAA965BA;
	Wed,  3 Feb 2010 21:14:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZC9ok1WPHnq8ox28NvThISJPFU4=; b=RZd/sr
	l6CF0jvdg+8YoskDiP4jYFr13ifuwaCZ/hnEGjMGigTJh4fesgECjmUTfGkp0u+4
	ijygcY2bAhUpZNhmvhTImqsPj6ZzhdcE0jXgXrQK8a240vgMB2buUsCdNGNe8kls
	wYAMNX6D6Hu/5y863dq+zQKQ6lbIbQeKpfJwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AaN/ioxHOkwqFmk+u0GIua3d8YXF0pe0
	YXuTi6N9CpOu1rrsEZqUVsidbkQ8XM3iKlwTi5zs6Lz/5ngYLA4GleNJAPaNbqHN
	hNhFeZlYnEpguzyYgjRt0Lg+PgX2Jy13FiTX787HfwjjrCThcN1RU558ESi9ZtMj
	OOu7EZ30uVE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1638A965B6;
	Wed,  3 Feb 2010 21:14:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04BDC965AD; Wed,  3 Feb
 2010 21:14:04 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002011240510.1681@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 01 Feb 2010 13\:04\:35 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FAF22154-1132-11DF-B83A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138933>

Nicolas Pitre <nico@fluxnic.net> writes:

> Thing is... I don't know if the --max-pack-size argument is really that 
> used.  I'd expect people relying on that feature to use the config 
> variable instead,...

I suspect one of us need to be careful not to forget this thing...

-- >8 --
Subject: pack-objects --max-pack-size=<n> counts in bytes

The --window-memory argument and pack.packsizelimit configuration used by
the same program counted in bytes and honored the standard k/m/g suffixes.
Make this option do the same for consistency.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes-1.7.0.txt   |    6 ++++++
 Documentation/git-pack-objects.txt |    3 ++-
 builtin-pack-objects.c             |    7 +++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes-1.7.0.txt b/Documentation/RelNotes-1.7.0.txt
index 323ae54..adf8824 100644
--- a/Documentation/RelNotes-1.7.0.txt
+++ b/Documentation/RelNotes-1.7.0.txt
@@ -46,6 +46,12 @@ Notes on behaviour change
    environment, and diff.*.command and diff.*.textconv in the config
    file.
 
+ * "git pack-objects --max-pack-size=<n>" used to count in megabytes,
+   which was inconsistent with its corresponding configuration
+   variable and other options the command takes.  Now it counts in bytes
+   and allows standard k/m/g suffixes to be given.
+
+
 Updates since v1.6.6
 --------------------
 
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 097a147..fdaf775 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -106,7 +106,8 @@ base-name::
 	default.
 
 --max-pack-size=<n>::
-	Maximum size of each output packfile, expressed in MiB.
+	Maximum size of each output packfile, expressed in bytes.  The
+	size can be suffixed with "k", "m", or "g".
 	If specified,  multiple packfiles may be created.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4a41547..33e11d7 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2203,11 +2203,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!prefixcmp(arg, "--max-pack-size=")) {
-			char *end;
-			pack_size_limit_cfg = 0;
-			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
-			if (!arg[16] || *end)
+			unsigned long ul = 0;
+			if (!git_parse_ulong(arg + 16, &ul))
 				usage(pack_usage);
+			pack_size_limit_cfg = ul;
 			continue;
 		}
 		if (!prefixcmp(arg, "--window=")) {
