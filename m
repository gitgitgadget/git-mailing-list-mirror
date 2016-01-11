From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 09:26:53 -0800
Message-ID: <xmqqlh7wxc0y.fsf@gitster.mtv.corp.google.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
	<1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
	<CACsJy8Bs3z0Gk3CjhyZGfOLA7R3pZQz7K5gk4BTytvYkZeyBtQ@mail.gmail.com>
	<20160111111015.GA10612@hank>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:27:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIgFB-0000d8-7W
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760890AbcAKR05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:26:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760053AbcAKR04 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:26:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7669038E19;
	Mon, 11 Jan 2016 12:26:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HzOE+lwTUjvv0dyoz/V76LzBBv8=; b=T4oKMR
	kfLh5zRU0TgvxMi+M6qqoGO9VnQ/FHHB2FaVwXkp9Ivt28VXRbwA61WAdvMwsjOY
	gDRlpFEDBOK7N1EOSyEsH0kgf8nMDEwe7/n3dJPcif04mesxdrmuLNo72Lz8isUN
	FsMt+5zXWJfEgU8ih9sJpFInaZ8+2rcOykOnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T9Q6owiRMoSTRm4Oft8aNQOSWysZIDbl
	wsdhm77X0jAXNlBIEBwrZjFoXCui3C6+pUnAiabW5gRemgHeZ0txj28Y50JeLwNS
	x0V7WCEo3cy7eBKtMJ2ZgWkG6xQMLgV4YS5XNavg3/v0/+iCOewl8tyl5CK4mZVd
	jBgpjfsN0nk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E0E238E18;
	Mon, 11 Jan 2016 12:26:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DB29838E16;
	Mon, 11 Jan 2016 12:26:54 -0500 (EST)
In-Reply-To: <20160111111015.GA10612@hank> (Thomas Gummerer's message of "Mon,
	11 Jan 2016 12:10:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 827F0F26-B888-11E5-A519-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283678>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 01/11, Duy Nguyen wrote:
>> On Sun, Jan 10, 2016 at 9:19 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> > Currently when git grep is used outside of a git repository without the
>> > --no-index option git simply dies.  For convenience, implicitly make git
>> > grep behave like git grep --no-index when it is called outside of a git
>> > repository.
>>
>> Should we have a line about this behavior in git-grep.txt, maybe the
>> description section?
>
> Yes good point, the behavior change should definitely be documented.
>
>> I wonder if anybody wants the old behavior (e.g.
>> non-zero exit code when running outside a repo). If there is such a
>> case (*), we may need an option to revert it back (--no-no-index seems
>> ridiculous, maybe --use-index). The safest way though, is introduce a
>> new option like --use-index=<always|optional|never> then you can make
>> an grep alias with --use-index=optional.
>
> You're right.  I couldn't think of a reason why someone would rely on
> the old behavior, but maybe I missed something.  I like the idea of
> introducing the --use-index=... option.

I don't like that, though ;-)

"We run 'git grep' in random places and relied on it to fail when
run in somewhere not under control of Git." feels so flawed at
multiple levels that I doubt it deserves to be kept working.  For
one thing, "git grep" is not the way to tell something is under
control of Git (rev-parse would be a better thing for scriptor to
use).  For another, how would such a script tell between "not a
git repository" and there was no hits?

So I do agree that automatic fallback needs to be documented and
advertised as a feature (or even a bugfix), I do not think we want
to add knobs to keep such a broken script working.

> How should we handle priority between --no-index and --use-index,
> should we just give --no-index priority if it is set and ignore the
> new --use-index option, or is there some other way?
>
>> (*) I've been hitting really weird real-world use cases so I'm a bit paranoid..
>> --
>> Duy
