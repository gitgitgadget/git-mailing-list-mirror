From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add option to disable automatic dependency
 generation
Date: Thu, 17 Nov 2011 22:12:54 -0800
Message-ID: <7vty62klg9.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net>
 <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
 <20111118045742.GA25145@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 07:13:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRHh9-0006ax-2x
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 07:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756760Ab1KRGM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 01:12:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851Ab1KRGM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 01:12:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF0001496;
	Fri, 18 Nov 2011 01:12:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UcfXTKo5+ne8GDzrPfe2JextAaQ=; b=j9faN5
	7wbFsIm0+EoYD5f5cpu4YkhW1c5HlQzQUWyUfhFVldlVLfvD+vXX+u5+joWythiD
	N+ZMw5Jb0swjB/ls9a8I5pDcMCwtLJleY6V5wBRdga5G6j6KKNiHcam6NaNOxuHG
	8U8sYapNb3NsH+nOvwFm4oiAeokcfcmxGWvCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=szAjyQbZbqFPIoHhwZ/3ruaIutONV0Jq
	TSFTYm/bB6emHEnIRGbNOD3OZORLSw3LHLvRP/ZMBcDngWEQGjmosW6thTmT/t0O
	fJ1ANcrThCpcksVJWNlvBajgh59S8uL/MIEnk1GGdvsDcmgYfR8nDtU5SA9YqcQy
	fgSb//6qPyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C66781494;
	Fri, 18 Nov 2011 01:12:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59B0A1493; Fri, 18 Nov 2011
 01:12:56 -0500 (EST)
In-Reply-To: <20111118045742.GA25145@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Thu, 17 Nov 2011 22:57:42 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B6D9EE8-11AC-11E1-8E6A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185635>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Duy noticed that now that the COMPUTE_HEADER_DEPENDENCIES feature is
> turned on automatically for compilers that support it (see
> v1.7.8-rc0~142^2~1, 2011-08-18), there is no easy way to force it off.
> For example, setting COMPUTE_HEADER_DEPENDENCIES to the empty string
> in config.mak just tells the makefile to treat it as undefined and
> run a test command to see if the -MMD option is supported.
>
> Introduce a new NO_COMPUTE_HEADER_DEPENDENCIES variable that forces
> the feature off.

Eek. At least at the end user UI level, couldn't we do this as a tristate?
E.g. "YesPlease" (or anything that begins with Y if you are ambitious) to
explicitly enable, empty (or "auto") to autodetect, and anything else to
decline?

Even better, couldn't we either (1) rearrange .dep/ files somehow, so that
compiler difference does not matter, or (2) have dep_check to perform a
trial run to detect versions of compilers that produce the output that we
cannot use?
