From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] use new config API for worktree configurations of submodules
Date: Tue, 15 Jul 2014 15:37:21 -0700
Message-ID: <xmqqfvi2tfj2.fsf@gitster.dls.corp.google.com>
References: <20140628095800.GA89729@book.hvoigt.net>
	<20140628100321.GD89729@book.hvoigt.net>
	<xmqqy4w38v6r.fsf@gitster.dls.corp.google.com>
	<20140709195547.GA3081@sandbox-ub>
	<xmqqegxu9ojh.fsf@gitster.dls.corp.google.com>
	<20140714205759.GA3682@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 00:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7BM5-0001di-LM
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 00:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029AbaGOWhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 18:37:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58505 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756855AbaGOWh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 18:37:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33F8C2940C;
	Tue, 15 Jul 2014 18:37:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=85VHpbUFAl9vf18V7j0007y6baI=; b=ZHEqcw
	SKM1M83H2K5LYqKdjkol/HXjjpArTQi2CTawBnTZ1sLbAk8Fo8rsQk4hrrjlS6ad
	EeGF5yri7AgZtS5PH8m4pRKWp7iLq0kexBNqLFr8TC1C1owijOqOw5INTTiJN4H+
	HqG3kd7fvWVMIjB75o8xhqZOvNb/sHellEPaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GswblAR9Sp7vx/xeLH1PiIw6T55tUDgr
	BOCiaqiva3TyLhy+m5jzeqqUPDjKn5h7xg7cjopFfZCVF91L+Y6fy670zl37MKoq
	jg7RFXPN+ylWnTqbfFn5euaZWHhDuCCfDCQAbGDul2/ObdFuHAPFBC5kPv7FC0HN
	omfsgUAPcgw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2ABCF2940B;
	Tue, 15 Jul 2014 18:37:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 96C7229406;
	Tue, 15 Jul 2014 18:37:05 -0400 (EDT)
In-Reply-To: <20140714205759.GA3682@sandbox-ub> (Heiko Voigt's message of
	"Mon, 14 Jul 2014 22:57:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8C4226C6-0C70-11E4-AFF8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253610>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> Can there be any caller that include and use submodule-config.h that
>> does not need anythjing from submodule.h?  Or vice versa?
>> 
>> It just did not look like these two headers describe independent
>> subsystems but they almost always have to go hand-in-hand.  And if
>> that is the case, perhaps it is not such a good idea to add it as a
>> new header.  That was where my question came from.
>
> The reason for a separate module was because we add quite some lines of
> code for it.
>
> $ wc -l submodule.c
> 1068 submodule.c
> $ wc -l submodule-config.c 
> 435 submodule-config.c
>
> Because of this I would like to keep the c-files separate.

OK.  I do not feel too strongly.  It just looked odd that a change
needs to add a new header file without having to change the code in
existing files at all.

Any other thing that still needs fixing in the series, or is it now
ready for 'next'?
