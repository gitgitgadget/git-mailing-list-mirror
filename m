From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required amount
Date: Mon, 25 Aug 2014 14:11:09 -0700
Message-ID: <xmqqha10l1g2.fsf@gitster.dls.corp.google.com>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
	<20140825133550.GE17288@peff.net>
	<CAP8UFD2FAfg5GenJXOkOsjU9vmCO3R3Difp6-mrP_cp4zXQENg@mail.gmail.com>
	<20140825150028.GA28176@peff.net>
	<xmqq8umcmnmo.fsf@gitster.dls.corp.google.com>
	<20140825193519.GH30953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:11:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM1Xy-0006Xh-Ku
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 23:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933504AbaHYVLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 17:11:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54242 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933436AbaHYVLV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 17:11:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1CE8435DD4;
	Mon, 25 Aug 2014 17:11:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NMY/WyI5Gl4ILndH8BH7HKRFHb4=; b=atkaLs
	hwqs7cqMPPj2YproVXbLaNwbTnmqt3v1e0ecjwrnYQoh6z+h78w52u4f1gRMwxF6
	hpmJu5sbeHG3UaAHl/wwQbFJEDIrHSY8WrX9AoMi+7u0GcfAySKS0ML8m1ql57as
	3VJp4VMfLsSrWTqYaAgXlJoPA4OpyN61wnp0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LTpIgG7ZGJka81D4n33Y/dS4Rr1QNiKM
	JQGbVj9wbnZ03mRdcMui6LQtjT2MaTbc/5+srUoD+7stFd8JYfYyj4k1aJdm5J91
	oU3UkHeq5C47OmBT+STNiwHIsUT75fbbSzxeCWTMhrfRQMyQYkQW4hpdDDXTNISU
	4hu1IRIZVtw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 111E435DD3;
	Mon, 25 Aug 2014 17:11:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EA2D135DC8;
	Mon, 25 Aug 2014 17:11:11 -0400 (EDT)
In-Reply-To: <20140825193519.GH30953@peff.net> (Jeff King's message of "Mon,
	25 Aug 2014 15:35:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 575DF006-2C9C-11E4-A66D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255869>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 25, 2014 at 11:26:39AM -0700, Junio C Hamano wrote:
>
>> Good digging, and I agree that it should use the FLEX_ARRAY for
>> consistency.
>
> I can produce a patch, but I did not want to steal Arjun's thunder.

Hmph, would it have to overlap?  I think we can queue Arjun's patch
with +1 fix and FLEX_ARRAY thing separately, and they can go in in
any order, no?

> Arjun, did my proposal make sense? Do you want to try implementing that?
