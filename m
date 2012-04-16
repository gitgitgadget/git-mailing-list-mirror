From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 08:54:24 -0700
Message-ID: <7vaa2by8nj.fsf@alter.siamese.dyndns.org>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
 <20120415213718.GB5813@burratino>
 <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:54:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJoGA-0007tV-GT
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 17:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab2DPPy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 11:54:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40983 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755104Ab2DPPy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 11:54:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C78B17566;
	Mon, 16 Apr 2012 11:54:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z+bspT2fGni8aaDk8K8Fe+Pp3CU=; b=Lkdjdi
	jxGHxqyldFMi+Jm9VkoJMGlKqxwWvS2c0FxDsUKuKY472zfal6LdonsxrJNGVifp
	sp8e/RIjSgYorFU9dffiJC790vNGP0+tIXdE0oS0LqEGSPTSeqM450dHT8HN9ACz
	BQJrXzABsP7fBCylY21OWoRKUraA9GLAqbaGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ungp6+nmiD/79mt9WbmUMJy7rlys7Z89
	2761fsmfZWtijpr8AlXrZb9x5THN6DmPHP0IN20dwmJotRVnrOYwSlZAxxqMO8Dt
	HKqZNv1Dz4C0yil2+2av6fziNzg2J86zkPmxnO1m/q51l2cVhXatlGS54DzCiPuG
	N/DsS/3MxiQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEDFB7564;
	Mon, 16 Apr 2012 11:54:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BC7A7562; Mon, 16 Apr 2012
 11:54:26 -0400 (EDT)
In-Reply-To: <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 16 Apr 2012 13:49:56 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 717F1DB4-87DC-11E1-9B75-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195651>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Apr 16, 2012 at 12:37 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> The completion script has so far stuck to a limited namespace:
>>
>>        _git_*  (completion functions)
>>        __git_* (everything else, including public interfaces like __git_ps1)
>>
>> A name like __git_complete should work, presumably.
>
> Perhaps it's time to avoid the __ prefix for public interfaces;
> otherwise how would people know they are public?

We could do the same as __git_ps1, no?  People know to use it already;
they know it is public.

I am OK with introducing git_ps1 while keeping __git_ps1 as an equivalent
and declare that git_$anything will be the surface interface for end users
to *use* the machinery we provide, though.  Then git_complete could be
introduced without __git_complete equivalent.  Probably _git_$name has to
stay an implementation detail (i.e. the users can use it but it is their
responsibility to update their using script when the implementation
changes).
