From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] trailer: add tests for "git interpret-trailers"
Date: Mon, 30 Dec 2013 12:46:33 -0800
Message-ID: <xmqqk3emqd7a.fsf@gitster.dls.corp.google.com>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
	<20131224063726.19560.61859.chriscool@tuxfamily.org>
	<xmqq1u0utfwk.fsf@gitster.dls.corp.google.com>
	<20131230202042.GJ27213@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 21:47:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxjjq-00076j-Fn
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 21:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193Ab3L3Uqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 15:46:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117Ab3L3Uqj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 15:46:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0233E5F6DB;
	Mon, 30 Dec 2013 15:46:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iOxwQ9/ZcF2OM+V+52e7BxDGWMU=; b=qacJt6
	leYl6jQ/Y8HYA15tpcTmpN7nASwjKo5p4KQuOYoAKyyX4v2qpbx4vFJF1bvc1Atf
	YgELI+e4P94BQ8YhV03WcTjROPnREUdCpjSQgQmAkmj6dWMmnSdpeLaKq/l4T032
	KB0X3m+q5/9uFF5Z6d8/whDbjgSBHvAEwrZmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jqwy0uzgWGwXnos+j4wawEWb6sKIGD+f
	vZdJ68Envvg6r0l2qQ1M+knSnookerLL1mefwVuQY7BG4peWEI0tGLfzD4LocpK5
	91+HaCiyr+PHkzFxEJkPkTWF36ySazI2XO63+g9IllPZHWZIFKIsV/C3u2k2ufrg
	Qy2Iwr8sCp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E449A5F6DA;
	Mon, 30 Dec 2013 15:46:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40A4E5F6D9;
	Mon, 30 Dec 2013 15:46:37 -0500 (EST)
In-Reply-To: <20131230202042.GJ27213@leaf> (Josh Triplett's message of "Mon,
	30 Dec 2013 12:20:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A1438FE-7193-11E3-86B4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239824>

Josh Triplett <josh@joshtriplett.org> writes:

> On Mon, Dec 30, 2013 at 09:19:55AM -0800, Junio C Hamano wrote:
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> 
>> > +# Do not remove trailing spaces below!
>> > +cat >complex_message_trailers <<'EOF'
>> > +Fixes: 
>> > +Acked-by: 
>> > +Reviewed-by: 
>> > +Signed-off-by: 
>> > +EOF
>> 
>> Just a hint.  I think it is far safer and robust over time to do
>> something like this:
>> 
>> 	sed -e 's/ Z$/ /' <<-\EOF
>>         Fixes: Z
>>         Acked-by: Z
>>         EOF
>> 
>> instead of a comment, which can warn human developers but does not
>> do anything to prevent their editors' auto-fix features from kicking
>> in.
>
> This, but for simplicity, since every line needs the trailing space, why
> not just use 's/$/ /' and drop the ' Z' on every line?
>
> </bikeshed>
>
> - Josh Triplett

A few reasons:

 - The "everybody will have a single SP at the end" may or may not
   last forever;

 - With your scheme, if you already had _one_ trailing SPs in the
   input, it would be hard to spot in the source;

 - It makes it visually very clear that we expect a SP after these
   colons.  This is especially true if you replace 'Z' with
   something more readable (e.g. '|').
