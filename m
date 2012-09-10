From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Mon, 10 Sep 2012 09:30:59 -0700
Message-ID: <7vwr01on5o.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-10-git-send-email-git@adamspiers.org>
 <CACsJy8A2-C9xSz2LXt9Ptjxhe++i2vcBSMY-cxJLWUiutajZUQ@mail.gmail.com>
 <20120910110928.GA12974@atlantic.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:31:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6tF-0001AL-JK
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab2IJQbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:31:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab2IJQbC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:31:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF0E482A6;
	Mon, 10 Sep 2012 12:31:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fek9RCXjLH0ek/oEyIHDQIMVI3E=; b=ycGeW1
	Dxl4CcgPrQx3Jc/ZLWWyGO213H1K5sMSY3VuWmXsyiSGdPfW5CzMcqq15Ae8rG0Q
	/KYgw57GCpX9/C8Q2Btd3CzblzRqX7eI4LEgXLdpeVQgJt9nqG8WEWD/IJewfK+o
	rMZbuWAOQvBTO0Sv6P1iqjOt6vvlvtSzWSgZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cu6y2Q2aChGzolTU/Xpp1DT4OhZKv2uL
	K3DgTR58YQkhh7XRs/dVGFP4a4EUpg3Yd4LUpA8ANuuMJLsehUm6bGdSeYXuIzrZ
	R3fPuh7Ri852QHPDwnuhjvxFKVfy9OLIaQwczeJvVR+eQy3JdgQxp8+Y5B7RuAKX
	DzEyFwfmNyc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABACD82A5;
	Mon, 10 Sep 2012 12:31:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0969B82A4; Mon, 10 Sep 2012
 12:31:00 -0400 (EDT)
In-Reply-To: <20120910110928.GA12974@atlantic.linksys.moosehall> (Adam
 Spiers's message of "Mon, 10 Sep 2012 12:09:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E84CB34C-FB64-11E1-9DFE-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205142>

Adam Spiers <git@adamspiers.org> writes:

Administrivia.  Please never deflect direct responses to you with
"Mail-Followup-To" header.  I told my mailer to "follow-up" so that I
could give you advice in response, while adding others in the
discussion to Cc so that they do not have to repeat what I said, but
your "Mail-follow-up-to" forced my advice to go to Nguyen, who does
not need one.

> On Tue, Sep 04, 2012 at 08:06:12PM +0700, Nguyen Thai Ngoc Duy wrote:
>> On Sun, Sep 2, 2012 at 7:12 AM, Adam Spiers <git@adamspiers.org> wrote:
>> > --- a/builtin/add.c
>> > +++ b/builtin/add.c
>> > @@ -273,7 +273,7 @@ static int add_files(struct dir_struct *dir, int flags)
>> >                 fprintf(stderr, _(ignore_error));
>> >                 for (i = 0; i < dir->ignored_nr; i++)
>> >                         fprintf(stderr, "%s\n", dir->ignored[i]->name);
>> > -               fprintf(stderr, _("Use -f if you really want to add them.\n"));
>> > +               fprintf(stderr, _("Use -f if you really want to add them, or git check-ignore to see\nwhy they're ignored.\n"));
>> >                 die(_("no files added"));
>> >         }
>> 
>> String too long (> 80 chars).
>
> You mean the line of code is too long, or the argument to _(), or
> both?

Both.

               fprintf(stderr, _("Use -f if you really want to add them, or\n"
				 "run git check-ignore to see\nwhy they're ignored.\n"));

But in this particular case, I tend to think the additional noise
does not add much value and something the user wouldn't want to see
over and over again (in other words, it belongs to "an advice").
