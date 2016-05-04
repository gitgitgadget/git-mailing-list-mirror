From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 04 May 2016 12:57:31 -0700
Message-ID: <xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
	<1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
	<1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
	<F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
	<5729DF25.7030503@ramsayjones.plus.com>
	<xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
	<xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
	<20160504192516.GD21259@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 21:57:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay2vj-0001MY-G6
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbcEDT5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:57:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752399AbcEDT5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:57:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0736E17695;
	Wed,  4 May 2016 15:57:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DAGbTUBCrPLCyYCzsmXps1KQi6M=; b=ltC+Ko
	g61poRoQKjZbkLRlghejtxpP22777/PlIn5SI1QF9kcTU+1ogKR8xKj4rXpVSbbK
	n8zgVJ/FzZr1+Mw4XjQPzcopoLxN121FWcgcPxys00B/5GckDQAiJBTii1kYt6OP
	/6pNw/0NpgIM76o53pj8/KdgGHmkZzPvcd75w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MaMLzPIN1E9IUnVNNYU0IiWZ2s3Fd4MA
	9Ntn7ffbNikwG9o9KIMOxjMO5em43BlJiwSmFcpDYDC6yZmzkEw37j8X5V5n4VMB
	vk75Y9i6mA09laSiZy5JNtO9WXAPNovzUgJddDvJSRZmpo5v2WTD6TbqcrBEl8uS
	lXRfCJ55sOM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1B2317694;
	Wed,  4 May 2016 15:57:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7069D17693;
	Wed,  4 May 2016 15:57:32 -0400 (EDT)
In-Reply-To: <20160504192516.GD21259@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 May 2016 15:25:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 706ED38A-1232-11E6-A5A0-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293578>

Jeff King <peff@peff.net> writes:

> Likewise, I think we could build the whole HTML source and then actually
> just look for broken links in it. But that script would probably end up
> looking similar to this one, with s/linkgit/href/. But it does more
> directly measure what we want, which is that the rendered doc is usable;

I debated about this myself, but chose to inspect the source
material, as that approach is easier to give actionable lint output
to the user that points out the file:lineno to be corrected.

> it would catch something like using "--" instead of "{litdd}".

That is true indeed.  With the "source" approach, that would indeed
be harder.

>> +#!/bin/sh
>> +
>> +git grep -l linkgit: Documentation/ |
>> +while read path
>> +do
>> +	perl -e '
>
> Is it worth just making this a perl script, rather than a shell script
> with a giant inline perl script? Perl is actually really good at doing
> that "grep" as it reads the file. :)

OK.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 4 May 2016 11:48:06 -0700
Subject: [PATCH v2] ci: validate "gitlink:" in documentation

It is easy to add incorrect "linkgit:<page>[<section>]" references
to our documentation suite.  Catch these common classes of errors:

 * Referring to Documentation/<page>.txt that does not exist.

 * Referring to a <page> outside the Git suite.  In general, <page>
   must begin with "git".

 * Listing the manual <section> incorrectly.  The first line of the
   Documentation/<page>.txt must end with "(<section>)".

with a new script "ci/lint-gitlink".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/lint-gitlink | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100755 ci/lint-gitlink

diff --git a/ci/lint-gitlink b/ci/lint-gitlink
new file mode 100755
index 0000000..bb73e89
--- /dev/null
+++ b/ci/lint-gitlink
@@ -0,0 +1,60 @@
+#!/usr/bin/perl
+
+use File::Find;
+
+my $found_errors = 0;
+
+sub report {
+	my ($where, $what, $error) = @_;
+	print "$where: $error: $what\n";
+	$found_errors = 1;
+}
+
+sub grab_section {
+	my ($page) = @_;
+	open my $fh, "<", "Documentation/$page.txt";
+	my $firstline = <$fh>;
+	chomp $firstline;
+	close $fh;
+	my ($section) = ($firstline =~ /.*\((\d)\)$/);
+	return $section;
+}
+
+sub lint {
+	my ($file) = @_;
+	open my $fh, "<", $file
+		or return;
+	while (<$fh>) {
+		my $where = "$file:$.";
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
+	close $fh;
+}
+
+sub lint_it {
+	lint($File::Find::name) if -f;
+}
+
+find({ wanted => \&lint_it, no_chdir => 1 }, "Documentation");
+
+exit $found_errors;
-- 
2.8.2-498-g6350fe8
