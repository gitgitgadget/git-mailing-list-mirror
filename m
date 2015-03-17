From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Tue, 17 Mar 2015 20:49:50 +0100
Message-ID: <CAP8UFD0Mn3SPimYU3fdF5pV1MDAHXhKUVSutfJKrXzPpaXM=bA@mail.gmail.com>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
	<1425934575-19581-1-git-send-email-me@ikke.info>
	<xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
	<20150310225509.GA5442@vps892.directvps.nl>
	<xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
	<20150311184512.GB5442@vps892.directvps.nl>
	<xmqqsidb5m2r.fsf@gitster.dls.corp.google.com>
	<20150316163306.GB11832@vps892.directvps.nl>
	<xmqqbnjsrcyz.fsf@gitster.dls.corp.google.com>
	<065AE7977A54488198B39564E3E174E6@PhilipOakley>
	<xmqqr3sops9f.fsf@gitster.dls.corp.google.com>
	<CAP8UFD12UX+3psD2=9_RsGv8JA2C8N54qAYGydYgr7n5ta7dzw@mail.gmail.com>
	<xmqqtwxjo4nf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>, Kevin Daudt <me@ikke.info>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 20:49:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXxUy-0005Nx-Kq
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 20:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbbCQTtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 15:49:52 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34825 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbbCQTtu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 15:49:50 -0400
Received: by ieclw3 with SMTP id lw3so20207056iec.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E9e0pqXy4wq68ZRnDqX+hTohXkysRUbw58J15YvE/OE=;
        b=TU5bxSLe4ipwhu1LD5KKrdu/4fvF/eslB6SGFfct+Et5FCCW63RPVvc7sFC0AWJ94K
         Aib1PBbBfmtGm7peSBnTpbU/JjjaT9w/iya9nK/RmqPEkfU/koEbUdjhWpMjZ+QsHEOG
         kEoTxXR9SCBFErihcmUEt+UraqMZNhNmgEu1uISe1SR+FvB7MHPiRzoLlKYscspr6DN7
         rXMp9+rfyj6CSfEs5OC/hSFf5L56/p1+zFaKLVYuvcVG34BZSQZkM9jRXvZ0OynbaKrP
         6jKoPZ+jy4jnFnoGHwqe865uFJbolIJ9gc5Nb5ruB9Hg3gV+Xw5krFNN1nHgAb1FvqDn
         SQ8g==
X-Received: by 10.42.79.15 with SMTP id p15mr91076312ick.54.1426621790207;
 Tue, 17 Mar 2015 12:49:50 -0700 (PDT)
Received: by 10.50.245.168 with HTTP; Tue, 17 Mar 2015 12:49:50 -0700 (PDT)
In-Reply-To: <xmqqtwxjo4nf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265657>

On Tue, Mar 17, 2015 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Mon, Mar 16, 2015 at 10:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> However, you can say "git bisect bad <rev>" (and "git bisect good
>>> <rev>" for that matter) on a rev that is unrelated to what the
>>> current bisection state is.  E.g. after you mark the child of 8 as
>>> "bad", the bisected graph would become
>>>
>>>    G...1---2---3---4---6---8---B
>>>
>>> and you would be offered to test somewhere in the middle, say, 4.
>>> But it is perfectly OK for you to respond with "git bisect bad 7",
>>> if you know 7 is bad.
>>>
>>> I _think_ the current code blindly overwrites the "bad" pointer,
>>> making the bisection state into this graph if you do so.
>>>
>>>    G...1---2---3---4
>>>                     \
>>>                      5---B
>>
>> Yes, we keep only one "bad" pointer.
>>
>>> This is very suboptimal.  The side branch 4-to-7 could be much
>>> longer than the original trunk 4-to-the-tip, in which case we would
>>> have made the suspect space _larger_, not smaller.
>>
>> Yes, but the user is supposed to not change the "bad" pointer for no
>> good reason.
>
> That is irrelevant, no?  Nobody is questioning that the user is
> supposed to judge if a commit is "good" or "bad" correctly.

So if there is already a bad commit and the user gives another
bad commit, that means that the user knows that it will replace the
existing bad commit with the new one and that it's done for this
purpose.

> And nobody sane is dreaming that "Git could do better and detect
> user's mistakes when the user says 'bad' for a commit that is
> actually 'good'"; if Git can do that, then it should be able to do
> the bisect without any user input (including "bisect run") at all
> ;-).
>
>>> We certainly should be able to take advantage of the fact that the
>>> current "bad" commit (i.e. the child of 8) and the newly given "bad"
>>> commit (i.e. 7) are both known to be bad and mark 4 as "bad" instead
>>> when that happens, instead of doing the suboptimal thing the code
>>> currently does.
>>
>> Yeah, we could do that, but we would have to allow it only if a
>> special option is passed on the command line, for example:
>> git bisect bad --alternate <commitish>
>
> I am not quite sure if I am correctly getting what you meant to say,
> but if you meant "only when --alternate is given, we should do the
> merge-base thing; we should keep losing the current 'bad' and
> replace it with the new one without the --alternate option", I would
> see that as an exercise of a bad taste.

What I wanted to say is that if we change "git bisect bad <commitish>",
so that now it means "add a new bad commit" instead of the previous
"replace the current bad commit, if any, with this one", then experienced
users might see that change as a regression in the user interface and
it might even break scripts.

That's why I suggested to use a new option to mean
"add a new bad commit", though --alternate might not be the best
name for this option.

> Because the merge-base thing is using both the current and the new
> one, such a use is not "alternate" in the first place.
>
> If the proposal were "with a new option, the user can say 'oh, I
> made a mistake earlier and said that a commit that is not bad as
> 'bad'.  Let me replace the commit currently marked as 'bad' with
> this one.", I would find it very sensible, actually.

What I find sensible is to not break the semantics of the current
interface.

> I can see that such an operation can be called "alternate", but
> "--fix" might be shorter-and-sweeter-and-to-the-point.
>
> In the "normal" case, the commit we offer the user to check (and
> respond with "git bisect bad" without any commit parameter) is
> always an ancestor of the current 'bad', so the merge-base with
> 'bad' and the commit that was just checked would always be the
> current commit.  Using the merge-base thing will be transparent to
> the end users in the normal case, and when the user has off-line
> knowledge that some other commit that is not an ancestor of the
> current 'bad' commit is bad, the merge-base thing will give a better
> behaviour than the current implementation that blindly replaces.

Yes, I agree that it could be an improvement to make it possible for the
user to specify another bad commit. I just think it should be done with
a new option if there is already a bad commit...

>> and/or we could make "git bisect bad" accept any number of bad
>> commitishs.

... or by allowing any number of bad commits after "git bisect bad".

> Yes, that is exactly what I meant.
>
> The way I understand the Philip's point is that the user may have
> a-priori knowledge that a breakage from the same cause appears in
> both tips of these branches.  In such a case, we can start bisection
> after marking the merge-base of two 'bad' commits, e.g. 4 in the
> illustration in the message you are responding to, instead of
> including 5, 6, and 8 in the suspect set.

Yeah, I agree that we can do better in this case.

> You need to be careful, though.  An obvious pitfall is what you
> should do when there is a criss-cross merge.

Yeah, it is not as simple as it might look like, neither for the interface
nor for the behavior.
