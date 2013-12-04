From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mv: let 'git mv file no-such-dir/' error out
Date: Wed, 04 Dec 2013 09:44:22 -0800
Message-ID: <xmqqpppclde1.fsf@gitster.dls.corp.google.com>
References: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>
	<CACsJy8CfvdT2LgRHax3P6k94C3S9ScB4fuNRm7bZWGXRW=NqKA@mail.gmail.com>
	<vpqa9ghhunu.fsf@anie.imag.fr>
	<CACsJy8BdXkzzZpEaOvqkJ8ckubbQ0ArOMUT8qnMHMDscupfj_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 18:44:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoGV0-000727-DL
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 18:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429Ab3LDRoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 12:44:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755471Ab3LDRo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 12:44:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4DE356AF0;
	Wed,  4 Dec 2013 12:44:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9MIO4A+DMtLaFJt4piR9RCahrIs=; b=Fpg8FD
	X4gr6xhR4P8e1eb379/v0P3A+s5b1yT06CStAsAexzSnvC+Q99uyTE5o5UjYOmKP
	LJXF7mO1ykXjvW6ve4jmyYWF+yE2u9PMxeE8bRmJovnVPl5Whe583VlhcGsmewS2
	7+shIB1WGE7CNftcFXL8lIHxFA5o9NfXLEDqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lPFkJ/46ZbxcNlBZWcgkoTdkYKM/HNsr
	Y6Stwch0QH14RDp/0NBZCTMoZCs84Yt7E8pSHZQx/YsJk0Up/H9zK/nw8MxSZDy7
	oQbFqplaPwaIQIzHAC5Re4GnDUXP/lFFjVbjFx9yxBWokI/fEpCBYnVEx7xY5PZH
	BCoAQ4K3OOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9299156AEF;
	Wed,  4 Dec 2013 12:44:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5347756AEB;
	Wed,  4 Dec 2013 12:44:25 -0500 (EST)
In-Reply-To: <CACsJy8BdXkzzZpEaOvqkJ8ckubbQ0ArOMUT8qnMHMDscupfj_A@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 4 Dec 2013 20:10:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B75B987A-5D0B-11E3-952C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238794>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Dec 4, 2013 at 3:44 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Tue, Dec 3, 2013 at 3:32 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>>> There's something we probably should check. In d78b0f3 ([PATCH]
>>> git-mv: add more path normalization - 2006-08-16), it mentions about
>>>
>>> git mv something/ somewhere/
>>>
>>> there's no test in that commit so I don't know the actual input and
>>> expected outcome.
>>
>> To me, the expected outcome is "behave like Unix's mv" (which works with
>> or without the trailing slash if somewhere exists).
>>
>>> If "somewhere" is a directory, it errors out with this patch and works
>>> without it.
>>
>> I can't reproduce. I've added this to my patch (indeed, the area wasn't
>> well tested), and the tests pass.
>
> Now I can't either. Probably some mis-setups or some local bugs in my
> tree. Good that we have more tests.

OK, I was also scratching my head after seeing your response.

It seems that t7001 needs some face-lifting, by the way.  Perhaps
after this patch solidifies.
