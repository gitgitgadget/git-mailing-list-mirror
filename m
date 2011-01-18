From: Junio C Hamano <gitster@pobox.com>
Subject: Re*: [PATCH 1/3] t4034: bulk verify builtin word regex sanity
Date: Tue, 18 Jan 2011 10:00:57 -0800
Message-ID: <7voc7eks6e.fsf_-_@alter.siamese.dyndns.org>
References: <cover.1292688058.git.trast@student.ethz.ch>
 <854c8b6fa8a368bb34cc22d3fc948ae7136ed177.1292688058.git.trast@student.ethz.ch> <20110111214707.GA29133@burratino> <20110111214811.GB29133@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 19:01:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfFru-0005Mf-AH
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 19:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab1ARSBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 13:01:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab1ARSBP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 13:01:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 781892406;
	Tue, 18 Jan 2011 13:01:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JPida3TW8Sz81ruhuDHPEFUsUsc=; b=NBBuxx
	NBhPsx3DMliLLL9FgFJYFDIk42TP/ldLega23jufPhxeU+Im462RRilvAXT+E8m1
	5/C870YZu9gQPDrDHp21qCUlu+USoUoZCw8tqFrDfJ7M8KK73imrFdtrbskg4Saj
	618o7Do1JprM2yEujdeO/WGpTpq7FmE2H5R3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IpXWAubel4Gvx8cVa/O2e5UL0ble9LOb
	ztDOFK25Y0J2DP9KoQzQ1pTsYR6J8ihcV7N0szCnDFH4zjY56YETJ4XMcUTSoh8W
	3jyWgXNSwARzFtl3BdMa7JY/T/IHWFV7TA3gQ7yTOcH3jASwjdVa9xeM3ksfyZC9
	kqq8/9z8LzY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 197262401;
	Tue, 18 Jan 2011 13:01:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CDCA123F9; Tue, 18 Jan 2011
 13:01:43 -0500 (EST)
In-Reply-To: <20110111214811.GB29133@burratino> (Jonathan Nieder's message of
 "Tue\, 11 Jan 2011 15\:48\:11 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 07186396-232D-11E0-82D0-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165208>

Jonathan Nieder <jrnieder@gmail.com> writes:

> From: Thomas Rast <trast@student.ethz.ch>
> Date: Sat, 18 Dec 2010 17:17:54 +0100
>
> The builtin word regexes should be tested with some simple examples
> against simple issues.  Do this in bulk.

Thanks.

> diff --git a/t/t4034/bibtex/expect b/t/t4034/bibtex/expect
> new file mode 100644
> index 0000000..a157774
> --- /dev/null
> +++ b/t/t4034/bibtex/expect
> @@ -0,0 +1,15 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index 95cd55b..ddcba9b 100644<RESET>

Having to change this line every time the test input (or output) has
changed is somewhat unfortunate.

Also I noticed that "word_diff" shell function has this:

       test_must_fail git diff --no-index "$@" pre post >output &&

which solicits two comments:

 - We do not seem to document that --no-index implies --exit-code, ever
   since the latter option was introduced at 41bbf9d (Allow git-diff exit
   with codes similar to diff(1), 2007-03-14).  Probably we should.

 - This assumes that no test vector would have identical pre/post pair
   that expects no output, which feels somewhat limiting.

What we care about in this test is that "git diff --no-index" does not die
an uncontrolled death, so test_might_fail may be more appropriate.

Here is another that probably should be squashed to this patch together
with 3/3 to add tests for the perl driver (I noticed it only because 2/3
had trivial conflict due to recent addition of it).

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 18 Jan 2011 09:43:43 -0800
Subject: [PATCH] t4034 (diff --word-diff): add a minimum Perl drier test vector

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4034-diff-words.sh |    1 +
 t/t4034/perl/expect   |   13 +++++++++++++
 t/t4034/perl/post     |   22 ++++++++++++++++++++++
 t/t4034/perl/pre      |   22 ++++++++++++++++++++++
 4 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 t/t4034/perl/expect
 create mode 100644 t/t4034/perl/post
 create mode 100644 t/t4034/perl/pre

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index c3b1c48..37aeab0 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -301,6 +301,7 @@ test_language_driver html
 test_language_driver java
 test_language_driver objc
 test_language_driver pascal
+test_language_driver perl
 test_language_driver php
 test_language_driver python
 test_language_driver ruby
diff --git a/t/t4034/perl/expect b/t/t4034/perl/expect
new file mode 100644
index 0000000..a1deb6b
--- /dev/null
+++ b/t/t4034/perl/expect
@@ -0,0 +1,13 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index f6610d3..e8b72ef 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -4,8 +4,8 @@<RESET>
+
+package Frotz;<RESET>
+sub new {<RESET>
+	my <GREEN>(<RESET>$class<GREEN>, %opts)<RESET> = <RED>shift<RESET><GREEN>@_<RESET>;
+	return bless { <GREEN>xyzzy => "nitfol", %opts<RESET> }, $class;
+}<RESET>
+
+__END__<RESET>
diff --git a/t/t4034/perl/post b/t/t4034/perl/post
new file mode 100644
index 0000000..e8b72ef
--- /dev/null
+++ b/t/t4034/perl/post
@@ -0,0 +1,22 @@
+#!/usr/bin/perl
+
+use strict;
+
+package Frotz;
+sub new {
+	my ($class, %opts) = @_;
+	return bless { xyzzy => "nitfol", %opts }, $class;
+}
+
+__END__
+=head1 NAME
+
+frotz - Frotz
+
+=head1 SYNOPSIS
+
+  use frotz;
+
+  $nitfol = new Frotz();
+
+=cut
diff --git a/t/t4034/perl/pre b/t/t4034/perl/pre
new file mode 100644
index 0000000..f6610d3
--- /dev/null
+++ b/t/t4034/perl/pre
@@ -0,0 +1,22 @@
+#!/usr/bin/perl
+
+use strict;
+
+package Frotz;
+sub new {
+	my $class = shift;
+	return bless {}, $class;
+}
+
+__END__
+=head1 NAME
+
+frotz - Frotz
+
+=head1 SYNOPSIS
+
+  use frotz;
+
+  $nitfol = new Frotz();
+
+=cut
-- 
1.7.4.rc2.226.g63d9a
