From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Tue, 13 Aug 2013 09:49:46 -0700
Message-ID: <7vk3jpy1qt.fsf@alter.siamese.dyndns.org>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
	<7veh9z1gym.fsf@alter.siamese.dyndns.org>
	<CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
	<CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Jeske <davidj@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 18:49:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Hn9-0003n2-9u
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 18:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591Ab3HMQtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 12:49:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757445Ab3HMQtu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 12:49:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A318A3829D;
	Tue, 13 Aug 2013 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q/cA493JzHgipX9eMf/lebKW19A=; b=jA589r
	F1R2nk9Wss4cGLx7RTX3JaIUlRYDFxwbCLIXtsY+3b1ZfLWVoBKa1Q+qPWcGLzuA
	9SEmT4AkraQYqF3VQQSWv/z+0pEhKmu5kwIvTLvceHce+ZkdN2Lil7SjN1RZU6/i
	DLsC9vH5ZHXF2WOr07O8JCkqmi9UYbb7UVYCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uo2aaG/e1XvYPVPN5F59zTnKw94jW37F
	fwJJB4OHJcvWdw3QCPA92QDwkC+9JDzOzIaJrWpuKxsrf+Ei/8u/tTqn+APOVMk8
	KBFm6/kkmCg1h/mZgcd/Irw4nv1kTAt4gBiY+hxdHqalG8jGElyH3bRCDLE2Wruz
	eJplHyNM3kE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B3B43829C;
	Tue, 13 Aug 2013 16:49:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEBF638297;
	Tue, 13 Aug 2013 16:49:47 +0000 (UTC)
In-Reply-To: <CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 13 Aug 2013 13:05:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D46A932-0438-11E3-823D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232234>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Aug 12, 2013 at 3:37 PM, David Jeske <davidj@gmail.com> wrote:
>> Is there currently any way to say "hey, git, show me what commits are
>> dangling that might be lost in the reflog?"
>
> How do you define dangling commits? When you do "git commit --amend",
> the current commit will become dangling (in the sense that it's not
> referred by any ref, but the commit exists) and those are just noise
> in my opinion.

"fsck lost-and-found" would be one way.  It would be nice if we had
something like (note: the following will _NOT_ work)

	git log -g HEAD --not --branches

to say "walk the reflog of HEAD, but exclude anything that can be
reached from the tips of branches".
