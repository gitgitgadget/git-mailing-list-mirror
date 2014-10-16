From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/25] prune-safety
Date: Thu, 16 Oct 2014 14:07:47 -0700
Message-ID: <xmqqsiinsoyk.fsf@gitster.dls.corp.google.com>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 23:07:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XesH4-0004NI-2M
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 23:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbaJPVHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 17:07:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751318AbaJPVHt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 17:07:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C564716FD2;
	Thu, 16 Oct 2014 17:07:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+0qJ9u+vPeLBJ6pcoHCQDsaqlAs=; b=XVCt0u
	3wmEKX6Yhw9FKTH21YO2gPfx2dHcKI+WBqx/RclfOVzXMCqAQFr3jei4ZGjeFwkK
	FIswm7nBKJq0iojlEIyVxl/LrugkbaHu5Zlas7lg/elhb1qy9KXfaKY2KV55mU0U
	mECe/MGUy5QlOmktZxzMtcKioM/T2o027vzaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CKXuh/uHZ2IrtZ39bbEgvKwtO2R+8SVt
	H8UYkb1GXV3maBA07EaJNPntMYKpzoZ7mjld54XuX8euA+SJeEeQAR5Jl1B2D/lT
	v9ReQ92XfxGePdCwf9OdN4m7OP0ZJRXJFhuJnm9QEEAroXoFghMAGNET//Qwk89f
	2eaj3W4rsF4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBF4A16FD1;
	Thu, 16 Oct 2014 17:07:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32DAF16FCE;
	Thu, 16 Oct 2014 17:07:48 -0400 (EDT)
In-Reply-To: <20141015223244.GA25368@peff.net> (Jeff King's message of "Wed,
	15 Oct 2014 18:32:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7B5EA068-5578-11E4-8F7C-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Somewhere in this series the object enumeration seems to get
broken.  "git clone --no-local" of git.git repository died
with

    Cloning into 'victim-7'...
    remote: Counting objects: 173727, done.
    remote: Compressing objects: 100% (43697/43697), done.
    remote: Total 173727 (delta 130908), reused 170009 (delta 128151)
    Receiving objects: 100% (173727/173727), 33.45 MiB | 13.69 MiB/s,
    done.
    Resolving deltas: 100% (130908/130908), done.
    fatal: did not receive expected object a74380c3117994efba501df1707418eb6feb9284
    fatal: index-pack failed

where a74380c... is such an object.

If you have a clone of https://github.com/git/git.git

$ git rev-list --parents --objects --all | grep  a74380c3117994

would be an easy way to reproduce.
