From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re-Transmission of blobs?
Date: Wed, 11 Sep 2013 10:14:54 -0700
Message-ID: <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
References: <20130910130837.GA14259@raven.wolf.lan>
	<xmqqsixcy395.fsf@gitster.dls.corp.google.com>
	<20130911112758.GB14259@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Wed Sep 11 19:15:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJo0W-00016o-NA
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 19:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486Ab3IKRPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 13:15:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922Ab3IKRPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 13:15:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E798541542;
	Wed, 11 Sep 2013 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MtUCqQuJKtm/2umr/a8cDq7t8lg=; b=qGmfMg
	Mms4kC+3F+FTiwAzySeGuGh5sErNUpxfl5gDDhbq7eckkTU0BnwkyPAhoRrdBLyW
	sb8znwCQRimSCGVkUtbo688Js/SWN/zVqCQoKW+cI9djThik6xSRQafTWBUi5xR+
	yMoHbmIKEKR07FpyscIl8BOtSeimFO8qcbocw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A+1Waac57kPLNBmhfmvLtKZ6gwvGy/Ks
	2QbGYXn/crARaSgeyVbhnKZEqVzTXWXc3BLpNMJ3ABHjoXu3Ky8OUOX5RLECJIhW
	iNSWB528wDj05Wu5YxJ3d5VJ6EAKZ/25eevGrmz1Bk9v3s5popyTSDBrQJ0YGqlB
	1zBghAXPPpw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2685E41533;
	Wed, 11 Sep 2013 17:15:02 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FE0941514;
	Wed, 11 Sep 2013 17:14:59 +0000 (UTC)
In-Reply-To: <20130911112758.GB14259@raven.wolf.lan> (Josef Wolf's message of
	"Wed, 11 Sep 2013 13:27:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B041FE5A-1B05-11E3-9B27-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234582>

Josef Wolf <jw@raven.inka.de> writes:

> On Di, Sep 10, 2013 at 10:51:02 -0700, Junio C Hamano wrote:
>> Consider this simple history with only a handful of commits (as
>> usual, time flows from left to right):
>> 
>>               E
>>              /   
>>     A---B---C---D
>> 
>> where D is at the tip of the sending side, E is at the tip of the
>> receiving side.  The exchange goes roughly like this:
>> 
>>     (receiving side): what do you have?
>> 
>>     (sending side): my tip is at D.
>> 
>>     (receiving side): D?  I've never heard of it --- please give it
>>                       to me.  I have E.
>
> At this point, why would the receiving side not tell all the heads it knows
> about?

It did.  The receiving end had only one branch whose tip is E.  It
may have a tracking branch that knows where the tip of the sending
end used to be when it forked (which is C), so the above may say "I
have E and C".  It actually would say "I have B and A and ..." for a
bounded number of commits, but that does not fundamentally change
the picture---the important point is it is bounded and there is a
horizon.

>> There are some work being done to optimize this further using
>> various techniques, but they are not ready yet.

And this still stands.
