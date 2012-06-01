From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT PULL] ext4 updates for 3.5
Date: Fri, 01 Jun 2012 11:55:13 -0700
Message-ID: <7v8vg63lri.fsf@alter.siamese.dyndns.org>
References: <E1SaTSI-0005UV-4B@tytso-glaptop.cam.corp.google.com>
 <CA+55aFwk8oYx8EKWdT=5cMTLK7RDz8GQdGmHk2KXwcCq+Bb8PA@mail.gmail.com>
 <CA+55aFwwfMTN=WGQGmFO7DYeBUOGA7V4_6XueQS4JAzeykwn3Q@mail.gmail.com>
 <20120601174336.GA15778@thunk.org>
 <CA+55aFxgZupkAotfjUuWcfwTzHDYg0Afezme62P17=EX2KN+UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ted Ts'o" <tytso@mit.edu>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 20:55:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaX0P-000249-6c
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 20:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965684Ab2FASzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 14:55:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933626Ab2FASzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 14:55:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D90C28DD1;
	Fri,  1 Jun 2012 14:55:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YkSySffQjcXMr5lQotfPfaOvUtA=; b=d5lEyf
	bo0dZ0k17EHB8BlgEOs9fQG+JpMnXG5uiiQratJ7fmVf1kJxbQ6RtrFckt61OEeh
	VKz8oug3HNYiihcOGHMtetFEui0zm0821HOSLSPxS1I00YAv0OFpPdmMDPALPvx7
	cwR2UDY7VbtnVOJymGCY75WAI9Rx/rlZTnd6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jb2eXF9JOQgWpz6OVjVlYUjk4Gb0Lt11
	geWMHRSIohZ6wapxShRYeba0zm5dNicU9kLwuX72cS4kUpqC0qUrm1FmJE1tDNSc
	Ps0EW5T7Jvem9vmohrkbirhIIWkzm526hdFdgcnGJ6xY0BJMhNrP79OPXaIEw2nE
	EcFP1qC6Ipc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE3448DD0;
	Fri,  1 Jun 2012 14:55:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A8B38DCD; Fri,  1 Jun 2012
 14:55:15 -0400 (EDT)
In-Reply-To: <CA+55aFxgZupkAotfjUuWcfwTzHDYg0Afezme62P17=EX2KN+UQ@mail.gmail.com> (Linus
 Torvalds's message of "Fri, 1 Jun 2012 10:56:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52DB1FBC-AC1B-11E1-B4A3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199011>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Apparently git request-pull is too damn smart for its own good, and
> will find the tags even when they aren't mentioned, making you think
> it made it to me. Bot it doesn't - so then I have to go search for
> them by hand.

Something like this, perhaps.

 git-request-pull.sh | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index e6438e2..5ca786e 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -57,9 +57,13 @@ headrev=$(git rev-parse --verify "$head"^0) || exit
 merge_base=$(git merge-base $baserev $headrev) ||
 die "fatal: No commits in common between $base and $head"
 
-# $head is the token given from the command line. If a ref with that
-# name exists at the remote and their values match, we should use it.
-# Otherwise find a ref that matches $headrev.
+# $head is the token given from the command line, and $tag_name, if
+# exists, is the tag we are going to show the commit information for.
+# If that tag exists at the remote and it points at the commit, use it.
+# Otherwise, if a branch with the same name as $head exists at the remote
+# and their values match, use that instead.
+#
+# Otherwise find a random ref that matches $headrev.
 find_matching_ref='
 	sub abbr {
 		my $ref = shift;
@@ -70,24 +74,29 @@ find_matching_ref='
 		}
 	}
 
-	my ($exact, $found);
+	my ($tagged, $branch, $found);
 	while (<STDIN>) {
 		my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
 		next unless ($sha1 eq $ARGV[1]);
 		$found = abbr($ref);
+		if ($deref) {
+			$tagged = $found;
+			last;
+		}
 		if ($ref =~ m|/\Q$ARGV[0]\E$|) {
 			$exact = $found;
-			last;
 		}
 	}
-	if ($exact) {
+	if ($tagged) {
+		print "$tagged\n";
+	} elsif ($exact) {
 		print "$exact\n";
 	} elsif ($found) {
 		print "$found\n";
 	}
 '
 
-ref=$(git ls-remote "$url" | perl -e "$find_matching_ref" "$head" "$headrev")
+ref=$(git ls-remote "$url" | perl -e "$find_matching_ref" "$head" "$headrev" "$tag_name")
 
 url=$(git ls-remote --get-url "$url")
 
