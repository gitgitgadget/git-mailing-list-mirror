From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] revert: Implement --abort processing
Date: Thu, 02 Jun 2011 09:41:42 -0700
Message-ID: <7vboygdw3d.fsf@alter.siamese.dyndns.org>
References: <1306944446-11031-1-git-send-email-artagnon@gmail.com>
 <20110601190006.GB9730@elie>
 <BANLkTikgY_Kc6gu_iTtpiiayo9e=DPxOLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 18:42:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSAyC-00060O-VB
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 18:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197Ab1FBQl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 12:41:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab1FBQl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 12:41:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 752FC573A;
	Thu,  2 Jun 2011 12:44:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0g1XA2LfvYzchNGoXGi0TsXe+ns=; b=C43H7Q
	fFqnSxzgEA1s9g1A2sp39gdaXSCseVDVky6ZwvU2ET6EHEyooOqhT9o8Bw6q9LVC
	NogBjmQNOulSBeOQ3UtcmTloSuDYOMvTgINPk3tBM+CNPhF2O9IM91KlwZxlQoX7
	M2FI/5xdW6QvQZP3V258sj4Jj7HC1tuDfgl2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sJallTdFxCnkGTLhxhIwuM+EGYY4Cp60
	7fH6+MY/Wnl3U6AUFVgfD7oLNmMYj7Tiud26tsM8Z+P5Z1d3mNO/nPpODdtRJSkB
	tSvlD5E55BwA0T0/LfD3sP7BY0gxIX38jB9wxob8eayXYYfkcyhQGbdtO+GTgoTu
	6ShXwcxlIs4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 072E05739;
	Thu,  2 Jun 2011 12:44:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 387ED5738; Thu,  2 Jun 2011
 12:43:51 -0400 (EDT)
In-Reply-To: <BANLkTikgY_Kc6gu_iTtpiiayo9e=DPxOLw@mail.gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 2 Jun 2011 18:33:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 840EEF90-8D37-11E0-83D5-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174960>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I see now that this probably doesn't fit everyone's usecase. So the
> changes I propose are:
> 1. Don't rerere clear. We can probably document this fact somewhere,
> and hint the user about this during the time of abort.
> 2. Use reset --merge as Sverre suggested.
>
> I'll think about this workflow and post a patch soon.

Please do the former but I would advice you not to do the latter.

If you do not clear rerere then you are not serving the original audience
you wanted to serve, and if you do, you are hurting people when they do
want to keep rerere. You cannot win either way.

The users are better off being exposed to "reset --merge" than kept
unaware of the concepts necessary to do what they want hidden behind
"revert --abort" that has fuzzy semantics that restores some but not all,
with the definition of "some" being something we happened to decide here,
which can never match what the user in every situation would want.
