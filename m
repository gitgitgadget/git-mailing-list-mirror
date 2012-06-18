From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 RFC] verify_filename: ask the caller to chose the
 kind of diagnosis
Date: Mon, 18 Jun 2012 09:27:49 -0700
Message-ID: <7vvcio4mbe.fsf@alter.siamese.dyndns.org>
References: <vpq395tvlc0.fsf@bauges.imag.fr>
 <1339958341-22186-1-git-send-email-Matthieu.Moy@imag.fr>
 <1339958341-22186-2-git-send-email-Matthieu.Moy@imag.fr>
 <7vehpd7kot.fsf@alter.siamese.dyndns.org> <vpq62apt92f.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 18 18:28:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgeoC-0000jJ-4T
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 18:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab2FRQ2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 12:28:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510Ab2FRQ2C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 12:28:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D09557081;
	Mon, 18 Jun 2012 12:27:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gRE3khpvH9xThXF4yEH837B3LMU=; b=kQ+ZpF
	m5ST32MXgdodRzhv8tKnG+kAHVkoQz/o6q0vi1EQZYlfo55vX0CaQttCFg3JmAJ9
	eKi4F/p6SLUNNaSV5eHd/jOH4p4ZKaEjstfUN7ssmWoZ50c/ruwn+uGVEmGeDtZj
	st/bQF3gY4A8VIn87HyukCgz4lVda3euoYrLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gxBhUqV2hDK8GXFxWXGnTfq09nCcVU8E
	LlMUqOAW4LBi4WNdnQsFRmwQP9i/91w5kn9JzGnOZfyiVUbOmFfYe3WbzsFJ/V8u
	LAMx2iLGCayisC9cErb+WqIP0hA67gru+g7Qo6+EUlQShVg0RSynbEN6fW3GWCbg
	TGmGG9evK64=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C79DB7080;
	Mon, 18 Jun 2012 12:27:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D418707F; Mon, 18 Jun 2012
 12:27:51 -0400 (EDT)
In-Reply-To: <vpq62apt92f.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 18 Jun 2012 08:42:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C84E014-B962-11E1-B149-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200143>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The caller can mistakenly throw 0 or 1 at random but the _only_ right
>> value for this parameter is to set it to true only for the first
>> non-rev, no?
>
> In general, this is the case, but that's a consequence of "an object
> name would not be accepted anyway". I don't think there is any such call
> in Git's code source right now, but we could imagine a caller trying to
> verify that something is actually a file, and "verify_filename" would be
> a correct way to do it, provided you pass diagnose_rev == 0.

While I do not think that is likely to happen, I did think about
that, but then it started to feel somewhat troublesome that we do
not have symmetry "syntactically this place we have to have rev but
it could be a misspelled pathname" and I stopped.

If I mentally rephrase diagnose_rev to could_have_been_a_rev as you
later explained, it sort-of makes sense, and "diagnose_rev" hints
that, so probably it is not too bad.  Maybe "diagnose_misspelt_rev"
would have given a stronger hint, though.

> I think it would be better to document that as a comment, like this in
> cache.h:
>
>    * In most cases, the caller will want diagnose_rev == 1 when
>    * verifying the first non_rev argument, and diagnose_rev == 0 for the
>    * next ones (because we already saw a filename, there's not ambiguity
>    * anymore).
>    */
>   extern void verify_filename(const char *prefix, const char *name, int diagnose_rev);

I agree a better documentation is called for.  It is not "in most
cases", but "in all cases where the caller has to guess the boundary
between revs (that come earlier on the command line) and paths (that
come later), pass 1 in diagnose_misspelt_rev when checking the first
argument that was not a rev, because it is not a path but is a rev
that the user misspelled" or something like that.

I also thought that verify_filename_or_diagnose_misspelt_rev() as a
separate helper function might be cleaner, but by changing the
signature of an existing function you made sure that all the
exicting calls appear in the same patch and get eyeballed for the
correctness of the converison, which was good.
