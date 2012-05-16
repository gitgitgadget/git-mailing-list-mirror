From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-sh-setup: work around Cygwin path handling
 gotchas
Date: Wed, 16 May 2012 12:02:26 -0700
Message-ID: <7vd364c5kt.fsf@alter.siamese.dyndns.org>
References: <4FB09FF2.70309@viscovery.net>
 <1337191208-21110-1-git-send-email-gitster@pobox.com>
 <1337191208-21110-3-git-send-email-gitster@pobox.com>
 <CAAXzdLW5VYnHc41WZ0id=4Qe17dHSj4+J9tqVvG-PvtpXLmh+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 21:03:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUjVB-000769-4J
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 21:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515Ab2EPTDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 15:03:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55335 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138Ab2EPTDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 15:03:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82BD682C7;
	Wed, 16 May 2012 15:03:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VJbBOhmfBn9bsEUEu0KdM2mhZNU=; b=V1kIec
	TOb5OAsCLgyMNAMC6GejKBmijRNhfQi3+3h8TvZljcsvEPdIL5eyCJCGtp9GdMWF
	5MMUUqrZW1N5bJnIVCnOcCQtHGsINeBgsGKE2EQYmwyRYAwboYXwYcrk+vLp7oHC
	gg/iaMUUVvX0Jg2BHpjFicoAI0uWF/D3Kzezs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n7JSKL7Q5Pjbm0JCF+GudLSR6XOg3N9v
	FA49u8eAvlR+K8yWmR9w0SN0l/2HwXNHRufST1pMkTXPE6rFRCA+EeD+s7cDhmuZ
	UhheWA7DhYGwfZS4JsWd5MqGujxlFaalglGwkd1v7P+OK4Hjudss6StsaDzkus1U
	2/0/VyMulv8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79E8382C6;
	Wed, 16 May 2012 15:03:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A59F82BA; Wed, 16 May 2012
 15:02:36 -0400 (EDT)
In-Reply-To: <CAAXzdLW5VYnHc41WZ0id=4Qe17dHSj4+J9tqVvG-PvtpXLmh+Q@mail.gmail.com> (Steven
 Penny's message of "Wed, 16 May 2012 13:51:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B43F1B80-9F89-11E1-AA95-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197892>

Steven Penny <svnpenn@gmail.com> writes:

> Junio C Hamano wrote:
>> +*CYGWIN*)
>> +       pwd () {
>> +               builtin cygpath -m
>> +       }
>> +       ;;
>
> Ok I got it!
>
> The problem is twofold
>
> 1. Ramsay Jones	was right, it needs to be called like
>
> 	cygpath -m "$PWD"
>
> 2. The Cygwin "pwd" (and quite possibly MinGW "pwd") needs to be defined
>    **before** it is called

OK, I missed the first point, it seems.  But you seem to have missed that
these two problems are more or less independent---that is why I sent two
patches, not a single ball of wax like the one I am responding to.

So the replacement for [PATCH 2/2] would now look like this?

In addition to "applies fine, tested and works" reports from Windows
stakeholders, I still prefer to have a sign off from you (see
Documentation/SubmittingPatches).

Thanks.

-- >8 --
From: Steven Penny <svnpenn@gmail.com>
Date: Wed, 16 May 2012 10:44:49 -0700
Subject: [PATCH] git-sh-setup: work around Cygwin path handling gotchas

On Cygwin, tools built for Cygwin can take both Windows-style paths
(e.g. C:/dir/file.txt or C:\dir\file.txt) and Cygwin-style paths
(e.g. /cygdrive/c/dir/file.txt), but Windows-native tools can only take
Windows-style paths.  Because the paths that are relative to $GIT_DIR,
e.g. the name of the insn sheet file of the "rebase -i" command, are given
to the programs with $GIT_DIR prefixed, and $GIT_DIR in turn is computed
by calling "pwd", wrap "pwd" to call "cygpath -m" to give a Windows-style
path, in a way similar to how mingw does this.
---
 git-sh-setup.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 770a86e..b8e6327 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -241,6 +241,11 @@ case $(uname -s) in
 		return 1
 	}
 	;;
+*CYGWIN*)
+	pwd () {
+		cygpath -m "$PWD"
+	}
+	;;
 *)
 	is_absolute_path () {
 		case "$1" in
-- 
1.7.10.2.537.g0ac6509
