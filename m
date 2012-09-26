From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool--lib: Allow custom commands to override
 built-ins
Date: Wed, 26 Sep 2012 07:06:23 -0700
Message-ID: <7vtxukubds.fsf@alter.siamese.dyndns.org>
References: <1348559291-71739-1-git-send-email-davvid@gmail.com>
 <CALkWK0naJt840LfMNBM7EtdyLE5nmJeAsxG-Wttj8c84O5X7jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Sylvain Rabot <srabot@steek.com>,
	K Gateway <kowloongateway1@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Mike Schuld <mike.schuld@foundant.com>,
	Stefan Kendall <stefankendall@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 16:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGsG4-0000ud-Se
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 16:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab2IZOG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 10:06:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab2IZOG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 10:06:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B76F650A;
	Wed, 26 Sep 2012 10:06:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RiAWlErVQTUpLtXcxtzZz8eLxGM=; b=Nie/ab
	7t9DXUwkyYdE7e6pS+20rWGqQUTuB6uj+Ul5C0sogZgxOKhyRbKQKMmJS/77xhLF
	s7jHWCv/NJ2jUDHILZt6YD9WjqeMrbLvzIz1k7dRPJP8acuZ0eSb4jfrya5MaEy+
	ggxiR9bmy+Ifv14RZFPjSlyofJn/61e8PEf4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cREofIiuSmnsOfftlEFxxz38noB7m4+j
	B3lpOyT/p1os/Mmgxt3IxiuFs7WklHA3BYjF1NF9GBYbZv5wTXhtuodyio5DnsxW
	XqxpXGHPw9s9SWdZRfpbKr4lgeb4a1/Z0DrW3DHl0juEbbEmmgQ1zf+kexqxkC0j
	nqAtgnYeBE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 783DC6509;
	Wed, 26 Sep 2012 10:06:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E429E6508; Wed, 26 Sep 2012
 10:06:24 -0400 (EDT)
In-Reply-To: <CALkWK0naJt840LfMNBM7EtdyLE5nmJeAsxG-Wttj8c84O5X7jA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 26 Sep 2012 15:33:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B8F9F4C-07E3-11E2-AD9D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206415>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi David,
>
> David Aguilar wrote:
>>  diff_cmd () {
>> -       merge_tool_cmd="$(get_merge_tool_cmd "$1")"
>> -       if test -z "$merge_tool_cmd"
>> -       then
>> -               status=1
>> -               break
>> -       fi
>> -       ( eval $merge_tool_cmd )
>> -       status=$?
>> +       status=1
>>         return $status
>>  }
>
> Nit: Why not return 1, instead of setting $status and returning it?

Perhaps because the caller "run_merge_tool" pays attention to
$status that is a global variable?

Have you traced the call chain?
