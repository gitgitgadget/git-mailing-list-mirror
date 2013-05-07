From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 6 May 2013 23:37:13 -0500
Message-ID: <CAMP44s09kkVKSKWhFfES=wCsL5CL6FMDMmZFdCfKCjc_-h=o8A@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
	<518785B3.3050606@alum.mit.edu>
	<87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
	<518789D1.4010905@alum.mit.edu>
	<7v38u0t9va.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HASAuF0ECCvJr66WeqopDzLZQ12pKFsc-j5_VCDrizg@mail.gmail.com>
	<51886DE5.7030001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 07 06:37:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZeX-0002uk-Ba
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760127Ab3EGEhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:37:18 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:56837 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760064Ab3EGEhP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:37:15 -0400
Received: by mail-la0-f42.google.com with SMTP id fq13so133332lab.1
        for <git@vger.kernel.org>; Mon, 06 May 2013 21:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=OgcIdOPl/gGqNymr7p+pvo7LIIw3PlqmlTb8u3B8fAw=;
        b=fCZ65gGj1grKGsdpKgXm8ZsKtSfKBrinuZLgZciNB4dyAlZkYtgxPtNH0LK287XKSj
         r3G7UU5tElXX277yQ8XaqVdxfZm2+AIppG6HN5q71fRzvLpKRxuMwaEtrbX1GOeSE93M
         eQ3SgdgljGsTQC/zsdAkF7pajYuBHIw9C9JB9iVNFIwLaBhr/F063VeASTe5/7Vo+tpF
         6FR/nXZvlaywGajD/W7aMRROM/Wb+klf4clRzrg5wgewbgHbbQeVzcwJRxTu+/pmcnkm
         pKaoMPelpend6Hd8gH+GI+MZsQehsSp/97xsjHFhJ6Btb5lm+rdAb4fUhz9PGWyoteFr
         NElQ==
X-Received: by 10.112.166.101 with SMTP id zf5mr292868lbb.59.1367901433448;
 Mon, 06 May 2013 21:37:13 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 21:37:13 -0700 (PDT)
In-Reply-To: <51886DE5.7030001@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223542>

On Mon, May 6, 2013 at 9:58 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/06/2013 11:19 PM, Felipe Contreras wrote:
>> On Mon, May 6, 2013 at 10:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>
>>>> Yes, it can be handy to start loading the first "blobfile" in parallel
>>>> with the later stages of the conversion, before the second "dumpfile" is
>>>> ready.  In that case the user needs to pass --export-marks to the first
>>>> fast-import process to export marks on blobs so that the marks can be
>>>> passed to the second fast-import via --import-marks.
>>>>
>>>> So the proposed change would break a documented use of cvs2git.
>>>>
>>>> Making the export of blob marks optional would of course be OK, as long
>>>> as the default is to export them.
>>>
>>> Thanks for a concise summary.  Your use case fits exactly what
>>> Felipe conjectured as the nonexistent minority.
>>
>> Not true. cvs2git does *not* rely on the blobs being stored in a marks
>> file, because cvs2git does not rely on mark files at all.
>>
>>> An option that lets the caller say "I only care about marks on these
>>> types of objects to be written to (and read from) the exported marks
>>> file" would help Felipe's use case without harming your use case,
>>> and would be a sane and safe way to go.
>>
>> His case is not harmed at all. It's only the unfortunate command that
>> is mentioned in the documentation that didn't need to be mentioned at
>> all in the first place.
>>
>> It should be the other way around, if it's only this documentation
>> that is affected, we could add a switch for that particular command,
>> and the documentation should be updated, but it's overkill to add a
>> switch for one odd command in some documentation somewhere, it would
>> be much better to update the odd command to avoid using marks at all,
>> which is what the more appropriate command does, right below in the
>> same documentation.
>>
>>   cat ../cvs2svn-tmp/git-blob.dat ../cvs2svn-tmp/git-dump.dat | git fast-import
>>
>> Should the rest of the real world be punished because somebody added a
>> command in some documentation somewhere, which wasn't actually needed
>> in the first place?
>
> Don't get too fixated on the documentation.  The documentation just
> gives some examples of how cvs2git can be used.
>
> The reason that cvs2git outputs two files is that the first file is
> emitted at the very beginning of the conversion and the second at the
> very end.  These conversions can take a long time (> 1 day for very big
> repos), can be interrupted and restarted between "passes", and passes
> can even be re-run with changed configurations.
>
> CVS write access has to be turned off before the start of the final
> conversion, so no VCS is possible until the conversion is over.  So
> users are very interested in keeping the downtime minimal.

Of course VCS is possible before the conversion is over, you can do
all the cvs2git commands first, turn on CVS, and let 'git fast-import'
do it's thing afterwards, can you not?

> The blobfile
> can also be unwieldy (its size is approximately the sum of the sizes of
> all revisions of all files in the project).  Being able to load the
> blobfile into one fast-import process and the dumpfile into a different
> process (which relies on the feature that you propose removing) opens up
> a lot of possibilities:
>
> * The first fast-import of the blobfile can be started as soon as the
> blobfile is complete and run in parallel with the rest of the conversion.

Is that reason enough to punish everyone else?

> * If the blobfile needs to be transferred over the network (e.g.,
> because Git will be served from a different server than the one doing
> the conversion) the network transfer can also be done in parallel with
> the rest of the conversion.

Ditto.

> * The blobfile could be written to a named pipe that is being read by a
> git-fast-import process, to avoid having to write the blobfile to disk
> in the first place.

And it would still be possible.

{ cat file1; cat file2; } > pipe

What am I missing?

> * The user could run "git repack" between loading the blobfile and
> loading the dumpfile.

Is that reason enough to punish everyone else?

> These are just the ways that cvs2git does and/or could benefit from the
> flexibility that is now in git-fast-import.

Sure, all those things _migt_ be nice, but nothing would be broken,
would it? cvs2git can still achieve it's goal without it.

And if this "feature" is removed by *default*, it would be trivial to
enable an option to tell 'git fast-import' to store blobs from
cvs2git, would it not?

> Other tools might also be
> using git-fast-import in ways that would be broken by your proposed change.

Yeah, everything is possible, but the key word is *might*. Will
anything be *actually* broken by this change? My guess is, very few
things, if any.

Cheers.

-- 
Felipe Contreras
