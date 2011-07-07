From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Redoing a merge for a particular file
Date: Fri, 8 Jul 2011 11:31:41 +1200
Message-ID: <CAFOYHZBBtqK2VtZ-Bq3uMAhGD4esSz7JDJn_4xaKb4y8wt9LJA@mail.gmail.com>
References: <CAFOYHZCFetkokgtn4z0O3nPTEy6GCTEcN0Pzc8ce-joqMzZM1Q@mail.gmail.com>
	<20110707224114.GA23273@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 08 01:31:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qey2u-0000Fn-JE
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 01:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755Ab1GGXbn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jul 2011 19:31:43 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33922 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab1GGXbm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2011 19:31:42 -0400
Received: by vws1 with SMTP id 1so1082608vws.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=rM809ChLMFOVVsSAPPFuCyr92p4zvCPUFTjT3Kz6frY=;
        b=bFMeoCu4xc2WmaHJ0ic2JHlMQ8HkHEZS1a9XMbMOnceQOPlOIIMCF6CMQliDfLoqol
         bxIOxWM5sm+Ej+PvK2B2BVR6DhmMnrqxmeDoYNBlw9JAHiKnCOn64CxIkUA19pV8MQ06
         t26J52vVfDb+GSb0IJ06/ozeTltIApnbY6Uak=
Received: by 10.220.209.196 with SMTP id gh4mr515540vcb.50.1310081501276; Thu,
 07 Jul 2011 16:31:41 -0700 (PDT)
Received: by 10.220.200.72 with HTTP; Thu, 7 Jul 2011 16:31:41 -0700 (PDT)
In-Reply-To: <20110707224114.GA23273@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176788>

Peff sorry for the spam. I forgot to CC the list.

On Fri, Jul 8, 2011 at 10:41 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jul 08, 2011 at 10:24:10AM +1200, Chris Packham wrote:
>
>> I'm in the middle of merging to branches and I've screwed up my manu=
al
>> merge, I've also got rerere enabled and I can't seem to get back int=
o
>> a state to trigger git mergetool again.
>>
>> =C2=A0 $ git merge topic
>> =C2=A0 ...
>> =C2=A0 $ git mergetool
>> =C2=A0 $ make
>> =C2=A0 error: foo.c ... oops screwed up that merge.
>>
>> The merge wasn't too painful so I don't mind starting again.
>>
>> =C2=A0 $ git reset --hard HEAD^
>> =C2=A0 HEAD is now at 59c6097 ...
>> =C2=A0 $ git merge topic
>> =C2=A0 Auto-merging foo.c
>> =C2=A0 CONFLICT (content): Merge conflict in foo.c
>> =C2=A0 Auto-merging bar.c
>> =C2=A0 CONFLICT (content): bar.c
>> =C2=A0 Auto-merging otherfile1.c
>> =C2=A0 Auto-merging otherfile2.c
>> =C2=A0 Auto-merging otherfile3.c
>> =C2=A0 Resolved 'foo.c' using previous resolution.
>> =C2=A0 Resolved 'bar.c' using previous resolution.
>> =C2=A0 Automatic merge failed; fix conflicts and then commit the res=
ult.
>> =C2=A0 $ git mergetool
>> =C2=A0 No files need merging
>>
>> So rerere has remembered the bad resolution of foo.c. =C2=A0But even=
 if I
>> run 'git rerere clear' and repeat the above sequence I get the same
>> result.
>
> I think you actually want "rerere forget". Like:
>
> =C2=A0$ git reset --hard HEAD^
> =C2=A0$ git merge topic
> =C2=A0$ git rerere forget foo.c
>
> Although it is slightly more complicated if you have set
> rerere.autoupdate, since it will have cleared the index of any notion
> that the path was conflicted. In that case you can then follow the
> "rerere forget" with:
>
> =C2=A0$ git reset --hard
> =C2=A0$ git merge topic
>
> to retry again.
>
> But it doesn't look like you have autoupdate on, from the output abov=
e
> (it would say "Staged 'foo.c'" instead of "Resolved 'foo.c", I believ=
e).
>
>> I seem to remember something like this coming up before.
>> Wasn't there an option added to checkout to allow us to recreate the
>> pre-merge state?
>>
>> =C2=A0 $ git checkout --merge foo.c
>> =C2=A0 $ git mergetool
>> =C2=A0 No files need merging
>
> If you have rerere.autoupdate on, then it will have updated the index=
,
> and the path will not appear unmerged. You can use the trick above to
> get past it.
>
> If you aren't using rerere.autoupdate (and haven't updated the index
> yourself), you shouldn't even need the "git checkout --merge" line. I=
t
> just updates the working tree with the conflicted content, but merget=
ool
> will operate directly on the original versions contained in the index=
,
> anyway.
>
>> =C2=A0 $ git status
>> =C2=A0 # On branch master
>> =C2=A0 # Your branch is behind 'origin/master' by 1 commit, and can =
be
>> fast-forwarded.
>> =C2=A0 #
>> =C2=A0 # Changes to be committed:
>> =C2=A0 ....
>> =C2=A0 # Unmerged paths:
>> =C2=A0 # =C2=A0 (use "git add/rm <file>..." as appropriate to mark r=
esolution)
>> =C2=A0 #
>> =C2=A0 # =C2=A0 both modified: =C2=A0 =C2=A0 =C2=A0foo.c
>> =C2=A0 #
>>
>> foo.c now does have conflict markers in it so I think it's crying ou=
t
>> to be re-merged I just can't convince mergetool to do it. Am I doing
>> something wrong?
>
> Hmm. That does seem like "git checkout --merge" did the right thing, =
but
> that "mergetool" is wrong for not accepting it (it _should_ just be
> looking at what's in the index to find unmerged paths).
>
> Ahh. It is probably the fault of bb0a484 (mergetool: Skip autoresolve=
d
> paths, 2010-08-17), which checks with rerere to avoid resolved paths.=
 So
> I think:
>
> =C2=A0$ git rerere forget foo.c
> =C2=A0$ git mergetool
>
> would do what you want.
>
> -Peff
>

Thanks that sounds like what I want. I've also been a bit lazy and
didn't run 'make install-doc' when I upgraded to 1.7.5.4 so my system
man pages (1.7.0.4) don't mention rerere forget but it's there in
rerere -h.

Perhaps checkout --merge <path> should automagically tell rerere to
forget about the path?
