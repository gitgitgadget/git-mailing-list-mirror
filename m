From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Wed, 04 Jan 2012 14:15:10 -0800
Message-ID: <7vaa63p11t.fsf@alter.siamese.dyndns.org>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org> <20120104204017.GC27567@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 04 23:15:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiZ7C-0002Hh-SF
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 23:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757184Ab2ADWPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 17:15:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57204 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757181Ab2ADWPN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 17:15:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68D2C68E3;
	Wed,  4 Jan 2012 17:15:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l+sUnWjtFa0lc38I0YTGdzs/Tjs=; b=wPIZzg
	a1wREU9inoJxB4RJeW9B/K+s3NMvh6qiO7FJnqO/diBwfjhAmf9Tefn65hue4+4a
	GT9ZKFv9ZX9bGpuHUi0p5bpoSWRax7GMYJEAbaPmM5xZH0YX1LLcuvLunUhQUI4U
	GAICxU42dWIQ5ZlQLA5B8sb4eosfmpnVj+5q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vEIwUf0UiArBmyNEwP9zn1ooSEkeUNyG
	lTm9cIa+vY1mvaXGeGPtuV2xyqK6P0nqoy0HI/ERqyrdTFNKKyt6ax2HhOjy15rs
	aabIuFrWdCiSsdwJKLW3rlE8uZylh5P8zihwxnbLeJFHqETgfzt401DeelN+7OWC
	5/0/lyxVXkQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FD4368E2;
	Wed,  4 Jan 2012 17:15:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8B6C68DF; Wed,  4 Jan 2012
 17:15:11 -0500 (EST)
In-Reply-To: <20120104204017.GC27567@ecki.lan> (Clemens Buchacher's message
 of "Wed, 4 Jan 2012 21:40:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91E821B0-3721-11E1-91A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187949>

Clemens Buchacher <drizzd@aon.at> writes:

> On Wed, Jan 04, 2012 at 10:00:07AM -0800, Junio C Hamano wrote:
>>
>> >> >> +	# kill git-daemon child of git
>> >> >> +	say >&3 "Stopping git daemon ..."
>> >> >> +	pkill -P "$DAEMON_PID"
>> >> 
>> >> How portable is this one (I usually do not trust use of pkill anywhere)?
>> >
>> > I read that it is supposed to be more portable than skill or killall.
>> > But I have no way to research this. I have implemented a workaround
>> > using only 'ps' and 'kill' in [PATCH 3/6] avoid use of pkill.
>> 
>> Yuck, that patch looks even uglier X-<.
>> 
>> Do you really need to kill the children but not the daemon?
>
> If I kill just the parent "git daemon" command, then the actual
> git-daemon (started by run_command) will be left behind.

Sounds like we would be better off with a new "--foreground" option other
daemon-ish projects seem to have?
