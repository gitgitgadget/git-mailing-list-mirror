From: Junio C Hamano <gitster@pobox.com>
Subject: Re: C standard compliance?
Date: Wed, 29 Jan 2014 12:42:19 -0800
Message-ID: <xmqqwqhiikpg.fsf@gitster.dls.corp.google.com>
References: <87iot25y0r.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jan 29 21:42:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8bxs-0006D1-Ky
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 21:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbaA2UmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 15:42:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883AbaA2UmW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 15:42:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A50368AE1;
	Wed, 29 Jan 2014 15:42:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z+oe+l3yhclQJ+q/WX0xOy528dw=; b=itoTlk
	VbkwSptAbyLXon49VDvIZ7JMNVpdQ15oIwHlCSKMAw6L4Qxtx4SJr8yFSWg5t5VZ
	ckRKQGDWrYib1m71S/vpCcQ3Q88Q1DFzMnQA7/dsNlNz55mzfFIuEXe2VV3AKJvN
	apk/D3iSbw0i10AbuvnKP1RsGbOO9hMMm2pwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ci2wMGwEumJEBmSBLLqMvupF5Pnia5lo
	vyergGEiVK9JDkBDEs2hSzScvjTQJXfjUr98D8eUGTKvOThdSFfkWxFmMA7PPufH
	128WICCs51jdnPjoLA7vfq9TleAOJJBz1A5NxhFYATQi7TZ+wwCFiMlAr0SFO+eX
	lDhwUtodk6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1838A68AE0;
	Wed, 29 Jan 2014 15:42:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5433968ADF;
	Wed, 29 Jan 2014 15:42:21 -0500 (EST)
In-Reply-To: <87iot25y0r.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Wed, 29 Jan 2014 21:33:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D9E28BD8-8925-11E3-AE98-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241225>

David Kastrup <dak@gnu.org> writes:

> Hi, I am wondering if I may compare pointers with < that have been
> created using different calls of malloc.
>
> The C standard does not allow this (inequalities are only allowed for
> pointers into the same structure) to allow for some cheapskate sort of
> comparison in segmented architectures.

Hmm... if you were to implement a set of pointers in such a way that
you can cheaply tell if an unknown pointer belongs to that set, you
would use a hashtable, keyed with something that is derived from the
value of the pointer casted to uintptr_t, I would think.  Is such a
use of ((uintptr_t)ptr) unallowed?  If it is allowed, comparing two
unrelated pointers after casting them to uintptr_t would equally be
valid, I would have to think.
