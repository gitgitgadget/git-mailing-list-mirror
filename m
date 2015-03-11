From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/help.c: fix memory leak
Date: Tue, 10 Mar 2015 20:52:59 -0700
Message-ID: <xmqqioe8ur50.fsf@gitster.dls.corp.google.com>
References: <1425920304-22360-1-git-send-email-sbeller@google.com>
	<1425920304-22360-3-git-send-email-sbeller@google.com>
	<xmqqwq2oxyli.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYSBsfbR_gH1Ur12vMpcK5S0K6wrOpMhNVvgffAb683Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 04:59:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVXm7-00010h-9u
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 04:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbbCKDxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 23:53:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750774AbbCKDxG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 23:53:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A05A40962;
	Tue, 10 Mar 2015 23:53:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z0lrtRKLmPQQsgZaYRqePdSrPSI=; b=w6mg9S
	Iczbj4pGCPMePKoGvuCHDvEV7TlU0YRPld0R69qUxHRkBrz3r/tjOlVNfbWItHDh
	zHAtrZeBqHp48cfvKqR9wiNJjCYc3O4ma+Ts++NxVYmdfCM22YewOnYen1VXzG5y
	/0qz/4vsvmQOQH8pAx3rT9iw/TqlQw/ju47wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VVyPcUV7bWszinhoQFXfxEEVJV/vuSP8
	0qSnguZUMSYLY2vLKsVFyR0jHk9931nSEyCNiAC3fi28FblkIh3k5qt8qq54NUFG
	mGE5jdct+TncYeq1llMnLIWAooJDCbWVlSqP6Lve3C2sIJiY/wEnv/EZAMV0JceT
	B/GfSVWMLnc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 21EE040961;
	Tue, 10 Mar 2015 23:53:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CC9C4095D;
	Tue, 10 Mar 2015 23:53:00 -0400 (EDT)
In-Reply-To: <CAGZ79kYSBsfbR_gH1Ur12vMpcK5S0K6wrOpMhNVvgffAb683Bw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 10 Mar 2015 16:50:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C7DF39A-C7A2-11E4-AD99-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265295>

Stefan Beller <sbeller@google.com> writes:

>> Hmph, does this memory belong to us, or are we peeking into the
>> cached data in the config cache layer?
>
> So  alias_lookup(..) is a wrapper around git_config_string essentially
> (some more git_config_functions are involved, but we eventually reach
> git_config_string), where we have
>
>     *dest = xstrdup(value);
>
> so I think we need to free that memory, as the config cache layer doesn't
> care any more.

Ah, OK, thanks.
