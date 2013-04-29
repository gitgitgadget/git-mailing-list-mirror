From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Premerging topics
Date: Mon, 29 Apr 2013 21:06:59 +0200
Message-ID: <CALWbr2wiYkHMSihh-X-ToO-j4fty-P5OHicHa8ZUoqBkLS5mow@mail.gmail.com>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	<CALWbr2x5HDU2t7hpSCkZnuKjTJ1KxYC0v50wsDPT0fm4LyvzWw@mail.gmail.com>
	<CALKQrgeGPo--cYoGZ30nSfASh4CPzqGXQojkG9Ve96NFr+LrjA@mail.gmail.com>
	<7vzjwofpht.fsf@alter.siamese.dyndns.org>
	<CALKQrgd8jZQ__rnAT3wbfx-Y6mg-vrTdam53nS2ya2c=yMcS6Q@mail.gmail.com>
	<7vppxkflhq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 21:07:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWtQ4-0002Ja-Rz
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 21:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759266Ab3D2THO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 15:07:14 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:63869 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759267Ab3D2THA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 15:07:00 -0400
Received: by mail-qa0-f51.google.com with SMTP id g10so1209092qah.17
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ulbxJbNL6gNmyVSiztESCxzRXfvDUBF+Uc2EyRvoPDM=;
        b=QgyuPyKAgoEArJSZDqNBw04qEOicNPbrc8P1DujK/RSDjtKzy+F/C9VMUKeMkxIJFu
         4Ep2/DdnyO0L2mvjpFRwNVWrE0uqEjhVVJVBCywMwSPNBfNmdPD0i/MmAX+haUAY0vkJ
         QYIe9pbgscTCkEZjG0J31vXCE4x/PSEt9+F8olmTiwli0m4lMb+PhNLfAYywgj3zjGNR
         lDdKN4JQVkRvaam3obZUnHx6JJNNZqx6hr5rjA6oX8hPwjxpNu7FjHXp0c6vGcwBQL4M
         PYXYrubgLXbBfzP7w+Id7hCnwviGO1dJJlc7vxOG8YlFxENFgNjBSVmU5l4pfqwFPk2B
         yrbA==
X-Received: by 10.224.221.136 with SMTP id ic8mr52650132qab.17.1367262419596;
 Mon, 29 Apr 2013 12:06:59 -0700 (PDT)
Received: by 10.49.30.9 with HTTP; Mon, 29 Apr 2013 12:06:59 -0700 (PDT)
In-Reply-To: <7vppxkflhq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222847>

Should we think about adding some commands for that ?

On the very top of my head (there is certainly more than that):
- Save such a change: By basically creating a ref to HEAD (HEAD being
the commit, HEAD^ the fixed merge) with merge-fix/HEAD^^1-HEAD^^2
- Apply the merge-fix: On top of a merge, find the most recent
merge-fix for HEAD^1/HEAD^2 (according to what was discussed), and
squash it.

On Wed, Apr 24, 2013 at 9:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> This raises the same question I recently asked Antoine: For a given
>> prepackaged merge <X,Y>, do we assume that it only resolves conflicts
>> between the changes introduced in commit X vs. changes introduced in
>> commit Y, or do we assume that it resolves conflicts between the
>> histories leading up to X and Y, respectively? In other words, does
>> <X,Y> _supercede_ earlier pre-merges between the histories leading up
>> to X and Y?
>
> That is an interesting question.  There are largely two cases.
>
> When you replayed M---F to produce N---F', there may have been no
> textual or semantic conflict.  Which means that there were no new
> reason between A--X and B--Y that necessitates an evil merge.  A
> later merge between a descendant of X (but not Y) and a descendant
> of Y (but not X) can cherry pick the same <A,B> (M---F) on top of a
> mechanical merge,
>
> On the other hand, you may have had either a textual or a semantic
> conflict when replaying <A,B> on N, and you had to fix up F' for it
> to be the correct resolution of merge between X and Y.
>
>   ---o---o---A---o---X
>       \               \
>        \               N---F'
>         \             /
>          o---B---o---Y
>
> In such a case, you do want to record the fixed N---F' as the
> prepackaged resolution for <X,Y>.  Any time later when somebody is
> on a branch that has X (but not Y) and merges a branch that has Y
> (but not X), that N---F' should be the one to cherry-pick on top of
> a mechanical merge O between S and T.  What <A,B> (M---F) did is
> superseded if you are going to replay <X,Y>.
>
>   ---o---o---A---o---X----------S
>       \       \       \          \
>        \       M--F    N---F'     O---F''
>         \     /       /          /
>          o---B---o---Y----------T
>
> You can tell that by noticing that A is an ancestor of X and B is an
> ancestor of Y.  As you said, this is a good way to reduce the number
> of prepackaged evil merges that need to be considered.
>
