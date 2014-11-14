From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Fri, 14 Nov 2014 11:27:01 -0800
Message-ID: <xmqqwq6x37ne.fsf@gitster.dls.corp.google.com>
References: <20141107081324.GA19845@peff.net>
	<xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
	<20141107191745.GB5695@peff.net>
	<CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
	<CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
	<CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
	<20141108083040.GA15833@peff.net>
	<xmqqbnoge1ci.fsf@gitster.dls.corp.google.com>
	<20141114054440.GA54304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 20:27:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpMWa-0000Zi-BZ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 20:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965842AbaKNT1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 14:27:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965598AbaKNT1L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 14:27:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48B1F1D537;
	Fri, 14 Nov 2014 14:27:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dfwcJq5PSpvCuncovpIPxeoRmQk=; b=NcN4CB
	K1Z6r66nWlXUPdD9YtS3gC4uaNkjVgYgQSoS+HjIGMbvUnD6qRk4LtPQdOhjPbar
	gq6QMGQ0wV7quY+gdKyJDVgeJaCl9iGT8J6zPKBwTGBt7oPrRnb40MTR6bE3c+z/
	JbAQ+snQuZzIRtWw6dHca+ypTtO7dPzxYp10A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FsJvvVyX7fKgqgi5nF1tIK+ZRjbA4+ko
	Dwwh78YcrR2ea4Y80edxC7G6xpO+FQIAErnp7NkK+1Yjz5ml9wuGwnXFqi3WjiAw
	K9gukiqGb/H9aGcHHFd1h7UBtCeiyrgmhPOlnXidAfXcFhHY378PYyCaJYqPW4C5
	aSzctm0WvTA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D8A11D536;
	Fri, 14 Nov 2014 14:27:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31A241D533;
	Fri, 14 Nov 2014 14:27:02 -0500 (EST)
In-Reply-To: <20141114054440.GA54304@gmail.com> (David Aguilar's message of
	"Thu, 13 Nov 2014 21:44:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 35A663B2-6C34-11E4-9023-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> On Sun, Nov 09, 2014 at 09:21:49AM -0800, Junio C Hamano wrote:
>> 
>> It might be less risky if the updated semantics were to make the
>> paths that are originally in the index but not in $tree untracked
>> (as opposed to "reset --hard" emulation where they will be lost)
>> unless they need to be removed to make room for D/F conflict issues,
>> but I haven't thought it through.
>
> Git has always been really careful to not lose data.
>
> One way to avoid the problem of changing existing semantics is
> to make the new semantics accessible behind a flag, e.g.
> "git checkout --hard HEAD -- some-new-path".

Yup, but you seem to be behind by a few exchanges, as we tentatively
decided that we won't talk about changing the semantics and concentrate
on fixing the implementation glitches only at least for now ;-)

I find that "--hard" is not a very good name for the new mode.
There will be different kinds of "more than what we usually do"
modes of operations discovered over time in the coming years, and it
is better to be more specific to denote "in what way we are doing it
harder" (I think the difference the proposed new mode has is to also
checkout absense of the paths).

But in this particular case, making the paths that are absent in $tree
we are checking out of into untracked paths (instead of removing) is
a right balance of safety---it is similar to "git reset HEAD" (no
"--hard") after adding a new path which leaves the file in the
working tree.
