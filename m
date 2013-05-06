From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 6 May 2013 16:19:03 -0500
Message-ID: <CAMP44s1HASAuF0ECCvJr66WeqopDzLZQ12pKFsc-j5_VCDrizg@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
	<518785B3.3050606@alum.mit.edu>
	<87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
	<518789D1.4010905@alum.mit.edu>
	<7v38u0t9va.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 23:19:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZSoS-00086L-9P
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 23:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759409Ab3EFVTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 17:19:08 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34521 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759406Ab3EFVTF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 17:19:05 -0400
Received: by mail-la0-f50.google.com with SMTP id fl20so3737307lab.37
        for <git@vger.kernel.org>; Mon, 06 May 2013 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=C4zRkkeG85FYcvFVBB5hB8Dg5+qRzBMsjTPsLPQGkuw=;
        b=EJzKPFO+vcLifMF6N6x9okZ5GRuNymUvw1P8upeVws6ma4OMILP2v40qzjSZGqNJT/
         lXgJ4JN2yf60PICtShk7utXxf0VF8xx+wF2A4zM4jOSvg/W4iQF9zht6o+0a+GZZlbXc
         23k6/aYw3BWqZ7y7ys6APMK1RxeV6of+1SrYzXhStt4re2WVB9NtIQh66OUqb4mLttkT
         1eAbeAKSV3dSavy5e0f4Y9dsbGiQds/d//LCfijqi/8u0Xi1sEnO/p4V5sCzplhzGv9F
         2oC4eAxttDoma+eB2OX2op6n59icP8u2WasTGAzqL1hjUPkFywDWfqPqBaxDJsVcBYIS
         srBQ==
X-Received: by 10.112.166.101 with SMTP id zf5mr8563206lbb.59.1367875143180;
 Mon, 06 May 2013 14:19:03 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 14:19:03 -0700 (PDT)
In-Reply-To: <7v38u0t9va.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223507>

On Mon, May 6, 2013 at 10:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> Yes, it can be handy to start loading the first "blobfile" in parallel
>> with the later stages of the conversion, before the second "dumpfile" is
>> ready.  In that case the user needs to pass --export-marks to the first
>> fast-import process to export marks on blobs so that the marks can be
>> passed to the second fast-import via --import-marks.
>>
>> So the proposed change would break a documented use of cvs2git.
>>
>> Making the export of blob marks optional would of course be OK, as long
>> as the default is to export them.
>
> Thanks for a concise summary.  Your use case fits exactly what
> Felipe conjectured as the nonexistent minority.

Not true. cvs2git does *not* rely on the blobs being stored in a marks
file, because cvs2git does not rely on mark files at all.

> An option that lets the caller say "I only care about marks on these
> types of objects to be written to (and read from) the exported marks
> file" would help Felipe's use case without harming your use case,
> and would be a sane and safe way to go.

His case is not harmed at all. It's only the unfortunate command that
is mentioned in the documentation that didn't need to be mentioned at
all in the first place.

It should be the other way around, if it's only this documentation
that is affected, we could add a switch for that particular command,
and the documentation should be updated, but it's overkill to add a
switch for one odd command in some documentation somewhere, it would
be much better to update the odd command to avoid using marks at all,
which is what the more appropriate command does, right below in the
same documentation.

  cat ../cvs2svn-tmp/git-blob.dat ../cvs2svn-tmp/git-dump.dat | git fast-import

Should the rest of the real world be punished because somebody added a
command in some documentation somewhere, which wasn't actually needed
in the first place?

-- 
Felipe Contreras
