From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Tue, 1 Dec 2015 13:15:36 +0100
Message-ID: <CACsJy8CFCu4casNn25b1YPkV==-8kDy3wzYd5uf794R41M0Y9w@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net> <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
 <xmqqio4j8iit.fsf@gitster.mtv.corp.google.com> <CAGZ79kYY5FbvMpa2vOun7-h4S2cJvZLn67uPGYVbje55R4dFSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 13:16:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3jqw-0001SD-EU
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 13:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbbLAMQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 07:16:10 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33637 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006AbbLAMQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 07:16:08 -0500
Received: by lfaz4 with SMTP id z4so5566857lfa.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 04:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Qxd4TU1wrPmd5YnhXjyYaEfKKMSi4AhH/XX845edJQ4=;
        b=oVYjXa66d9h4awy+WofPFJaYXTuW0fy/Ztjp0hygX4iTmQF2PGOU5Wfom9zVU3fsQP
         NQ0eIxpLjUE0fdXiXXfYJV3KiSqw8OgaV6FNt1mxfU80B/CHXdSQR0QwV1v5tzq+FNv2
         L8pMksKsTDZqmiOEArokcLGeISQIPytgvcdpBIOFohkPGGJJk/51Xq/xQOv5IyBq3/XE
         ZoyOgdnLcIvzhIqTpp2u+ZQLpnwZjXAYpxheL5NP+coJnMycqGNPh49+Bf4fzfsTQp63
         qe1E7grTysUPV+vestv3xtieIH9cWAEPMPH0bMayLfqRolwnsciYo5CuODt+bK/vhFh4
         QrzA==
X-Received: by 10.25.170.149 with SMTP id t143mr28827718lfe.162.1448972166690;
 Tue, 01 Dec 2015 04:16:06 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Tue, 1 Dec 2015 04:15:36 -0800 (PST)
In-Reply-To: <CAGZ79kYY5FbvMpa2vOun7-h4S2cJvZLn67uPGYVbje55R4dFSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281838>

On Tue, Dec 1, 2015 at 1:47 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Nov 30, 2015 at 10:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> +cc Junio, Duy
>>>
>>> So cloning from an arbitrary SHA1 is not a new thing I just came up with,
>>> but has been discussed before[1].
>>>
>>> Junio wrote on Oct 09, 2014:
>>>> This is so non-standard a thing to do that I doubt it is worth
>>>> supporting with "git clone".  "git clone --branch", which is about
>>> "> I want to follow that particular branch", would not mesh well with
>>>> "I want to see the history that leads to this exact commit", either.
>>>> You would not know which branch(es) is that exact commit is on in
>>>> the first place.
>>>
>>> I disagree with this. This is the *exact* thing you actually want to do when
>>> dealing with submodules.
>>
>> Yup, I know, but I do not think the above disagrees with you (read
>> again ;-).  It merely says "--branch" option to "clone" is not a
>> good place to add a new "clone at this single commit" mode of
>> operation.
>
> Ok. So maybe a bit of bike shedding time:
>
> How does
>
>     git clone --detached-head <sha1>

maybe

git clone --commit-id <sha1> repo (*)

instead. Detached head is implied, and this way you don't have to
disambiguate sha-1 vs refname. And --commit-id can also be added in
git-fetch. Actually the git-fetch case is even more interesting, what
do we do with refspec..

(*) as usual, we accept committish sha-1, not just comit sha-1, so
--commit-id may be confusing..? Or maybe just go with --tag where we
accept either tag names, tag sha-1 or commit-sha1

> sound? I would imagine that this would either present you with a fresh clone
> with a detached head at the specified sha1, or if the server doesn't support
> getting a specific sha1, it would error out.
-- 
Duy
