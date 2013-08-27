From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/23] Preliminary pack v4 support
Date: Tue, 27 Aug 2013 09:44:51 -0700
Message-ID: <xmqq8uzndqws.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
	<xmqqioyrfa5m.fsf@gitster.dls.corp.google.com>
	<alpine.LFD.2.03.1308271153370.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 18:45:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEMO4-0008SJ-9l
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 18:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab3H0Qo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 12:44:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab3H0Qoz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 12:44:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 993503C178;
	Tue, 27 Aug 2013 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R5d9vj6azTdeB0NOMrT/2CUoauo=; b=O5QpGf
	1JrKBOqekjmoxXHGk6L8yCKdb7BzxIgstGZv3jieKUoSAaIbl1eIo3w+OZesdwwM
	wWJEO+eJht9ieUslADgceHxWCIQ+qQryUe/30ucuahC/IYgt+EC6Q5i2mUIAeU3L
	3HO715M+boix9Ofbg6yV47L7cMS0Wdip5j86s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JG7vn/RBO1ZldtZ9zWlhTRT1Kyzlf+n5
	uV9/VbTbFlUr4iQqIU2miE2Aa1gAd9OyUCO3szfd5Lxgj7O2YsWUnqbHCvYBs9oo
	KzKTvgoDuIu9dW+3393zIzyin3ZyMY7uM3/N05JyzresSlkZn/cRyBUYkSzOFCxR
	LUJ34PLxMZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 711F53C173;
	Tue, 27 Aug 2013 16:44:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A963E3C170;
	Tue, 27 Aug 2013 16:44:53 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1308271153370.14472@syhkavp.arg> (Nicolas
	Pitre's message of "Tue, 27 Aug 2013 11:59:45 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FF982D28-0F37-11E3-AEE7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233112>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Tue, 27 Aug 2013, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@fluxnic.net> writes:
>> ... 
>> > I'd like to preserve the author time stamps as they relate to where in
>> > the world I was when the corresponding code was written.  You'll notice
>> > I didn't work on the code in the same order as it is now presented.
>> 
>> We can also notice things like "From: user@machine.(none)" ;-)
>
> Heh.

In any case, the "Date: " in-body header next to your "From: "
in-body header is your friend if you want to do the "where and when
did I work on this?"

>> > Still open question: what to do with a thin pack.  Should we really
>> > complete it with local objects upon reception, or were we only over
>> > paranoid at the time we imposed this rule?
>> 
>> I do not think paranoia had much to do with it.  I am afraid that
>> allowing a delta in a pack to depend on a base in another pack means
>> that the former pack becomes unusable without the latter, which
>> would make object store management (e.g. partial repacking) a lot
>> more cumbersome, no?
>
> That's what I'm wondering.  We already end up with a broken repository 
> if the commit graph is spread across multiple packs and one of those 
> pack is removed.  Having a delta base in a separate pack is not much 
> different in that regard.

In practice, maybe, but I somehow find that it is more fundamental
breakage not to be able to reconstitute objects that a pack and its
index claims to have than missing an object that is referenced in
the reachability graph.

As you have "0-index" escape hatch for SHA-1 table, but no similar
escape hatch for the people's name table, I can see why it may be
cumbersome to fix a thin pack by only appending to a received
packfile and updating a few header fields, though.

> So the rule could be that any kind of repacking must not carry over 
> deltas with a non local base i.e. repack always produces delta 
> references belonging to the same pack.
