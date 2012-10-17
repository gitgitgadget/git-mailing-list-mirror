From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for
 .gitattributes
Date: Wed, 17 Oct 2012 00:33:12 -0700
Message-ID: <7vk3uppn7r.fsf@alter.siamese.dyndns.org>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-3-git-send-email-pclouds@gmail.com>
 <50758477.3030304@viscovery.net> <7vtxu2ayov.fsf@alter.siamese.dyndns.org>
 <50765CDC.8020509@viscovery.net> <7vpq4p80sn.fsf@alter.siamese.dyndns.org>
 <5077C7AC.9010301@viscovery.net> <7v4nlx3cc8.fsf@alter.siamese.dyndns.org>
 <507BA6F0.4090500@viscovery.net> <7vfw5fy8tx.fsf@alter.siamese.dyndns.org>
 <507D010A.8000904@viscovery.net> <507E58CF.2040803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:33:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOO88-00014y-Ts
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 09:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134Ab2JQHdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 03:33:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab2JQHdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 03:33:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15B127FA0;
	Wed, 17 Oct 2012 03:33:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eLwxvpatNDiiL2Hf+J6lVtfmLh4=; b=JSF9q1
	pAdnN7KpFivNVEyIxO22V0BjzMjJyPVH+3CUh4lHPuhCFR8C61XfOJA8eHhSvVWO
	/EZKucazU5iJJLWbgvJUaSPbXJdfag8dc9S2PPwGDIVcSRF0/3iR5cPR5dXWDmmy
	AWzpgoH2A1D8Y5xIhPjltzXv2lpB6nvqX2YW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jcgERqFYHCQ/vLocm61f5+75XCJTrurh
	FKx9v3vx+SgRB3qZIcAaS2F+VxwyX1RneQXeYxXMNbEntmEMeRa2WdSDuAcRRv2E
	Zw+AntWt7M/SMDrhMcaDaXElfuHw18MY7je+3GsrFR6FIgSTC9tuDyL8/e9kiA0C
	YcNdWG/tT1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 031407F9F;
	Wed, 17 Oct 2012 03:33:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A33D7F9B; Wed, 17 Oct 2012
 03:33:14 -0400 (EDT)
In-Reply-To: <507E58CF.2040803@viscovery.net> (Johannes Sixt's message of
 "Wed, 17 Oct 2012 09:05:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9A10542-182C-11E2-B9BF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207901>

Johannes Sixt <j.sixt@viscovery.net> writes:

> diff --git a/compat/mingw.c b/compat/mingw.c
> index afc892d..4e63838 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -335,6 +335,28 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
>  	return freopen(filename, otype, stream);
>  }
>  
> +#undef fflush
> +int mingw_fflush(FILE *stream)
> +{
> +	int ret = fflush(stream);

The "#undef" above is a bit unfortunate.

Whenever I see this construct I start to wonder "I know this is to
disable our own #define we have elsewhere that renames fflush() to
mingw_fflush(), but what happens if the system include implements
fflush() as a macro?"

A better organization might be

 - make "int mingw_fflush(FILE *);" declaration available to all the
   callers and to this part of the file; and

 - make "#define fflush(x) mingw_fflush(x)" macro visible when
   compiling the rest of the system, but make it invisible to the
   implementation of the emulation function.

The latter implies that a function in the emulation layer, if it
needs to fflush(), would explicitly call mingw_fflush().

I know you did this knowing that it is not an issue on your
platform, and this file is only used on your platform anyway, so I
do not think we should address such a reorganization right now, but
it is something we may want to keep an eye on, as other people may
later try to stub away a real macro imitating this part of the code.

Thanks for following through.

Sometimes discussions on our list result in participant feeling
satisified with the conclusion without completing the last mile of
producing and applying the patch, which I find only after a few
month when I'm trawling the list archive for anything we missed.

Now I'll have to do my part and queue this to my tree ;-)
