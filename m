From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] submodule deinit: require '--all' instead of '.' for all submodules
Date: Thu, 05 May 2016 10:59:11 -0700
Message-ID: <xmqqr3dgbd3k.fsf@gitster.mtv.corp.google.com>
References: <1462401603-2067-1-git-send-email-sbeller@google.com>
	<20160504232642.GC395@google.com>
	<CAGZ79kbeCCcmGh57zUdQ=BzFOWUiwj8-3nM4dbK9yONbrmLaPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 05 19:59:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayNYe-0000sP-DL
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 19:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001AbcEER7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 13:59:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754558AbcEER7P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 13:59:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF72418692;
	Thu,  5 May 2016 13:59:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UNjNkvo2deRvnCCvbu/a2Hedu/k=; b=BuHY3w
	4YoTI4ymi85/zqxr/Eaxke7LLiw2MiQk2wDRDYDjWQklPh7bqd89947rBsJtjKcB
	1qclwkEDHIVw7ZLpUIlf0opJY+nhzg1HhLHDm32E51STHHOhEzrkAcEeCWkMJB8p
	LFYMOotC2IO2H2Dp04pWEu7elCI7v0YTGKwrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=brSO6RkcA09gwel2Uzzcuv58C1WYsxxn
	GG/E4J2LyebkKakGhBB7JCzVAo4mxt3T3aqayNyeuFGFDewF/3r64wtGUVjdwwkR
	2Oasqrdsxu+C5OUpY1BUQyv2p0ohBjGdfEx0PHvyTFzw4zkuFSDRTCEQ/iz5pzUC
	3umtUl1gC3o=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7F451868F;
	Thu,  5 May 2016 13:59:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BC511868C;
	Thu,  5 May 2016 13:59:13 -0400 (EDT)
In-Reply-To: <CAGZ79kbeCCcmGh57zUdQ=BzFOWUiwj8-3nM4dbK9yONbrmLaPw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 4 May 2016 16:38:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13593C94-12EB-11E6-B550-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293657>

Stefan Beller <sbeller@google.com> writes:

>>> +When the command is run without pathspec, it errors out,
>>> +instead of deinit-ing everything, to prevent mistakes. In
>>> +version 2.8 and before the command gave a suggestion to use
>>> +'.' to unregister all submodules when it was invoked without
>>> +any argument, but this suggestion did not work and gave a
>>> +wrong message if you followed it in pathological cases and is
>>> +no longer recommended.
>>
>> Why tell the user what happened in 2.8 and earlier?  It's not clear what
>> the reader would do with that information.
>
> Because people may wonder what happened to '.' ?

I am to blame on that final text, but I think Jonathan is right.
"In version 2.8 and earlier..." can just go.  Users may need to 
understand why no-arg form is not a silent no-op but an error,
and they need to know how to de-init everything with the version
of Git they have (i.e. with "--all").  Compared to these two,
"Your fingers may have been trained to say '.', but it was found
not to work in pathological cases" is of much lessor importance,
especially because with or without this patch, the definition of
"pathological" cases does not change.

>> I think this paragraph could be removed.  --all is explained lower
>> down and the error message points it out to users who need it.
>
> When we want to keep supporting '.' forever, I would remove this section.

I am not sure what you mean by "keep supporting '.'".  If your
repository has any tracked path, "deinit ." would deinit all
submodules, with or without this change.

Are you worried about the future change you are planning to that
involves reverting 84ba959b (submodule: fix regression for deinit
without submodules, 2016-03-22), after which a pathspec that does
not match any submodule would become a "possible typo" error?

It is true that '.' would error out if there is no submodule in the
repository, as opposed to erroring out only when there is no tracked
path, which is what you get with today's version (and the version
with this fix in the patch under discussion).  But '.' is not
special with respect to that change.  'README' would also error out
if there is no submodule whose path matches that pathspec in that
future version, as opposed to erroring out only if 'README' is not
tracked at all in today's version.

Or are you thinking that it may be better to give '.' a special
meaning, iow, not treating it as just a regular pathspec?  Perhaps
make '.' to mean "everything but it is not an error if there is none
to begin with"?  I fear that going in that direction would deform
the mental model the users would form from seeing how commands
behave when given a pathspec.  The "." would still look like any
other pathspec elements, and I am sure you will not special case "."
in the usage string but will claim that it is covered by the mention
of <pathspec> at the end of the command line in the usage string,
so you are making them expect that "." used as a pathspec would
behave like that for all other places that we take pathspec, when
in reality, only "submodule deinit" make it behave differently.

Which I do not think is particularly a good idea.

>> Not about this patch: the organization of options is a little strange.
>> A separate section with options for each subcommand would be easier to
>> read.
>
> I agree.

I agree.

>> Do we want to claim the short-and-sweet option -a?  (I don't mind but it
>> doesn't seem necessary.)
>
> We do.

I don't, but I do not care too deeaply.


>>> @@ -257,8 +270,8 @@ OPTIONS
>>>  --force::
>>>       This option is only valid for add, deinit and update commands.
>>>       When running add, allow adding an otherwise ignored submodule path.
>>> -     When running deinit the submodule work trees will be removed even if
>>> -     they contain local changes.
>>> +     When running deinit the submodule working trees will be removed even
>>> +     if they contain local changes.
>>
>> Unrelated change?
>
> It's close enough for deinit to squash it in here, no?

More importantly, the patch adds a new instance of "working tree" to
the documentation elsewhere; fixing this existing instance of "work
tree" is relevant from consistency's point of view.

>>> @@ -544,9 +548,13 @@ cmd_deinit()
>>>               shift
>>>       done
>>>
>>> -     if test $# = 0
>>> +     if test -n "$deinit_all" && test "$#" -ne 0
>>> +     then
>>> +             die "$(eval_gettext "--all and pathspec are incompatible")"
>>
>> This message still feels too low-level to me, but I might be swimming
>> uphill here.
>>
>> Another option would be to call 'usage' and be done.
>
> I had that idea as well, but I think pointing out the low level is better
> than giving the high level again, so the user immediately sees what's wrong.

I do not particularly see the message low-level.  Jonathan, what do
you have against pointing out the exact problem?  After seeing the
usage string that also talks about --quite, --force, etc., I have to
somehow realize that these are irrelevant noises that have nothing
to do with the error, and puzzle out that the (choose|from|here) is
telling me that I cannot give pathspec when I am giving --all
myself.

> Once we change how '.' is handled we can do that?

Again, I am worried about "Once we change how ...".
