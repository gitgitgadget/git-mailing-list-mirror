From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: new 'add-envelope' option
Date: Sun, 22 Nov 2009 15:54:03 -0800
Message-ID: <7v7htice04.fsf@alter.siamese.dyndns.org>
References: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
 <20091121193600.GA3296@coredump.intra.peff.net>
 <94a0d4530911211159l1fadad0ldb0d760439ceb57@mail.gmail.com>
 <94a0d4530911220437l5386b36ds4ef06dc66cc11bcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 00:54:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCMGA-000488-2X
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 00:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860AbZKVXyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 18:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbZKVXyI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 18:54:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790AbZKVXyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 18:54:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4AB65A0A4F;
	Sun, 22 Nov 2009 18:54:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M+TFC/WXpCVmBzrjyTnmGhbCIIs=; b=TOu6QN
	oOMEZZ7rJT7mZx+xsw2KL4R35A5TW+/PEdadSsqq/NQKoMr7nommdVRqk0Bl4iBx
	uWiHjQWlJvQwB0wXNNu0Evknj1zrTkvMwN7fur5qfOCe9ZCbkue4coYGFdrx5egg
	K9ahkDZqSNGZk2Ybj+QZRfmLSbO5rSR8N9bT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PEnf2fpnGqXMP0sW0TMt7hZ7aepbpXS1
	mjRWkwD0/Vt7yoQPTwWg/tyd9dEHyJHfoM9NZDYhXSRLGy9mf67JPEPScZbwkn6u
	CtY4STSqcLSJ2hNjN8I1/5/04o2xHW/i6cBDEZ/l981EVB/IB/eU4FGiK5z1TLXb
	K1q2TWiiyx8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B270A0A4E;
	Sun, 22 Nov 2009 18:54:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AFAF8A0A4D; Sun, 22 Nov 2009
 18:54:05 -0500 (EST)
In-Reply-To: <94a0d4530911220437l5386b36ds4ef06dc66cc11bcc@mail.gmail.com>
 (Felipe Contreras's message of "Sun\, 22 Nov 2009 14\:37\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 54011D36-D7C2-11DE-82C8-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133467>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I thought a bit more about this, and in the end what we really want is
> to add the sender envelope. The most typical case would be to use the
> 'from' address, but we should be able to override it (we do both by
> using --envelope-sender).
>
> So here are other options.
>
> a) --add-envelope: add the sender envelope, by default it would be the
> 'from' address, but could be overridden by --envelope-sender.

I do not think the latter half of this description makes much sense, as
the existing --envelope-sender=<this-address> alone already says "add this
envelope sender".

It is unfortunate that we cannot sanely have an option that takes an
optional string argument from the command line.  Ideally, if we can
specify --envelope-sender without any argument, we could make it to mean
"pretend as if the 'from' address is given to this option", but that would
make the command line pasing ambiguous, so we would need an extra option
like this one.  "--envelope-sender=from" might be a more intuitive way to
say this, though.

> b) --envelope-sender="" or "auto": this would require minimal changes
> but looks a bita strange.

An explicit empty string does look very strange, but I do not think a
magic word like "auto" (or "from") that cannot sanely be your envelope
sender address is a bad idea.

> Any thoughts?

It is much easier to work on the configuration front, by the way, and I
expect people who regularly interact with multiple projects to appreciate
this feature would configure their send-email once and forget about it, so
the command line clunkiness might not be such a big issue.

A user who works with more than one projects with different identity known
to each project would use $HOME/.gitconfig and send-email configuration
identity feature to set "sendemail.<identity>.from" and friends in there,
while setting sendemail.identity configuration in .git/config for each
project, so being able to say "use whatever 'from' as the envelope sender"
once in $HOME/.gitconfig would be convenient.

So I could have in $HOME/.gitconfig:

        [sendemail]
		; used as a boolean to say "use from"
                envelopesender
        [sendemail.git]
                from = Junio C Hamano <gitster@pobox.com>
                to = git mailing list <git@vger.kernel.org>
        [sendemail.frotz]
                from = Junio C Hamano <frotzster@example.xz>
                to = frotz mailing list <frotz@example.xz>

and then in my {git,frotz}.git/.git/config would have

        [sendemail]                     [sendemail]
                identity = git                  identity = frotz

respectively.  Without your patch, in $HOME/.gitconfig, I wouldn't have
the global sendemail.envelopesender but have separate individual
configuration variables sendemail.{git,frotz}.envelopesender defined.
