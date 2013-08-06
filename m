From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase -i error message interprets \t in commit message
Date: Tue, 06 Aug 2013 12:35:11 -0700
Message-ID: <7vhaf2fw9c.fsf@alter.siamese.dyndns.org>
References: <87k3jy6cyc.fsf@fencepost.gnu.org> <vpqli4ekdni.fsf@anie.imag.fr>
	<87fvum694z.fsf@fencepost.gnu.org> <vpqd2pqka9e.fsf@anie.imag.fr>
	<87bo5a62te.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 06 21:35:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6n2P-0002pC-PD
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 21:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056Ab3HFTfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 15:35:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755509Ab3HFTfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 15:35:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6732636F4E;
	Tue,  6 Aug 2013 19:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=auYLh4eISfXxppF7JKsPnWAIEc0=; b=wpxp4l
	06NKwMMWt+wb0USqhAbQiJw36dIoy3CSUz9swd591P1iGTWRHvQwJRxppH5kXlrV
	cFcdMBQcfoO/fiTV55ivlvhF0aWXgSc+YBJqK5//5svUskQ3Hji7z2hM5oIHXLJn
	UZn5PT84EMEe3lNnpn7hhkpi/Tl2/WFRUknE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jLzjF07RDGCDff3i5pf7zfK9tPBcSqxE
	OQkJIWsv6mU0JgwH8NpcVL8aH2/AD6ITOXYC1BmggRgpEAr+rwEKr2Dd57BLaEEw
	Rdli7QwVM/WGE46+oU2kLn/yz/6cxhtfKiJwLQfEdSG7cmlQOimLOaf+CFc+PJkg
	3p0tVMBC82I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B2B936F4D;
	Tue,  6 Aug 2013 19:35:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D78B36F4A;
	Tue,  6 Aug 2013 19:35:12 +0000 (UTC)
In-Reply-To: <87bo5a62te.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 06 Aug 2013 21:23:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FCFDD32-FECF-11E2-8732-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231782>

David Kastrup <dak@gnu.org> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>>From 7962ac8d8f2cbc556f669fd97487f9d70edc4ea1 Mon Sep 17 00:00:00 2001
>> From: Matthieu Moy <Matthieu.Moy@imag.fr>
>> Date: Tue, 6 Aug 2013 19:13:03 +0200
>> Subject: [PATCH] die_with_status: use "printf '%s\n'", not "echo"
>>
>> At least GNU echo interprets backslashes in its arguments.
>
> I think that's incorrect in several respects.  For one thing, echo is
> never called for most Bourne shells since echo is a builtin (might have
> been different for UNIX version 7 or so).  For another, GNU echo would
> behave like Bash:
>
> And GNU Bash does not interpret escapes unless you do echo -e.  Escape
> sequence interpretation, however, happens for Dash:
>
> dak@lola:/usr/local/tmp/lilypond$ dash -c 'echo "x\tx"'
> x	x
> dak@lola:/usr/local/tmp/lilypond$ bash -c 'echo "x\tx"'
> x\tx
> dak@lola:/usr/local/tmp/lilypond$ /bin/echo "x\tx"
> x\tx
>
> So replace "GNU echo" in your commit message with "Dash's echo builtin"
> and you get closer.

I'll queue the attached.

POSIX makes it an implementation defined behaviour when the first
argument is "-n", or any argument contains a backslas (X/Open System
Interfaces wants to treat "-n" as literal and always interpret the
backslash sequence), so it is definitely safer to avoid running
'echo' on any random string.

Thanks.

Author: Matthieu Moy <Matthieu.Moy@imag.fr>
Date:   Tue Aug 6 20:26:44 2013 +0200

    die_with_status: use "printf '%s\n'", not "echo"
    
    Some implementations of 'echo' (e.g. dash's built-in) interpret
    backslash sequences in their arguments.
    
    This triggered at least one bug: the error message of "rebase -i" was
    turning \t in commit messages into actual tabulations. There may be
    others.
    
    Using "printf '%s\n'" instead avoids this bad behavior, and is the form
    used by the "say" function.
    
    Noticed-by: David Kastrup <dak@gnu.org>
    Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 7a964ad..e15be51 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -53,7 +53,7 @@ die () {
 die_with_status () {
 	status=$1
 	shift
-	echo >&2 "$*"
+	printf >&2 '%s\n' "$*"
 	exit "$status"
 }
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 49ccb38..074deb1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -976,4 +976,17 @@ test_expect_success 'rebase -i with --strategy and -X' '
 	test $(cat file1) = Z
 '
 
+test_expect_success 'rebase -i error on commits with \ in message' '
+	current_head=$(git rev-parse HEAD)
+	test_when_finished "git rebase --abort; git reset --hard $current_head; rm -f error" &&
+	test_commit TO-REMOVE will-conflict old-content &&
+	test_commit "\temp" will-conflict new-content dummy &&
+	(
+	EDITOR=true &&
+	export EDITOR &&
+	test_must_fail git rebase -i HEAD^ --onto HEAD^^ 2>error
+	) &&
+	grep -v "	" error
+'
+
 test_done
