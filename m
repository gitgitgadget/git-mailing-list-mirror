From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 15:36:22 -0800
Message-ID: <7v3at42avd.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 00:37:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDTQs-0007eP-IW
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 00:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761581AbYAKXgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 18:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761552AbYAKXgf
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 18:36:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023AbYAKXge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 18:36:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A3B923D37;
	Fri, 11 Jan 2008 18:36:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 13EA03D36;
	Fri, 11 Jan 2008 18:36:28 -0500 (EST)
In-Reply-To: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	(Stephen Sinclair's message of "Fri, 11 Jan 2008 15:10:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70222>

"Stephen Sinclair" <radarsat1@gmail.com> writes:

> @@ -423,8 +423,18 @@ static int prepare_log_message(const char
> *index_file, const char *prefix)
>  			"#\n",
>  			git_path("MERGE_HEAD"));
>
> +    fprintf(fp, "\n");
> +
> +    fprintf(fp,
> +            "# Committer: %s\n"
> +            "# Author:    %s\n"
> +            "#\n",
> +            fmt_name(getenv("GIT_AUTHOR_NAME"),
> +                     getenv("GIT_AUTHOR_EMAIL")),
> +            fmt_name(getenv("GIT_COMMITTER_NAME"),
> +                     getenv("GIT_COMMITTER_EMAIL")));
> +

I'd almost agree with this patch if if added AUTHOR but not
COMMITTER, and only when AUTHOR is different from me.  That
would help reassure anybody while amending other's changes.
COMMITTER is always me and I should not reminded with extra
lines that waste precious screen real estate.

And no, I did not check if your change correctly supports the
use case of amending other's changes.  But if I recall the code
correctly, I suspect that your change doesn't.  The recorded
author is determined after the log message is prepared, way
later.

I strongly agree with Dscho that this change needs to be
defended with a good description on the reason why this is good.
If the reason is "newbie protection", I do not think this is a
good change at all.  Newbie protection is never a good reason to
make people who graduated that state to pay extra price
unconditionally.
