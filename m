From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC/RFD] clone: quell the progress report from init
Date: Fri, 26 Mar 2010 13:24:07 -0700
Message-ID: <7vzl1uhlw8.fsf@alter.siamese.dyndns.org>
References: <4BAB2234.4070202@drmicha.warpmail.net>
 <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net> <7veij6lvze.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1003261611130.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 21:24:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvG53-0005ul-HY
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 21:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab0CZUY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 16:24:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab0CZUY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 16:24:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ACE7A5BC6;
	Fri, 26 Mar 2010 16:24:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TJBbGiW9DMZAw490w7djLNXMHDA=; b=cQ9T7b
	JyVbDmyjcHlwoWixER4gTwFcDKtySpcWh8tSivgD8yft1ZSzcM3g6ReM9eJDBC+l
	SW5fCuP20ssJTqrsugx10n2PFhtLaB0TbVJ3k7+f4anOORKC+a/S6+mVnjfNolwM
	Xtjwrq7QQEKDb0hmL9t0ORnqiCbZ28uV36QJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YvMhATT5TwxPNyiQP279xa0wiuzO4Fn6
	ZBrP03W0kgSmH29srFun3XlGMgwWBtksfcC4PgSu2qFgaZDaOV+X9rzTQd9lmpbv
	NidWXLujmf70OWTnA4bzR2hR/0D6M78yhlM6Ayku3QB3+g1r0r/I/A9qYRAbqxrC
	3NJ5v/AQSZs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25A4CA5BC1;
	Fri, 26 Mar 2010 16:24:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10089A5BBB; Fri, 26 Mar
 2010 16:24:09 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1003261611130.694@xanadu.home> (Nicolas Pitre's
 message of "Fri\, 26 Mar 2010 16\:16\:50 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8E51BE82-3915-11DF-8DFC-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143281>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Fri, 26 Mar 2010, Junio C Hamano wrote:
>
>> An alternative might be to squelch init_db() like your patch did, and then
>> replace it with a message of our own, perhaps like this:
>> 
>>  $ git clone -n /var/tmp/gomi victim-003
>>  Cloning into victim-003...
>>  done.
>>  $ git clone -n file:///var/tmp/gomi victim-004
>>  Cloning into victim-004...
>>  remote: Counting objects: ...
>>  Receiving objects: 100% (120/120), done.
>> 
>> Here I am assuming we would add "done." to the local codepath.
> ...
> Personally I like your suggestion above.  A clone is not something you 
> perform repeatedly, and it is the first thing that random people told to 
> use Git to grab a piece of code will do.  Better give them some comfort 
> by telling them what is happening.

Ok, I can agree with that.  People who like silence can always say -q ;-)
