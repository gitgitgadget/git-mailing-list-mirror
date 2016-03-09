From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 00/48] Libifying git apply
Date: Wed, 09 Mar 2016 10:14:20 -0800
Message-ID: <xmqqbn6nikn7.fsf@gitster.mtv.corp.google.com>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 19:14:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adicx-0007sx-Gg
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933774AbcCISO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:14:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933549AbcCISOX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:14:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9CB164AEF2;
	Wed,  9 Mar 2016 13:14:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lwu4znPfEiUhDIBhUHDzzBYGmN0=; b=YA1pzg
	2X/tRLAsWrNjHuqk4S4Uu4ToBBqy9jyO17l1YX1yAhJyRmxjnN7bRAmedS9Dc4Nq
	JJWz7pGQ+d+iKuMkDG+7ItTgqegKR7DxGhQgFjezmvIHuM/ZftYiBm7XFAC4yl4s
	EhNW1NrBO92V20CAAzLjQtHGpqRH0ZCYsWvVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CawF2H1AMS3llzwOCM+3XyjsLOUNkonC
	XwM44j1b6fy9HxUek2o8671KNxWkeRviBL4MHP2zYnfEQnUB63Ky11s5zhGGMCG/
	AKkToy8XZGd4lYf5EvieDH2/Q5p39yCLnHTZsAmOop4NH+QRppZvrndsc0NH9dbt
	CGwLKwpdCKU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9413F4AEF1;
	Wed,  9 Mar 2016 13:14:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0345A4AEF0;
	Wed,  9 Mar 2016 13:14:22 -0500 (EST)
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Wed, 9 Mar 2016 18:48:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BF83807E-E622-11E5-98E7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288542>

Christian Couder <christian.couder@gmail.com> writes:

> One point I'd especially welcome feedback about is the fact that there
> are many boolean options that are using OPT_BOOL(...), so they use an
> int. And there are a few others that are using OPT_BIT(...), so they
> use just a bit. I wonder if it is worth it to try to be consistent,
> and maybe also to try to save some memory.
>
> Related to this, some of the variables for these options have not been
> moved into the "apply_state" structure, because they are not global to
> the file, but maybe for consistency they should be.

These might be worthy clean-ups but that is only if they are done
after we make sure conversion proper is done faithfully to the
original, i.e. without introducing unnecessary bugs.  I'd advise
against doing them before the libification is done.
