From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/4] git submodule: Fix handling of // and /.. in paths
 for added submodules
Date: Thu, 26 Feb 2009 09:04:51 -0800
Message-ID: <7vtz6ht9ho.fsf@gitster.siamese.dyndns.org>
References: <49A541D3.4030001@viscovery.net>
 <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-2-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-3-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-4-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-5-git-send-email-git@drmicha.warpmail.net>
 <49A55056.8020504@viscovery.net> <49A556D5.7020806@drmicha.warpmail.net>
 <49A55DAD.2000309@viscovery.net> <7v1vtm1a6b.fsf@gitster.siamese.dyndns.org>
 <49A65B4C.305@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Andrei Thorp <garoth@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 18:07:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcjhP-0008Ji-Kb
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 18:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029AbZBZRFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 12:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755717AbZBZRFA
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 12:05:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478AbZBZRFA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 12:05:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6144D14F7;
	Fri, 27 Feb 2009 12:04:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 95E9414F5; Fri,
 27 Feb 2009 12:04:52 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2C2A2C6-04F0-11DE-AA03-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111579>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 25.02.2009 22:25:
>
>> The sed scripts in the more important parts of scripted Porcelains avoid
>> multiple commands on a single line concatenated with ";" mostly by inertia
>> on my side, but it was acquired exactly from this kind of portability
>> mess.  IIRC, AIX's was the worst offender. It also got "/A/../B/ { ... }"
>> wrong in earlier versions.
>
> I'm a bit confused now. Are you saying that "git-submodule.sh" should
> avoid the multiple lines in sed (which work in AIX 4.3.3)?

No, I understand J6t's comment:

>>> I don't know... Let's see: My AIX 4.3.3 sed understands it if it is not
>>> all on a single line, and that says a lot. Specifically, I tried this:

to mean that this is bad:

	sed -e 'a;b;c;d;e'

while this works

	sed -e '
        	a
                b
                c
                d
                e
	'
