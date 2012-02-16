From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/3] gitweb: Deal with HEAD pointing to unborn branch
 in "heads" view
Date: Thu, 16 Feb 2012 15:28:31 -0800
Message-ID: <7vsjiawe74.fsf@alter.siamese.dyndns.org>
References: <1329320203-20272-1-git-send-email-jnareb@gmail.com>
 <1329320203-20272-2-git-send-email-jnareb@gmail.com>
 <7vr4xuy12f.fsf@alter.siamese.dyndns.org>
 <201202162341.09712.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rajesh boyapati <boyapatisrajesh@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 00:28:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyAkp-0006XJ-BK
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 00:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab2BPX2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 18:28:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51907 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755561Ab2BPX2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 18:28:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 678BB6D64;
	Thu, 16 Feb 2012 18:28:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7ZCydToZiJQlToAEH2KozZfYmBQ=; b=fe/b5U
	SHV+XWvED/OjrH1esvC4v0qZppXqbOJ/jn0RmbGGUUNxlSTg0TR+8rFFhRH3MUf7
	8F8CPECVX5IcPEzi9t1B8r47Xl280jvgZPmjPK4FMbekkPUWRN8MMSJa/Wh/EMqB
	xDADTrUvK/otsuQ20DX7/Efp+N51wUa37F6rI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pKXJSrLtov6sDSDhFjPdAMOUyuwTsLEI
	UiD50gFrmyS9G4UCGpD6uNL1uBIyEokCUQo7bGNyhv7CoMRGEGrhFRr1VOvZNVKP
	w1Oh5NiL1QX8crIMvRdWFiYIH4VDpdnlkHZkCI3e2GfnXU29G6F6w1P8bgG4bwS7
	XiPrAyUWPfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E5E56D63;
	Thu, 16 Feb 2012 18:28:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 927926D62; Thu, 16 Feb 2012
 18:28:32 -0500 (EST)
In-Reply-To: <201202162341.09712.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu, 16 Feb 2012 23:41:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0AFBD2A-58F5-11E1-8988-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190922>

Jakub Narebski <jnareb@gmail.com> writes:

> On Thu, 16 Feb 2012, Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > Gitweb has problems if HEAD points to an unborn branch, with no
>> > commits on it yet, but there are other branches present (so it is not
>> > newly initialized repository).
>> 
>> It would be more readable if you rephrase the vague "has problems" with a
>> concrete description of what the problem is.
>
> Sorry about this.
>
> The problem is that gitweb would generate the following warning, writing
> it in web server logs:
>
>   Use of uninitialized value in string eq

When known and easily describable in a short paragraph, let's write both
the cause and the symptom together.

> Should I re-roll this patch with improved commit message?

I was following Peff's 4 step review process, and I was in step #1 (read
the log message---can I understand what this is about without looking at
the patch?), so I haven't reached the diff part of your message ;-)

You added "defined $head_at &&" to protect against the undef comparison
for all uses of $head and I do not see any $head that was left unconverted
by mistake, so the patch looks OK to me (at times I wish gitweb were
written in a language more strict than Perl so that a compiler can catch
such mistakes).

But after trying to write a reroll myself, I have to wonder what would
happen if you have two branches pointing at the same commit as the one at
HEAD.  Why isn't the use of current_head class controlled by comparison
between the name of the ref and the output from "symbolic-ref HEAD"?

-- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Date: Wed, 15 Feb 2012 16:36:41 +0100
Subject: [PATCH] gitweb: Fix "heads" view when there is no current branch

In a repository whose HEAD points to an unborn branch with no commits,
"heads" view and "summary" view (which shows what is shown in "heads"
view) compared the object names of commits at the tip of branches with the
output from "git rev-parse HEAD", which caused comparison of a string with
undef and resulted in a warning in the server log.

This can happen if non-bare repository (with default 'master' branch)
is updated not via committing but by other means like push to it, or
Gerrit.  It can happen also just after running "git checkout --orphan
<new branch>" but before creating any new commit on this branch.

Rewrite the comparison so that it also works when $head points at nothing;
in such a case, no branch can be "the current branch", add a test for it.

While at it rename local variable $head to $head_at, as it points to
current commit rather than current branch name (HEAD contents).

Reported-by: Rajesh Boyapati
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/gitweb.perl                     |    4 ++--
 t/t9500-gitweb-standalone-no-errors.sh |    9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3fc7380..af154c3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5633,7 +5633,7 @@ sub git_tags_body {
 
 sub git_heads_body {
 	# uses global variable $project
-	my ($headlist, $head, $from, $to, $extra) = @_;
+	my ($headlist, $head_at, $from, $to, $extra) = @_;
 	$from = 0 unless defined $from;
 	$to = $#{$headlist} if (!defined $to || $#{$headlist} < $to);
 
@@ -5642,7 +5642,7 @@ sub git_heads_body {
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $headlist->[$i];
 		my %ref = %$entry;
-		my $curr = $ref{'id'} eq $head;
+		my $curr = defined $head_at && $ref{'id'} eq $head_at;
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 0f771c6..81246a6 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -739,4 +739,13 @@ test_expect_success \
 	'echo "\$projects_list_group_categories = 1;" >>gitweb_config.perl &&
 	 gitweb_run'
 
+# ----------------------------------------------------------------------
+# unborn branches
+
+test_expect_success \
+	'unborn HEAD: "summary" page (with "heads" subview)' \
+	'git checkout orphan_branch || git checkout --orphan orphan_branch &&
+	 test_when_finished "git checkout master" &&
+	 gitweb_run "p=.git;a=summary"'
+
 test_done
-- 
1.7.9.1.236.gedc23
