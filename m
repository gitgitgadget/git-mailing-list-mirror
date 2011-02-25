From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/31] rebase: extract merge code to new source file
Date: Fri, 25 Feb 2011 12:24:54 -0800
Message-ID: <7vwrkn9815.fsf@alter.siamese.dyndns.org>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-19-git-send-email-martin.von.zweigbergk@gmail.com>
 <4D58E17C.9090001@viscovery.net> <alpine.DEB.2.00.1102232216180.11038@debian>
 <20110224080734.GB25595@sigill.intra.peff.net>
 <20110224080904.GC25595@sigill.intra.peff.net>
 <alpine.DEB.2.00.1102242229230.11894@debian>
 <20110225090238.GB16861@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 21:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt4E6-00080H-Df
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 21:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930Ab1BYUZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 15:25:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932808Ab1BYUZO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 15:25:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E07B1308D;
	Fri, 25 Feb 2011 15:26:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q+DhRnn/BklJanc3JiA06EcdAGk=; b=pnv0qy
	SmY1dUy+cURuFGQIkPclOce7cqI/ihl2chggJ4WhB6CZV1saVvxey3uV2lL0/qAr
	mpVcQt2wLQoY7V0Fm677TZGo6X2L8CZlzwzKsrc6MtL5u+QeTyPfAWR74BJ2YY70
	0+fPLXaX+HFYoHabrbGSASw8HJmKLdX6rrmOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fKlg7JgZEezjnkKkP7ijIhE+Fbztkdoq
	WUahLi1N+GwseTiuOQ8310CYvMNoVLWXXjN8+wcOB6WutpDMsQzsxZuiTrRJ+iYi
	8FJkkR5vYN1OD85z2jXWjrGPXdnV6NtvdJ2hNEjO0hPuTrGVnem9LC0C7VnY5RAx
	jHG1eMazKUk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70AAC3089;
	Fri, 25 Feb 2011 15:26:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EA6843080; Fri, 25 Feb 2011
 15:26:11 -0500 (EST)
In-Reply-To: <20110225090238.GB16861@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 25 Feb 2011 04\:02\:39 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8220D786-411D-11E0-825B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167938>

Jeff King <peff@peff.net> writes:

> Looks right, but...
>
>> @@ -382,6 +379,9 @@ SCRIPT_SH += git-web--browse.sh
>>  SCRIPT_LIB += git-mergetool--lib
>>  SCRIPT_LIB += git-parse-remote
>>  SCRIPT_LIB += git-sh-setup
>> +SCRIPT_LIB += git-rebase--am.sh
>> +SCRIPT_LIB += git-rebase--interactive.sh
>> +SCRIPT_LIB += git-rebase--merge.sh
>
> We usually keep these sorted.

Also SCRIPT_LIB omits .sh (which feels inconsistent) and the above will
break the build.

No need to resend, as I've already fixed it up.

Thanks.
