From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2010, #01; Wed, 2)
Date: Sat, 05 Jun 2010 11:07:32 -0700
Message-ID: <7v39x1z72z.fsf@alter.siamese.dyndns.org>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <20100604211811.GA7471@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 20:07:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKxmc-0003W7-U2
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 20:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab0FESHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 14:07:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab0FESHl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 14:07:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E57F4B9B96;
	Sat,  5 Jun 2010 14:07:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=qZjjxvcwzz33DC1wZJ9pa7nfCEA=; b=DjScPuMttotYNVO6l/XYbQA
	UjVGtGsLkGhlzBk/Ed+oSdqy9YlQHIJOZEJSQMyIaqJqHW84FQAetPrZB6e+Cohz
	ObDf5BIoID6Smi+8I4u1EISO6+57Cn+IotvaQOP9rTo9Ooki2kG2/cGnUL+i+cWk
	afSfq0FViCZKbCjedsqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=A8W+HvBAVs/nSwC3i4xVPR1VuCxiAD+WuZNkRICc+/WhykDXq
	/8SHiY1DPn9OJkBRPmMnVsALT7tvKfbFH97l5QKzjptQIJzmz08ubB8EFhEs63sP
	TBKak3QXZsoe5mil0anv40Ue4/qMLhBSVNjvSPxhM2xzkhJ+wq/i1ul0VU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BD69B9B93;
	Sat,  5 Jun 2010 14:07:37 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CDD2B9B91; Sat,  5 Jun
 2010 14:07:33 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 393440C4-70CD-11DF-99AA-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148482>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> * gv/portable (2010-05-14) 18 commits
> [...]
>>  - Do not use "diff" found on PATH while building and installing
>
> That patch (d1b1a919) breaks merge-one-file when run outside the test
> suite as far as I can tell.

Thanks for catching.  I wonder if something like this would be better in
that it wouldn't break people who do not use custom "DIFF" while it would
help people who do at the same time...

 Makefile              |    2 ++
 git-merge-one-file.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index bcb84be..0367e8a 100644
--- a/Makefile
+++ b/Makefile
@@ -1494,6 +1494,7 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
+DIFF_SQ = $(subst ','\'',$(DIFF))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
 
@@ -1582,6 +1583,7 @@ define cmd_munge_script
 $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
+    -e 's|@@DIFF@@|$(DIFF_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e $(BROKEN_PATH_FIX) \
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 3145009..b86402a 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -107,7 +107,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		# remove lines that are unique to ours.
 		orig=`git-unpack-file $2`
 		sz0=`wc -c <"$orig"`
-		$DIFF -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
+		@@DIFF@@ -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
 		sz1=`wc -c <"$orig"`
 
 		# If we do not have enough common material, it is not
