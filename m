From: Junio C Hamano <gitster@pobox.com>
Subject: Re* manpage for git-pull mentions a non-valid option -m in a comment
Date: Tue, 14 Jan 2014 10:26:21 -0800
Message-ID: <xmqqvbxm4dyq.fsf@gitster.dls.corp.google.com>
References: <loom.20140114T025825-557@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ivan Zakharyaschev <imz@altlinux.org>
X-From: git-owner@vger.kernel.org Tue Jan 14 19:26:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W38h5-0007mL-La
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 19:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbaANS02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 13:26:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbaANS00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 13:26:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 257D661241;
	Tue, 14 Jan 2014 13:26:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WxnAsZQIWuru1Uk+DsJSocRInQE=; b=dK11Gn
	lsCQJkiNf3eSGs7VmcrTXCsQbPHvDPBEQHSuxcuoSndXBwY06iCl5oZ3IReeuPo3
	E/aFRw6rzA1o3NSXYwzHSwU56QX3vRpaIoCJuM1WgOFoFtV64QZlKgBnbqwQgzK5
	eChOxcSXY/F5y1TPgcSnpPyWj7wjStYP4Zgos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n1VeIEVEX8ufthXUWeO7+4XxMLRysaog
	tQPglpp/VzrWf1eqcclRQuYn4/R8KplV8eCHwom70IgTKcnkuhRLgFIUn/kWwtgU
	bfeBMWu4GOiBamHtEESERrVpvwNvAtGnkcGhjJ+NGVIyEJbsWevLZTiVacEe12iu
	gJz8KOHFM5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 111A061240;
	Tue, 14 Jan 2014 13:26:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4709B6123F;
	Tue, 14 Jan 2014 13:26:25 -0500 (EST)
In-Reply-To: <loom.20140114T025825-557@post.gmane.org> (Ivan Zakharyaschev's
	message of "Tue, 14 Jan 2014 02:09:47 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 604D2C70-7D49-11E3-88E5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240404>

Ivan Zakharyaschev <imz@altlinux.org> writes:

> Hello!
>
> git-1.8.4.4
>
> The manpage for git-pull mentions -m in a comment:
>
> --edit, -e, --no-edit
> Invoke an editor before committing successful mechanical merge to further edit
> the auto-generated merge message, so that the user can explain and justify the
> merge. The --no-edit option can be used to accept the auto-generated message
> (this is generally discouraged). The --edit (or -e) option is still useful if
> you are giving a draft message with the -m option from the command line and
> want to edit it in the editor.
>
> but it is not accepted actually:

I do not think "git pull" ever had the "-m <message>" option; what
you are seeing probably is a fallout from attempting to share the
documentation pieces between "git pull" and "git merge" too
agressively without proofreading.

It seems that there are two issues; here is an untested attempt to
fix.

-- >8 --
Subject: Documentaiotn: exclude irrelevant options from "git pull"

10eb64f5 (git pull manpage: don't include -n from fetch-options.txt,
2008-01-25) introduced a way to exclude some parts of included
source when building git-pull documentation, and later 409b8d82
(Documentation/git-pull: put verbosity options before merge/fetch
ones, 2010-02-24) attempted to use the mechanism to exclude some
parts of merge-options.txt when used from git-pull.txt.

However, the latter did not have an intended effect, because the
macro "git-pull" used to decide if the source is included in
git-pull documentation were defined a bit too late.

Define the macro before it is used to fix this.

Even though "--[no-]edit" can be used with "git pull", the
explanation of the interaction between this option and the "-m"
option does not make sense within the context of "git pull".  Use
the same conditional inclusion mechanism to remove this part from
"git pull" documentation, while keeping it for "git merge".

Reported-by: Ivan Zakharyaschev
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/git-pull.txt      | 4 ++--
 Documentation/merge-options.txt | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 6083aab..200eb22 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -99,10 +99,10 @@ must be given before the options meant for 'git fetch'.
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-include::merge-options.txt[]
-
 :git-pull: 1
 
+include::merge-options.txt[]
+
 -r::
 --rebase[=false|true|preserve]::
 	When true, rebase the current branch on top of the upstream
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index afba8d4..e134315 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -14,9 +14,12 @@ inspect and further tweak the merge result before committing.
 	further edit the auto-generated merge message, so that the user
 	can explain and justify the merge. The `--no-edit` option can be
 	used to accept the auto-generated message (this is generally
-	discouraged). The `--edit` (or `-e`) option is still useful if you are
-	giving a draft message with the `-m` option from the command line
-	and want to edit it in the editor.
+	discouraged).
+ifndef::git-pull[]
+The `--edit` (or `-e`) option is still useful if you are
+giving a draft message with the `-m` option from the command line
+and want to edit it in the editor.
+endif::git-pull[]
 +
 Older scripts may depend on the historical behaviour of not allowing the
 user to edit the merge log message. They will see an editor opened when
