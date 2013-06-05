From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/15] for-each-ref: get --pretty using format_commit_message
Date: Wed, 05 Jun 2013 10:09:55 -0700
Message-ID: <7v61xs32n0.fsf@alter.siamese.dyndns.org>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
	<1370349337-20938-9-git-send-email-artagnon@gmail.com>
	<CAPig+cRmnc=poOZUxZms_OWdLpBM_q=h+MDYisu8WtuF11PYXA@mail.gmail.com>
	<CACsJy8ABwroExpXQRX8OYAnDum9+sX1+JB9z+WNn+YcZoXi5KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 19:10:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkHDu-0001S5-0V
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 19:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748Ab3FERKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 13:10:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755901Ab3FERJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 13:09:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31E8623C50;
	Wed,  5 Jun 2013 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c4tdz0ExJjQHJZotGN3WKeGpoio=; b=mDfZiB
	4nBAxqW3ji6kGkQHTxvXKMzTDusarD6vurBPquY2uZrkfhxbunXIZPSFyjTh4ukl
	9zlFFMNX+uH4fjVGMuPKzm9goyu2CBpmQ9v324u2oXdGLDoXdFhLhb2DjhPlbjAE
	wqXxEiZHmTf1qPSJKvWJ96RfAIkfxWV8sopT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yQz45uXP8zERugElpW/OdRL7nDl2hq/8
	AQUB4RVG18FyyeamTustJqjU+iii+QnRfyPuNpUmSTIY4SyiuYDGNNKwfNyI8EKu
	auFvXR3rqm/XeuBgi8uOUPOsfaYbV+hdo0SLOb+vb7Y3tIQZUFzSjgqZTDqnF+01
	dT8EAXzgWcM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2262A23C4F;
	Wed,  5 Jun 2013 17:09:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DCE023C4B;
	Wed,  5 Jun 2013 17:09:57 +0000 (UTC)
In-Reply-To: <CACsJy8ABwroExpXQRX8OYAnDum9+sX1+JB9z+WNn+YcZoXi5KA@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 5 Jun 2013 20:21:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF9404F2-CE02-11E2-B67E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226460>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jun 5, 2013 at 4:12 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +Caveats:
>>> +
>>> +1. Many of the placeholders in "PRETTY FORMATS" are designed to work
>>> +   specifically on commit objects: when non-commit objects are
>>> +   supplied, those placeholders won't work.
>>
>> Should "won't work" be expanded upon? It's not clear if this means
>> that git will outright crash, or if it will abort with an appropriate
>> error message, or if the directive will be displayed as-is or removed
>> from the output.
>
> It will be displayed as-is but that's a bit inconsistent: %(unknown)
> prints error and aborts while %unknown simply produces %unknown. The
> latter is how "git log --format" does it. But I think we could make
> for-each-ref --pretty to do the former for %unknown. It'll be
> consistent with %(unknown) and we do not need to elaborate much (it's
> pretty obvious when it does not work).

The Caveat Eric is asking about talks about "what happens to a
%(field) that only makes sense for a commit when showing a ref
pointing at a non-commit?", but you are answering "what happend to a
%(invalidfield) that is not defined", aren't you?

IIRC, the reason we show literal from "log --format" is to make it
easier for the person who misspelt %placeholder to spot it in the
output, and also make it easier for the person who use %placeholder
meant for newer versions of Git with an older one.  It would be a
bit unnice to die for the latter, especially if the format string is
in a script or something.

To "log --format", all input objects are expected to be commits, so
it does not have the "what does %(authordate) give when given a blob"
issue.

But for "for-each-ref --format", it is perfectly normal that you may
feed a non-commit; it makes the mechanism unusable if you errored
out %(authordate) when showing a ref that points at a tag, doesn't
it?  Substituting an inapplicable placeholder with an empty string
would be an easies way out, unless it learns a flexible/elaborate
conditional formatting mechanism, I would think.
