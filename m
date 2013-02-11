From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 19:44:58 -0800
Message-ID: <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 04:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4kKg-0006C2-HT
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 04:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952Ab3BKDpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 22:45:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50934 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab3BKDpE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 22:45:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4F7EC5A2;
	Sun, 10 Feb 2013 22:45:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TH9i/4bWzT6dgQC3oUMfPI3XFpI=; b=gCpxKH
	J19hKsyjioXsRAW6ruQ8Lw1kaoVCmnDkTVjEVt2e+R+3qgP8cyX/trpUB3BFsySm
	+e96K4OtDlWtkXB7qFzPiJKyIJTEPUDrJ4rhdZonmbihs5z6QVW1TKyxMLD9OfZ9
	keaM+SvR16OBkzvU4Girjc7NvnxQvnKmoSLlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l9b6FFljLdgLxZ3f+OpJFXlTE+rvn4rr
	YcAxjXB5LNe9j2fi52+Xv4lkIxN7BGF4Xgm5qOhRdr9Afj5Kg4sDtPbbPN4PGzOG
	CIdY4T77s18T3MWfgvVMmKJCTmTzBXN3IroWrZAMDCKf9+qZjAkRkX70pVMcetTr
	4nge2+lWcI4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98831C5A1;
	Sun, 10 Feb 2013 22:45:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E755C59D; Sun, 10 Feb 2013
 22:45:01 -0500 (EST)
In-Reply-To: <20130211012016.GA13243@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 10 Feb 2013 17:20:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A3A9638-73FD-11E2-99D6-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215980>

Jonathan Nieder <jrnieder@gmail.com> writes:

> How about this?
>
> A patch on top could change the default "git-shell-commands is not
> present" message if that seems worthwhile.

Hmph.

I wonder if rewording the message when git-shell-commmands directory
is not there may be a better first step (which actually could be the
last step)?

That is, showing something like this,

> +printf '%s\n' "Hi $USER! You've successfully authenticated, but I do not"
> +printf '%s\n' "provide interactive shell access."

but rephrased with a reference to "git help shell" for people
preparing their own server when ~/git-shell-commands/ in good order?

Something like

diff --git a/shell.c b/shell.c
index 84b237f..71ff04f 100644
--- a/shell.c
+++ b/shell.c
@@ -162,9 +162,11 @@ int main(int argc, char **argv)
 		/* Allow the user to run an interactive shell */
 		cd_to_homedir();
 		if (access(COMMAND_DIR, R_OK | X_OK) == -1) {
-			die("Interactive git shell is not enabled.\n"
+			die("The user has been recognized as '%s' but "
+			    "interactive git shell is not enabled.\n"
 			    "hint: ~/" COMMAND_DIR " should exist "
-			    "and have read and execute access.");
+			    "and have read and execute access.",
+			    get_user_name());
 		}
 		run_shell();
 		exit(0);
