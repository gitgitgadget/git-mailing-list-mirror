From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/5] submodule--helper clone: lose the extra prefix option
Date: Fri, 25 Mar 2016 16:15:13 -0700
Message-ID: <xmqqegay175q.fsf@gitster.mtv.corp.google.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
	<1458931156-29125-6-git-send-email-sbeller@google.com>
	<xmqqfuve2vln.fsf@gitster.mtv.corp.google.com>
	<xmqq60wa2s7w.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZotAZeKJxRsHczMp5BG7edu=GLj6mox08M6afkMu1UDg@mail.gmail.com>
	<xmqqmvpm18sw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbbVN4kQyQoTk+3o5yPZPAdGULtOhKisOLUf9-u7ssh7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 00:15:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajawx-0004f3-Eh
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 00:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbcCYXPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 19:15:18 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751127AbcCYXPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 19:15:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0AD6F5040B;
	Fri, 25 Mar 2016 19:15:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XaFmpBSWTJBl4uyx/BhagqhHWH4=; b=Xb/x/t
	ZEpz+yDyRSjDeMGPId/GL6ghEMrMwqZi7/P/CkgR3tDIIez4kGAmYgUBTFm05HjP
	b4y89TY6pK6hJGG6KzUhem2gEhxSx0Oss8fY9OX0XnZj9BOCdhcNYKS2IB+XHLNI
	tD1HiS8N0nKbYp2raqTeAUg96W8IOaxHFt5RU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xodtEbFMb2deDK+1rloVvZ9ulzAWtrjs
	deoKiVoPmW2MjOHNbYkEIhoq/FQPonW9k5IIPocv6SJ1dKm4mCZJlVoTFJyR8AGb
	UZ6YOnmyRbmz2bXX1Z7EihFh34dESRbpdh8qh5HrlnW5dpP8c2HydN4wHKxpThDv
	9WB+vghRj8I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 002075040A;
	Fri, 25 Mar 2016 19:15:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6582450409;
	Fri, 25 Mar 2016 19:15:14 -0400 (EDT)
In-Reply-To: <CAGZ79kbbVN4kQyQoTk+3o5yPZPAdGULtOhKisOLUf9-u7ssh7A@mail.gmail.com>
	(Stefan Beller's message of "Fri, 25 Mar 2016 16:02:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E30D69E-F2DF-11E5-8CD9-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289966>

Stefan Beller <sbeller@google.com> writes:

>> Of course by using -C, you might notice that repo/sub/untracked does
>> not exist, but that is not a proper error checking---what if the
>> submodule at repo/sub does have a directory with that name?  IOW,
>> the computation that gave repo/sub/untracked instead of ../untracked
>> is wrong and using -C would not make it right.
>
> There is no explicit computation of repo/sub/untracked, but it would happen
> implicitely in the -C case as we'd be in the repo/sub and try to chdir
> to 'untracked'
> (interpreted as a relative path)

You are looking at repo/sub/untracked that does not have anything to
do with the reality, and it does not matter if you have an explicit
code to construct "char *" that points at such a pathname, or it
happens implicitly.  Looking for 'untracked' directory after going
inside 'repo/sub/untracked' is simply wrong, just like looking for
'sub/untracked' diretory while staying at 'repo/' is wrong.

If anything, ../tracked might have some relevance to the reality but
nobody is computing it, which may be a bug in "git submodule" if
<cmd> wants to have an access to the original place.

In either case, that is true with either -C/--prefix, no?

>> And if you clear the prefix you originally obtained in calling
>> script "git submodule", which is "untracked/", even if <cmd> somehow
>> wanted to refer to the "file" in that directory, the only clue to do
>> so is forever lost.  Again, this is unrelated to -C/--prefix, but
>> that is what the patch 2 in the original series (which was rolled
>> into patch 1 in the update) was about.
>
> As of now this file would also be lost I would assume, as it is unclear
> which repository you refer to.
>
> If you are in the "subsub" submodule and know that the $wt_prefix=untracked,
> you still don't know if the original command was invoked from the root super
> project or the intermediate submodule.

I am talking about a case where

        cd repo
        cd untracked
	git submodule <cmd> --recurse-submodules --read-from=file

wants to run <cmd>, using information stored in repo/untracked/file,
and work on submodules repo/sub and repo/sub/subsub.  The reference
to the original location somehow needs to be carried through if we
wanted to allow this kind of thing.

>> So I am not sure what the value of using -C is.  At least that
>> "example from before" does not serve as a good justification.

And I do not think your reply does not change anything with respect
to this statement.
