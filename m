From: =?UTF-8?Q?Mihai_Capot=C4=83?= <mihai@mihaic.ro>
Subject: Re: [PATCH v2] count-objects: output "KiB" instead of "kilobytes"
Date: Fri, 5 Apr 2013 11:38:52 +0200
Message-ID: <CADyhzG04H-9w51YsUruW58LHyPxFCLhEcd7Za2CQhDgxR4fKBw@mail.gmail.com>
References: <7vip44a8xl.fsf@alter.siamese.dyndns.org>
	<1364993331-20199-1-git-send-email-mihai@mihaic.ro>
	<7vd2ub7k7c.fsf@alter.siamese.dyndns.org>
	<CADyhzG3HJhrXJAoTfyHUsg=8ZmUUwUgrNfUiLHF0Ws=gSERAqw@mail.gmail.com>
	<7vvc82jm77.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 18:53:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWEE-0002u6-Hp
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161610Ab3DEJi4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Apr 2013 05:38:56 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:65135 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161374Ab3DEJiy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Apr 2013 05:38:54 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so2994674iag.17
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 02:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=7blVuCqsNyUUU5132F3GEDgO5jFmcaNOTf9bKTHVOaw=;
        b=RAdCvt5cLIFmEQ1pjabG/SN19hVSBukDKEUHGSp9OlMbm+dt1vPifoYZmBnnYce1jI
         t1HJ2uq/kXhGtQ+NtgvM7SY8j8h0uJZp5q81RyLjuwMtqEPJzftss5D3AK9tMRvWV+Dr
         fKh0MWx1hqdxR2L9Mnxb5bT1ipQ9w9/2XCP/gJjWE0XwQETyXHOvA9wnt4Fh11C1UDlv
         K7kHrC2RX3/XQbTvvOOPTM31jVZ4Q2ODysJOw1OCUwtXB6v+Jd36iUH6MyWf0bJvgqd7
         OzsDakMK/W9+AVZhiWzoFgtzYWx7/PJta8EU49PsGxJ5+KdpQiA+HCNpe8YU3vItdm/N
         +RDw==
X-Received: by 10.43.4.74 with SMTP id ob10mr5081706icb.28.1365154732981; Fri,
 05 Apr 2013 02:38:52 -0700 (PDT)
Received: by 10.64.7.75 with HTTP; Fri, 5 Apr 2013 02:38:52 -0700 (PDT)
In-Reply-To: <7vvc82jm77.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQl3EowD9WyNvcPMASCmnSysN/1dr+xL2mak9swgcISSNf4IsxAKjOLE27FecCW+yqOLHC5E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220166>

On Thu, Apr 4, 2013 at 6:27 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Mihai Capot=C4=83 <mihai@mihaic.ro> writes:
>
>> The git manual contains an explicit warning about the output of a
>> porcelain command changing: "The interface to Porcelain commands on
>> the other hand are subject to change in order to improve the end use=
r
>> experience."
>
> Yeah, I know that, as I wrote it ;-)
>
> Aside from count-object being not exactly a Porcelain, the statement
> does not give us a blank check to make random changes as we see fit.
> There needs to be a clear improvement.
>
> I am just having a hard time weighing the benefit of using more
> accurate kibibytes over kilobytes and the possible downside of
> breaking other peoples' tools.
>
> Perhaps it would be alright if the change was accompanied by a
> warning in the Release Notes to say something like:
>
>         If you have scripts that decide when to run "git repack" by
>         parsing the output from "git count-objects", this release
>         may break them.  Sorry about that.  One of the scripts
>         shipped by git-core itself also had to be adjusted.  The
>         command reports the total diskspace used to store loose
>         objects in kibibytes, but it was labelled as "kilobytes".
>         The number now is shown with "KiB", e.g. "6750 objects,
>         50928 KiB".
>
>         You may want to consider updating such scripts to always
>         call "git gc --auto" to let it decide when to repack for
>         you.
>
> Also, I suspect that for the purpose of this exact output field,
> nobody cares the difference between kibibytes and kilobytes.
> Depending on the system, we add up either st.st_blocks or st.st_size
> and the result is not that exact as "how much diskspace is
> consumed".

I agree completely. I think the release notes warning is a good plan.
Just in case you decide against it, I'm also sending a completely
different patch to document the issue.

Mihai
