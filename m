From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Tue, 29 Oct 2013 12:54:16 -0700
Message-ID: <xmqqa9hretuf.fsf@gitster.dls.corp.google.com>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
	<xmqqa9hui2lp.fsf@gitster.dls.corp.google.com>
	<xmqq1u35iwyl.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0R7JAkQSiX=1nqg_fmo-o7B-ekkxvsjHFgwspk5V0PHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@joshtriplett.org>, git <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 20:54:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbFN0-0007XM-Sa
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 20:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab3J2TyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 15:54:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967Ab3J2TyT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 15:54:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CE1D4DFF8;
	Tue, 29 Oct 2013 19:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gZRVo1j4Vv1KSSwMrcMatHUsoEs=; b=DUHsml
	MuADc6OsbEBR1ItPHxwLhbG2Gzhao9sQoVI+eL/aYH1hUidPxEZEMiUqsA1Y8eW9
	XLqjtTSRyVRmtxV7wuGKmJ2ZoouCmfWbtsoto2Wi6FTDioxrBdW6xRiHqnaCS4ki
	viMDiSq/ifFOCeneF1/npSIOOf73AqSz7chZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hxg3sPHy2PNkD3+axiLJGOhYqYF8z2kF
	aS33ltLkFuPtLvLgmg6RvM3A+/091li5K71pQfKFJVPZvqoON9DeHUxABoJ4xXll
	L95blPdDozgKoL2Pp6eNPGm3qfnBZmGRjR1u2YA+6HEWvpodecQBUcZ8uspto4sN
	Q9U6awj4U+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D7F54DFF7;
	Tue, 29 Oct 2013 19:54:19 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FA274DFF2;
	Tue, 29 Oct 2013 19:54:18 +0000 (UTC)
In-Reply-To: <CAP8UFD0R7JAkQSiX=1nqg_fmo-o7B-ekkxvsjHFgwspk5V0PHA@mail.gmail.com>
	(Christian Couder's message of "Tue, 29 Oct 2013 05:45:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E58C56DE-40D3-11E3-B3E5-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236946>

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Oct 28, 2013 at 10:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Thinking aloud further, what I had in mind was along the lines of
>> the following.
>>
>>  * The most generic external interface would be spelled as
>>
>>     --trailer <token>[=<param>]
>>
>>    where <token> can be things like "signoff", "closes", "acked-by",
>>    "change-id", "fixes", etc.; they can be taken from an unbounded
>>    set.  The historical "--signoff" can become a short-hand for
>>    "--trailer signoff".  More than one "--trailer" option can be
>>    given on a single command line.
>
> Ok, and maybe the <token> could also be the full trailer like "Signed-off-by".

Yeah, between these two:

    [commitTrailer "Signed-off-by"]
        style = append-norepeat
        shorthand = signoff
        command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'

   [commitTrailer "signoff"]
        style = append-norepeat
        trailer = Signed-off-by
        command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'

I do not have strong preference either way.  One of these two sets
of configuration will have to become a built-in default (i.e. still
allowing people from other development community conventions to
redefine how S-o-b: works), so there will be no user-visible
difference either way at the highest-level Porcelain anyway.

Oh, also, it seems people prefer to call them "footers", judging by
the messages in this thread. I do not have a problem with that word,
either; I suspect we may have to update existing documentation that
calls them "trailers", if we go that way, though.
