From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git bug. "make [all]" does not use USE_LIBPCRE when "configure --with-libpcre" was previously run
Date: Wed, 14 Aug 2013 09:39:10 -0700
Message-ID: <7vtxistefl.fsf@alter.siamese.dyndns.org>
References: <20130814124849.GA8234@ashu.dyn1.rarus.ru>
	<7v38qcuudi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 18:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9e6R-0007Mn-9G
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 18:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760103Ab3HNQjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 12:39:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760098Ab3HNQjO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 12:39:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0576D37719;
	Wed, 14 Aug 2013 16:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HTONlJydCgvH7stChGVD3rdVZGA=; b=dFlotw
	yZIgsnQu25cfjBeIsJ91vX/wrz7zgaxnfAsfNlb/DmTzleERmC3Yrp0IMx1K/Xfl
	ghEstS5SkFSvvvqFdSHRYIt53d7L6S7b+Vk3W+fHyiXmK0boQsI3KEDEnTq4vpYL
	Pr3ll3Bq6CTa+lAffbiAEKd6C6SXJlS/Cefvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yPJKSsKRkbVDEHFz9mZrVTtEuNDbfig4
	4jXMxJ3DGRohZovnp5fHzrJnuj1dnkRqy4DG2v8ZE/vunYtNwLJL8U14eJ07pMQJ
	I3LmD/iAzYy7EMhoO+IZvu9YzZCqCRTng9x5j14yoLKQsgvYC9fD1Lsc495MogYZ
	IniOGo7dEL8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF84437718;
	Wed, 14 Aug 2013 16:39:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8D8B37715;
	Wed, 14 Aug 2013 16:39:11 +0000 (UTC)
In-Reply-To: <7v38qcuudi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 14 Aug 2013 09:09:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C883AEC-0500-11E3-9232-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232293>

Junio C Hamano <gitster@pobox.com> writes:

> This does not have anything to do with C, but is a breakage in our
> autoconf script.  It appears that anything that is meant to be
> appended at end via $config_appended_defs mechanism is missing from
> the end result.
>
> In fact, symbols whose explicit substitution the above patch
> removes, e.g. CC_LD_DYNPATH, TCLTK_PATH, NEEDS_SSL_WITH_CRYPTO,
> etc. are all missing.

Wait, I spoke too soon.

    $ rm -f configure config.status &&
      make configure &&
      ./configure --with-libpcre &&
      grep USE_LIBPCRE config.mak.autogen
    USE_LIBPCRE=YesPlease

no longer reproduces for me (even though I _thought_ I tried and saw
the breakage).  Hmmmmmm.....
