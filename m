From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack v4 trees with a canonical base
Date: Tue, 10 Sep 2013 13:13:24 -0700
Message-ID: <xmqqbo40xwnv.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.03.1309091517380.20709@syhkavp.arg>
	<CACsJy8C+SFBRD1czeeK5VBDYT4xA6K+61HgLRnjB+CYJ-2g+uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 22:13:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJUJY-0001LO-F4
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 22:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab3IJUN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 16:13:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893Ab3IJUN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 16:13:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2291A40FBF;
	Tue, 10 Sep 2013 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L86XQV4E3ljvkxK9h4aOI3uahC4=; b=AK7t9C
	FGlIlviibmgYCph21yqxTSQg4T+6MLVPzMkDQy9pCKYzROVPdS9y6ognfOHTQSS7
	w/H9pTk/lUlJC3ghddlNe8KleaVQAqLQnNh5+XdI48AbalPsj7evWS42kpXoBHUO
	qLCRVmCbBUzCipOOKuYWUk2BjGYBZAl2TM9C8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EPBZFmX1WWiWPUtgAmemiMhkxV2Z4jcv
	TYDu97BGvl5dgWAgKO+sNSpdvMJprckEqiJTyKjjXwl0jQCvCDoIwIGqCStYWyKt
	8HCJRLYe7bXWvPMLh1LLIU2avvm6fneE4Na4c3nqq4Co0Hrb9jOzAI/NwumKtZLt
	7zl0ZIFQvZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13C5640FBE;
	Tue, 10 Sep 2013 20:13:27 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 588CE40FBB;
	Tue, 10 Sep 2013 20:13:26 +0000 (UTC)
In-Reply-To: <CACsJy8C+SFBRD1czeeK5VBDYT4xA6K+61HgLRnjB+CYJ-2g+uA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 10 Sep 2013 07:52:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7382BA46-1A55-11E3-974C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234477>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Sep 10, 2013 at 2:25 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> An eventual optimization to index-pack when completing a pack would be
>> to attempt the encoding of appended tree objects into the packv4 format
>> using the existing dictionary table in the pack, and fall back to the
>> canonical format if that table doesn't have all the necessary elements.
>
> Yeah, it's on the improvement todo list. The way pack-objects creates
> dictionaries right now, the tree dict should contain all elements the
> base trees need so fall back is only necessary when trees are have
> extra zeros in mode field.

Careful.

There may be trees in the wild that record 100775 or 100777 in the
mode field for executable blobs, which also need to be special
cased.
