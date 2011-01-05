From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false
Date: Wed, 05 Jan 2011 10:51:09 -0800
Message-ID: <7vsjx7chgi.fsf@alter.siamese.dyndns.org>
References: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net>
 <7vsjxjyce6.fsf@alter.siamese.dyndns.org>
 <20101227080343.GA15026@orbis-terrarum.net>
 <982E526FA742C94E9AC26DA766FD07090A3399@NYCMBX3.winmail.deshaw.com>
 <vpqhbdoxpzp.fsf@bauges.imag.fr> <20110104225826.GA2122@burratino>
 <7vmxngdys8.fsf@alter.siamese.dyndns.org>
 <982E526FA742C94E9AC26DA766FD07090A33A5@NYCMBX3.winmail.deshaw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Vallon\, Justin" <Justin.Vallon@deshaw.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 19:51:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaYSQ-0007iH-W6
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 19:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab1AESv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 13:51:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab1AESvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 13:51:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C3244FD2;
	Wed,  5 Jan 2011 13:52:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ygK+imRq5DNgjGrZ6RRj/N34EG4=; b=OBjdwk
	89LaSI87NnJeqVwST7kxLlMLk0zuvV4DVVJszg2dFzg9ZUyDa9j6FukmxMz6iIwI
	nbFUCCYuvw9LFT+NZibIOvXlz/mNYE4AHd1BM88QyLMDtqXR3J2YpULbjjHZqN3r
	7Cv7h0c7lj+PQtXqRln61ZoMUVnjcMvHd0OcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M0rJabGCMs9bazVx4MjTw2HY1TcGIbFU
	W1gWWWhl6HC8+PgW2AiSkSOGmazyj/tNFPNVq8MYG9nhXddpw6xfCnNPhXz3pbis
	cpbmSMmwTloATD12QnQDT/uJfvsAL+ljj1gdDhVakWidolCUxgnlE7Qmrsgz6R8k
	UybLoKEIvUQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD9754FCD;
	Wed,  5 Jan 2011 13:51:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 215FA4FCC; Wed,  5 Jan 2011
 13:51:49 -0500 (EST)
In-Reply-To: <982E526FA742C94E9AC26DA766FD07090A33A5@NYCMBX3.winmail.deshaw.com> (Justin
 Vallon's message of "Wed\, 5 Jan 2011 10\:04\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DEB01E7E-18FC-11E0-80A8-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164582>

"Vallon, Justin" <Justin.Vallon@deshaw.com> writes:

>>Because POSIX shells are required to mark variables they inherit from the
>>environment with the export attribute, your tests will run with SHELL
>>exported to the environment if your usual shell is bash (i.e. SHELL is
>>already exported to processes it spawns), even if you use another POSIX
>>shell to run your git and tests.  That makes the issue doubly harder to
>>notice.
>
> I don't really follow this.  The #! line is /bin/sh.  The user's $SHELL
> does not come into play.  Either SHELL is in /bin/sh's environment and
> it should be cleared in the child, or it isn't and it won't matter.

Read what you are responding to again.

The "doubly harder to notice" is _not_ about gentoo's /bin/sh, but about
the experiment Matthieu did (ask: "what shell spawned t3404 that has the
she-bang /bin/sh?").

If that shell is bash, which automatically marks SHELL with the export
attribute, it places the variable in the environment.  t3404 is run under
/bin/sh, which presumably is POSIX and initializes its shell variable SHELL
with what was in the environment, and while doing so, it also marks the
variable with the export attribute.  The script does not "unset SHELL" but
merely assigns an empty string to it, which is the value to be exported to
the processes the script runs.

Imagine that whoever was having trouble did not have SHELL exported to the
environment when t3404 is run.  The script assigns an empty string to its
shell variable SHELL but nothing marks the variable with the export
attribute, hence the processes the script runs will never see that as the
value of the environment variable (in fact, they wouldn't see SHELL
environment variable at all).
