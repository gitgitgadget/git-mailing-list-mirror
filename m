From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] fast-export: output reset command for commandline
 revs
Date: Sun, 06 Nov 2011 21:52:33 -0800
Message-ID: <7v1utk4gym.fsf@alter.siamese.dyndns.org>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"Eric Herman" <eric@freesa.org>,
	"Fernando Vezzosi" <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 06:52:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNI8P-0008NP-JQ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 06:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab1KGFwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 00:52:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49650 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919Ab1KGFwg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 00:52:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92D081C6D;
	Mon,  7 Nov 2011 00:52:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HmB2qx+earO8ssu5K+idXHmvOuM=; b=tybry0
	Q4Ri/c5hciMUkWjOYC6wMB5MlQGM+LiiIA3OaBdCYInev6WPzYPqcsPbnIuGjcM2
	v+jXn9CwiEJKSvwhe2LgSUttQYXSBIsE1LxmKlfthf02FMMO8/fjsdt2jqeb4Unk
	YxRqMuTlHUxDSBGvshtclWIZSZgI1mH03r8lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fUK7v9BO5WtO5kshnsrJ2XALafHDYJTx
	uFDVUozlhFqrsC0ygW5gonB4WpUiIuRv4t1nnEkfA6gQv95uzDopP9Zd3tvyvjo1
	n0U1njt78rKMwKScMxnbD5kwvwhlPV8x4k8Goda0xGf38ElDqzTVxFgaOh/jkyer
	gdbpfb153pU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 860611C6C;
	Mon,  7 Nov 2011 00:52:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDBCF1C6B; Mon,  7 Nov 2011
 00:52:34 -0500 (EST)
In-Reply-To: <1320535407-4933-4-git-send-email-srabbelier@gmail.com> (Sverre
 Rabbelier's message of "Sun, 6 Nov 2011 00:23:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0C72B12-0904-11E1-A572-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184952>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>   Additionally, the elem->whence != REV_CMD_RIGHT case should really
>   check if REV_CMD_RIGHT_REF, but as this is not provided by the
>   ref_info structure this is left as is.

I am not sure what you mean by REV_CMD_RIGHT_REF here. Do you mean "We are
only interested in the RHS endpoint of A...B syntax (i.e. B) but only when
it is a refname and not an arbitrary SHA-1 expression (e.g. even though
next~4 in "master...next~4" is a RHS endpoint, it is not a ref, and we do
not want it)"?

I think the distinction you are trying to express ("is it a ref and if so
what exact refname resolve_ref() would produce, or is it just the name of
a random commit?") is a very useful thing in general, but it is orthogonal
to what existing REV_CMD_* are trying to express, which is "where did they
come from", that you can read from the name of the field "whence".

Perhaps we would want to add a new field "const char *ref" to "struct
rev_cmdline_entry" to record the additional information you want perhaps
by storing the result of resolve_ref() if it is a ref and NULL otherwise.
Would it be too much work to add it to perfect this series?

By the way, REV_CMD_REF is meant to mean "the user did not explicitly name
this but it came as a result of iterating over refs/something/ namespace",
and does not mean "this is a tip of some ref" (they happen to be all refs,
but "obtained by iteration, not by explicit naming" is the more important
reason for marking them as such). As they are numerous, if you are going
to add that "const char *ref" field to rev_cmdline_entry, we may want to
either leave it NULL for REV_CMD_REF entries (the name field already has
that information anyway), or have it point at its name field (we need to
audit the codepath to free the name and ref fields if we go that route).
