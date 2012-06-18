From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] symbolic-ref: check format of given reference
Date: Mon, 18 Jun 2012 09:39:15 -0700
Message-ID: <7vr4tc4lsc.fsf@alter.siamese.dyndns.org>
References: <4FDE3D7D.4090502@elegosoft.com>
 <7vaa017j51.fsf@alter.siamese.dyndns.org> <4FDF18E5.7020908@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 18:39:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgezA-0006cK-3j
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 18:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab2FRQjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 12:39:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129Ab2FRQjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 12:39:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07A20744A;
	Mon, 18 Jun 2012 12:39:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z7vEC5M/p4ECyumxyzNfqxQYtRY=; b=F7BVxe
	kVmTqBqvY4KoQY5qFPbXo+BO46E5hFfBwSYPG81EuFXN5nhP6EL90P9bz++vk1I+
	w3dybMX3LAdcMNiLhQqbPL4vYEGtlWBVR3EtZY/WLQIboI6lTR77R2pqiMwce6Hj
	a7s5/kbGgXe+mvVgSJLrEjPQh2uohO8U85ea4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GCjiG/15xWTJt9mjseqhorA0fM4t7v2v
	+H7QpLCVwoh0UOae8cWiJrmbFJK9xM180Uz36UkbINeuT9XoiKFBYbP36yvY85Z3
	njDrWXc5f+IcPEU+t3KzjhTEhKKxz/34X9eKoBcmUhWqrJIGx7byXoAsJ5yU/PFW
	f1qjJQctPHc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F26087449;
	Mon, 18 Jun 2012 12:39:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 684ED7447; Mon, 18 Jun 2012
 12:39:16 -0400 (EDT)
In-Reply-To: <4FDF18E5.7020908@elegosoft.com> (Michael Schubert's message of
 "Mon, 18 Jun 2012 14:02:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24E0734A-B964-11E1-84BF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200144>

Michael Schubert <mschub@elegosoft.com> writes:

>>> Additionally, I had to reindent two lines to make git-am happy
>>> (indent with spaces).
>> 
>> I doubt that it is needed; the '-' lines show runs of HT followed by
>> fewer than 8 SP, which should not trigger "indent with spaces".
>
> I've only noticed because git-am was telling me when I tried to
> apply the patch.? Am I missing something?

Perhaps, but I cannot tell exactly what you are doing wrong.

If you didn't touch lines you did not have to in a way to break
indentation and cause "indent with spaces", "am" would not have
complained (it only looks at "+" lines).

Attached is a patch based on your patch but removes the unnecessary
re-indentation part, and "git am" happily applies it to my tree
without complaining.  Does it apply for you (obviously to a revision
without your patch) cleanly without complaint?  Otherwise it could
be that whitespace categories that are specified for the file in
your local attributes file may be different from mine (i.e. an empty
set).

-- >8 --
From: Michael Schubert <mschub@elegosoft.com>
Date: Sun, 17 Jun 2012 22:26:37 +0200
Subject: [PATCH] symbolic-ref: check format of given reference

Currently, it's possible to update HEAD with a nonsense reference since
no strict validation is performed. Example:

	$ git symbolic-ref HEAD 'refs/heads/master
    >
    >
    > '

Fix this by checking the given reference with check_refname_format().

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/symbolic-ref.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 801d62e..a529541 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -44,13 +44,15 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options,
 			     git_symbolic_ref_usage, 0);
-	if (msg &&!*msg)
+	if (msg && !*msg)
 		die("Refusing to perform update with empty message");
 	switch (argc) {
 	case 1:
 		check_symref(argv[0], quiet);
 		break;
 	case 2:
+		if (check_refname_format(argv[1], 0))
+			die("No valid reference format: '%s'", argv[1]);
 		if (!strcmp(argv[0], "HEAD") &&
 		    prefixcmp(argv[1], "refs/"))
 			die("Refusing to point HEAD outside of refs/");
-- 
1.7.11
