From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: add instructions to the commit message when
 editing
Date: Mon, 30 Jan 2012 13:03:35 -0800
Message-ID: <7vy5soaons.fsf@alter.siamese.dyndns.org>
References: <7vd3a1caxb.fsf@alter.siamese.dyndns.org>
 <0c9a880c7dca27520f957446c6b0e72e93609b03.1327954927.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 30 22:03:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RryO8-0004Fh-3D
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 22:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab2A3VDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 16:03:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583Ab2A3VDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 16:03:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D34A1731C;
	Mon, 30 Jan 2012 16:03:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ooSHZ5dUmRkpPcFJBaD+klKUcxY=; b=Dl/mpo
	voH6JO+0WBHCJQzloPELsE7/vy//+YWoo0dk2QybhioajwnNlzOKWjoFDRB1cqDD
	LT+KhiGpYdOZtPoL+3WGSRirtDoiocH2DokTH83g75sIMaEWbb5a1vMsOWubxG5X
	IWEL/095Ycf63a+FDzf3OSOEyNi9IN3/C83xY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rnQOWaOZuoFveA2D3ShlZywjz2xwOUe/
	znSj95Uh2eGmMxAceXgms36vqsTSESutXAxUAGsvDfwhhyjEE5odHJBusD8nY6pI
	Mw6Hbro38EmdsTNpMOFlKl0KO5i/P/6Ijfs2V0rH0rEyTRucFs9/O8xKZ0x/jqH5
	ejG8WwY3/OA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAF37731B;
	Mon, 30 Jan 2012 16:03:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6347E731A; Mon, 30 Jan 2012
 16:03:37 -0500 (EST)
In-Reply-To: <0c9a880c7dca27520f957446c6b0e72e93609b03.1327954927.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon, 30 Jan 2012 21:25:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0ECDABC-4B85-11E1-A815-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189423>

Thomas Rast <trast@student.ethz.ch> writes:

> The sentence about justification is one of the few things about
> standard git that are not agnostic to the workflow that the user
> chose.

We try to be agnostic at plumbing level, but I do not think we ever made
such a promise at the Porcelain level like "git merge". On the contrary,
we try to encourage good workflows by coding behaviours to support BCP to
Porcelain commands.  Am I misreading what you were trying to say here?

> diff --git a/builtin/merge.c b/builtin/merge.c
> index bfb7547..ed628b8 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -885,11 +885,22 @@ static void abort_commit(const char *err_msg)
>  	exit(1);
>  }
>  
> +static const char merge_editor_comment[] =
> +N_("Please enter the commit message for your merge commit.  You should\n"
> +"justify it especially if it merges an updated upstream into a topic\n"
> +"branch.\n"
> +"\n"
> +"Lines starting with '#' will be ignored, and an empty message aborts\n"
> +"the commit.\n");

I am tempted to rewrite this a bit, perhaps something like ...

  Please enter the commit message for your merge commit.  Explain
  why the merge is necessary, especially if it merges an updated
  upstream into a topic branch.

... because people who need to be told to "justify it" would probably be
helped by a more explicit "explain _why_ it is needed".
