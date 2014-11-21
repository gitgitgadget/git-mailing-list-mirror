From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Fri, 21 Nov 2014 09:33:08 -0800
Message-ID: <xmqqegsw1msr.fsf@gitster.dls.corp.google.com>
References: <1416498395.23953.8.camel@mad-scientist.net>
	<xmqqioi94wy0.fsf@gitster.dls.corp.google.com>
	<1416582517.23953.18.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Smith <paul@mad-scientist.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 18:33:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrs57-0003qw-AM
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 18:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbaKURdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 12:33:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750699AbaKURdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 12:33:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 142411EF9F;
	Fri, 21 Nov 2014 12:33:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WAZEAgzIRgkdB7sMRitHTWefd24=; b=TR2zjz
	ttWjltj6HR/YkRRGWdznCcf227LQo/yVjFLVrZ7pdT35/WmtUIoMx0hp2/sadUGv
	HwG8QaRgmwVQiXLHU3JOE7y/ulmf4KCA3/CNBJnzK072IFOS5oR09FSrNWSwWn1K
	v6K+UPDpMff+uVPR5jQw2yB3csmjcYyEiGOBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ea/Ig+p/Sehal1e0amIE0HziassOrwJ7
	RvXMzSzOT/Gg1gXa/CtlQGJaiMyHSN8MNF7PF50jTKtjro7jIy2YiGw9ylwCmzL1
	S5OxQRnGkM2pl6ikg70/D6hj1Wj+eles3lJKKODwaSwYU2g6eQ/W+m8UEDj4/oSB
	yEsA6m2AzM8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07B211EF9E;
	Fri, 21 Nov 2014 12:33:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C9841EF9A;
	Fri, 21 Nov 2014 12:33:09 -0500 (EST)
In-Reply-To: <1416582517.23953.18.camel@mad-scientist.net> (Paul Smith's
	message of "Fri, 21 Nov 2014 10:08:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 75F05B6A-71A4-11E4-88A0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Smith <paul@mad-scientist.net> writes:

>> Why these changes?  I thought you are making sure $cleandir is
>> absolute so that you do not have to do this and can just "cd" into
>> the new working tree, the same way the user would do once it is set
>> up.
>
> I made cleandir absolute mainly because you asked me to :-).  I didn't
> realize that the implication behind that request was that I'd put back
> the original "cd" as well.

This is about not changing unnecessarily the original that has been
battle-tested and keeping the result resistant to future mistakes
(i.e. somebody going elsewhere without realizing a relative cleandir
will cause problems).  Once $cleandir is fixed, there no longer is a
good reason to change how HEAD is pointed in the $new_workdir or its
working tree populated; the change in the earlier round in that area
was necessary when $cleandir was not absolute, but not anymore.
