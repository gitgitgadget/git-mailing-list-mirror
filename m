From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git send-email: include [anything]-by: signatures
Date: Tue, 03 Sep 2013 14:39:05 -0700
Message-ID: <xmqqk3ixpoue.fsf@gitster.dls.corp.google.com>
References: <20130826165747.GA30788@redhat.com>
	<20130831192250.GA3823@redhat.com>
	<20130903063535.GA3608@sigill.intra.peff.net>
	<20130903084454.GC18901@redhat.com>
	<xmqqmwntu96c.fsf@gitster.dls.corp.google.com>
	<20130903210149.GA24480@redhat.com>
	<20130903210352.GA27344@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 23:39:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGyJi-0003K1-Gh
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 23:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892Ab3ICVjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 17:39:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759989Ab3ICVjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 17:39:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBF783E0BF;
	Tue,  3 Sep 2013 21:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=duoCibYBlJuaKX/1GBYea7ueRqM=; b=g6/p00
	rZTY2sIq6YAuOhl0g2HtWbX7a5erKe+Uu+JdrpMe7w2mEwtSIORo7MDJ4UUtTDB0
	rBJtVyi1zQk0qLjL2o/wf/6HvZm6z/D42baGofcWv/5rtfUWErDZ3Zv2pWLgr8Ul
	/J4uXABgDRe+snJivVr1Khp7OjODpUetMhR4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vw67wizZVrVuef8Of7voYK/Rnf4vCCOI
	V1QogFjlhdkG/mjM9uFKW7SEao+xoWosFBeQ+5H8Z1PIwX5sMiugliiSSyk5OaD6
	fDQDowuj9BG4hi5n5ikuHk1ek0IHir/d1OT7ssPMYcFxKQ4519ZP+rlPifIYDBS8
	QXk/qUSAYEI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45F2E3E0B9;
	Tue,  3 Sep 2013 21:39:12 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5323B3E0A8;
	Tue,  3 Sep 2013 21:39:09 +0000 (UTC)
In-Reply-To: <20130903210352.GA27344@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 3 Sep 2013 17:03:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 44A16066-14E1-11E3-B79D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233783>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 04, 2013 at 12:01:49AM +0300, Michael S. Tsirkin wrote:
>
>> > The question of course is the first point Peff raised.  I am not
>> > sure offhand what the right per-project customization interface
>> > would be.  A starting point might be something like:
>> > 
>> > 	--cc-trailer=signed-off-by,acked-by,reviewed-by
>> 
>> tested-by, reported-by ...
>
> Yeah, I think having the list customizable is nice, but not allowing
> some pattern matching seems unfriendly, as it requires the user to
> enumerate a potentially long list.
>
>> > 	--cc-trailer='*-by'
>> > 
>> > and an obvious configuration variable that gives the default for it.
>> > That would eventually allow us not to special case any fixed set of
>> > trailers like S-o-b like the current code does, which would be a big
>> > plus.
>> 
>> What bothers me is that git normally uses gawk based patterns,
>> but send-email is in perl so it has a different syntax for regexp.
>> What do you suggest?  Make a small binary to do the matching for us?
>
> Would fnmatch-style globbing (like "*-by") be enough? That should be
> easy to do in perl.

Web query finds File::FnMatch; I do not know if that is the most
commonly used, or if it comes with the base distribution, though.
