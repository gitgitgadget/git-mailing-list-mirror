From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug report? fatal: Ambiguous object name: 'xxx' during branch
 operation
Date: Tue, 06 Mar 2012 15:44:01 -0800
Message-ID: <7vvcmhpa66.fsf@alter.siamese.dyndns.org>
References: <CAB1hNr8itJV1-pzWxUo1KPsZNivg+KuRq_5jUwLUyCUpk7k=4w@mail.gmail.com>
 <CAB1hNr8-iPbXD-7eEOxZtrJWO78V8sDmwWWQRMMExvtGtpPrhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arya Irani <arya.irani@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:44:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5439-0000qc-6q
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 00:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759151Ab2CFXoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 18:44:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754592Ab2CFXoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 18:44:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E7006DB6;
	Tue,  6 Mar 2012 18:44:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lrVrvn7Rlu8NrW9V4iPwWSkjZ0I=; b=dX+zwy
	RO1HhUSgv7EmwALrj3kFoqJmVi/e3/6kOMJ6XUB8IyVZx/3HoVsjYlQrNF8rKP0r
	zz2f3tc2hfjdr4WHwljE2UsyddWQU7vsI62JJXYZYTqLU1iqczH5x0ewA1mJhQK8
	RIDiL3drZNSniz8oC3WN+RHWdmf6ZeoVqcrTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=woAC7KARi5uXCY0JBqQ/eYkVOyhQkIfR
	4wk+fyY0/+sD0dG4IiDcx6izO+9wDKlYdnDc2dMsBcwDnE2GN45DmybT43uvdU51
	IbXzoPBiPoGuCKEDJSw5DrIkpMR5vKuwOvoW0Ahxkza+J2VyGagDO52LM+fA5Gwy
	fFYcZYDncC4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F1C46DB5;
	Tue,  6 Mar 2012 18:44:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA9C16DB3; Tue,  6 Mar 2012
 18:44:02 -0500 (EST)
In-Reply-To: <CAB1hNr8-iPbXD-7eEOxZtrJWO78V8sDmwWWQRMMExvtGtpPrhw@mail.gmail.com> (Arya
 Irani's message of "Tue, 6 Mar 2012 18:18:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40EACF24-67E6-11E1-A1CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192417>

Arya Irani <arya.irani@gmail.com> writes:

> If the default start-point for a branch is HEAD, then how can it fail
> due to ambiguity?

The whole create_branch() codepath is a mess and needs to be cleaned
up, but in the shorter term, something like this, perhaps?

 builtin/branch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d8cccf7..02d0653 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -807,7 +807,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (argc > 0 && argc <= 2) {
 		if (kinds != REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
-		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
+		create_branch(head, argv[0], (argc == 2) ? argv[1] : "HEAD",
 			      force_create, reflog, 0, track);
 	} else
 		usage_with_options(builtin_branch_usage, options);
