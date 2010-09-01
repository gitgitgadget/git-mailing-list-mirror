From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] install-webdoc: quell diff output on stdout
Date: Wed, 01 Sep 2010 09:24:27 -0700
Message-ID: <7vzkw15t50.fsf@alter.siamese.dyndns.org>
References: <2730e927194a15f708ea4c5ffa72353f793f2ed4.1283353628.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 01 18:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqq7B-0000I8-8v
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 18:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab0IAQYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 12:24:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab0IAQYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 12:24:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 08297D29EB;
	Wed,  1 Sep 2010 12:24:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/S7n0slxguZCzQQ5+z6gRhFZtx4=; b=kyMNE/
	AiVO2D6p402roS6DNz/o6rz3pzJx8FqcXIv4XaHJ0LjxxmFoS9iDBRPcrFftt5H1
	ujYXJu46/N1K86LSpoC4VrQ/Fgway0C2csEp/GmBQ9uEaJuQ20uG3KBqBjXwUk7R
	hgUMPj4/nIpV1nqvN8XGfVWplaueTCZiIrb1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D/6FjJg8L+6p/NbOGDN5h6jrMB6S+ld/
	qlfRPLdC44+VrkKFGVrm5QL0Bdzk4GXODQVorQYYSuCylDId2871Xw0xMfiq1DVI
	s9pK671KMR6AiQvdYDl3bpafCWcNXNFdnxdu1KeGif4p/BCBxV0l1o+yY0/E4Zb/
	F9jo+2kK1JQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA0C0D29E9;
	Wed,  1 Sep 2010 12:24:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E3BCD29E8; Wed,  1 Sep
 2010 12:24:28 -0400 (EDT)
In-Reply-To: <2730e927194a15f708ea4c5ffa72353f793f2ed4.1283353628.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed\,  1 Sep 2010 17\:10\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 66A5582E-B5E5-11DF-A84C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155058>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When installing html-doc, install-webdoc.sh compares the installed html
> with the version to be installed using diff. Currently, the diff output
> fills up stdout.

As I've been using this output as the final sanity check on k.org
environment, I personally do not want to lose the output from that
particular diff.

When I push to the public repository, a hook is triggered to build and
install the documentation, sending its progress to a log file, and I have
a window open running "tail -f" on it.

Actually why don't we do the attached instead as the first step?

The timestamp that follows "Last updated " is formatted differently
depending on the version of AsciiDoc.  Looking at 4604fe56 on "html"
branch, you can see that AsciiDoc 7.0.2 used to give "02-Jul-2008 03:02:14
UTC" but AsciiDoc 8.2.5 gave "2008-09-19 06:33:25 UTC".  We haven't been
correctly filtering out phantom changes that result from only the build
date for some time now, it seems.

    Side note:

    How can you find the above easily?  Here is one way, if you run git
    with f506b8e (git log/diff: add -G<regexp> that greps in the patch
    text, 2010-08-23) currently parked in 'pu':

	git log -p -G"Last updated [0-9][0-9]-[A-Z][a-z][a-z]-" origin/html

 Documentation/install-webdoc.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
index 34d02a2..37e67d1 100755
--- a/Documentation/install-webdoc.sh
+++ b/Documentation/install-webdoc.sh
@@ -12,7 +12,7 @@ do
 	then
 		: did not match
 	elif test -f "$T/$h" &&
-	   $DIFF -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"
+		$DIFF -u -I'^Last updated ' "$T/$h" "$h"
 	then
 		:; # up to date
 	else
