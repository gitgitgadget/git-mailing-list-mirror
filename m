From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag deletions not rejected with receive.denyDeletes=
 true
Date: Fri, 09 Dec 2011 11:15:37 -0800
Message-ID: <7vy5uleeue.fsf@alter.siamese.dyndns.org>
References: <18285669.571323420520289.JavaMail.root@promailix.prometil.com>
 <18683796.591323420674000.JavaMail.root@promailix.prometil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jerome DE VIVIE <j.devivie@prometil.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:15:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ5v8-0008Tg-Ay
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab1LITPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 14:15:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab1LITPk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 14:15:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2A0F52FF;
	Fri,  9 Dec 2011 14:15:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u9wD0vhyfbbLDo6DoqOVg5MJ2co=; b=SEKpaR
	Of3FGPspAOjaURBt4KL9cp/LG/bzlLoqmdvSgI5hbrsjiIm7GxE36lyn4ktV9899
	aniTl3gxSVYe8rKE30kqre7o+Gtm6U8/9J8zGZYlAng7Q0ng27xXfmZdIhRxL7A4
	wuh02ewt0hDXeaga4Pw5PmRVbfFpukiRxX/4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LkL1WPLfMEzilcrjDax/5gt5676wntQl
	s99Y6/44yxJdX57yJsei4yBPLZDUGuZudxbR6iYMUEV9b4SErDucW8OkiED5okai
	SdD7p3BgBH4DqjD5KDajGTJXXOm1LZK0hEEZ5NEabPW6CNobeTXs4RGKlvYtY6DN
	fHE2PAr19KM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 986A252FE;
	Fri,  9 Dec 2011 14:15:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A1F252FD; Fri,  9 Dec 2011
 14:15:39 -0500 (EST)
In-Reply-To: <18683796.591323420674000.JavaMail.root@promailix.prometil.com>
 (Jerome DE VIVIE's message of "Fri, 9 Dec 2011 09:51:14 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E1DB334-229A-11E1-8B30-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186667>

Jerome DE VIVIE <j.devivie@prometil.com> writes:

> Hello,
>
> I have try to deny tag deletion over push using denyDeletes parameter:
>
> git config --system receive.denyDeletes true
> git daemon --reuseaddr --base-path=.. --export-all --verbose --enable=receive-pack
>
> I can push tag deletions despite what the internet says (http://progit.org/book/ch7-1.html#receivedenydeletes). I don't know if it is a bug. Could you have a look, pls ? Thank you

The code seems to be written in such a way that it _explicitly_ wants to
limit the effect of the configuration only to branches. The change was
introduced by a240de1 (Introduce receive.denyDeletes, 2008-11-01) and the
motivation was explained as:

    Introduce receive.denyDeletes
    
    Occasionally, it may be useful to prevent branches from getting deleted from
    a centralized repository, particularly when no administrative access to the
    server is available to undo it via reflog. It also makes
    receive.denyNonFastForwards more useful if it is used for access control
    since it prevents force-updating by deleting and re-creating a ref.

So I would have to say your "the internet" is wrong.

Our documentation can also use some updates, as it dates to the days back
when we more liberally used "refs" and "branches" interchangeably.
