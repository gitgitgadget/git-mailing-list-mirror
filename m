From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] ls-remote: optionally return non-zero on non-existing
 refs
Date: Wed, 18 May 2011 14:38:37 -0700
Message-ID: <7v7h9nbsf6.fsf@alter.siamese.dyndns.org>
References: <20110512120536.GA22033@camk.edu.pl>
 <7voc37dh4l.fsf@alter.siamese.dyndns.org>
 <7vk4dvdg6x.fsf@alter.siamese.dyndns.org> <4DD3D490.1090503@elegosoft.com>
 <7v7h9ndfs9.fsf@alter.siamese.dyndns.org> <4DD426A8.3010402@elegosoft.com>
 <m2y623so4l.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org,
	Kacper Kornet <draenog@pld-linux.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed May 18 23:38:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMoSD-0003JW-U8
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 23:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019Ab1ERViv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 17:38:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755953Ab1ERViu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 17:38:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2C785080;
	Wed, 18 May 2011 17:40:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hy11U7hrfCJd28ShkFGTEqeG59A=; b=LdgMNT
	bYlXGZfUB0jYHV1Rp0/5Udvy9nDCyRluP+wj1E7K2nXY+yTYa6YqMYGJWicqxcSL
	u6G+WJ6DOVTWlwyKLgaVol6GWRnNdQq5C7DZjCDimOXLBZZuGQWTfnFw1crb/oAJ
	+NQLW1WTo2CdpJ5gPnUpge1+xxjl+AIntxCU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PhlbW5A9qe6xNFIF57fZ4sMY6jSIvRh5
	wvG6SNRdJ2erM4tAM3uGlD35J7vyuArD4odgpk8PIjC9b46WMx9WcgG7FHanqdqu
	psN4XWIfGnavgoinWiCanzfWLhVKiT5oh6AFrfptKYV0VrhziMw2NBTAnu7xSBbr
	H6wV/SzSaD0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 65AD1507D;
	Wed, 18 May 2011 17:40:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B6CED507A; Wed, 18 May 2011
 17:40:45 -0400 (EDT)
In-Reply-To: <m2y623so4l.fsf@igel.home> (Andreas Schwab's message of "Wed, 18
 May 2011 23:19:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80484556-8197-11E0-9BFA-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173904>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Michael Schubert <mschub@elegosoft.com> writes:
>
>> +-e::
>> +--exit-code::
>> +	Exit with a non-zero status code when the specified references don't
>> +	exist.
>
> All or any of them?  Also, the <refs> are patterns, so this should
> probably be talking about "not matching".

FWIW, here is what I am going to queue:

Points are:

 (1) explain that the command indicates success in the normal case when we
     successfully talked with the remote end;

 (2) help people who want to use this option by explicitly mentioning "2",
     not "non-zero", so that they can write:

	git ls-remote $there $pattern
        case $? in
        0)
        	: success! ;;
	2)
        	: successfully talked, but nothing found ;;
	*)
        	: we couldn't even talk to them ;;
	esac

 (3) test!

-- >8 --
From: Michael Schubert <mschub@elegosoft.com>
Date: Wed, 18 May 2011 22:06:00 +0200
Subject: [PATCH] ls-remote: the --exit-code option reports "no matching refs"

The "git ls-remote" uses its exit status to indicate if it successfully
talked with the remote repository. A new option "--exit-code" makes the
command exit with status "2" when there is no refs to be listed, even when
the command successfully talked with the remote repository.

This way, the caller can tell if we failed to contact the remote, or the
remote did not have what we wanted to see. Of course, you can inspect the
output from the command, which has been and will continue to be a valid
way to check the same thing.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5512-ls-remote.sh            |   24 ++++++++++++++++++++++++
 Documentation/git-ls-remote.txt |    8 +++++++-
 builtin/ls-remote.c             |   11 +++++++++--
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index d191235..5c546c9 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -123,4 +123,28 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 
 '
 
+test_expect_success 'die with non-2 for wrong repository even with --exit-code' '
+	git ls-remote --exit-code ./no-such-repository ;# not &&
+	status=$? &&
+	test $status != 2 && test $status != 0
+'
+
+test_expect_success 'Report success even when nothing matches' '
+	git ls-remote other.git "refs/nsn/*" >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Report no-match with --exit-code' '
+	test_expect_code 2 git ls-remote --exit-code other.git "refs/nsn/*" >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Report match with --exit-code' '
+	git ls-remote --exit-code other.git "refs/tags/*" >actual &&
+	git ls-remote . tags/mark >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index c3df8c0..7a9b86a 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]
-	      <repository> [<refs>...]
+	      [--exit-code] <repository> [<refs>...]
 
 DESCRIPTION
 -----------
@@ -36,6 +36,12 @@ OPTIONS
 	SSH and where the SSH daemon does not use the PATH configured by the
 	user.
 
+--exit-code::
+	Exit with status "2" when no matching refs are found in the remote
+	repository. Usually the command exits with status "0" to indicate
+	it successfully talked with the remote repository, whether it
+	found any matching refs.
+
 <repository>::
 	Location of the repository.  The shorthand defined in
 	$GIT_DIR/branches/ can be used. Use "." (dot) to list references in
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1a1ff87..1022309 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -5,7 +5,7 @@
 
 static const char ls_remote_usage[] =
 "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\n"
-"                     [-q|--quiet] [<repository> [<refs>...]]";
+"                     [-q|--quiet] [--exit-code] [<repository> [<refs>...]]";
 
 /*
  * Is there one among the list of patterns that match the tail part
@@ -35,6 +35,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	unsigned flags = 0;
 	int get_url = 0;
 	int quiet = 0;
+	int status = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
 
@@ -74,6 +75,11 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 				get_url = 1;
 				continue;
 			}
+			if (!strcmp("--exit-code", arg)) {
+				/* return this code if no refs are reported */
+				status = 2;
+				continue;
+			}
 			usage(ls_remote_usage);
 		}
 		dest = arg;
@@ -121,6 +127,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		if (!tail_match(pattern, ref->name))
 			continue;
 		printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
+		status = 0; /* we found something */
 	}
-	return 0;
+	return status;
 }
-- 
1.7.5.1.414.gb4910
