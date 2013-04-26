From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] "git add -A/--no-all" finishing touches
Date: Thu, 25 Apr 2013 17:14:23 -0700
Message-ID: <7vhaiuywps.fsf@alter.siamese.dyndns.org>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
	<1366663435-13598-1-git-send-email-gitster@pobox.com>
	<7vhaiu1a89.fsf@alter.siamese.dyndns.org>
	<7v4neu19mj.fsf@alter.siamese.dyndns.org>
	<20130425232410.GN29963@google.com>
	<7vvc7ayy84.fsf@alter.siamese.dyndns.org>
	<7vobd2yy3c.fsf@alter.siamese.dyndns.org>
	<20130425235624.GO29963@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 02:14:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWJ6-0008SF-8a
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554Ab3DZAO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:14:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758011Ab3DZAO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:14:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 013F419B84;
	Fri, 26 Apr 2013 00:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sCzEELbD481zIK4uEeovdSDMgzU=; b=kt8elh
	a3j8Re7c0U7noxO0P9fmkCpKY073NSh1oZPoQpECAkW6j4RCgDOXgfszpPAlA0yZ
	tCWYr3/fdb6cfMJdhnoecebqnawzjsfvpVtCFqzu1pYxvhcv5AxS1ItNqDW2Qn3p
	q5zMDghyUeV++zclznJ574h3MxKrjWgL4kTLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L0sdFJuENjBjSMSR0NPtHQdqiQHIoYqk
	POVYRzRLACfJmWOnMlAXTEZ+rNksDRsYzl6CXYxp1pY8ubQbNKk7/bYOYB1t3vwP
	nMEwpkiU1RVE/5d/BeVyp5FQApd29SEQifZdAz26iXD6ZoHhUER57c9ozZx4q+0X
	BZX/PuEaGig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC6D419B83;
	Fri, 26 Apr 2013 00:14:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DF6F19B82;
	Fri, 26 Apr 2013 00:14:25 +0000 (UTC)
In-Reply-To: <20130425235624.GO29963@google.com> (Jonathan Nieder's message of
	"Thu, 25 Apr 2013 16:56:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40CAC9EC-AE06-11E2-8959-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222479>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Maybe the warning should happen after add_file_to_index() has run,
> letting git compare the old and new index entries for that path?

Yeah, new and deleted cases we do not have to worry about, so a
no-op add_file_to_index() is the only case we have to be careful.
There is a "if verbose, say 'add %s'" logic in the funciton, so it
should be possible to enhance the API without affecting existing
callers to extract that necessary information out of it.
