From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Mon, 30 Apr 2012 18:08:29 -0700
Message-ID: <7vy5pcd7xu.fsf@alter.siamese.dyndns.org>
References: <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
 <20120427082118.GA7257@dcvr.yhbt.net>
 <20120427082559.GC4023@login.drsnuggles.stderr.nl>
 <20120429082341.GA32664@dcvr.yhbt.net>
 <7vvckihyqm.fsf@alter.siamese.dyndns.org>
 <7vk40yhv5q.fsf@alter.siamese.dyndns.org>
 <20120430081939.GA27715@dcvr.yhbt.net>
 <7vipghgq9a.fsf@alter.siamese.dyndns.org>
 <20120430165315.GO4023@login.drsnuggles.stderr.nl>
 <20120430190200.GA27108@dcvr.yhbt.net>
 <20120430192016.GQ4023@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 01 03:08:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP1a1-0004Ga-35
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 03:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484Ab2EABId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 21:08:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35958 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757300Ab2EABIb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 21:08:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D21C7A17;
	Mon, 30 Apr 2012 21:08:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=997Hln06MRL5yWAcqRGT8xUhznw=; b=q3lS1X
	3TZhw2O/CbVG6bRB55M4gV9RNpfDQ0mSZ8rb9c51IqqXrEe83TRcFqOphClQd+dx
	NOsg3L4Q7kA+sjUJ4YnrIPtJkAp7CuH4DSUQHQqxkFoUUqbZ8b1ERGl2VoajZTfQ
	oniQPwc1scZI6aEA9JIffK8L84mFNDUX/bTgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w1biUdFGWrgWjBa/q2RkWEBfTQqTNGcX
	lwKsa9wq/u/I6+Orejf4hlMTClzzqCTPOp4p2LXNEPriXmlr3TCbuuPgerHqNuXA
	GKyiIgmCroOuLLXOq/h2gFkJkfXHoNCJS5kMYhN0yc5dQmMlrVqIKEz8POqWCFer
	pLuWQqwuRVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 530967A15;
	Mon, 30 Apr 2012 21:08:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9975C7A13; Mon, 30 Apr 2012
 21:08:30 -0400 (EDT)
In-Reply-To: <20120430192016.GQ4023@login.drsnuggles.stderr.nl> (Matthijs
 Kooijman's message of "Mon, 30 Apr 2012 21:20:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A5BE01C-932A-11E1-BA83-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196640>

Matthijs Kooijman <matthijs@stdin.nl> writes:

> Hi Eric,
>
>> > This does textual comparison, so 1.6.6 > 1.6.12. To do proper version
>> > comparison, I think the version numbers should be split into
>> > major/minor/revision and each be compared numerically.
>> 
>> Ah, thanks for the analysis, we were lucky in the past that all version
>> components only had a single character.
> Indeed. Note that this includes the released subversion versions. For
> example, the code contains this check:
>
>     $SVN::Core::VERSION le '1.5.4'
>
> and 1.5.10 < 1.5.4. Fortunately, 1.5.9 was the last release in the 1.5
> series, and no other checks compare against 1.6.x.
>
> If subversion would ever reach the 1.10.x version number, things would
> also start breaking.
>
>> I think the former is preferable for git.  Sort::Versions isn't used
>> anywhere else in git and I don't think it's widely installed.

Ok, something along the lines of this.  Perhaps instead of "compare_",
we may want to call it "require_", so that negative return maps naturally
to a failure.

diff --git a/git-svn.perl b/git-svn.perl
index 427da9e..4a2ec43 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -41,11 +41,28 @@ sub fatal (@) { print STDERR "@_\n"; exit 1 }
 # repository decides to close the connection which we expect to be kept alive.
 $SIG{PIPE} = 'IGNORE';
 
+# Given a dot separated version number, "subtract" it from
+# the SVN::Core::VERSION; non-negaitive return means the SVN::Core
+# is at least at the version the caller asked for.
+sub compare_svn_version {
+	my (@ours) = split(/\./, $SVN::Core::VERSION);
+	my (@theirs) = split(/\./, $_[0]);
+	my ($i, $diff);
+
+	for ($i = 0; $i < @ours && $i < @theirs; $i++) {
+		$diff = $ours[$i] - $theirs[$i];
+		return $diff if ($diff);
+	}
+	return 1 if ($i < @ours);
+	return -1 if ($i < @theirs);
+	return 0;
+}
+
 sub _req_svn {
 	require SVN::Core; # use()-ing this causes segfaults for me... *shrug*
 	require SVN::Ra;
 	require SVN::Delta;
-	if ($SVN::Core::VERSION lt '1.1.0') {
+	if (compare_svn_version('1.1.0') < 0) {
 		fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)";
 	}
 }
@@ -1474,7 +1491,7 @@ sub cmd_info {
 	}
 	::_req_svn();
 	$result .= "Repository UUID: $uuid\n" unless $diff_status eq "A" &&
-		($SVN::Core::VERSION le '1.5.4' || $file_type ne "dir");
+		(compare_svn_version('1.5.4') <= 0 || $file_type ne "dir");
 	$result .= "Revision: " . ($diff_status eq "A" ? 0 : $rev) . "\n";
 
 	$result .= "Node Kind: " .
@@ -5464,7 +5481,7 @@ sub _auth_providers () {
 
 	# earlier 1.6.x versions would segfault, and <= 1.5.x didn't have
 	# this function
-	if ($SVN::Core::VERSION gt '1.6.12') {
+	if (compare_svn_version('1.6.12') > 0) {
 		my $config = SVN::Core::config_get_config($config_dir);
 		my ($p, @a);
 		# config_get_config returns all config files from
@@ -5623,7 +5640,7 @@ sub get_log {
 	# drop it.  Therefore, the receiver callback passed to it
 	# is made aware of this limitation by being wrapped if
 	# the limit passed to is being wrapped.
-	if ($SVN::Core::VERSION le '1.2.0') {
+	if (compare_svn_version('1.2.0') <= 0) {
 		my $limit = splice(@args, 3, 1);
 		if ($limit > 0) {
 			my $receiver = pop @args;
@@ -5655,7 +5672,8 @@ sub trees_match {
 
 sub get_commit_editor {
 	my ($self, $log, $cb, $pool) = @_;
-	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
+	
+	my @lock = (compare_svn_version('1.2.0') >= 0) ? (undef, 0) : ();
 	$self->SUPER::get_commit_editor($log, $cb, @lock, $pool);
 }
 
@@ -5673,7 +5691,7 @@ sub gs_do_update {
 	my (@pc) = split m#/#, $path;
 	my $reporter = $self->do_update($rev_b, (@pc ? shift @pc : ''),
 	                                1, $editor, $pool);
-	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
+	my @lock = (compare_svn_version('1.2.0') >= 0) ? (undef) : ();
 
 	# Since we can't rely on svn_ra_reparent being available, we'll
 	# just have to do some magic with set_path to make it so
@@ -5723,7 +5741,7 @@ sub gs_do_switch {
 	$ra ||= $self;
 	$url_b = escape_url($url_b);
 	my $reporter = $ra->do_switch($rev_b, '', 1, $url_b, $editor, $pool);
-	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
+	my @lock = (compare_svn_version('1.2.0') >= 0) ? (undef) : ();
 	$reporter->set_path('', $rev_a, 0, @lock, $pool);
 	$reporter->finish_report($pool);
 
