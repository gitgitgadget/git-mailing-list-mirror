From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Tue, 19 Jan 2016 17:46:55 -0800
Message-ID: <xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
	<20160119191234.GA17562@sigill.intra.peff.net>
	<xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
	<20160120002606.GA9359@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, larsxschneider@gmail.com,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:47:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLhrv-0002ub-Eh
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 02:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934670AbcATBr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 20:47:27 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934174AbcATBq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 20:46:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EACB53D4CF;
	Tue, 19 Jan 2016 20:46:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=462fMRLIhPHG3P+GUSGpSlZ2wz0=; b=iZ4O0l
	nkJ0eQVtnnFo8iMoKywXBrjjPmI5+NlVDpLKFwsFqoy+lNb/GaK0bt5eFSha8gIq
	6pCFczprCgGCFw50mE+Z3y+nEWKoJIF3dbZ/+gDy6de2qz1uNnMmQ788QWCI3m4G
	Ma6+SzDe1FWlNon/S6RX4gl3OQ/JVzTcapZjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j7SeV5eMl3p56LtWiy4l8i32jugjx8+i
	BlgQR93N4ujMkAG/D55aa6hQacmjd52kwM7uzXF6llC+/O3KAy7QmUekUXm8/psx
	T28bpR8NH9kXocR2nvLYDZx3piFXq9N5fEAwTMOa0jLWzoFjuBQGlgdg1Cb6zfVS
	2YXjmVDS4K0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E337B3D4CE;
	Tue, 19 Jan 2016 20:46:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6A7FC3D4CD;
	Tue, 19 Jan 2016 20:46:56 -0500 (EST)
In-Reply-To: <20160120002606.GA9359@glandium.org> (Mike Hommey's message of
	"Wed, 20 Jan 2016 09:26:06 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B01CAD4A-BF17-11E5-80C2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284409>

Mike Hommey <mh@glandium.org> writes:

> On Tue, Jan 19, 2016 at 03:00:52PM -0800, Junio C Hamano wrote:
>
>> I think 3 comes from this:
>> 
>>   http://thread.gmane.org/gmane.comp.version-control.git/279348/focus=279674
>
> Having recently looked into this, the relevant travis-ci documentation
> is:
> https://docs.travis-ci.com/user/ci-environment/
>
> which says all environments have 2 cores, so you won't get much from
> anything higher than -j3.
>
> The following document also says something slightly different:
> https://docs.travis-ci.com/user/speeding-up-the-build#Parallelizing-your-build-on-one-VM
>
> "Travis CI VMs run on 1.5 virtual cores."

Yup, that 1.5 was already mentioned in the earlier thread, but many
tests are mostly I/O bound, so 1.5 (or 2 for that matter) does not
mean we should not go higher than -j2 or -j3.  What I meant was that
the 3 comes from the old discussion "let's be nice to those who
offer this to us for free".
