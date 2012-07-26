From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] allow recovery from command name typos
Date: Thu, 26 Jul 2012 10:53:24 -0700
Message-ID: <7v394e8l4b.fsf@alter.siamese.dyndns.org>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-2-git-send-email-rctay89@gmail.com>
 <1343232982-10540-3-git-send-email-rctay89@gmail.com>
 <1343232982-10540-4-git-send-email-rctay89@gmail.com>
 <1343232982-10540-5-git-send-email-rctay89@gmail.com>
 <7vtxwvbu5s.fsf@alter.siamese.dyndns.org>
 <CALUzUxp91zubHEkWMC1z2xp7kJCRYrtznQS_=pVSZoNkZMihig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 19:53:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuSFi-0000aS-8k
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 19:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab2GZRx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 13:53:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966Ab2GZRx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 13:53:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC1C28D77;
	Thu, 26 Jul 2012 13:53:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=76UiOpGI+f0nO2611YTXxnevIRk=; b=NY+pGW
	0pvwfTKZxEGbMzvFswWFmsqR7/J46fzwrvR5viIBXbbUWkWiP5xB+oj9wKgmpKUD
	Q98l0RvSjrJJx+a991cuRAL9I9mFZQ29De/OJk5vGVa6Rd/SdMMABn+VH5YifNZA
	IKcP8CQ0ZL6bdfm1jD6vWlNSZTf52oZ4RpnM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vTRZC6JRASkh7BQvCLAcSq3mj69enyyl
	W+xK1Yg+/MjR0RRpMO8zeqUl9AtXV0/5cv3WwUUjeVNwweM9ShZpISxRT2htuxR6
	3rTriB8qLZJMTLW61G9/sbAtcKpIZioBYgf7aAm5CB+PH7b6enAi5xr09apDgnxw
	xNRwzDDn9KI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA0708D76;
	Thu, 26 Jul 2012 13:53:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 210B58D74; Thu, 26 Jul 2012
 13:53:27 -0400 (EDT)
In-Reply-To: <CALUzUxp91zubHEkWMC1z2xp7kJCRYrtznQS_=pVSZoNkZMihig@mail.gmail.com> (Tay Ray
 Chuan's message of "Fri, 27 Jul 2012 01:08:34 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD66BE3A-D74A-11E1-9332-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202287>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Thu, Jul 26, 2012 at 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Tay Ray Chuan <rctay89@gmail.com> writes:
>>
>> > If suggestions are available (based on Levenshtein distance) and if the
>> > terminal isatty(), present a prompt to the user to select one of the
>> > computed suggestions.
>>
>> The way to determine "If the terminal is a tty" used in this patch
>> looks overly dangerous, given that we do not know what kind of "git"
>> command we may be invoking at this point.
>
> Indeed, it should also have considered stdin's tty-ness.

Not necessarily. As long as you call git_prompt(), which opens
/dev/tty on its own and does not break even if its standard input is
coming from elsewhere, you should be OK.
