From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: support NNTP
Date: Thu, 25 Apr 2013 10:35:10 -0700
Message-ID: <7vbo924ipd.fsf@alter.siamese.dyndns.org>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
	<7vobd5l277.fsf@alter.siamese.dyndns.org> <87txmw75bb.fsf@samsung.com>
	<7vip3bgax9.fsf@alter.siamese.dyndns.org> <87sj2fhzdx.fsf@samsung.com>
	<7vppxi4kkv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: l.stelmach@samsung.com (=?utf-8?Q?=C5=81ukasz?= Stelmach)
X-From: git-owner@vger.kernel.org Thu Apr 25 19:35:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVQ4r-0001B4-Ex
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 19:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024Ab3DYRfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 13:35:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932340Ab3DYRfP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 13:35:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C1E419242;
	Thu, 25 Apr 2013 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6tOhJLNyR+I7
	NQQIGGCAEP7W+mM=; b=oY0etC/y0IEq5j6GjhG+kshMbGuWaSUmC33KtcCxzI6L
	5Z0iyOuEVJcCC03zNuXdfYhI92IjWwvNcyBYOrRuapH8Mjc7h5CrNuDckzCXP53v
	ai7ym3LG9o7wOAv4CRC/hdKph0VFiOKNqromfgUixsC6CmEu0jd3v7O6rpvupFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o6S62X
	6dfNlyvpUkZQPykeyViSZib1MkGUWSjI502jEzPA47h9DVSV5QC2Hu3lkLzWK2uj
	IjA/mCM9uyUYPfee8HLT9TBZQIFs6OqcjdSvNC8qyKCpRYAQ0iWpx+epUNVwea4t
	vX5cq2jnSWiOdB/yyv+jCD7XQ7vYyItYjwFzo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DA3A19241;
	Thu, 25 Apr 2013 17:35:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B4E21923D;
	Thu, 25 Apr 2013 17:35:12 +0000 (UTC)
In-Reply-To: <7vppxi4kkv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 25 Apr 2013 09:54:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BAEF692-ADCE-11E2-A459-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222399>

Junio C Hamano <gitster@pobox.com> writes:

> l.stelmach@samsung.com (=C5=81ukasz Stelmach) writes:
>
>> OK, I see. Good point. Where would you recommend me to put these mod=
ules
>> and how to name them? I mean I don't want to make to much mess here =
(;
>
> I would not recommend you to do any of the above now.  As I said, the
> open-coded if/elsif cascade version you posted is fine as a starting
> point.  I'd prefer to see it made work correctly as advertised first
> with documentation updates and tests.
>
> A Perl guru might want to come and refactor the result once the code
> solidifies, but that should be left as a separate series.

An alternative structure of the patch, if you are feeling brave,
could go like this:

 (1) With a thought process similar to what I illustrated in my
     message you responded with "OK, I see. Good point.", identify
     all the codepaths that will need to become methods that are
     specific to the transport (SMTP or NNTP).

 (2) Without adding any NNTP goodies, refactor the current code to
     use a single class for driving conversation with a SMTP server.
     You will implement all the methods you identified in the
     previous step and the result will become "[PATCH 1/2]
     send-email: refactor to use a transport-specific class".

 (3) Implement a new class to drive conversation with an NNTP
     server, that has the same set of methods as the SMTP one you
     wrote in the previous step.  The result will become "[PATCH
     2/2] send-email: introduce NNTP transport".  This would need
     updates to the documentation.

I do not necessarily suggest you to go this route, by the way. It is
up to you and depends on how proficient you are (and how comfortable
you feel) dealing with modular Perl programs.
