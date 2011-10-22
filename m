From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] MSVC: Compile fix by not including sys/resources.h
Date: Fri, 21 Oct 2011 17:56:45 -0700
Message-ID: <7vk47x7sj6.fsf@alter.siamese.dyndns.org>
References: <4EA1C9C9.9010904@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 02:59:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHPvo-000539-T4
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 02:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764Ab1JVA4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 20:56:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab1JVA4s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 20:56:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E3985D80;
	Fri, 21 Oct 2011 20:56:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jQflEvgdtl5XnOpkLc/MGabeF0s=; b=ANLGo4
	XNkQlybVbVJ9m43L0+Is1lNfqFnxYTYUdz2X/HNQrwzaNpgrguEnsIKq39WmK3W3
	1OuutwoZ3nHjOJtsWiTIu27fFDbShtGK14EJcNgfSe2YOmdDmpMdNgJlck1dO4no
	DmZtTAzyjrBT4GRMD0gTNvkE1Tu6HwXyiXJVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M63JAjSW50H2N9Mk/YAd46Sw3mVe9CC0
	TYuHZUgYpWrtktTwU/KZFlNsRPmtjRkLtzeOPGUSFjgmXoANDurXM+gkIMCueDNn
	c3Fy4LARD0xDf+6xlzcnqTjjXY1LltMB8it00N0exOvlxGPG3u9LhtxeTuGJtupL
	eTRFyGuyBlY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66CC85D7E;
	Fri, 21 Oct 2011 20:56:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAD765D7D; Fri, 21 Oct 2011
 20:56:46 -0400 (EDT)
In-Reply-To: <4EA1C9C9.9010904@lyx.org> (Vincent van Ravesteijn's message of
 "Fri, 21 Oct 2011 21:36:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7A0B458-FC48-11E0-9F38-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184095>

>> ...
>> Subject: [PATCH 1/3] MSVC: Compile fix by not including sys/resources.h
>> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
........................................................^^^^^^

Could you refrain from doing that?  It breaks the patch text.

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Fix compilation when compiling with MSVC because sys/resource.h
> is not available. This patch causes a number of other headerfiles
> that are not available to be excluded as well.
>
> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>

Instead of current

	#ifndef mingw32 is the only one that is strange
        ... everything for systems that is not strainge ...
        #else
        ... include mingw specific tweaks ...
        #endif
        #ifdef msvc is also strange
        ... include msvc specific tweaks ...
        #endif

it turns things around and says what it wants to achieve in a more direct
way, i.e.

	#if mingw32
        #include "compat/mingw.h"
	#elif msvc
        #include "compat/msvc.h"
	#else
        ... all the others ...
	#endif

which makes it look simpler.
