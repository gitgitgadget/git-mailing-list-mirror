From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 04 May 2016 11:52:52 -0700
Message-ID: <xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
	<1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
	<1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
	<F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
	<5729DF25.7030503@ramsayjones.plus.com>
	<xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	peff@peff.net, Matthieu.Moy@grenoble-inp.fr, sbeller@google.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 20:53:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay1uv-0006hK-O1
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 20:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbcEDSw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 14:52:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750825AbcEDSwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 14:52:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 13F8017CD7;
	Wed,  4 May 2016 14:52:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HYeQ/yH2/AzyyzT9JIK7II2Ha6Y=; b=NGE1f3
	gzADqpCNIlli3A1k6DabzpOBS6Txf4T2HYv0RpC9uYR8n1pZw6+yppeNsJVo5UvE
	Xx52vmQVSalk27dJ56N+mf3xhCpKayuv5qQ7BLk9fItpbrDc8BNnu3nBC0DkDD3S
	LFldCDml+OPEWBm60tYuWUirkoxh172PVMcbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CnVsPxpH+BOuTjy544PiQm6amfMJCPfW
	R8lvz24HxtGr5VybI+f/GssjTpzxHkDxy2GDil5ikdv2w62mXoiI40Rn0CuAh68o
	vHBDxHkrSl2oxn4FCzRg0KK78mz0TfT5HIbB5nipROmw1m4Dy0TQauqkjBnJgVRE
	46UE2o2BXhQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AD0B17CD6;
	Wed,  4 May 2016 14:52:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A14117CD5;
	Wed,  4 May 2016 14:52:53 -0400 (EDT)
In-Reply-To: <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 May 2016 10:28:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6863EF08-1229-11E6-996A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293566>

Junio C Hamano <gitster@pobox.com> writes:

> I do not think there is any false positive above, so perhaps the
> checker script below can be used as the link checker we discussed?

-- >8 --
Subject: [PATCH] ci: validate "gitlink:" in documentation

It is easy to add incorrect "linkgit:<page>[<section>]" references
to our documentation suite.  Catch these common classes of errors:

 * Referring to Documentation/<page>.txt that does not exist.

 * Referring to a <page> outside the Git suite.  In general, <page>
   must begin with "git".

 * Listing the manual <section> incorrectly.  The first line of the
   Documentation/<page>.txt must end with "(<section>)".

with a new script ci/lint-gitlink.sh.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/lint-gitlink.sh | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100755 ci/lint-gitlink.sh

diff --git a/ci/lint-gitlink.sh b/ci/lint-gitlink.sh
new file mode 100755
index 0000000..2379626
--- /dev/null
+++ b/ci/lint-gitlink.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+git grep -l linkgit: Documentation/ |
+while read path
+do
+	perl -e '
+	sub report {
+		my ($where, $what, $error) = @_;
+		print "$where: $error: $what\n";
+	}
+
+	sub grab_section {
+		my ($page) = @_;
+		open my $fh, "<", "Documentation/$page.txt";
+		my $firstline = <$fh>;
+		chomp $firstline;
+		close $fh;
+		my ($section) = ($firstline =~ /.*\((\d)\)$/);
+		return $section;
+	}
+
+	while (<>) {
+		my $where = "$ARGV:$.";
+		while (s/linkgit:((.*?)\[(\d)\])//) {
+			my ($target, $page, $section) = ($1, $2, $3);
+
+			# De-AsciiDoc
+			$page =~ s/{litdd}/--/g;
+
+			if ($page !~ /^git/) {
+				report($where, $target, "nongit link");
+				next;
+			}
+			if (! -f "Documentation/$page.txt") {
+				report($where, $target, "no such source");
+				next;
+			}
+			$real_section = grab_section($page);
+			if ($real_section != $section) {
+				report($where, $target,
+					"wrong section (should be $real_section)");
+				next;
+			}
+		}
+	}
+	' "$path"
+done
-- 
2.8.2-498-g6350fe8
