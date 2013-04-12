From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 21:46:35 -0700
Message-ID: <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
References: <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
 <20130411181103.GJ27070@google.com>
 <20130411181439.GA2820@sigill.intra.peff.net>
 <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
 <20130411200330.GA15667@odin.tremily.us>
 <7vip3shfpd.fsf@alter.siamese.dyndns.org>
 <20130411222301.GA11283@sigill.intra.peff.net>
 <20130412005748.GA17116@odin.tremily.us>
 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 06:46:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQVsq-0002QG-49
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 06:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab3DLEqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 00:46:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53204 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab3DLEqi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 00:46:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29041E78C;
	Fri, 12 Apr 2013 04:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BzECf0SAnakp2J3yc9Z4ql7oE8o=; b=CJFrFq
	3Uk4u5mTlwp7qNNmJBUy628pvTYK3gCl/u3+v4pq5Sn5bF53o9EHqSyJt+hVayZ/
	yJRy807C0RlGiReqEDJkuL7UK3ca8tBJav6HRB00hpkixyTK0Tsf8+b9o7A0tPo9
	UaFQeEowoALDgoY/kYmX3reR7/+wJD8NTiNiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MiA5G+bPnlV9S1A0V7Wxk8uTym2WPcli
	jJh5vr+5toncd+EPSBgPlZBFc//xtT48H+pAeDawPngFJ+L5YaFAAQJ9Ugep7416
	51UZ08fL5NCtbMAZ3AXr4PTNqcc7toLFO8AbMJJF8ASq4VgiYprKALzwWX+oVXHx
	CMbTee2VDSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FAB5E78B;
	Fri, 12 Apr 2013 04:46:38 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C129E787; Fri, 12 Apr 2013
 04:46:37 +0000 (UTC)
In-Reply-To: <20130412043501.GA12942@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 12 Apr 2013 00:35:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5AD15A8-A32B-11E2-A021-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220951>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 11, 2013 at 09:11:20PM -0700, Junio C Hamano wrote:
>
>> The --user option to git-daemon would be a good place to do that, I
>> think.  Depending on what other "setuid to less privileged before
>> running" programs do (I do not know offhand), we can say something
>> like this perhaps?
>
> That's a good question. I looked at (just sampling a few off the top of
> my head):
>
>   xinetd
>   openbsd-inetd
>   inetutils-inetd
>   postfix
>   dovecot
>   courier
>
> and none of them sets HOME when dropping privileges. Admittedly some of
> them do not drop privileges immediately in the same way (e.g., the imap
> servers need to remain root so that they can switch to the right user to
> read mail). Postfix does set HOME, but only when actually "becoming" the
> user to do deliveries, not at startup.

Thanks for checking.

For $HOME, it is sufficient to do an unsetenv-equivalent, and I
suspect some of them do just that, though.  Vanilla openbsd-inetd
doesn't, but Debian seems to have a patch to sanitize the
environment, for example.

But still...

> I could also be wrong on one or more of those, as that is from some
> quick grepping, but I think it's clear that the norm is not to set HOME
> alongside setuid (of all of them, I would say git-daemon behaves most
> like the inetd utils, as it does not ever "become" users at all).
>
>>     --user::
>> 	... current description ...
>>     +
>>     (Like|Unlike) many programs that let you run programs as
>>     specified user, the daemon does not reset environment variables
>>     such as $HOME when it runs git programs like upload-pack and
>>     receive-pack. Set and export HOME to point at the home directory
>>     of the user you specify with this option before you start the
>>     daemon, and make sure the Git configuration files in that
>>     directory is readable by that user.
>
> So choosing "Like" here, I think this makes sense.

I would prefer the simplicity ;-)

"Set and export HOME to point at the home directory of the user you
specify with this option" screams that it wants to be rephrased at
me, though.  It somehow sounds as if this option is a way to set and
export the environment variable unless re-read carefully X-<.
