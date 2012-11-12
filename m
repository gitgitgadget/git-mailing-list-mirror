From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Mon, 12 Nov 2012 21:46:38 +0100
Message-ID: <CAMP44s0HnJvgJc=hKyJ+Jcz4oiN1QS--wPSN_3UsfVM4EWMubg@mail.gmail.com>
References: <5093DC0C.5000603@drmicha.warpmail.net>
	<20121108200919.GP15560@sigill.intra.peff.net>
	<509CCCBC.8010102@drmicha.warpmail.net>
	<CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
	<509E8EB2.7040509@drmicha.warpmail.net>
	<CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
	<509EAA45.8020005@gmail.com>
	<CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
	<509FD9BC.7050204@gmail.com>
	<7vwqxqiul3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitzilla@gmail.com, Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:46:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY0uD-0004gI-EG
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab2KLUqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:46:40 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52274 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab2KLUqj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:46:39 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so6692199obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 12:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QzTjVhg2KIUTKhGc/tLYAtSr9mPajcNujty4ufcKsro=;
        b=LT5WjokJwATis7tYADLnw91mO4j652AhUykNbekH1Phltdi7gKp9lFaw/zTHVWMAlt
         3jX2ItvLWilu4ESGepQESRm2U/xp2ffIS9l86Whv/27H0onT2z6sK2GuI2olgbTwjHWy
         IIpY4otvfiJYVbMiaCgNUf4d1JmdEY/3muC/mbRnhoihzRHwv8pFIclbFplQhqazG4oZ
         5MtHFyY8l7lhOemDfg+asKAeb3iM4TTR3+A1CVfAcuPwxPh1IiikowMrI2LxmRen54d6
         w2pFkXSGduQtPXHVKyAboGTJh2IzLdkeF2JCkzIArtEZsVdYKJOUBLitWjGwxwcsPuiB
         tErA==
Received: by 10.182.194.70 with SMTP id hu6mr16407953obc.4.1352753198586; Mon,
 12 Nov 2012 12:46:38 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 12:46:38 -0800 (PST)
In-Reply-To: <7vwqxqiul3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209524>

On Mon, Nov 12, 2012 at 6:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
>
>> On 11/11/2012 07:41 AM, Felipe Contreras wrote:
>>> On Sat, Nov 10, 2012 at 8:25 PM, A Large Angry SCM<gitzilla@gmail.com>  wrote:
>>>> On 11/10/2012 01:43 PM, Felipe Contreras wrote:
>>>
>>>>> So, the options are:
>>>>>
>>>>> a) Leave the name conversion to the export tools, and when they miss
>>>>> some weird corner case, like 'Author<email', let the user face the
>>>>> consequences, perhaps after an hour of the process.
>>>>>
>>>>> We know there are sources of data that don't have git-formatted author
>>>>> names, so we know every tool out there must do this checking.
>>>>>
>>>>> In addition to that, let the export tool decide what to do when one of
>>>>> these bad names appear, which in many cases probably means do nothing,
>>>>> so the user would not even see that such a bad name was there, which
>>>>> might not be what they want.
>>>>>
>>>>> b) Do the name conversion in fast-import itself, perhaps optionally,
>>>>> so if a tool missed some weird corner case, the user does not have to
>>>>> face the consequences.
>>>>>
>>>>> The tool writers don't have to worry about this, so we would not have
>>>>> tools out there doing a half-assed job of this.
>>>>>
>>>>> And what happens when such bad names end up being consistent: warning,
>>>>> a scaffold mapping of bad names, etc.
>>>>>
>>>>>
>>>>> One is bad for the users, and the tools writers, only disadvantages,
>>>>> the other is good for the users and the tools writers, only
>>>>> advantages.
>>>>>
>>>>
>>>> c) Do the name conversion, and whatever other cleanup and manipulations
>>>> you're interesting in, in a filter between the exporter and git-fast-import.
>>>
>>> Such a filter would probably be quite complicated, and would decrease
>>> performance.
>>>
>>
>> Really?
>>
>> The fast import stream protocol is pretty simple. All the filter
>> really needs to do is pass through everything that isn't a 'commit'
>> command. And for the 'commit' command, it only needs to do something
>> with the 'author' and 'committer' lines; passing through everything
>> else.
>>
>> I agree that an additional filter _may_ decrease performance somewhat
>> if you are already CPU constrained. But I suspect that the effect
>> would be negligible compared to the all of the SHA-1 calculations.
>
> More importantly, which do users prefer: quickly produce an
> incorrect result, or spend some more time to get it right?

Why not both?

If I do 'git clone hg::http://selenic.com/hg' I expect it to work, no
matter what. Then, if I care about getting it right, like for example
if the project is moving to git, then check
.git/hg/origin/bad-authors, and fill them with the right ones.

Of course, the current remote helper framework doesn't have the option
to map authors, but it could be added. That would be better than
letting every remote helper tool to have a custom way of mapping
authors, and also custom configuration for them.

> Because the exporting tool has a lot more intimate knowledge about
> how the names are represented in the history of the original SCM,
> canonicalization of the names, if done at that point, would likely
> to give us more useful results, than a canonicalization done at the
> beginning of the importer, which lacks SCM specific details.  So in
> that sense, (a) is more preferrable than (b).

But it doesn't have more intimate knowledge. It has exactly the same
information as fast-import; nothing.

What intimate knowledge is a tool expected to get from this?

% hg commit -u 'Foo Bar<foo.bar@example.com> <none@none>' -m one
% hg --debug log
changeset:   0:5ef37a2c773f02d0e01f1ecdcc59149832d294e8
tag:         tip
phase:       draft
parent:      -1:0000000000000000000000000000000000000000
parent:      -1:0000000000000000000000000000000000000000
manifest:    0:c6d4cd25b9fc2f83b0dd51f4acbea9486fce54d7
user:        Foo Bar<foo.bar@example.com> <none@none>
date:        Sun Nov 11 18:33:00 2012 +0100
files+:      file
extra:       branch=default
description:
one

Some tools might, but if they did, then bad authors wouldn't be a problem.

> On the other hand, we would want consistency across the converted
> results no matter what SCM the history was originally in.  E.g. a
> name without email that came from CVS or SVN would consistently want
> to become "name <noname@noname>" or "name <name>" or whatever, and
> letting exporting tools responsible for the canonicalization will
> lead them to create their own garbage.  In that sense, (b) can be
> better than (a).

Or 'Unknown <unknown>' or '<none@none>' or '<>', or any of the forms
conversion tools have been doing for ages.

Cheers.

-- 
Felipe Contreras
