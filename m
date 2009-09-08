From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: [PATCH] post-receive-email: do not call sendmail if no mail was generated
Date: Tue, 8 Sep 2009 20:55:55 +0200
Message-ID: <20090908185555.GA3858@lars.home.noschinski.de>
References: <1251481187-6361-1-git-send-email-lars@public.noschinski.de> <20090908092059.GA8207@lars.home.noschinski.de> <7vk5098jcv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Gerrit Pape <pape@smarden.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 21:16:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml6BT-0006QX-O6
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 21:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbZIHTQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 15:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbZIHTQp
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 15:16:45 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:54207 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbZIHTQp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 15:16:45 -0400
Received: from [87.78.95.112] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1Ml5pJ-0006Fe-IX; Tue, 08 Sep 2009 20:54:01 +0200
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1Ml5r9-0001vT-Mj; Tue, 08 Sep 2009 20:55:55 +0200
Content-Disposition: inline
In-Reply-To: <7vk5098jcv.fsf@alter.siamese.dyndns.org>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128025>

* Junio C Hamano <gitster@pobox.com> [09-09-08 19:22]:
> Lars Noschinski <lars@public.noschinski.de> writes:
> > * Lars Noschinski <lars@public.noschinski.de> [09-08-28 19:39]:
> >> contrib/hooks/post-receive-email used to call the send_mail function
> >> (and thus, /usr/sbin/sendmail), even if generate_mail returned an error.
> >> This is problematic, as the sendmail binary provided by exim4 generates
> >> an error mail if provided with an empty input.
> >> 
> >> Therefore, this commit changes post-receive-email to only call sendmail
> >> if generate_mail returned without error.
> >> 
> >> Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
[...]
>  - Slurping generate_email's output into a shell variable is a bad taste.
>    You said that the message is always small enough but _how_ do we know
>    it?

You are right; I overlooked that the revision formatting is configurable
and if set up to display the full patch, the mail could get pretty big.

I know found a solution which does neither store the full output in a
variable nor needs a temporary file. I will post it as a reply to this
mail.

>  - If this is to save us from a quirk in some but not all implementations
>    of /usr/lib/sendmail, then shouldn't the logic be made into a new
>    conditional?

I don't know if this a quirk in exim; I could not find a formal
specification of the sendmail behaviour and treating such an "input" as
an error seems at least not insane.

In any case, I think the overhead implied by new patch is small enough,
that a switch is unnecessary.

>  - I do not see a direct link between "if generate_mail returned an error"
>    and "if ... an empty input".  What if generate_mail started its output
>    but then failed halfway?  We have some output so the send_mail won't be
>    fed empty, but $? would be not zero, so the patch is testing a
>    different condition from what the log message claims to be checking.

Yeah, you are right. This is also fixed in the new patch.

> People who do use this script and people who have worked on it may have
> other more useful comments.

CCed some of them.
