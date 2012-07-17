From: Michael G Schwern <schwern@pobox.com>
Subject: Extract Git classes from git-svn (10/10) (was Re: Fix git-svn tests
 for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 16:17:54 -0700
Message-ID: <5005F2A2.9040800@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:18:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrH1k-0000mb-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 01:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826Ab2GQXR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 19:17:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756346Ab2GQXRz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 19:17:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 056E88664;
	Tue, 17 Jul 2012 19:17:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=QZv+hIQhKRex
	+FPO0+I6UXkXmzY=; b=fhFz1Qd6MYj0pTq48Dte/dv5k50HoAn4Kw/dUaW1xSP7
	EHNgTnNRl/CFhKLMcHDxKg+c1yRsYNuA3oF7hiphsRQqfGGfHSYN2T//JPh7STYs
	CYbnK0RNR3LFF+mmqIQPlHseQcetwYlNzZMKeWgpa7+yn2KB392nYPYi+jXBc/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wDcNlE
	ieP2d8uB6JC5BDq+Tu0Xdq9ku1fwaQfbw0bUhWFwH8k0VuLsLwp4AO8KlmxSijCi
	vAOJREI2CXv53oB/DmZv5U5SQMHvYW6OE1fq58vApdGgfv0zbcgJatb/3xeUC3DR
	kI8eo4j5mxDJE50yP4H5w4vPZXDXLnBzdst+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6E558663;
	Tue, 17 Jul 2012 19:17:54 -0400 (EDT)
Received: from windhund.local (unknown [67.23.204.5]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FA1F8660; Tue, 17 Jul
 2012 19:17:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120717174446.GA14244@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: A3323B1C-D065-11E1-AC15-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201635>

>From 5152b76800f076ba0bd528664f62d3c67966fa4e Mon Sep 17 00:00:00 2001
From: "Michael G. Schwern" <schwern@pobox.com>
Date: Thu, 12 Jul 2012 17:25:25 -0700
Subject: [PATCH 11/11] Fix Git::SVN::GlobSpec so it works.

Only used in one place in Git::SVN, load it on demand.

That should be all the Git classes out of git-svn.
---
 perl/Git/SVN.pm          | 5 ++++-
 perl/Git/SVN/GlobSpec.pm | 1 +
 perl/Makefile            | 1 +
 t/Git-SVN/00compile.t    | 3 ++-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 02983d6..247ee1d 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -202,11 +202,14 @@ sub read_all_remotes {
 			    . "must start with 'refs/'\n")
 				unless $remote_ref =~ m{^refs/};
 			$local_ref = uri_decode($local_ref);
+
+			require Git::SVN::GlobSpec;
 			my $rs = {
 			    t => $t,
 			    remote => $remote,
 			    path => Git::SVN::GlobSpec->new($local_ref, 1),
-			    ref => Git::SVN::GlobSpec->new($remote_ref, 0) };
+			    ref => Git::SVN::GlobSpec->new($remote_ref, 0)
+			};
 			if (length($rs->{ref}->{right}) != 0) {
 				die "The '*' glob character must be the last ",
 				    "character of '$remote_ref'\n";
diff --git a/perl/Git/SVN/GlobSpec.pm b/perl/Git/SVN/GlobSpec.pm
index 96cfd98..fede3af 100644
--- a/perl/Git/SVN/GlobSpec.pm
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -1,4 +1,5 @@
 package Git::SVN::GlobSpec;
+
 use strict;
 use warnings;

diff --git a/perl/Makefile b/perl/Makefile
index 6c32918..aa4a28b 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -31,6 +31,7 @@ modules += Git/SVN
 modules += Git/SVN/Memoize/YAML
 modules += Git/SVN/Fetcher
 modules += Git/SVN/Editor
+modules += Git/SVN/GlobSpec
 modules += Git/SVN/Log
 modules += Git/SVN/Migration
 modules += Git/SVN/Prompt
diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
index 5419438..c92fee4 100644
--- a/t/Git-SVN/00compile.t
+++ b/t/Git-SVN/00compile.t
@@ -3,7 +3,7 @@
 use strict;
 use warnings;

-use Test::More tests => 6;
+use Test::More tests => 7;

 require_ok 'Git::SVN';
 require_ok 'Git::SVN::Utils';
@@ -11,3 +11,4 @@ require_ok 'Git::SVN::Ra';
 require_ok 'Git::SVN::Log';
 require_ok 'Git::SVN::Migration';
 require_ok 'Git::IndexInfo';
+require_ok 'Git::SVN::GlobSpec';
-- 
1.7.11.1
