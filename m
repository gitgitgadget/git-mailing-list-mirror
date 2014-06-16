From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] string-list: Add string_list initializer helper functions
Date: Mon, 16 Jun 2014 15:59:05 -0700
Message-ID: <xmqqsin4o406.fsf@gitster.dls.corp.google.com>
References: <1402907232-24629-1-git-send-email-tanayabh@gmail.com>
	<1402907232-24629-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 00:59:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwfrx-0004U2-By
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 00:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbaFPW7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 18:59:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51997 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbaFPW7M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 18:59:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2462821ACA;
	Mon, 16 Jun 2014 18:59:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5bBAZndBIevQcBVH4CrPX3f19sg=; b=pmktIZ
	6vdZneJVInNefXpWRfymzbA3B6Vj6l6bMc9fOMLQx2gTF6YBIB34hINGrAWj/gfD
	hg9XM+DgdhHRMdhIjvhFLEMieW55jNTVPGrryFkSUS+POhxvkHIAcQxVSjw6AlNk
	huzKSpXC3uG72ptJAEEDqaRD9TmGwgeRqEaIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DutWnF3FMYCdSW4PYq+Vd/J3zGYh+b6S
	9kbNiA+p4aYiSAAfvyA8Oo1w0Eu54jYrFkK2+gLv23Ls+KnS+dGTaI/yBQReR+3l
	As5M238yXW6R6tspcopxlyEV7n0zbsv2HGwrJKyOcw2J7Z54W3XsaWkFH0aFuVlC
	3HemBvsCeKI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1921021AC9;
	Mon, 16 Jun 2014 18:59:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 41E8521ABA;
	Mon, 16 Jun 2014 18:59:05 -0400 (EDT)
In-Reply-To: <1402907232-24629-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 16 Jun 2014 01:27:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D0CFEE14-F5A9-11E3-8F03-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251829>

Tanay Abhra <tanayabh@gmail.com> writes:

> When a compound construct like a string_list within another
> struct is used, the default initializer macros are useless.
> For such cases add helper functions for string_list
> initialization for both DUP and NODUP modes.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---


Sorry, but I do not understand the above "useless".  Do you mean to
say that xyzzy below cannot be initialized that way?

 git.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git.c b/git.c
index d261575..17714d1 100644
--- a/git.c
+++ b/git.c
@@ -595,11 +595,24 @@ static int run_argv(int *argcp, const char ***argv)
 }
 
 
+#include "string-list.h"
+
 int main(int argc, char **av)
 {
 	const char **argv = (const char **) av;
 	const char *cmd;
 
+	struct compound {
+		int frotz;
+		struct string_list nitfol;
+	} xyzzy = {
+		314,
+		STRING_LIST_INIT_DUP,
+	};
+	printf("dup-strings is set to %s\n",
+	       xyzzy.nitfol.strdup_strings ? "true" : "false");
+	return 0;
+
 	startup_info = &git_startup_info;
 
 	cmd = git_extract_argv0_path(argv[0]);
