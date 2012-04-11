From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] remote-helpers: set up a pipe to read fast-import
 response
Date: Wed, 11 Apr 2012 09:10:09 -0700
Message-ID: <7v1ununtb2.fsf@alter.siamese.dyndns.org>
References: <20120411143249.GA4140@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:10:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI07l-0002tq-8a
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758647Ab2DKQKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 12:10:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36286 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755486Ab2DKQKR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:10:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D2737F1C;
	Wed, 11 Apr 2012 12:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DCFFj1FlR+ASP1vQnbxDb5BhJ+w=; b=RYKlQd
	1BZ7ovgUBE5Udqq/Psyz/9U6o/jN1OT96fnrVR2K0xT67WaXgyyBpi8SMfqpmv46
	5dAqhuPB4ZUyZtIT4ThquxD2kbruQl+3Gck1GlKE2Jkq5JujDwsRYkS7GsDu1Moq
	YYfULqz8f/Pm0pyR+iuaxUATErnzYfdS5Oka0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RNp2kmEsf2tXFqt3YZXBYOqPPyB47AY2
	L5FzrHkmGgzC4ieMCGjtny3Ue07wd/fxNHPMPZEAsFH0Nt2K7IYljd++AJqGBO45
	u7AM0bodpHjeozpN1uSOYnk+F6gYDM/IF9vYbMNJGDeouhdrpN8HLLrxuHc42Ryf
	KjIsUQfKGlU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 946AA7F1B;
	Wed, 11 Apr 2012 12:10:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4746D7F16; Wed, 11 Apr 2012
 12:10:11 -0400 (EDT)
In-Reply-To: <20120411143249.GA4140@burratino> (Jonathan Nieder's message of
 "Wed, 11 Apr 2012 09:32:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D09B1EAA-83F0-11E1-B34D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195196>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Something like this patch was sitting in my tree gathering moss but I
> quite like it so I thought I should send it out for feedback.
>
> I can't seem to find any copy of this patch in the list archives.
> Maybe I received it by private email.  Dmitry, do you remember better?
>
> Can also be found at
>
>   git://repo.or.cz/git/jrn.git topics/di/remote-helper-blob-access
>
> and will be part of the svn-fe-pu branch there in the next push.

Does this essentially connect the frontend and fast-import via
bidirectional pipes?  How is the flow control and deadlock avoidance
supposed to happen (I guess the side that wants to give a command to ask
for information needs to wait until it reads everything from the other
side to drain the pipe before doing so), and isn't it something that need
to be documented?
