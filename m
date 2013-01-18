From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] config: add helper function for parsing key names
Date: Fri, 18 Jan 2013 12:53:32 -0800
Message-ID: <7va9s6qkkz.fsf@alter.siamese.dyndns.org>
References: <20130114145845.GA16497@sigill.intra.peff.net>
 <20130114150012.GA16828@sigill.intra.peff.net>
 <7v8v7veixc.fsf@alter.siamese.dyndns.org>
 <20130115160422.GC21815@sigill.intra.peff.net>
 <7vehhm4bof.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 21:54:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwIwn-0003aN-5r
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 21:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab3ARUxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 15:53:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab3ARUxf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 15:53:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DF91BD46;
	Fri, 18 Jan 2013 15:53:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yELq6OX1CZac22BqzlalLOwYs2Y=; b=YkE2jM
	KmdpeSTOuaijZYo09wDkmIN9MS6FN1gkMYJM3fVgF50fgLmZqz4lL8fH0I03eKmN
	7sRfuLsigFqKI6rPfeOejPYfETRpDHJ2hVkJcTkoUDPI6w+XgCv1QHYIKMXAHCc4
	TbXlPm9fQ1gLZTLH5MGcVWjT+Y4sHcQQx+9Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=udmIfqpl527TSKrPU0HeEfTwiUAKj4wo
	1+DxFSoE5XJD7/8ke3fu1IYzrlSCeXqMrCM+mBTFsqNmU7nJMWURvgjVeIdNSne+
	HvK30VJHoBGxpvr9/2sirF0/JcoTsWNuDpZSYFD0Lv1Cy1mp0U6nmyZm5BQhEx21
	JGgU0PMp2wQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51A76BD45;
	Fri, 18 Jan 2013 15:53:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C59B6BD43; Fri, 18 Jan 2013
 15:53:33 -0500 (EST)
In-Reply-To: <7vehhm4bof.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 15 Jan 2013 09:07:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F623F2A-61B1-11E2-9610-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213937>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> ... did you have any comment on
>> the "struct config_key" alternative I sent as a follow-up?
>
> I did read it but I cannot say I did so very carefully.  My gut
> reaction was that the "take the variable name and section name,
> return the subsection name pointer and length, if there is any, and
> the key" made it readable enough.  The proposed interface to make
> and lend a copy to the caller does make it more readble, but I do
> not know if that is worth doing.  Neutral-to-slightly-in-favor, I
> would say.

Now I re-read that "struct config_key" thing, I would have to say
that the idea of giving split and NUL-terminated strings to the
callers is good, but the "cheat" looks somewhat brittle for all the
reasons that come from using a static buffer (which you already
mentioned).  As I do not offhand think of a better alternative, I'd
say we leave it for another day.
