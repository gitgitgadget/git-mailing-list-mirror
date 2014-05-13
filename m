From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote-hg: getbundle changed in mercurial 3.0
Date: Tue, 13 May 2014 14:00:18 -0700
Message-ID: <xmqqmwelmm1p.fsf@gitster.dls.corp.google.com>
References: <1400008359-18267-1-git-send-email-1007380@gmail.com>
	<1400012506-20705-1-git-send-email-1007380@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Giokas <1007380@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:00:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJoO-0003Dp-GK
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbaEMVA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:00:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55385 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242AbaEMVA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:00:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F000918A52;
	Tue, 13 May 2014 17:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2lg+b4YxUZFFbdy+ntvBfPnWoT4=; b=uRpHMe
	I2nC7OL+S4nxyuqKRYplpehjR7QY2BUZf7GONaP5y3VV4+EuhzNhbob7/WAA+3F5
	pKawQBt0DXMJ2njOMxnAosimykBPqQ6UW04+JeaR07/OpWjRTnU1EGKw8vRYQG0Z
	DtklwLfPDV5ciRuj23U9/TrxZNCv6HWjcAekE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KX1lJrbAyX4zqzK9P6SHy6Cpe19LYkjo
	FxVqzEIrcIu1lMsPfa18XaS2LJPKGyDEh77h1bcoP3v44a0sYqVcX7rs9eUeYtYp
	5SemFVb3ROAdv84gsHCiLwJdvoXNTkQ+ivlYirJNvKdAB5kLj9KMWzPGbApAIEw6
	MJrMhT/PV/I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E652E18A50;
	Tue, 13 May 2014 17:00:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2E1A018A29;
	Tue, 13 May 2014 17:00:20 -0400 (EDT)
In-Reply-To: <1400012506-20705-1-git-send-email-1007380@gmail.com> (William
	Giokas's message of "Tue, 13 May 2014 15:21:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 97E4663A-DAE1-11E3-9EA9-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248851>

William Giokas <1007380@gmail.com> writes:

> +try:
> +    from mercurial.changegroup import getbundle
> +
> +except ImportError:
> +    def getbundle(repo, **kwargs):
> +        return repo.getbundle(**kwargs)
> +
>  import re
>  import sys
>  import os
> @@ -985,7 +992,8 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
>      if not checkheads(repo, remote, p_revs):
>          return None
>  
> -    cg = repo.getbundle('push', heads=list(p_revs), common=common)
> +    cg = getbundle(repo=repo, source='push', heads=list(p_revs),
> +                   common=common)

Yikes, this is starting to look bad, but the thing being in Python,
perhaps that is the best we could do if we want a solution that is
viable in the longer term.

As a short-term band-aid to be merged/cherry-picked to maintenance
tracks post 2.0 final, I actually would prefer 58aee086 (remote-hg:
add support for hg v3.0, 2014-05-03) for its simplicity.

I dunno.  Thankfully I do not have to decide right now ;-)
