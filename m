From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Fix date checking in case if time was not
 initialized.
Date: Mon, 25 Feb 2013 11:37:51 -0800
Message-ID: <7va9qsxjzk.fsf@alter.siamese.dyndns.org>
References: <CAHXAxrOOqn6ZSVT1AFyO3a3paD1tokBtcnaX68a+ddhodOvZ6Q@mail.gmail.com>
 <7vzjysxnb1.fsf@alter.siamese.dyndns.org>
 <CAHXAxrMaQRdBxSvNO+no_9d==v0tVnkpXtguTKyfvnm-VfR_xA@mail.gmail.com>
 <7vr4k4xlie.fsf@alter.siamese.dyndns.org>
 <CAHXAxrOjSS5jGLcCw4KTxP_F_uRQhi0cPSvzbx58jx9dP25XPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:38:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3sS-0003NA-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759560Ab3BYThz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 14:37:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759348Ab3BYThy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 14:37:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F4DEAE48;
	Mon, 25 Feb 2013 14:37:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BlOFaa7pepKWE0qQ0DtBn7xTSPY=; b=KowH+h
	Tx1Otzi+oznqr01uZSdx8yxDOu6deWBQXuTDNuAJN2GId3AoJ4t/WcSnUTsSIDLn
	1A/oDUnMgTJQkj2ciVhvujyjsYMI3nlQiAhi1gM8C376O/Oc/O06UjTQFA18ZZQO
	51uZtAHPE6s0Mh/8jbaHVxO2l0VuQ6TFhWX7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YP/92+s7uCt4X+LF1F8a88kz2xN7O+xz
	EA2UZw6J8NcHQSCUFJwvuIHthyTexxq+iyFRMed7YjWYfx9BE2gnjBNEkIk8iTcG
	i5AXpl6mzUQQDxIvkwHG6d+Z+XKvoe41FVxO5qE8nyOm7MWDdeTrfY2fEUUH2+5X
	Dh7i1Y28j1M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 802C9AE47;
	Mon, 25 Feb 2013 14:37:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04525AE44; Mon, 25 Feb 2013
 14:37:52 -0500 (EST)
In-Reply-To: <CAHXAxrOjSS5jGLcCw4KTxP_F_uRQhi0cPSvzbx58jx9dP25XPA@mail.gmail.com> (Mike
 Gorchak's message of "Mon, 25 Feb 2013 21:32:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D89073D8-7F82-11E2-8C61-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217095>

Mike Gorchak <mike.gorchak.qnx@gmail.com> writes:

> 	if (tm->tm_hour < 0 || tm->tm_min < 0 || tm->tm_sec < 0)
> 		return -1;
>
> So is_date() always return negative result for the text string where
> date is placed before time like '2008-02-14 20:30:45'.

Yes, it returns this -1 on other platforms, but...

> It must fail on
> other platforms as well.

... the input '2008-02-14 20:30:45' still parses fine for others
(including me).  That is what is puzzling.

A shot in the dark: perhaps your time_t is unsigned?
