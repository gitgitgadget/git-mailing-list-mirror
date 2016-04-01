From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ident: make the useConfigOnly error messages more informative
Date: Fri, 01 Apr 2016 15:04:24 -0700
Message-ID: <xmqqmvpdgf4n.fsf@gitster.mtv.corp.google.com>
References: <1459366183-15451-1-git-send-email-redneb@gmx.com>
	<1459366183-15451-2-git-send-email-redneb@gmx.com>
	<xmqqlh4zr492.fsf@gitster.mtv.corp.google.com>
	<20160330232552.GA31861@zeno>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Marios Titas <redneb@gmx.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 00:04:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am7BA-0007K3-3t
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 00:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbcDAWE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 18:04:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753751AbcDAWE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 18:04:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C54694F3B4;
	Fri,  1 Apr 2016 18:04:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GFEH+4K9+SWN8VYgVwAPI1PI8zY=; b=D2phon
	CD/t/MDmZWe+XZkzldmdN45lneV0ivdDVMsgOI6lO/mg3rrvoUKYmLvtZPyAciL5
	S7hs3EARlnlvgztSSM2LFDEYrz9+3mC0K2Ii/fY/ICNbViDfoyWO3B2Sf+iy6qxU
	CPWXjWOAdICUFDFGfUSLlcTrCA818pb2/fnzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UolFuyn9EmQ5L6xh7hv8qH/Zb2e8dym9
	RMxBMEvzrg3ZNwv/q5isXfwKEBKTuPVsLUySQ82mzmWamwrbtsMahJkrMKpUW6B2
	b/gXlKj8JD4yQKXCXLE0NdoE/Ht9KA/hB508qAgCOphqf7YW5RJ7vWBUT57mW33s
	p4sG/wO56ew=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC2314F3B3;
	Fri,  1 Apr 2016 18:04:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39D584F3B1;
	Fri,  1 Apr 2016 18:04:26 -0400 (EDT)
In-Reply-To: <20160330232552.GA31861@zeno> (Marios Titas's message of "Thu, 31
	Mar 2016 02:25:52 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B2EDBE66-F855-11E5-AC95-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290583>

Marios Titas <redneb@gmx.com> writes:

> Yeah, maybe informative is not the right word. What I meant is that it
> directs the user to do the "git config user.name" thing, which is
> likely the most appropriate course of action in this situation. In any
> event, I think printing the env_hint message would be really helpful
> in this case.

OK, let's do this, then.

Thanks.

-- >8 --
From: Marios Titas <redneb@gmx.com>
Date: Wed, 30 Mar 2016 22:29:43 +0300
Subject: [PATCH] ident: give "please tell me" message upon useConfigOnly error

The env_hint message applies perfectly to the case when
user.useConfigOnly is set and at least one of the user.name and the
user.email are not provided.

Additionally, use a less descriptive error message to discourage
users from disabling user.useConfigOnly configuration variable to
work around this error condition.  We want to encourage them to set
user.name or user.email instead.

Signed-off-by: Marios Titas <redneb@gmx.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ident.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/ident.c b/ident.c
index b2521ff..c766127 100644
--- a/ident.c
+++ b/ident.c
@@ -352,8 +352,10 @@ const char *fmt_ident(const char *name, const char *email,
 		int using_default = 0;
 		if (!name) {
 			if (strict && ident_use_config_only
-			    && !(ident_config_given & IDENT_NAME_GIVEN))
-				die("user.useConfigOnly set but no name given");
+			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
+				fputs(env_hint, stderr);
+				die("no name was given and auto-detection is disabled");
+			}
 			name = ident_default_name();
 			using_default = 1;
 			if (strict && default_name_is_bogus) {
@@ -375,8 +377,10 @@ const char *fmt_ident(const char *name, const char *email,
 
 	if (!email) {
 		if (strict && ident_use_config_only
-		    && !(ident_config_given & IDENT_MAIL_GIVEN))
-			die("user.useConfigOnly set but no mail given");
+		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
+			fputs(env_hint, stderr);
+			die("no email was given and auto-detection is disabled");
+		}
 		email = ident_default_email();
 		if (strict && default_email_is_bogus) {
 			fputs(env_hint, stderr);
-- 
2.8.0-246-g1783343
