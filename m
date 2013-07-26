From: Junio C Hamano <gitster@pobox.com>
Subject: Re: redundant message in builtin/rm.c
Date: Thu, 25 Jul 2013 23:04:48 -0700
Message-ID: <7v1u6l501r.fsf@alter.siamese.dyndns.org>
References: <CANYiYbGQj6mCDraxiBHXEL+qd7OwnFCaMpB3Wb4_Pg=-p+KJAg@mail.gmail.com>
	<CAN0XMOJ+ar+iKwVi_z02x7p3XcZj0SxT69a7ApRxOioet8RwDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"'Git List" <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 08:04:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2b97-0000CP-3R
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 08:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab3GZGEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 02:04:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57612 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265Ab3GZGEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 02:04:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3447E2D468;
	Fri, 26 Jul 2013 06:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pspkirICy3+DPIWuCF5y/QdKlRE=; b=dKotTw
	WQbQmfoDRS/MssTMc57Iv10QPNZ4i7opp6RPw30SVWIeMbmY0oahxszfCN2kOGju
	jxqH4/Uf2/4QKccBHqJiTKuLOVNepp18bV01Ibr9s1E8yHcD3lCiqJoTpiiPbpU4
	oi5+gwxBRpkKUwnpHHVT4YtzHkWZ1VzqdaKXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SyNUfsKxA+KRphXqg3Tlj4Xu8g9WAxYx
	5uTq/iOXjqHRdBJSRx0oDkUeMwcSTvoniWKfSLO400PIprnaZaxZSh38KMz01szf
	BuaXkXC9Q34kTLQ8pkLs9ELgmFDNIyGyfDAOSGWWxK3v1BNdV2EcQqfdQ+FgGkhy
	CVHxbaADXBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A5E72D467;
	Fri, 26 Jul 2013 06:04:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5626D2D465;
	Fri, 26 Jul 2013 06:04:50 +0000 (UTC)
In-Reply-To: <CAN0XMOJ+ar+iKwVi_z02x7p3XcZj0SxT69a7ApRxOioet8RwDw@mail.gmail.com>
	(Ralf Thielow's message of "Fri, 26 Jul 2013 06:03:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 483F2C9A-F5B9-11E2-B4C7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231166>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> It's more readable if "\n" is at the end of a line.
>
> Q_("the following submodule (or one of its nested submodules)\n"
> "uses a .git directory:"

Thanks both.  Perhaps we should do something like this?

-- >8 --
Subject: builtin/rm.c: consolidate error reporting for removing submodules

We have two (not identical) copies of error reporting when
attempting to remove submodules that have their repositories
embedded within them.  Add a helper function so that we do not have
to repeat similar error messages with subtly different wording
without a good reason.

Noticed by Jiang Xin.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rm.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 5d0c068..694568a 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -57,6 +57,21 @@ static void print_error_files(struct string_list *files_list,
 	}
 }
 
+static void error_removing_concrete_submodules(struct string_list *files, int *errs)
+{
+	print_error_files(files,
+			  Q_("the following submodule (or one of its nested "
+			     "submodules)\n"
+			     "uses a .git directory:",
+			     "the following submodules (or one of its nested "
+			     "submodules)\n"
+			     "use a .git directory:", files->nr),
+			  _("\n(use 'rm -rf' if you really want to remove "
+			    "it including all of its history)"),
+			  errs);
+	string_list_clear(files, 0);
+}
+
 static int check_submodules_use_gitfiles(void)
 {
 	int i;
@@ -85,16 +100,8 @@ static int check_submodules_use_gitfiles(void)
 		if (!submodule_uses_gitfile(name))
 			string_list_append(&files, name);
 	}
-	print_error_files(&files,
-			  Q_("the following submodule (or one of its nested "
-			     "submodules)\n uses a .git directory:",
-			     "the following submodules (or one of its nested "
-			     "submodules)\n use a .git directory:",
-			     files.nr),
-			  _("\n(use 'rm -rf' if you really want to remove "
-			    "it including all of its history)"),
-			  &errs);
-	string_list_clear(&files, 0);
+
+	error_removing_concrete_submodules(&files, &errs);
 
 	return errs;
 }
@@ -236,17 +243,9 @@ static int check_local_mod(unsigned char *head, int index_only)
 			    " or -f to force removal)"),
 			  &errs);
 	string_list_clear(&files_cached, 0);
-	print_error_files(&files_submodule,
-			  Q_("the following submodule (or one of its nested "
-			     "submodule)\nuses a .git directory:",
-			     "the following submodules (or one of its nested "
-			     "submodule)\nuse a .git directory:",
-			     files_submodule.nr),
-			  _("\n(use 'rm -rf' if you really "
-			    "want to remove it including all "
-			    "of its history)"),
-			  &errs);
-	string_list_clear(&files_submodule, 0);
+
+	error_removing_concrete_submodules(&files_submodule, &errs);
+
 	print_error_files(&files_local,
 			  Q_("the following file has local modifications:",
 			     "the following files have local modifications:",
