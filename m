From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Wed, 02 Jan 2013 23:08:47 -0800
Message-ID: <7vmwwqyc8w.fsf@alter.siamese.dyndns.org>
References: <20130101172645.GA5506@thyrsus.com>
 <CAEUsAPYwinmbDkSVu71WJRgUjLfBeNdKDFt6O1f8-Ti9evn6Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: esr@thyrsus.com, git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 08:09:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqevP-0002Gi-IA
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 08:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162Ab3ACHIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 02:08:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab3ACHIt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 02:08:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5164889C7;
	Thu,  3 Jan 2013 02:08:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nE9LDZSWI+WTjBPTd7hjHwrv2yI=; b=rf7rFZ
	H7BJp8ifIcfa+LNBb5fN9eh3dTn1TbtQuSEGH+dYs8vFWi7ZVqz/KyL8iOFF/nLL
	pBR8DrO/deVuy+8PKUtwxepMkXxjSJ8RkTa7TOZGHid5OgemhiJIaVaLz1FhudLG
	prPYd32PHxB+DtyYoH2V98eKBAxhMeOOs9nbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l30wa1TqfufKLVNgzO5LVTeM08ie+PeI
	MEPAL2ANgmyUDnHOnv2ZUoTOfrNWgal/q0ZysZCsxXs2EIvwErZkQrxC31hxTu9t
	nkcBcxZfBJvp18KclJPHBj9wHZ7ITwdbH9vnBdrPyRxt1ne7sbIiLBtqFGb7PaTM
	6GW5d5Bk8B0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 424D589C6;
	Thu,  3 Jan 2013 02:08:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA55989C4; Thu,  3 Jan 2013
 02:08:48 -0500 (EST)
In-Reply-To: <CAEUsAPYwinmbDkSVu71WJRgUjLfBeNdKDFt6O1f8-Ti9evn6Hw@mail.gmail.com> (Chris
 Rorvick's message of "Thu, 3 Jan 2013 00:34:52 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BCD195A-5574-11E2-B31A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212571>

Chris Rorvick <chris@rorvick.com> writes:

> outdir needs to be quoted in the formatted string, i.e.:
>
>   "%s | (cd '%s' >/dev/null ..."

The issue is real, but I am afraid that the above is not sufficient
because outdir can contain single quotes.  I think other places that
call out to external processes share the same issue of being careless
about quoting in general.

Doesn't Python come with a standard subprocess module that lets you
spawn external programs safely, similar to the way Perl's list form
open(), e.g. "open($fh, "-|", 'git', @args)", works?
