From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Tue, 26 Aug 2014 12:52:38 -0700
Message-ID: <xmqqa96rhvuh.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<1408485987-3590-19-git-send-email-gitster@pobox.com>
	<CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
	<xmqqvbplpg2s.fsf@gitster.dls.corp.google.com>
	<xmqqa96wpfqb.fsf@gitster.dls.corp.google.com>
	<CAJo=hJu_T7irRk=fBsJ+GQxbVQ9GgO2ytihxKm+bXSLsL+wQbg@mail.gmail.com>
	<xmqqd2bomowm.fsf@gitster.dls.corp.google.com>
	<CAJo=hJs3m-0u7NkPHJqvk4qZBGtPguck-xn=in3m-+30UxDQoA@mail.gmail.com>
	<xmqqiolfhwhi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 21:53:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMMnb-0002L2-0v
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 21:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbaHZTwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 15:52:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64000 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215AbaHZTwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 15:52:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 262DC32AAA;
	Tue, 26 Aug 2014 15:52:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e40/v8Gg2pxAQwN0UIVl0AJ1ylo=; b=EEAQdG
	MJmxicDaWhe/MrEGCN+H0rWkIWr2Zev3jJSHkokKO4A+sYIKv75EkabpDl15q01s
	sGdbVQbE4vGZAswHQrGb9hfxMPW3/BzHHH+FFw+RfmrKl96Ly/j3rEtf+em2wfau
	5NygBpqUpcTIKEv6KfszZJAolLyx/mb5ereZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IO1iMvBaG2JaJ880RgqVKeQiC9SlZSMp
	Zqv00hs8UM1it1Z6qX/HC6baxsXO2HU46qOKjPwFspCL63e2OCZvSoEVE2q7SZSH
	9AGm7zzPawyt5j9XAaXE5bf8gVkhZp6hc1ucTaykenFAREpXwWI3oEqvdM6zZPeA
	OWwADqv7OCM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1DFC532AA9;
	Tue, 26 Aug 2014 15:52:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 89F2032A82;
	Tue, 26 Aug 2014 15:52:40 -0400 (EDT)
In-Reply-To: <xmqqiolfhwhi.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 26 Aug 2014 12:38:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 89896D44-2D5A-11E4-B738-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255939>

Junio C Hamano <gitster@pobox.com> writes:

> That is unfortunate.  Would it be a major surgery to update the
> protocol not to do that, perhaps by moving the command list from 3
> to 2 (the latter of which is not currently doing anything useful
> payload-wise, other than flushing a HTTP request early)?

Nah, that was one of the most stupid thing I ever said here X.
There is nothing that ties #2 and #3 unless the server side keeps
some state, so that would not work very well X-<.

>
>> Push on smart HTTP is 3 HTTP requests:
>>
>>   1)  get advertisement
>>   2)  POST empty flush packet to tickle auth (literally just "0000").
>>   3)  POST command list + pack
