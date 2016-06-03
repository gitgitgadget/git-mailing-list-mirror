From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] pathspec: allow escaped query values
Date: Fri, 03 Jun 2016 13:39:23 -0700
Message-ID: <xmqqzir2nh1g.fsf@gitster.mtv.corp.google.com>
References: <20160603191930.16973-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, ramsay@ramsayjones.plus.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 22:40:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8vsm-0004LY-UW
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 22:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbcFCUjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 16:39:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422701AbcFCUj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 16:39:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CAAFC22E0A;
	Fri,  3 Jun 2016 16:39:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y1CEKDmw7nwd2C3yp85hAcRf+FE=; b=oycKeG
	MSIKIthLe0cDT03RW4/eCm1meIOHcaj2sE1XkwuertSTWtpEmN5+YgFDRJ0cDIOo
	4DgGO3ADud69jXG903NVwcigVhi/4cRogSWABC6NGbC2tsxG3rej8P7+xo8LYTRD
	ILjU+WFluhZqAFIpOUF3C9PVMAGiY8ttdYlMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yaFIHAY7Jvjq7sguj5KiQnPM9fF2rImC
	pcDCIeKE/Kf0WRefr6PFvM3NTqbrH2ZmAx8ivnp5RyqjAGh139y0q1pUOdUzE0Y3
	w3zbqVzpFzehzeMJ8th+GxUpW05n+MnIW0YIAzjphKr+py4FmdBYyb/xbYorNOu0
	brw5I8KNLc8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3CD922E09;
	Fri,  3 Jun 2016 16:39:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D43E22E08;
	Fri,  3 Jun 2016 16:39:25 -0400 (EDT)
In-Reply-To: <20160603191930.16973-1-sbeller@google.com> (Stefan Beller's
	message of "Fri, 3 Jun 2016 12:19:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4286C940-29CB-11E6-B81D-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296370>

Stefan Beller <sbeller@google.com> writes:

> In our own .gitattributes file we have attributes such as:
>
>     *.[ch] whitespace=indent,trail,space
>
> When querying for attributes we want to be able to ask for the exact
> value, i.e.
>
>     git ls-files :(attr:whitespace=indent,trail,space)
>
> should work, but the commas are used in the attr magic to introduce
> the next attr, such that this query currently fails with
>
> fatal: Invalid pathspec magic 'trail' in ':(attr:whitespace=indent,trail,space)'
>
> This change allows escaping characters by a backslash, such that the query
>
>     git ls-files :(attr:whitespace=indent\,trail\,space)
>
> will match all path that have the value "indent,trail,space" for the
> whitespace attribute. To accomplish this, we need to modify two places.
> First `eat_long_magic` needs to not stop early upon seeing a comma or
> closing paren that is escaped. As a second step we need to remove any
> escaping from the attr value.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> differences to v3 (http://thread.gmane.org/gmane.comp.version-control.git/296259):
> * lose the *src check before invalid_value_char
> * remove a stray new line in parse_pathspec_attr_match
>
> Thanks,
> Stefan

Excellent.  Thanks.
