From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 07/14] trailer: add interpret-trailers command
Date: Fri, 07 Feb 2014 10:09:51 -0800
Message-ID: <xmqqk3d6vlow.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.48784.chriscool@tuxfamily.org>
	<xmqqiosrwzoh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD10aGq+cUcaiMHRKsLLKvF1eYUuM+G85MRHqhwBXZVv-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 19:09:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBpsE-0001Uj-WD
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 19:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbaBGSJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 13:09:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbaBGSJy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 13:09:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE27E69751;
	Fri,  7 Feb 2014 13:09:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DKyEqK5ququo/IljLsH4G53wPG4=; b=tkbLaR
	1ETrmoFN3hXbslFGb+PxfKJ0fzEIkOThTgA7aDB5HXf9CeggOLeKbgMnffPoeSGf
	WyJsedLvB2nrNda72Nws9rjQI0bNUmDDnInUt4fceCh4/sGfyXtZdaqbTj5DuxRn
	pvt2bzKKkhSpY5R9vXMDRtc7wZGz1LRB66mA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hv1I08G5S219opNnfQWxbxvp0df7Yf1A
	db+S8plGKlp9hbHcIS3O6BEl1QAk6Ig3ZM7Ml/9LbHbTFCtg7QnPq5DUqhGGHYPU
	KmtE+FUghVOJ2KyzNln14+89RouoofAl8I66yzhN2EuH0Zys0RX6GlBbYGir6526
	UF+8k8w074Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3B6269750;
	Fri,  7 Feb 2014 13:09:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A8C66974E;
	Fri,  7 Feb 2014 13:09:52 -0500 (EST)
In-Reply-To: <CAP8UFD10aGq+cUcaiMHRKsLLKvF1eYUuM+G85MRHqhwBXZVv-g@mail.gmail.com>
	(Christian Couder's message of "Fri, 7 Feb 2014 09:34:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0A98722A-9023-11E3-86B8-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241789>

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Feb 7, 2014 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <chriscool@tuxfamily.org> writes:
>>
>>> diff --git a/git.c b/git.c
>>> index 3799514..1420b58 100644
>>> --- a/git.c
>>> +++ b/git.c
>>> @@ -383,6 +383,7 @@ static void handle_internal_command(int argc, const char **argv)
>>>               { "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
>>>               { "init", cmd_init_db },
>>>               { "init-db", cmd_init_db },
>>> +             { "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
>>>               { "log", cmd_log, RUN_SETUP },
>>>               { "ls-files", cmd_ls_files, RUN_SETUP },
>>>               { "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
>>
>> Does this even need to have a git repository?  What is the RUN_SETUP
>> for?
>
> It needs to read git config files, but it could work without reading them too.
> I will have another look at it.

Of course.  At this point in the series while reviewing 7/14 there
was no config [*1*] and that was why I was scratching my head.


[Footnote]

*1* Flipping the series structure to a top-down fashion, having an
almost no-op command that fails all the new tests in the beginning
and then building the internal incrementally, might be a worthwhile
change, but it is *not* worth the effort to add the command without
RUN_SETUP at 7/14 and then change the same line to have RUN_SETUP
when you start to need it could be an option; I am *not* suggesting
that.
