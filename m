From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] transport-helper: serious crash fix
Date: Tue, 15 Apr 2014 14:28:13 -0700
Message-ID: <xmqqbnw2jn9u.fsf@gitster.dls.corp.google.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 23:28:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaAu2-0002A8-5e
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 23:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbaDOV2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 17:28:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbaDOV2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 17:28:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11E4C7C5E7;
	Tue, 15 Apr 2014 17:28:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3S2YBCC3mmVCHZR4EeuE+flfp28=; b=YBFryG
	AWUuNiWHb6vf9lPj8AYfX5LizwTfpW42ub+Xm+N/9bV2qUdj4GciAqD8p+t+6teI
	al/eMxAblH/mltQ+MEM+EnLYorEE3sgxlrEosfhuyWHmwDfcZS1Rf6lYYHW8Vzsv
	/Pu+XGu20HT6iwoNXYYGNjIgnZaSf5YKBcYzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nB6wElIrfymay8Hv77WBF5hq3KzkXaO/
	53h7DBqXTuI2DfqQW6Hear6OKlxmax0Mo1QZMO7HqmQpeIXhb50wfz+KLo9mOdB8
	uyjDCmpWWOANeudya153ikqoT+U27n/dHjcKw3p4t8lWzovNhvH742USuxoPZaUa
	OWOmBy/x+6k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E77787C5E5;
	Tue, 15 Apr 2014 17:28:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BA467C5E3;
	Tue, 15 Apr 2014 17:28:15 -0400 (EDT)
In-Reply-To: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 12 Apr 2014 15:33:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DAEECA46-C4E4-11E3-94A1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246304>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> One of the most serious recurring issues[1][2][3] with remote helpers is that
> marks get out of sync. The way to analize and reproduce these wasn't trivial,
> but the culprit seems to be a crash while doing `git push`. It has been known
> already how exactly that happens, but no simple way how to fix it.
>
> This is the simplest way so far; tell `git fast-export` to export the marks to
> a temporary file, and move it to the right location only *after* the remote
> helper has finished its job without errors.
>
> Since the code wasn't prepared for a change like this, some reorganization
> changes are needed. More changes might be welcome to further propagate the
> errors properly through the code, but for the moment the errors are propagated
> to the right location, in order to fix this specific problem.

This seems to be based on a somewhat older codebase; I tried to be
careful while adjusting the patch to the current codebase, but
please give it an eyeball to see if I didn't make any silly mistake
in the version that has been parked on 'pu'.

After an positive Ack (or "you botched the forward-porting; here is
a rebased one you should replace them with"), I'd like to merge it
to 'next' and then to 'master' by -rc0 (or -rc1 at the latest) so
that we have enough time to expose the updated code before 2.0.

Thanks.
