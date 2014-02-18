From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Tue, 18 Feb 2014 11:51:05 -0800
Message-ID: <xmqqtxbwdwt2.fsf@gitster.dls.corp.google.com>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home>
	<CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
	<xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
	<20140215085355.GA15461@lanh>
	<xmqqha7wfdld.fsf@gitster.dls.corp.google.com>
	<20140218193520.GB1048@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 18 20:51:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFqhL-0004u0-Cx
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 20:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbaBRTvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 14:51:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbaBRTvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 14:51:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CB886D75F;
	Tue, 18 Feb 2014 14:51:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5WSbsCG+n+zY+JMKwVyiej2aEIA=; b=kxdwQJ
	nwlAHIFBIVkVl0Ul3x98+m5PCcsPtBXRz24svWBbP0ZplZ3f2XeRXUPsHJFNkkSS
	ohOZYdoCwD3yDg1zmy22ECTPpQV25E8E611lEXe/EPwamY5nbHh+2h0zQ18nBCrb
	MUi51VcVdhu/MirjmalscMlRM7IwtTAjLkfuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=swGgKjoAifqm5x4kKD5CeIWFY7ryFNCz
	yU1U7GZx0cBooKN9vW5wEvHXuLGTtHo1fapvwLTaoyN3U7vi17DlU1UMST/PD7Rv
	aiw1rUs8xtt9Mq6hgg4//VuBjop6KOYuk+mRNqo/Y5FSVDhqYI9QhFyIQYPc/91Q
	dDrnczNRPxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E6366D75B;
	Tue, 18 Feb 2014 14:51:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEF496D758;
	Tue, 18 Feb 2014 14:51:08 -0500 (EST)
In-Reply-To: <20140218193520.GB1048@serenity.lan> (John Keeping's message of
	"Tue, 18 Feb 2014 19:35:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 02CDA694-98D6-11E3-8576-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242346>

John Keeping <john@keeping.me.uk> writes:

> There's already the arbitrary set of prefixes in
> refs.c::prettify_refname() and refs.c::ref_rev_parse_rules().  I can see
> how a user might think that since "git log refs/heads/name" is
> equivalent to "git log master" then "git branch refs/heads/name" should
> be equivalent to "git branch name".

Not quite, I am afraid.  Branch names used for "git branch <name>"
and "git checkout <name>" are like the Lvalue of an assignment, as
opposed to extended SHA-1 expressions to express any commit
(e.g. 'master^0', 'refs/heads/master', or 'master') that correspond
to the Rvalues used in an expression.  Because "git checkout" can
take a branch name or an arbitrary commit object name, there needs a
way for the users to disambiguate.

Saying that "git checkout refs/heads/name" must be equivalent to
"git checkout name" is like arguing that assignment "value+0 = x"
should be valid because "value+0" is a valid value.

For the first parameter to "git branch", there is no ambiguity---it
must be the name of a branch and cannot be an arbitrary commit
object name, so special casing "git branch refs/heads/master" to
mean "git branch master" may not be too bad.  But then we need to
either start rejecting "git branch refs/tags/v1.0" or keep allowing
it to create a ref refs/heads/refs/tags/v1.0 to denote the branch of
that exact name given---neither of which is more consistent, so...
