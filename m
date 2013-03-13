From: Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Wed, 13 Mar 2013 12:28:27 -0700
Message-ID: <7vy5dr14mc.fsf@alter.siamese.dyndns.org>
References: <20130312210630.GF2317@serenity.lan>
 <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
 <7vehfk5kn2.fsf@alter.siamese.dyndns.org> <3222724986386016520@unknownmsgid>
 <20130313001758.GH2317@serenity.lan>
 <CAJDDKr7ZU16XWtCfYX9-RMzcpKa_FF80Od+mUMG4n8dUKeLsvw@mail.gmail.com>
 <7vtxof48sg.fsf@alter.siamese.dyndns.org>
 <7v1ubj45ac.fsf@alter.siamese.dyndns.org>
 <20130313170821.GK2317@serenity.lan>
 <7vppz32o60.fsf@alter.siamese.dyndns.org>
 <20130313180106.GL2317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 13 20:29:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFrMB-0002F6-Te
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 20:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933242Ab3CMT2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 15:28:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933218Ab3CMT2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 15:28:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A15A14B;
	Wed, 13 Mar 2013 15:28:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sQBcdpSWLFQM2PNscHhIe9879+c=; b=wimhQZ
	f+T0gm4vMLPeFxlD1rU0zYsiNwSfH+6cGyH3reIpEQojXDDWsLK/oYvEoBvT4jLh
	P9VUplxXaB7qW26F874tKHcncFLmt5in5XO6CPnMVdF8jX6zaSTDyvlo/+g+OSqK
	VXLO83INHOkbS1FyK34R+rGw9VjX0AjxMrw9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZmDR9iWxdIqR3/7RBAoX4rESTwa5Zz9n
	4kkQvHIfPt7EwI/goMC4uyaiUeeKTFW/MurSL6eyRafI2VwyOY9fxc9mv84UuUva
	THuhWSkzS8z0gAaNeHbfISJo0fPgzUckNzqj3fBsa3dljncY1/hIkEJF36wHtIoX
	3DfBzNDTfIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5261A14A;
	Wed, 13 Mar 2013 15:28:29 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D473A146; Wed, 13 Mar 2013
 15:28:29 -0400 (EDT)
In-Reply-To: <20130313180106.GL2317@serenity.lan> (John Keeping's message of
 "Wed, 13 Mar 2013 18:01:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F2D3760-8C14-11E2-8EE2-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218083>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Mar 13, 2013 at 10:40:55AM -0700, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > git-hash-object(1) implies that it will apply the clean filter and EOL
>> > conversion when it's given a path to a file in the working tree (as it
>> > is here).  Is that not the case?
>> 
>> Applying clean to smudged contents _ought to_ recover clean version,
>> but is that "ought to" something you would want to rely on?
>
> How does git-status figure out that file that has been touch'd does not
> have unstaged changes without relying on this?  Surely this case is no
> different from that?

I just checked.  ce_modified_check_fs() does ce_compare_data() which
does the same "hash the path and compare the resulting hash".  So I
think we are OK.

Thanks.
