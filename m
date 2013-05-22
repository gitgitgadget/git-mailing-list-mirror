From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] transport-helper: check if the dry-run is supported
Date: Tue, 21 May 2013 17:47:35 -0700
Message-ID: <7vip2blu1k.fsf@alter.siamese.dyndns.org>
References: <1369099924-13763-1-git-send-email-felipe.contreras@gmail.com>
	<7vli78p920.fsf@alter.siamese.dyndns.org>
	<CAMP44s14ZBUYhxDkSwjoi+6JPx4whfQDhiq_4QfMteALsbuQ_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 02:47:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UexDT-0007LK-6E
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 02:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab3EVArj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 20:47:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373Ab3EVAri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 20:47:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B642B1A182;
	Wed, 22 May 2013 00:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CXOlfu7d5M6gBaN/LAPgW4d2czg=; b=nWyEwM
	Xf/vxUni5XlMQU496fqeik2aBeOoIFSKtdJpz2aPJitm4RDxwiwB43nIUAI5GprX
	Ksyy/a6IC8+qY2q1U8UqpWMOUfa8AxK7LZQ+uHlN49DHkYKTEiYcnFpZMtfmoA0C
	TU6SkkfCXKZ9kvzovlxHEzd67YXUvLYmk+2Is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bch+hA8G+NKxjqxcitv/tN9e447oNzuj
	o5I74Ut0DL/3BuyOIembEk1ExZHrl1/bB2ahHDGCZMsowF5fmyM039UxhOtUGFma
	RH6LosZeg0gjmK0Tt2kKh8Zs3SJdDhrjk/tBUUB/vhCDJQFnHmVOvjGZHMD0LaeO
	fgwPB9yLS9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A91AE1A181;
	Wed, 22 May 2013 00:47:37 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0837B1A17D;
	Wed, 22 May 2013 00:47:36 +0000 (UTC)
In-Reply-To: <CAMP44s14ZBUYhxDkSwjoi+6JPx4whfQDhiq_4QfMteALsbuQ_Q@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 21 May 2013 16:14:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 329BE3D8-C279-11E2-87EB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225102>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, May 21, 2013 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> This sounds like a good thing to do.  Perhaps the refspec mapping
>> can be handled the same way as a backend feature so that you do not
>> have to unconditionally disable it in the other patch.
>
> With my patch the remote helper doesn't need to know about the refspec
> handling at all, it just works magically.

The consumers of "git fast-export" do not need to know how to flip
refspecs when consuming output from "git fast-export", because you
taught "git fast-export" to do the mapping.

But doesn't that coin have a flip side?  When somebody else (not
git) generates a fast-import stream, because these consumers are not
prepared to flip refspecs, they cannot rename while importing.  All
the producers have to be taught to do the ref mapping.

I do not know if this matters in real life, and even if it did, in
the eventual ideal world, both importers and exporters would learn
to do so.  So I do not think what you did in your patch is a bad
design in that sense.  It is a half step in the right direction.

I however found it somewhat ugly that the interface to specify set
of refs to traverse history to find the set of objects to export
stays the same as before, and the ref-mapping arguments are bolted
on to the machinery, without having any relationship between them.
The user is free to tell it to export only 'next', while telling it
to map 'master' to 'trunk', for example.

This is an external interface that is exposed to any users of "git
fast-export", so if we go that route, we would have to keep that
interface working forever, even when later somebody else wants to
add an interface that only requires ref-mapping arguments (and infer
what is exported from the left hand side of the refspecs).

That part is what I found is less than ideal in the patch.
