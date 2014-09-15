From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] credential-cache: close stderr in daemon process
Date: Mon, 15 Sep 2014 14:38:11 -0700
Message-ID: <xmqqoaug4la4.fsf@gitster.dls.corp.google.com>
References: <20140914073506.GA19667@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 23:38:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTdyV-0004j9-OQ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 23:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705AbaIOViP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 17:38:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55973 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994AbaIOViP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 17:38:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4578A3A67A;
	Mon, 15 Sep 2014 17:38:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i3Ny4OePm62OcovnOJy10CEOEs4=; b=xGUbO+
	GzzzbudnlRdNIyab2GVWs605zF63qRTPV+5MTiBegY2BX6It3wG10MrBz7MlpLze
	10ZmPrRMdynD5ko4b82QBDh2zf0BM/50qziMGTKqCycbVsorwvNgYoccqvwD3lc/
	f6urHJ+tDGOayZ3SlGh7HNsACEBcOElolyvV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ot2L9UrnRhepV8I7CI933byW/jChChkC
	smYErBxgj12J5B5pNVo/cumfoWPGcYpspUCj9LhNKBxS71uJaifzN7I06buwwTNx
	XVDdwFaTpY3+h2EOiSlwPO5XSzl7xh5cDOByC+ZrJbjAADyFTZTEBnF7yr2dTVtu
	pyj3vi/ik0s=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CAEE3A679;
	Mon, 15 Sep 2014 17:38:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AE7B23A677;
	Mon, 15 Sep 2014 17:38:13 -0400 (EDT)
In-Reply-To: <20140914073506.GA19667@peff.net> (Jeff King's message of "Sun,
	14 Sep 2014 03:35:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 98A69952-3D20-11E4-B09A-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257082>

Jeff King <peff@peff.net> writes:

> +	if (!debug)
> +		freopen("/dev/null", "w", stderr);

I am getting this:

credential-cache--daemon.c:216:10: error: ignoring return value of
'freopen', declared with attribute warn_unused_result
[-Werror=unused-result]

which is somewhat irritating.  Even though I am not irritated by
this code, but by the compiler and glibc headers, this is apparently
the only offending one, so we may want to fix it anyway.
