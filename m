Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09765C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 20:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56E060F6F
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 20:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhJVUrv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 22 Oct 2021 16:47:51 -0400
Received: from elephants.elehost.com ([216.66.27.132]:63936 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhJVUru (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 16:47:50 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19MKjI40064516
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Oct 2021 16:45:18 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Kalyan Sriram'" <kalyan@coderkalyan.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com> <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net> <xmqqbl3ihu6l.fsf@gitster.g> <016801d7c74b$64bb9a90$2e32cfb0$@nexbridge.com> <0101017ca921a6a0-96383fe2-4d73-47cb-83f7-4152b2c6ed7e-000000@us-west-2.amazonses.com>
In-Reply-To: <0101017ca921a6a0-96383fe2-4d73-47cb-83f7-4152b2c6ed7e-000000@us-west-2.amazonses.com>
Subject: RE: Git submodule remove
Date:   Fri, 22 Oct 2021 16:45:12 -0400
Message-ID: <01a201d7c785$b9261ee0$2b725ca0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHQ2mH4tSFhsklRMMoBOV3P9H2RGwH+CCNTAU73O8ECVuyztAFAuplKq7YwL0A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 22, 2021 1:52 PM, Kalyan Sriram wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>; 'Junio C Hamano' <gitster@pobox.com>; 'brian m. carlson'
><sandals@crustytoothpaste.net>
>Cc: git@vger.kernel.org
>Subject: RE: Git submodule remove
>
>On Fri Oct 22, 2021 at 6:47 AM PDT, Randall S. Becker wrote:
>> On October 21, 2021 6:47 PM, Junio C Hamano wrote:
>> >To: brian m. carlson <sandals@crustytoothpaste.net>
>> >Cc: Kalyan Sriram <kalyan@coderkalyan.com>; git@vger.kernel.org
>> >Subject: Re: Git submodule remove
>> >
>> >"brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> >
>> >> On 2021-10-21 at 17:25:38, Kalyan Sriram wrote:
>> >>> Hello,
>> >>>
>> >>> I was curious why git-submodule does not have an `rm` command.
>> >>> Currently I have to manually delete it from .gitmodules,
>> >>> .git/config, .git/modules/, etc. See [0].
>> >>>
>> >>> I'd like to contribute my first patch to this project by adding
>> >>> this feature, but wanted to check first with the community if
>> >>> there's any particular reason it was chosen not to not be
>> >>> implemented, or if it's simply that nobody has gotten around to it
>> >>> - it seems to be a relatively common feature someone might want.
>> >>>
>> >>> Anyway, please let me know if this is something that would be
>> >>> accepted, or if anyone has any comments or suggestions.
>> >>
>> >> I think the reason it hasn't been implemented is that nobody's
>> >> gotten around to it yet.  I certainly would find this useful and
>> >> have wanted the same thing myself, so I can't see a reason why the
>> >> right series wouldn't be accepted.
>> >
>> >I tend to agree that nobody felt the need strongly enough.  Code
>> >tends to accumulate without ever getting removed, and removal of a
>> file,
>> >removal of a directory, or removal of a submodule is a much rarer event compared to other changes people would need to make.
>> >Adding such a feature would have been much more work for those who
>> >faced such a rare occasion to want to use it than just doing it
>> by
>> >hand and committing the result.
>> >
>> >I'd imagine that the happy-case implementation should be fairly straight-forward.  You would:
>> >
>> > - ensure that the submodule is "absorbed" already;
>> >
>> > - run "git rm -f" the submodule to remove the gitlink from the index
>> >   and remove the directory from the working tree; and
>> >
>> > - remove the .gitmodules entry for the submodule.
>> >
>> >and you'd leave the final "record the state of the index as a commit"
>> >to the user, simply because the user would want to have other changes
>> >related to the removal of the submodule in the same commit (like changes to files in the superproject that refer to the submodule
>contents or removal of other submodules).
>> >
>> >The hard part is unhappy-cases.  There are too many things that can
>> >go wrong and you need to handle all the error cases correctly
>> so that
>> >you do not leave the user's repository in an uncontrollably messy state.
>>
>> Just my rambling:
>>
>> The really unhappy place is when a user deletes the upstream submodule
>> repo itself after not seeing it in main any longer during some cleanup
>> adventure, then someone else tries to check out an older commit that
>> references the submodule.
>IMO this seems like a pretty unlikely situation to be in, which doesn't warrant *not* adding this feature. I get the idea, but how commonly
>do people checkout old commits and play around with them? In any case, this seems to be the project maintainer's problem, not git's.
>> This particular unhappy
>> place seems a whole lot like 'git branch -d' vs '-D', where it might
>> be good not to allow the submodule rm if it is referenced in a commit
>> (insert acceptable criteria for not forcing it here, which probably
>> doesn't exist).
>But wouldn't a submodule always be referenced in a commit? The first thing anyone does after adding a submodule, after all, is to
>commit it into the repository. Later on, you may decide you don't need that submodule dependency anymore...
>> A prune-like operation, as with workspace prune might be a little
>> safer - but not much.
>Sorry, I'm having a hard time understanding. What would this look like, and how it would be safer?

Given that git is distributed, probably not safer at all (see other responses in the thread). I really don't like the submodule rm concept in the slightest although I appreciate the necessity, but you really really have to want it. A prune operation might be better if a criteria could be specified to define when removing the submodule might be acceptable, at least locally. Suppose:

git submodule prune --branch=main --after=commitish

which could allow the prune if the submodule was not referenced on the main branches before a certain point in history. I don't like it, but it might be an idea worth thinking about.

-Randall

