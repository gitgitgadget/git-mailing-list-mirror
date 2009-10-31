From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 19:01:58 -0700
Message-ID: <7vk4yccodl.fsf@alter.siamese.dyndns.org>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock> <20091031013934.GD5160@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 03:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N43IM-0005Fg-D7
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 03:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625AbZJaCCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 22:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757623AbZJaCCK
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 22:02:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757616AbZJaCCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 22:02:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C4E16D702;
	Fri, 30 Oct 2009 22:02:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TYeBflzAykSmkcG2zoFAHXK8rjM=; b=entAHY
	jk7U7SbhjvGJSRlEgI0V5mIGsqQslwlPRck1ZaLOIN3F1E6IAd70hW42I4GFk/eg
	zh1RmyXZMLOEQvIl6MvW8cki+U+CWF7GiGf8mSxr8aaZpAfnHNvpW5iyKEscgdbk
	3wCr7hBV+Ex0Ed1B993gsuh7tbsnMAo31Ua2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CeGe752yfRgrUdt67BTtT2egsoZXyPJx
	QukqByACS7AldQUVq+kYjNwSAgfxQbSNm41dYBIQFG6Nix8XXJDjp8s+/FyWXfUb
	3joNryRbRnKFlgowsCW4ZPHNtdXGJnUHx0BAkxMpQ+6NRmUu29dkby4hDacyrNo3
	wsFoYtDLp48=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16C136D6FF;
	Fri, 30 Oct 2009 22:02:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FE5E6D6FE; Fri, 30 Oct
 2009 22:02:00 -0400 (EDT)
In-Reply-To: <20091031013934.GD5160@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 30 Oct 2009 20\:39\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 64F26D9C-C5C1-11DE-BFA7-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131823>

Jonathan Nieder <jrnieder@gmail.com> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> Expose the command used by launch_editor() for scripts to use.
> This should allow one to avoid searching for a proper editor
> separately in each command.
>
> If no satisfactory GIT_EDITOR could be chosen, let "git var -l"
> output a warning.  This warning goes to stderr so as not to
> confuse scripts.  Example:
>
> 	core.logallrefupdates=true
>
> 	*** Please tell me who you are.
>
> 	Run
>
> 	  git config --global user.email "you@example.com"
> 	  git config --global user.name "Your Name"
>
> 	to set your account's default identity.
> 	Omit --global to set the identity only in this repository.
>
> 	GIT_COMMITTER_IDENT=user <user@domain> 1256952739 -0500
> 	GIT_AUTHOR_IDENT=user <user@domain> 1256952739 -0500
> 	warning: GIT_EDITOR: terminal is dumb, but EDITOR unset

Sorry, I cannot grok this example.  Is it supposed to be a transcript
of a user session?  What did the user type?
