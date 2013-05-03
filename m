From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] index-pack, unpack-objects: add --not-so-strict for connectivity check
Date: Thu, 02 May 2013 23:33:19 -0700
Message-ID: <7vk3ngzi6o.fsf@alter.siamese.dyndns.org>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-5-git-send-email-pclouds@gmail.com>
	<7vvc722s0h.fsf@alter.siamese.dyndns.org>
	<CACsJy8A2dYssdV7JHutYKgo-nZswBAuedXoJ=aygrVSR=JeTrw@mail.gmail.com>
	<7vvc711h4m.fsf@alter.siamese.dyndns.org>
	<CACsJy8AXe-5o7EyEp_aFB=+Ny8GoqrObxzwbAhGD4w9h7Jhmog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 08:33:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY9Ye-0007ld-Kz
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 08:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762865Ab3ECGdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 02:33:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38135 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762770Ab3ECGdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 02:33:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34F1415C2C;
	Fri,  3 May 2013 06:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/XEQ/M/zxGrwENkPw0BHOhK4qXg=; b=Sk1yLH
	/Q3k1jl3eIu/TYSPyORm2UG1hvbXsR2mIely9DcKgOMJQezZrl1eX5SAzPbPxefu
	Puqpw11it+5/suDlsunUbZ1II8Uzr6IhKAUNYnCVaumIIFGXR6u+2rEJenQcSZ6N
	UTODlbzdzdOrip0+dixCqihlAsCZ9FqDMfkSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iYpkwIQszhmZnh2NpGxdQG97nyJolY/y
	5sDK/fOF7Izy9evapPJ+KOCVX404oX0mPnqw5HLPL/jDz6eNTNIPhw9GsAQW3iTd
	2+b8EwGGFTcaZX6Ow/LgGjsQN7TkY0y1jRb3M5SH7Mbkf6jJP21vP95Va7SANU1d
	c7ye/iPFtNo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 280DA15C2B;
	Fri,  3 May 2013 06:33:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A252B15C2A;
	Fri,  3 May 2013 06:33:21 +0000 (UTC)
In-Reply-To: <CACsJy8AXe-5o7EyEp_aFB=+Ny8GoqrObxzwbAhGD4w9h7Jhmog@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 3 May 2013 12:29:06 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5985E006-B3BB-11E2-BAFF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223285>

Duy Nguyen <pclouds@gmail.com> writes:

> What do you mean by "partial history"? Do we have dangling pointers
> after doing that commit walker?

"^C" will leave the objects and it is safe because it will not
update refs.

But your code that does not verify the full connectivity from such
an object (that is outside the transferred pack) to the rest of the
history will then make the resulting repository broken, if you
update your ref to point at such an object, no?  Ading a single
has_sha1_file() only verifies that single object, not the history
behind it.
