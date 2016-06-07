From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/38] resolve_gitlink_ref(): implement using resolve_ref_recursively()
Date: Tue, 07 Jun 2016 10:19:44 -0700
Message-ID: <xmqq7fe0syq7.fsf@gitster.mtv.corp.google.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
	<a9787723bcd990413661b8cb2e5542d618ab6321.1464983301.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:19:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAKfR-0003Ii-IW
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 19:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbcFGRTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 13:19:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750760AbcFGRTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 13:19:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B462C233A9;
	Tue,  7 Jun 2016 13:19:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BYd8UG7GrmjMuq3WSFPfSLvVTOI=; b=g1inhb
	VBPkBFWdQ9X7t3ICs4Cjpfy3fgCvUh0VBt4zVMHtulX61w9zqSnCz5BXWNLD9Ci5
	szfH0XPdtCz28CA+ti+CngaRTHmaAByGR9rFteaHQI0GlbDQPTAncgvjxFazVqjb
	vEuxFRZ6mXujV6Sn5w/ID0de0+tbMKq1+qQfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fhVK/cHUleg5T7IM8Y5dR4Zsy9drt/2w
	Mw7FcUzP1zf7aICfHzl5ZeKXL0E/PWeIfVw8q2uNr12+AknldnFUSm50MZcdlzJz
	G26EJ3cDoD9biwGWYtzrZFboo0Y6dGCHODokv28oR59nJy4uzcnSIY43jS2jAJDI
	RwP2luCWNag=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD2E3233A8;
	Tue,  7 Jun 2016 13:19:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32C58233A7;
	Tue,  7 Jun 2016 13:19:46 -0400 (EDT)
In-Reply-To: <a9787723bcd990413661b8cb2e5542d618ab6321.1464983301.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Fri, 3 Jun 2016 23:03:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0827074A-2CD4-11E6-B37C-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296699>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> resolve_ref_recursively() can handle references in arbitrary files
> reference stores, so use it to resolve "gitlink" (i.e., submodule)
> references. Aside from removing redundant code, this allows submodule
> lookups to benefit from the much more robust code that we use for
> reading non-submodule references. And, since the code is now agnostic
> about reference backends, it will work for any future references
> backend (so move its definition to refs.c).

Nice.
