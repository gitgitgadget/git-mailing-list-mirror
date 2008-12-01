From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Detecting HEAD more reliably while cloning
Date: Sun, 30 Nov 2008 18:54:56 -0800
Message-ID: <7vzljgsiyn.fsf@gitster.siamese.dyndns.org>
References: <1228039053-31099-1-git-send-email-gitster@pobox.com>
 <1228039053-31099-2-git-send-email-gitster@pobox.com>
 <1228039053-31099-3-git-send-email-gitster@pobox.com>
 <1228039053-31099-4-git-send-email-gitster@pobox.com>
 <1228039053-31099-5-git-send-email-gitster@pobox.com>
 <1228039053-31099-6-git-send-email-gitster@pobox.com>
 <7vabbhttq0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 03:56:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6yy1-0000ER-G3
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 03:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbYLACz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 21:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbYLACz1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 21:55:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbYLACz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 21:55:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E0D6C17D58;
	Sun, 30 Nov 2008 21:55:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3538C17D85; Sun,
 30 Nov 2008 21:54:58 -0500 (EST)
In-Reply-To: <7vabbhttq0.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 30 Nov 2008 02:04:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7FD8B83E-BF53-11DD-A178-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101997>

Junio C Hamano <gitster@pobox.com> writes:

> You may have noticed that the new git-send-email reversed the order of six
> patch files (one cover and five patches) I gave from the command line.
> Please consider this series as a bug report ;-)
>
> I think the bug is that "pop @ARGV" should read "shift @ARGV" or something
> silly and trivial like that, but it is getting late, so I won't debug
> tonight.

Perhaps this is a good enough fix?  Very lightly tested.

-- >8 --
send-email: do not reverse the command line arguments

The loop picks elements from @ARGV one by one, sifts them into arguments
meant for format-patch and the script itself, and pushes them to @files
and @rev_list_opts arrays.  Pick elements from @ARGV starting at the
beginning using shift, instead of at the end using pop, as push appends
them to the end of the array.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git c/git-send-email.perl w/git-send-email.perl
index 7508f8f..45beb9c 100755
--- c/git-send-email.perl
+++ w/git-send-email.perl
@@ -421,7 +421,7 @@ EOF
 # Now that all the defaults are set, process the rest of the command line
 # arguments and collect up the files that need to be processed.
 my @rev_list_opts;
-while (my $f = pop @ARGV) {
+while (defined(my $f = shift @ARGV)) {
 	if ($f eq "--") {
 		push @rev_list_opts, "--", @ARGV;
 		@ARGV = ();
