From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/6] transport-helper: fixes
Date: Fri, 18 Apr 2014 18:09:11 -0700
Message-ID: <xmqqtx9q9lc8.fsf@gitster.dls.corp.google.com>
References: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq61mbod8y.fsf@gitster.dls.corp.google.com>
	<5351b6219fce_3497cdf30c6e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 03:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbJmR-0006hP-ME
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 03:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbaDSBJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 21:09:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982AbaDSBJO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 21:09:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 951FA7D98A;
	Fri, 18 Apr 2014 21:09:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=emTqfdOP1PEff3PEWCfi06o9TiE=; b=q6NRQ4
	0NDXstwtucyJ8LRXtKqDDL50E7aI6zUmN0mlG7i9iXRJ9euyJw2f7Z7X7yu+vT/u
	3S64nFmRycfY9JNyuM4SzqTtpUhi7jsg9ZQnpiShASto6DjRod6dZiATW4IPQLFp
	Gyu9+wIOl1wiTo6x4p3tAIXmUAwAh1RmukbNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhk1DtRBc+DyVG6FiY8hNs5Q3ZUluSOm
	EWtZL7tKztRVh+vCLntkrtK8IUPJ+JpLfbLla0MsL4KWjhvkeRE14X58kScz02ZL
	Qe9eh5MZkDniHVIRLmz5KbZcEvNvnVNaRnEzyXPGADHv/KWBRiIiLKr/RIO1Dvo/
	E5dK8qeWzXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73D637D989;
	Fri, 18 Apr 2014 21:09:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFF2B7D988;
	Fri, 18 Apr 2014 21:09:12 -0400 (EDT)
In-Reply-To: <5351b6219fce_3497cdf30c6e@nysa.notmuch> (Felipe Contreras's
	message of "Fri, 18 Apr 2014 18:32:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 382D7B36-C75F-11E3-B280-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246496>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > These patches add support for remote helpers --force, --dry-run, and reporting
>> > forced update.
>> >
>> > Changes since v8:
>> >
>> > --- a/transport-helper.c
>> > +++ b/transport-helper.c
>> > @@ -734,7 +734,7 @@ static int push_update_ref_status(struct strbuf *buf,
>> >         }
>> >  
>> >         (*ref)->status = status;
>> > -       (*ref)->forced_update = forced;
>> > +       (*ref)->forced_update |= forced;
>> >         (*ref)->remote_status = msg;
>> >         return !(status == REF_STATUS_OK);
>> >  }
>> 
>> Hmph, isn't v8 already in 'master' as of 90e6255a (Merge branch
>> 'fc/transport-helper-fixes', 2014-03-18)?
>
> I think I saw gitk report "Branches: remotes/origin/pu", but OK.

I don't get that "but" part, but as I said, if what you wanted to
apply has further updates relative to what we have, please send in
incremental.  The patches did not apply cleanly near the tip of
'master', so I didn't check what could be missing myself.

Thanks.
