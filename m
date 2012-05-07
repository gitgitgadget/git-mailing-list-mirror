From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] allow recovery from command name typos
Date: Mon, 07 May 2012 10:41:39 -0700
Message-ID: <7v62c77uss.fsf@alter.siamese.dyndns.org>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1336287330-7215-2-git-send-email-rctay89@gmail.com>
 <1336287330-7215-3-git-send-email-rctay89@gmail.com>
 <1336287330-7215-4-git-send-email-rctay89@gmail.com>
 <1336287330-7215-5-git-send-email-rctay89@gmail.com>
 <20120506082130.GB27878@sigill.intra.peff.net>
 <CALUzUxqXrsB8XfQL6vOiQo1pLHNRjxRUxJLRiK_mcSU8fvTSCg@mail.gmail.com>
 <878vh4con4.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 07 19:41:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRRwR-0008Kw-8k
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 19:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110Ab2EGRln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 13:41:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40068 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757078Ab2EGRlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 13:41:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B22A649E;
	Mon,  7 May 2012 13:41:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z1R+kyO/P5vVuZRa0lXyKlKj8cM=; b=Q7IpCN
	tTiEQb5Mh8h9fIXvhl7Vt7eQTwYtXbMKMqDjT7wwgltgQHs+ymvrgnIRgWA1FhXj
	Du8JA2QpS2iZKjZsG3NXY5V4jRPPDrGaXBm6txE1yoYfARUxw1wWr8ZmPwSujbsx
	DXAz//EVqAs5vAgib+hwacpdgypr9Zwfo6ljU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pUZpLoio3ZpUez8Gp/jGKnEscaoFuHF6
	us2l3DAVtZ1veJG0xw/Aopi+55hXDmzeEMIIeve12CiBHU+DE6hX4wORiYKpOt4G
	/IO7c6+KVV/stextnuoPYuxUwBup4Z1rYiItcXf7w6Gsf79zFyhnepZV6agH7oi5
	SiXeJQPiRSw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41AE0649D;
	Mon,  7 May 2012 13:41:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2A45649A; Mon,  7 May 2012
 13:41:40 -0400 (EDT)
In-Reply-To: <878vh4con4.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 7 May 2012 11:43:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7587978-986B-11E1-B848-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197286>

Thomas Rast <trast@student.ethz.ch> writes:

> We already have help.autocorrect.  It defaults to 0, which results in
>
>   $ g rebest
>   git: 'rebest' is not a git command. See 'git --help'.
>   
>   Did you mean one of these?
>           rebase
>           reset
>           revert
>
> But it can also be a timeout in deciseconds, after which the match is
> automatically executed (if there is only one).  You could hijack it by
>
> * making 'ask' mean your new feature
>
> * making 'off' etc. be the same as 0 for sanity
>
> * making the default value be like 0, but with an extra message such as
>
>     Use 'git config --global help.autocorrect ask' to let me prompt for
>     the correct command.
>
>   though I'm sure you can improve on the wording.

Sounds good.

By the way, does anybody actually use the deciseconds grace period to ^C
the process?  I know I was the guilty party for suggesting it, but it
strikes me that it is rather a dangerous option.  When checking out
another branch with great difference with "git chekcout foo", you would be
asked "did you mean checkout?", and if you hit ^C a bit too late, you may
not kill autocorrect but end up killing a lengthy "checkout" in the
middle, messing up the working tree with a mixture of files in old and new
branches, needing a "reset --hard" to recover.  We might want to update
the documentation to warn about this, even though I personally do not
think it is worth removing the support (and going through the trouble of
having to deal with "why did you remove the useful feature" complaints).
