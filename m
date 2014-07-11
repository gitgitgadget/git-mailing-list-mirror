From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 v4] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 09:28:37 -0700
Message-ID: <xmqqtx6n507e.fsf@gitster.dls.corp.google.com>
References: <1405036334-8093-1-git-send-email-jacob.e.keller@intel.com>
	<1405036334-8093-2-git-send-email-jacob.e.keller@intel.com>
	<xmqqion4543l.fsf@gitster.dls.corp.google.com>
	<1405095622.22963.6.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"peff\@peff.net" <peff@peff.net>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:28:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5dgo-0003rz-7W
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 18:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbaGKQ2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 12:28:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55737 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754470AbaGKQ2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 12:28:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6953125061;
	Fri, 11 Jul 2014 12:28:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xd8iJyooitmHeFbxKa+ANBmfamA=; b=ZgE4So
	vDfjVkcbUd+xfI6QnXwzojDhgfnqfy+/DULBqSrCZS6DkieLcvy/WD84kgXLzxc0
	mgRzUXmMs5+PaRFyQ5GRuQyujIcMuWmqK3L2ra2Esj4i2SDFOBixwBbqCe90GJEo
	PCStOducS+DM1xqyt4dDY46NeV03jv98xLoIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nn9ik7hGjoABakdwP1S5qzbJ2ifbkgZb
	so2J4n4FmRpKdGQcXhcIlkYj1CLCA52uaQFIs+lNS8up3/SD+flkiEg6b9xrwDzz
	ZoKRdLzJnPJ1aLSXrxtMkPsrYjsmW7ENBo5uQvkp781s7hcuuf+EQzYOtY/8VAa+
	NijnpXntwsE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DE8D2505C;
	Fri, 11 Jul 2014 12:28:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DDFBC25044;
	Fri, 11 Jul 2014 12:28:23 -0400 (EDT)
In-Reply-To: <1405095622.22963.6.camel@jekeller-desk1.amr.corp.intel.com>
	(Jacob E. Keller's message of "Fri, 11 Jul 2014 16:20:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 61000B96-0918-11E4-9174-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253288>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> On Fri, 2014-07-11 at 08:04 -0700, Junio C Hamano wrote:
> ...
>> > +static int tag_sort = 0;
>> 
>> Please do not initialize variables in bss segment to 0 by hand.
>> 
>> If this variable is meant to take one of these *CMP_SORT values
>> defined as macro later in this file, it is better to define this
>> variable somewhere after and close to the definitions of the macros.
>> Perhaps immediately after the "struct tag_filter" is declared?
>
> I put it just above the struct tag_filter now, as this puts it right
> below the #defines regarding it's value.

Either would be fine, but just to clarify.

Because these macro definitions are for the .sort field of that
structure, and the new tag_sort variable is the second user of that
macro, my suggestion to put it _after_ was to be in line with "add
new things at the end, when there is no compelling reason not to"
below.

>> When there is no reason to have things in a particular order, it is
>> customary to add new things at the end, not in the front, unless the
>> new thing is so much more important than everything else---but then
>> we are no longer talking about the case where there is no reason to
>> have things in a particular order ;-).

Thanks.
