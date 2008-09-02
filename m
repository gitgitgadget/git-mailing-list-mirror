From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fast-import: add ignore non-existent files option.
Date: Tue, 2 Sep 2008 10:57:51 +0300
Message-ID: <94a0d4530809020057w3bffd130xdfdcdfb622698d65@mail.gmail.com>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com>
	 <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
	 <7v63pftqmk.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530809011625n772fdc58h3ce1c04e79fb116f@mail.gmail.com>
	 <7vk5dvs3k8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 09:59:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaQmx-00076K-Fj
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbYIBH5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 03:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbYIBH5y
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 03:57:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:39210 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbYIBH5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 03:57:53 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2144573rvb.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VyqLjpcwZG0Klt3KpvPiYNN5OafjZh7y7iEn9eGuGTw=;
        b=rY3gVWrf7g4kCmJJaUIhU4oN8IZZIYVoEuGtQvL3E2sVaizariWgQAS2OswZ2muV+U
         QjgLqqL1X/XNiUA5v/nh9t0+CGKxdiXVP9UfmxovnNxiscW602Y6lNDBeOKu844hD4GB
         i3jDD4hS2/cZ+3iPrbJELRTWzM2zKDFh0MVGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iMPi8op0IUpKGAxGQed6e+J9wkYU102q1JNW99BOkFSfdMuu8dwXyaOHob89/QRCAH
         Wq2/h2kq6w1OrVATZN0aXyUFqtvj8tB1oD/UWF4vrjV81ZPYQtjrhWHl3p9zvTyk/eFK
         ls+fX3wgE5SFv7dO10Dx8Kb6nxse9eyXqJyXI=
Received: by 10.140.164.1 with SMTP id m1mr3980497rve.69.1220342272071;
        Tue, 02 Sep 2008 00:57:52 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Tue, 2 Sep 2008 00:57:51 -0700 (PDT)
In-Reply-To: <7vk5dvs3k8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94664>

On Tue, Sep 2, 2008 at 5:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Felipe Contreras" <felipe.contreras@gmail.com> writes:
>
>> On Tue, Sep 2, 2008 at 2:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> This is useful for SCMs that don't have proper changesets in each
>>>> revision (monotone).
>>>
>>> I am still not convinced this is a proper workaround for the issue.  Why
>>> shouldn't the feeder of fast-import be able to do this?
>>
>> If I could get a list of the files that changed on each revision from
>> monotone I would, but that's not possible (I've asked in their mailing
>> list). Apparently there's a way to feed the right data, but it's
>> complicated.
>
> Ok, I did not realize that you are not keeping track of what the parents'
> trees look like when processing a merge commit.
>
> But it raises a bigger question.  You earlier said:
>
>    In monotone you can have something like:
>
>     A
>    / \
>    B D
>    | |
>    C E
>    \ /
>     F
>
>    If you do a 'delete foo' in B, and a 'delete bar' in F, you will get
>    this stored in the merge revision (F):
>
>    old_revision [C]
>    delete "foo"
>    delete "bar"
>
>    old_revision [E]
>    delete "bar"
>
>    All the changes of the merged branches are stored again in the merge revision.
>
> Now, does it talk about C and E because they are immediate parents of B
> and D, or because they are immediate child of the common ancestor F?  I am
> guessing it is the latter (what I mean is if it still talks aobut C and E
> if you had more intermediate commits between B and C).  What the merge at
> A records is not relative to B/D but relative to immediate child of the
> fork point.

Er, no it's the other way around. A is the original child, F is the
merge. I thought it was evident because of the alphabetical ordering.

> If that is the case, ignoring a delete that deletes already deleted path
> is fine; I think it is the least of your problem.  The above description
> makes me wonder what they say about modification.  Do they talk about the
> same modification that happened between B and C when talking about A?  If
> that is the case, it would be a far larger problem.  You cannot just say
> "ignore any modification recorded in a merge, because they have been
> already done on the branches being merged (i.e. up to B and up to D)", as
> A may have to be an evil merge.
>
> I have to wonder if you can "mark" the tree object of C, and when you
> process merge A, represent A's tree by starting from that marked tree,
> applying only the description to bring the state of "old_revision [C]"
> to that of A (delete "foo" and delete "bar" in your illustration), and
> recording that tree with parents B and D.

I'm not sure I understand correctly, but anyway, how would you propose
to "mark" the tree objects?

>>>> @@ -1993,8 +1994,15 @@ static void file_change_cr(struct branch *b, int rename)
>>>> ...
>>>
>>> Also what happened to the missing warning() for 'D'elete codepath?
>>
>> I'm not interested in it.
>
> If I were asking for an unrelated "feature" when you are developing some
> other feature, it would have been different, but I do not think that is a
> good answer in this particular case.
>
> Your --tolerant (or --ignore-errors) is about customizing strictness of
> the error handling, and you know of a case where the error handling is not
> strict enough in the existing code.  In other words, your "not interested"
> is _not_ saying "It is an unrelated feature that I am not interested in";
> it is saying "I am not interested in making my patch self consistent; a
> half-baked hack that happens to solve my case is good enough for me."

Hmm, ok.

-- 
Felipe Contreras
