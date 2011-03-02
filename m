From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: got myself into trouble; now what? - how to revert once you've pushed
Date: Wed, 2 Mar 2011 08:10:38 -0500
Message-ID: <AANLkTi==_zmSy4j-JwyCuYouV-J3shSObJe2y942PjCn@mail.gmail.com>
References: <AANLkTi=RGhGMcoDEL4q2pnnZ97tdswYG7OkjNS3wF7jn@mail.gmail.com>
	<20110301195027.GE10082@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 14:10:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PulpF-0005mV-20
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 14:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab1CBNKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 08:10:40 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36934 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab1CBNKj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 08:10:39 -0500
Received: by gyh20 with SMTP id 20so2352462gyh.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 05:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Lg+Zrl8QofMs5Zy2RF8GLzGpIIz3yR/WL879F6xl0pQ=;
        b=TsOGF9UR+dNbn2Pzeno8fZVvyzCrvpBKrSAHUSIRuWcP7E0KMYaMn5SfzR9u16KWmV
         7aKIM44OtLm5FFwDx96XD9Y7JGBjp+8kfhWSU6bvu/6A5z5G8uIs7VlzdBTAsCepQeU2
         v2jTAXwd0OrQiUiScF5+Px8TEs/6HIH3+UrHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sxqsKiGPWBCRPWlDra4I0eTsPrZHB0W7JAyABiLL5/9tc8mZwnxnlLfgazNmIFYLDs
         HCp+jCdP8iDTb8OUiIGyWUh2cJEY4ZAY0X+lhiIfCmcBXQn8aGbkBMcQdnS0pVVrGemC
         snmOt7BPnWOpOGnlZdbcc09TdTkIDiMINKdbw=
Received: by 10.236.103.9 with SMTP id e9mr13964240yhg.75.1299071438793; Wed,
 02 Mar 2011 05:10:38 -0800 (PST)
Received: by 10.236.108.33 with HTTP; Wed, 2 Mar 2011 05:10:38 -0800 (PST)
In-Reply-To: <20110301195027.GE10082@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168308>

On Tue, Mar 1, 2011 at 2:50 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 01, 2011 at 02:37:19PM -0500, Robert Buck wrote:
>
>> We have two branches: master, feature/wixinstall
>>
>> Apparently a merge happened from the branch to master (and I am pret=
ty
>> sure I never typed `git merge...`). But alas, a merge somehow happen=
ed
>> and got pushed.
>
> Did you run "git pull", which is basically fetch+merge?
>
>> Then I followed the Git Pro documentation, which said to do this...
>>
>> =C2=A0 =C2=A0 git revert -m 1 [sha_of_C8]
>>
>> Now I am left with a bigger mess. When I merge master to the branch,
>> all the newly added files on the branch got deleted (not what I
>> wanted). Somehow git is interpreting the revert literally as a
>> sequence of deletes which it incorrectly then applies to the work on
>> the branch.
>
> Yeah. That reverts the merge, in essence creating a new tree built on
> top of the merge without the results of the merge. But when you try t=
o
> re-merge between those two branches, it sees that history has already
> combined, and then afterwards eliminated the result. Which is not wha=
t
> you wanted.
>
> Read the section "reverting the revert" directly below the advice you
> followed:
>
> =C2=A0http://progit.org/2010/03/02/undoing-merges.html
>
>> What I really wanted the revert to do is restore the history of the
>> world immediately prior to the merge. But now I have a branch I can'=
t
>> merge into at all without losing a weeks work.
>>
>> How can I get out of this mess?
>
> If you can accept that history will be rewritten (which is a problem =
if
> people have built on top of your bogus merge), then what you want is:
>
> =C2=A0git checkout master
> =C2=A0git reset --hard $SHA1_OF_MERGE^
>
> and then re-push.

That does not work; the central server rejects the commit. Now there
are two other commits after mine, and the problem is getting worse.

Does anyone have a detailed guide of how to obliterate a range of
commits and replay subsequent history on top of that?

-Bob
