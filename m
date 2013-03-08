From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: suppress implicit "." work-tree for bare repos
Date: Thu, 07 Mar 2013 23:54:18 -0800
Message-ID: <7vboaujphx.fsf@alter.siamese.dyndns.org>
References: <CAHREChhuX82ibNEDQnQUeS9TEeyMFGpuNhyXzt1Pn-Tt2BVOQA@mail.gmail.com>
 <20130308054824.GA24429@sigill.intra.peff.net>
 <20130308071554.GB24429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 08 08:54:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDs8e-0000S7-7j
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 08:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759Ab3CHHyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 02:54:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50200 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754871Ab3CHHyV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 02:54:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E060AC98;
	Fri,  8 Mar 2013 02:54:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uKI0V8mTu4I84OxHdAO10rREb90=; b=HFGU8S
	nLuTa8B9E1lgBnS2AugimNP5OSebRvkQoeHHixQET807v9tOC/iX6Ma00E6n7VVO
	CrJrdTRQJgPk/sqyQvttw2ocdxPFh9J9+/nxrzRymRt4/jZKnF+eZoVmW8apAKaz
	XBB2L1pKHY5OjttQl/NkDkcmEqvjkXgaC4o0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DUK/aneJehKqcXvz46eL9S/3DAbB/FzD
	cl6tqFXTTPIAUdNzaJnwEa0NX8Ht9gwq5d8OSjBb3xSoEldcwbdE8ecQ7a9mA/Kv
	60xM+2Vixm6ZsVB79p/l+ZFJzUyHVkuPOXA+4kkuB78N/jCfbxcx9csOkpR2g8Ip
	gS9fPCEbi68=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 131D1AC97;
	Fri,  8 Mar 2013 02:54:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E729AC95; Fri,  8 Mar 2013
 02:54:20 -0500 (EST)
In-Reply-To: <20130308071554.GB24429@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 8 Mar 2013 02:15:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6273D276-87C5-11E2-8729-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217645>

Jeff King <peff@peff.net> writes:

> diff --git a/cache.h b/cache.h
> index e493563..070169a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -344,6 +344,7 @@ static inline enum object_type object_type(unsigned int mode)
>  #define GIT_DIR_ENVIRONMENT "GIT_DIR"
>  #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
>  #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
> +#define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_IMPLICIT_WORK_TREE"
>  #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
>  #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
>  #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"

Not adding any user documentation is fine (you explained why in the
log message), but I would really prefer to have some in-code comment
to clarify its meaning.  Is it "Please do use implicit work tree"
boolean?  Is it "This is the path to the work tree we have already
figured out" string?  Is it something else?  What is it used for,
who sets it, what other codepath that will be invented in the future
need to be careful to set it (or unset it) and how does one who
writes that new codepath decides that he needs to do so (or
shouldn't)?

I would know *today* that it is a bool to affect us, after having
discovered that we are in bare and we have set GIT_DIR (so if the
end user already had GIT_DIR, we shouldn't set it ourselves), and
also our child processes, but I am not confident that I will
remember this thread 6 months down the road.
