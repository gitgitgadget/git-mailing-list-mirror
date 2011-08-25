From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow multiple calls to submodule merge search for the
 same path
Date: Thu, 25 Aug 2011 16:39:26 -0700
Message-ID: <7vobzdgixd.fsf@alter.siamese.dyndns.org>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com> <20110824191438.GA45292@book.hvoigt.net> <7vty96obo9.fsf@alter.siamese.dyndns.org> <20110824194618.GD45292@book.hvoigt.net> <7v39gqo2fn.fsf@alter.siamese.dyndns.org> <20110825211144.GA67523@book.hvoigt.net> <7vwre1gjq1.fsf@alter.siamese.dyndns.org> <7vsjopgjfs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 01:39:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwjWK-0007aY-8V
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 01:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab1HYXj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 19:39:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab1HYXj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 19:39:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30AC85DD8;
	Thu, 25 Aug 2011 19:39:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8A7zRRKTS+kOGkkNWxoYOqzU4/A=; b=QnpI6U
	1vxpBO+HjIa1xu/X388BTDesNfLVO2LZEatd6qX0C38TM0gg8S7x/NPwIvVEHCdj
	usHgtdClVAz2y+rf+u5vT6BDcZRbuD1UaMjaUn+H1v5zzM/LICU73TA7q9xV483U
	K5Ey0kBd327FAkHmrcJB/wx2qsbaNuIWCWHzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kQNbnXpbd9uShT/KirPAmHF2l40/xW4b
	rhgFnlRNczlHqGEFgTbMHRj1KZd+yki+UCFtIuvUDouju1YD6uf+htyJ4BKlfpMi
	0H+kfrGqU3+27uVr2dBkEy3UDTMffl7kOdkIwoopHr1jSIM1qBbiKsP+1xox07wB
	HNt0cF6CbcQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26DA15DD7;
	Thu, 25 Aug 2011 19:39:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84F3D5DD6; Thu, 25 Aug 2011
 19:39:27 -0400 (EDT)
In-Reply-To: <7vsjopgjfs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 25 Aug 2011 16:28:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78C62968-CF73-11E0-8331-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180138>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>>
>>> diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
>>> index 8f6f2d6..603fb72 100755
>>> --- a/t/t7405-submodule-merge.sh
>>> +++ b/t/t7405-submodule-merge.sh
>>> @@ -269,7 +269,7 @@ test_expect_success 'setup for recursive merge with submodule' '
>>>  '
>>>  
>>>  # merge should leave submodule unmerged in index
>>> -test_expect_failure 'recursive merge with submodule' '
>>> +test_expect_success 'recursive merge with submodule' '
>>>  	(cd merge-recursive &&
>>>  	 test_must_fail git merge top-bc &&
>>>  	 echo "160000 $(git rev-parse top-cb:sub) 2	sub" > expect2 &&
>>
>> What is this patch based on?
>
> Ah, nevermind. I figured it out. Thanks.

Just FYI; squashed this on top to fix compilation breakage.
Thanks.

 submodule.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 21a57d2..752cd8a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -738,6 +738,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 	struct object_array merges;
 	struct commit *commit;
 	int contains_another;
+	FILE *out;
 
 	char merged_revision[42];
 	const char *rev_args[] = { "rev-list", "--merges", "--ancestry-path",
@@ -762,14 +763,15 @@ static int find_first_merges(struct object_array *result, const char *path,
 	if (start_command(&cp))
 		die("Could not run 'git rev-list --merges --ancestry-path --all %s' "
 				"command in submodule %s", merged_revision, path);
-	FILE *out = fdopen(cp.out, "r");
+	out = fdopen(cp.out, "r");
 	if (!out)
 		die("Could not open pipe of rev-list command.");
 
 	/* save all revisions from the above list that contain b */
 	while (strbuf_getline(&one_rev, out, '\n') != EOF) {
+		struct object *o;
 		commit = lookup_commit_reference_by_name(one_rev.buf);
-		struct object *o = &(commit->object);
+		o = &(commit->object);
 		if (in_merge_bases(b, &commit, 1))
 			add_object_array(o, NULL, &merges);
 	}
