From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Tue, 7 May 2013 02:07:45 -0500
Message-ID: <CAMP44s1Y6rjyKZ_CGWJJ81s16DTu7cqKeFY48J_ndzpp2t8=dQ@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
	<518785B3.3050606@alum.mit.edu>
	<87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
	<518789D1.4010905@alum.mit.edu>
	<CAMP44s1Nk7YAjNkTq=ShQbzkMasw6bpcEPTXLb8x+2q-vXLRGg@mail.gmail.com>
	<518874A5.5050002@alum.mit.edu>
	<CAMP44s3vGKv-Z6sx0sjAPH7_U1+AiJjFHjKz8ke+EUqW-u2Y=A@mail.gmail.com>
	<5188A36A.8000408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 07 09:07:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZc09-000232-Ry
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 09:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758180Ab3EGHHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 03:07:49 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:49543 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757834Ab3EGHHr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 03:07:47 -0400
Received: by mail-la0-f42.google.com with SMTP id fq13so223603lab.1
        for <git@vger.kernel.org>; Tue, 07 May 2013 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vxqvCI6G7E5Dq9EeD68qqpVf8YJVq6ZgpdXHJjK+euk=;
        b=vsgTxGKYhrWgeHsrPtfyeDsq854JogShrlIWpgu1rU3xb7lh6uclPcI5YT21izlEwe
         ACJobdUQfa8+Pn7ePBfxJZMDMHdT2mERHzhn6b29zF+zARtRc6DGiGvyQ3T+nbXvmdxd
         vX7V19V2zqrR94K42WLmWaoXXT8BIz3hY+sVNjaYlgwNVhr4pbozvfRXu9H0nQLUKjW0
         yeLCGolDkI216d+6NbOEwXSFFzL3l+sbXcRL4EdoKvE6jQ70y2yog4DiJL4Tj2I7C8kF
         G/Kd/GlSMySRLUArxhG63PUMtr0RdYH43Qph4MEGYHFMB+7/RNbRm90xbafe0fYz4d8a
         xdfA==
X-Received: by 10.152.22.168 with SMTP id e8mr345495laf.20.1367910465328; Tue,
 07 May 2013 00:07:45 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 7 May 2013 00:07:45 -0700 (PDT)
In-Reply-To: <5188A36A.8000408@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223560>

On Tue, May 7, 2013 at 1:47 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/07/2013 06:47 AM, Felipe Contreras wrote:
>> On Mon, May 6, 2013 at 10:27 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>
>>> You conjectured earlier that nobody uses blob marks, and I provided a
>>> counterexample.  Then you proposed a workaround that would require
>>> changes to the cvs2git documentation, and I even explained how your
>>> proposed workaround is not as flexible as the status quo.
>>
>> cvs2git does *not* need blob marks, it does not need marks at all.
>>
>> The use-case that you mentioned has nothing to do with cvs2git, in
>> fact. I can be described as this:
>>
>> % ./generate-blobs > blobs
>> % git fast-import --export-marks=marks < blobs
>> % ./generate-commits > commits
>> % git fast-import --import-marks=marks < commits
>>
>> In this example 'generate-commits' has no notion of marks at all, and
>> 'git fast-import' doesn't need marks to process both blobs and
>> commits.
>
> The "generate-blobs" program generates a mark for each blob and
> remembers the marks in a database.  The "generate-commits" program reads
> the marks from the database and incorporates them in the definitions of
> the commits that it writes to its output.  So yes, the program pair
> *does* rely on marks for blobs being exported correctly.

Fine:

% ./generate-data > data
% ./split-blobs data > blobs
% ./split-commits data > commits

How exactly the files 'blobs' and 'commits' are generated is
irrelevant, 'git fast-import' will need them *once*, and never again,
in fact, doesn't even need to know they are two files. There's no need
for marks.

> I've tired of this discussion.  I am quite sure that your change will
> not be accepted, so I see no need to participate further.  Please do not
> interpret my silence as agreement with your quarrelsome arguments.

How convenient. I ask the though questions, and you suddenly get tired
of the discussion. So, let me answer for you:

* Which the *vastly* more common case? That blobs are needed, or that
they are not?

That they are not. To suggest otherwise would be ridiculous.

And of course this patch will not be accepted, because nobody is
interested in improving things in the most easy and sensible way.

Yours and everybody else's argument is one and the same: status quo,
which is of course, not an argument at all.

But it's pointless to try to convince you, because a) you are not
interested in changing your mind b) you are not interested in seeking
the most sensible solution c) you are only interested in doing what
you are used to do, which is to not change anything, ever d) you know
making this the default is only slightly risky, at best, and not only
the world is not going to end, but most likely nobody would even
notice, and the ones that would, are probably already participating in
this conversation, but you don't even want to do something slightly
risky, because it would show that others were right, and your concerns
don't actually affect any real users at all.

But as I said, drop the patch. Who needs progress?

Cheers.

-- 
Felipe Contreras
