From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] rev-parse --parseopt: option argument name hints
Date: Fri, 21 Mar 2014 10:04:58 -0700
Message-ID: <xmqqvbv7v5xh.fsf@gitster.dls.corp.google.com>
References: <532AA923.6030409@gmail.com>
	<1395305092-1928-1-git-send-email-ilya.bobyr@gmail.com>
	<xmqqpplgyaud.fsf@gitster.dls.corp.google.com>
	<532B7774.30308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:05:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR2sV-0001i5-E2
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 18:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbaCURFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 13:05:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbaCURFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 13:05:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14DC474866;
	Fri, 21 Mar 2014 13:05:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wed9xrVPyywn52gqsDF2GHkbVl8=; b=cH447s
	i9Sp+lDBfs12jgjrV3GjV5mgL+e8g3/WBFGybyAuM2e4qACdWHdlSxrAEQ5fQEan
	AEC/cPTaW2t/0abfTV0J9Y0qEtxRtISHHdPqdKtMaLlbW56DBCoPZI0QrJsbtwPy
	qIYyZuRIqua2JkxdDgrzToa5ALWS8ZmkMY0/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P7dgvJY0LJhuxw1QXXJ1TZfi0EAAY4P3
	BbQo5in9vu+HaWX1vsjbk6slcvNaCW45d1pcsPxuQyaO4mFfyDL2ecB4lO30zf76
	/S8WUouXc9KgBAZrciLBQ2A9k6TDkIPYYlY7NHcE+UWipwVc8C+PpUGCwKT27xJh
	n5r/JqfR37k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3E3174864;
	Fri, 21 Mar 2014 13:05:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D87574862;
	Fri, 21 Mar 2014 13:05:00 -0400 (EDT)
Importance: high
In-Reply-To: <532B7774.30308@gmail.com> (Ilya Bobyr's message of "Thu, 20 Mar
	2014 16:19:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EFDB1780-B11A-11E3-9FE2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244702>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

>>> +	`<arg_hing>`, if specified, is used as a name of the argument in the
>>> +	help output, for options that take arguments. `<arg_hint>` is
>>> +	terminated by the first whitespace. When output the name is shown in
>>> +	angle braces.  Underscore symbols are replaced with spaces.
>> The last part is troubling (and sounds not very sane).  Do we do
>> such a munging anywhere else, or is it just here?  If the latter I'd
>> prefer not to see such a hack.
>
> The following commands have spaces in argument names in the "-h"
> output for one or two arguments:
>   * clone
>   * commit
>   * merge
>
> A number of commands use dashes to separate words in arguments names.

That was not what I asked.  I was asking if there is a precedent to
use "you cannot have underscores in hint; they will be turned into
spaces" quoting convention.  I do not think of any (we either do a
backslash-quote, c-quote inside dq-pair, or %20, depending on the
context).

Personally, because these "hints" are not even hints (they are more
like placeholders for value that makes it easier to refer to in the
description of an option [*1*]), I wouldn't shed tears if scripted
Porcelains cannot use a space in the argh.  In fact, it probably
makes the result harder to read and format more funnily if you had a
space in the argh string, be it in a subcommand implemented in C or
in a scripted Porcelain.

"An optional argh is terminated by a whitespace" is perfectly fine,
and by doing so we do not have to worry about having to introduce a
new quoting convention like you did, which is a big plus.


[Footnote]

*1* Perhaps like this:

	--gpg-sign[=<key-id>]
        	Sign (with the key specified with <key-id>)
