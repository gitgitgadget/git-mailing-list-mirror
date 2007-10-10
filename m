From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 09/13] Clear up the semantics of Series.new_patch
Date: Wed, 10 Oct 2007 09:43:25 +0200
Message-ID: <87prznxvmq.fsf@lysator.liu.se>
References: <20070914222819.7001.55921.stgit@morpheus.local>
	<20070914223154.7001.12254.stgit@morpheus.local>
	<b0943d9e0710080616r36142946m3e24d2f6893287c9@mail.gmail.com>
	<20071008132524.GA11253@diana.vm.bytemark.co.uk>
	<b0943d9e0710091401s280b3a12md9e700fb3ae007bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 09:44:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfWFM-0001hT-GB
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 09:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbXJJHoj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2007 03:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbXJJHoi
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 03:44:38 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:58536 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbXJJHoi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2007 03:44:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 5EEB8200A22C;
	Wed, 10 Oct 2007 09:44:15 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 07108-01-26; Wed, 10 Oct 2007 09:43:55 +0200 (CEST)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 1C606200A221;
	Wed, 10 Oct 2007 09:43:25 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 32AD57B4080; Wed, 10 Oct 2007 09:43:25 +0200 (CEST)
In-Reply-To: <b0943d9e0710091401s280b3a12md9e700fb3ae007bf@mail.gmail.com> (Catalin Marinas's message of "Tue\, 9 Oct 2007 22\:01\:44 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60475>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 08/10/2007, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
>> On 2007-10-08 14:16:10 +0100, Catalin Marinas wrote:
>>
>> > On 14/09/2007, David K=C3=A5gedal <davidk@lysator.liu.se> wrote:
>> >
>> > > +        assert commit or (top and bottom)
>> > > +        assert not before_existing or (top and bottom)
>> > > +        assert not (commit and before_existing)
>> > > +        assert (top and bottom) or (not top and not bottom)
>> > > +        assert not top or (bottom =3D=3D git.get_commit(top).ge=
t_parent())
>> >
>> > The last assertion here prevents the use of 'stg pick --reverse'.
>> > This command creates an unapplied patch with top and bottom revers=
ed
>> > and pushes it to force a three-way merge.
>> >
>> > It seems to work OK if I comment it out but I wonder whether it wi=
ll
>> > break in the future with the planned removal of the top and bottom
>> > files.
>>
>> I think the assert represents a real constraint, namely that there h=
as
>> to be a 1:1 correspondance between patches and commits.

Yes, that was the point of the series.

>> Couldn't "stg pick --reverse" create a new commit and use that? That
>> is, given that we want to revert commit C, create a new commit C* wi=
th
>
> Series.new_patch already creates a commit, why should we move the
> functionality to 'pick'? The only call to new_patch with commit=3DFal=
se
> seems to be from 'uncommit' (and it makes sense indeed).

It might be true that the assertion could be amended so that if
commit=3DTrue, then it is allowed to have top/bottom that doesn't
correspond to a commit and its parent. But it's hard to be sure
without looking at the code much harder than I did just now.  Testing
would also help.

>> And shouldn't there be a test for this? :-)
>
> Yes :-). I think there are many other tests needed. It would be usefu=
l
> to do a code coverage with the existing tests to see what we are
> missing. Unit testing might be useful as well but we all have limited
> spare time.

--=20
David K=C3=A5gedal
