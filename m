From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: update hook for GPG signed submission on secured branches
Date: Fri, 16 Jan 2015 14:49:46 -0800
Message-ID: <xmqq7fwm1gtx.fsf@gitster.dls.corp.google.com>
References: <BBE88A3EA44D47159C483F1046AC747E@black>
	<xmqqsifa1px6.fsf@gitster.dls.corp.google.com>
	<BD3DE7B299FE458287DC8C829CEADEC2@black>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Jason Pyeron" <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Fri Jan 16 23:50:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCFiQ-0002u1-SD
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 23:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbbAPWtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 17:49:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750968AbbAPWtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 17:49:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A1282E2A5;
	Fri, 16 Jan 2015 17:49:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3iK9ePvOR5fn72BLnZ7lToo7ubU=; b=JDXowP
	x/i9w1NOq8S4imoDLsa4NEhG5XjDMDZhcV8zv0gov29CuJNAsTF0fXyFiI3TJMCJ
	obfPp/gKD6fO70peYuV9z7xlo5oxjcMy8ipH1llH5zO8qtuGCAYOdUKRxwAfJwRy
	e6kWbTjKNduN5gur6EuyQBkdedrU+VAcbm+fY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FY2mmwp1Il5Qkt3C4XBxuw22nGKcCOvL
	ZWuyZoleAQa6hUJ9bLSxVt4ntZrlmMEFhXfmTZA+AdR4KqSKeqUxyD2ximk5kkrI
	zKDU6MJQLQzmDMss8AghNOoUB3qaMkg/eUCIjasl+7nUn39Wv3UJAEvIaHynZ6Gj
	TeTFvvs1O8U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30F922E2A4;
	Fri, 16 Jan 2015 17:49:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A680B2E2A3;
	Fri, 16 Jan 2015 17:49:47 -0500 (EST)
In-Reply-To: <BD3DE7B299FE458287DC8C829CEADEC2@black> (Jason Pyeron's message
	of "Fri, 16 Jan 2015 14:47:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8DD6EF6-9DD1-11E4-8599-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262578>

"Jason Pyeron" <jpyeron@pdinc.us> writes:

>> Is this complex pipeline the same as this (I didn't understand the
>> trailing I at the end)?
>
> Case insensitive, could have used [0-9a-fA-F].

Ahh, a GNU extension.

>> 	git cat-file commit "$newrev" |
>>         sed -ne '/^gpgsig /,/^ -----END/{
>>         	s/^gpgsig //
>>                 s/^ //p
>> 	}' |
>
> Will all future signature values end with a "^ -----END"?

If it bothers you, alternatively, you can stop at the end of the
commit object header, i.e.

	/^gpgsig /,/^$/{
        	s/^gigsig//
                s/^ //p
	}

but I do not think it matters that much ;-)
