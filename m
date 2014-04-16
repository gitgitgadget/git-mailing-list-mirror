From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [PATCH] git-rebase: Print name of rev when using shorthand
Date: Thu, 17 Apr 2014 08:22:46 +0900
Message-ID: <CAN7MxmWHPaxC0vzJxnJjcarpSh2SsdzhuTbt1rSiJhNS0U8K0Q@mail.gmail.com>
References: <1397419474-31999-1-git-send-email-modocache@gmail.com>
	<xmqqwqerogvr.fsf@gitster.dls.corp.google.com>
	<CAN7MxmUikP6pVAj3cpDiSbFxawScTh5zKusPUe8SpkNbH=e6Aw@mail.gmail.com>
	<xmqqk3api4yy.fsf@gitster.dls.corp.google.com>
	<xmqqa9blgkew.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 01:22:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaZAJ-0004R7-0w
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 01:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326AbaDPXWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 19:22:47 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56966 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbaDPXWq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 19:22:46 -0400
Received: by mail-ie0-f174.google.com with SMTP id rp18so11213514iec.33
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hlbkMlgUcFmNByuRQ5DUe5FF3I8cC27G74sKu2QOfcI=;
        b=FU5eq1qeyWNbld8AGN67EHRTvn+p2uW820jwlHMcQSdCaD/ZZiPYnodKKDIDeTY4Ld
         lf1WMHQ1vX2nfJB3ABkFdgNiO67zmnv5skq5GkYyDYr1EP9LdIXRZqMeS2KySsvNIuDh
         gYnHlPDi1JAb+vzErBpy33hzbfPRDLVfxQn76QijvfLQWqNJS9bBXIbVMYrzeA02DVWc
         53+l9jRyWc+z9J5DoErkuj1DV2nkPt3J8qdL9wZ1gJoHNkMjFZkVSF7h4dBEUYvoFRfz
         mL04NhqxH9I1emCW+5mkufwC+qa4P7KOqu2vnC6+LTnEEhR7KecpSRQMdvb20QDEGmEG
         oQ1w==
X-Received: by 10.42.4.201 with SMTP id 9mr4827430ict.57.1397690566166; Wed,
 16 Apr 2014 16:22:46 -0700 (PDT)
Received: by 10.64.55.161 with HTTP; Wed, 16 Apr 2014 16:22:46 -0700 (PDT)
In-Reply-To: <xmqqa9blgkew.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246392>

> The concept of "n-th prior checkout" (aka @{-n}) and "immediately
> previous checkout" (aka "-") are equivalent, even though the former
> may be more generic.
>
> You seem to be saying that those who understand the former are with
> superiour mental capacity in general than those who only know the
> latter, and they can always remember where they came from.
>
> ...have you considered _why_ it is a good thing to show the symbolic
> name in the first place?

I think I failed to express my point here; I don't think people that
use "@{-1}" have superior mental capacity, but rather simply that
they are aware of the "@{-n}" method of specifying a previous reference.
So in response to the command "git rebase @{-4}", displaying the
result "Fast-forwarded HEAD to @{-4}" does not contain any unknown
syntax that may confuse them. They may not remember what "@{-4}"
refers to, but they are aware of the syntax at least.

On the other hand, people who use the "-" shorthand may or may
not be aware of the "@{-n}" syntax. In that respect, I think it would
be confusing to display "Fast-forwarded HEAD to @{-1}" in response
to the command "git rebase -"; the user may not know what "@{-1}"
means!

Thus my original point was that I felt displaying a symbolic name in
response to "git rebase -" was more important than doing so in
response to "git rebase @{-1}". The issue isn't about forgetting what
"@{-n}" refers to, it's whether the user even knows what "@{-n}" is
supposed to mean.

But in light of your other comments:

>> Furthermore, were we to translate "@{-1}", does that mean we
>> should also translate "@{-2}" or prior?
>
> Surely, why not.  If a user is so forgetful to need help remembering
> where s/he was immediately before, wouldn't it be more helpful to
> give "here is where you were" reminder for older ones to allow them
> to double check they specified the right thing and spot possible
> mistakes?
>
> ...
>
> Giving the symbolic name 'master' is good because it is possible
> that the user thought the previous branch was 'frotz', forgetting
> that another branch was checked out tentatively in between, and the
> user ended up rebasing on top of a wrong branch.  Telling what that
> previous branch is is a way to help user spot such a potential
> mistake.  So I am all for making "rebase -" report what concrete
> branch the branch was replayed on top of, and consider it an incomplete
> improvement if "rebase @{-1}" (or "rebase @{-2}") did not get the
> same help---especially when I know that the underlying mechanism you
> would use to translate @{-1} back to the concrete branch name is the
> same for both cases anyway.

I had not originally thought of this, perhaps because I was preoccupied
with preventing users from seeing syntax they might not be aware of.
But I definitely agree that displaying symbolic names for all "@{-n}"
is a good way to prevent user error.

> I can buy "that would be a lot more work, and I do not want to do it
> (or I do not think I can solve it in a more general way)", though.

Perish the thought! :)

I will try to re-roll this patch to include symbolic names for "@{-n}".

As usual, thanks for the feedback!

- Brian Gesiak
