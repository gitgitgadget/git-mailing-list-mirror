From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config
 options
Date: Thu, 02 Dec 2010 13:46:56 -0800
Message-ID: <7vtyivq23z.fsf@alter.siamese.dyndns.org>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net> <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com> <20101201160503.GB26120@burratino> <m3aakp4g5o.fsf@localhost.localdomain> <20101201163406.GD26120@burratino> <4CF67D36.9020908@drmicha.warpmail.net> <20101201175815.GB7774@sigill.intra.peff.net> <7vvd3duvfy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 22:47:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POGzo-00062q-FO
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 22:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938Ab0LBVrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 16:47:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab0LBVrO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 16:47:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A44F23CEC;
	Thu,  2 Dec 2010 16:47:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xdmXDAULp9+EHXaxN9iINDsN95Y=; b=I2LOUZ
	yLYbOoHaW9ZkTupqVbIjQyyRF67TJzL6bUun0Xw1hQEtIkcqkJ852GP70ttP72pq
	XGnrpspTpIWdbtyvgPXKY/o+IpmwP5AdUjXpfcIFYT+Dw/CDVPk693KV0uQzFTNl
	jJNr8PiuobeCYs+gIyAsWFxNsSPfOd+oDCoo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WlVHXYt6Lxp+t8FpEhtpYIwgFxcXaS9l
	FVyOaQzAPq8K9GmnA3fzScCPPTKfa/r6PtPalOalS40a0N/fRhfEoCDIj/Lbs4ya
	hNg21VlpTKemMlYcawUkRKn+h9oLWJy7Bzz6oRBWtn+3E7+vlOoigBgBJOU2JrTf
	BPhXUtj6xAU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14AAE3CE7;
	Thu,  2 Dec 2010 16:47:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3FE0A3CE3; Thu,  2 Dec 2010
 16:47:17 -0500 (EST)
In-Reply-To: <7vvd3duvfy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 01 Dec 2010 11\:47\:29 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C126170A-FE5D-11DF-B229-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162748>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> If there are short config options that work, though, we should probably
>> keep them. It surely can't be that hard for the perl code to accept both
>> "cvsimport.r" and "cvsimport.remote" for "-r" and
>> "cvsimport.generaterevisions" (or whatever) for "-R"?
>
> I'd agree.  The current parameter set we give to GetOptions is:
>
>     haivmkuo:d:p:r:C:z:s:M:P:A:S:L:R
>
> and I notice that we cannot sanely access A, M, P, R, S and their
> lowercase counterparts.
>
> It shouldn't be too hard to interpret the single letter options for the
> currently supported set but only for lowercase letters plus '-C <arg>' and
> '-L <arg>' (because there are no lowercase ones that crash with them), and
> give long config names to at least the ones inaccessible with the above.
>
> Wouldn't that give us a regression-free solution to the immediate problem
> at hand?
>
> Supporting long options on the command line, and giving long config name
> synonyms to the lowercase ones, would be a plus for consistency's sake,
> but that probably is a separate topic.

So here is an attempt to do that first step, taking the list of long names
from Jonathan's message earlier in the thread.  If we start giving set of
long options, long option names may come from a different table which
would likely to have names in the dashed form, so this code already
expects names with dashes, e.g. "track-revisions", and contracts them to
names for configuration files, e.g. "trackRevisions".

 git-cvsimport.perl   |   19 ++++++++++++++++++-
 t/t9600-cvsimport.sh |    7 +++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 2b07c72..8c916d9 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -89,6 +89,14 @@ sub write_author_info($) {
 }
 
 # convert getopts specs for use by git config
+my %longmap = (
+	'A:' => 'authors-file',
+	'M:' => 'merge-regex',
+	'P:' => undef,
+	'R' => 'track-revisions',
+	'S:' => 'ignore-paths',
+);
+
 sub read_repo_config {
 	# Split the string between characters, unless there is a ':'
 	# So "abc:de" becomes ["a", "b", "c:", "d", "e"]
@@ -98,8 +106,17 @@ sub read_repo_config {
 		$key =~ s/://g;
 		my $arg = 'git config';
 		$arg .= ' --bool' if ($o !~ /:$/);
-
-		chomp(my $tmp = `$arg --get cvsimport.$key`);
+		my $ckey = $key;
+
+		if (exists $longmap{$o}) {
+			# An uppercase option like -R cannot be
+			# expressed in the configuration, as the
+			# variable names are downcased.
+			$ckey = $longmap{$o};
+			next if (! defined $ckey);
+			$ckey =~ s/-//g;
+		}
+		chomp(my $tmp = `$arg --get cvsimport.$ckey`);
 		if ($tmp && !($arg =~ /--bool/ && $tmp eq 'false')) {
 			no strict 'refs';
 			my $opt_name = "opt_" . $key;
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index b572ce3..6ede84c 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -93,7 +93,8 @@ EOF
 test_expect_success 'update git module' '
 
 	cd module-git &&
-	git cvsimport -a -R -z 0 module &&
+	git config cvsimport.trackRevisions true &&
+	git cvsimport -a -z 0 module &&
 	git merge origin &&
 	cd .. &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna
@@ -122,7 +123,8 @@ test_expect_success 'cvsimport.module config works' '
 
 	cd module-git &&
 		git config cvsimport.module module &&
-		git cvsimport -a -R -z0 &&
+		git config cvsimport.trackRevisions true &&
+		git cvsimport -a -z0 &&
 		git merge origin &&
 	cd .. &&
 	test_cmp module-cvs/tick module-git/tick
@@ -142,6 +144,7 @@ test_expect_success 'import from a CVS working tree' '
 
 	$CVS co -d import-from-wt module &&
 	cd import-from-wt &&
+		git config cvsimport.trackRevisions false &&
 		git cvsimport -a -z0 &&
 		echo 1 >expect &&
 		git log -1 --pretty=format:%s%n >actual &&
