From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] revision: introduce --exclude=<glob> to tame wildcards
Date: Tue, 3 Sep 2013 17:03:47 -0500
Message-ID: <CAMP44s12Huoeuxw-pD7Y-C5FeKD=-4BOvsA8vpLzaySZfi1k1Q@mail.gmail.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
	<CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com>
	<CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com>
	<CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
	<xmqqeh9b15x6.fsf@gitster.dls.corp.google.com>
	<xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
	<CAMP44s1hhoPbeBsmN8NL_VtCz3bO-jg1sPP7hovL1kPBhbrXFQ@mail.gmail.com>
	<xmqq8uzdvrh1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 00:03:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGyhV-00044P-0W
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 00:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761233Ab3ICWDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 18:03:49 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:54847 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760223Ab3ICWDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 18:03:48 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so5376932lbi.15
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OMY1LNtgZ7Y5c44rsLFfIBIx3rYGBHm+BcmtrSWRc+k=;
        b=lMBqLoL96hX8mL1VlePc+Y6DymW0Ovb2lYOxGtWPjjcEd136yVzFDnEzNlyu2ltXJP
         Sy1GT4cs341UA+AlCs5RvEuVfrzEGiUm60O3jL2TxUqNt+hozQCC/d8roW4b7TA43OCB
         G1PSa2EuIE0IgSnw81rmnKAtZ0NovI7Jv4m/BJdO6CFmZ4KPLHZfg71/1lZ5PLAv86fo
         Q4WKOD4w7pIP11oGF0FN/EN4U+DcrPsvze4aZ8iPxDJJ4NVIU01i/OoKdNTUNcL7zSS7
         TMa5YQ6lQLlAIgEsaHJFMbYE9McMCfLT/jzy2F3msA3Oe3yNdtAqhRKDXQSMQJunsUcg
         VFCg==
X-Received: by 10.152.5.162 with SMTP id t2mr28110063lat.1.1378245827128; Tue,
 03 Sep 2013 15:03:47 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 3 Sep 2013 15:03:47 -0700 (PDT)
In-Reply-To: <xmqq8uzdvrh1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233789>

On Tue, Sep 3, 2013 at 10:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Fri, Aug 30, 2013 at 6:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> People often find "git log --branches" etc. that includes _all_
>>> branches is cumbersome to use when they want to grab most but except
>>> some.  The same applies to --tags, --all and --glob.
>>
>> This idea looks very familiar, from the wording of this commit message
>> it seems you came with the idea out of nowhere. Did you?
>
> As the comment after three-dash quotes, the inspiration came from
> this suggestion:
>
>  > It may be a good idea to step back a bit and think of this topic as
>  > a way to enhance the --branches option and its friends with only the
>  > inclusive wildcard semantics.
>
> which is not anything new.  It takes from J6t's
>
>       To unclutter 'git branch' output, I rename work-in-progress branches
>       to begin with "wip/", ready-to-merge branches do not carry this
>       prefix. To inspect unmerged work of the latter kind of branches I
>       would like to type... what?

Yeah, and where did that come from?

> But the thing is, that is nothing new, either.
>
> Pretty much ever since we added --branches --tags and later --glob,
>
>  (1) traversing from "almost all but minus some branches", and
>  (2) stopping traversal at "almost all but minus some branches"
>
> were what people sometimes wanted to have (which is pretty much what
> the first paragraph of the proposed commit message says) using
> "negative glob". Looking the phrase in the list archive finds for
> example $gmane/159770 from 2010, but I would not be surprised if you
> find older message wishing the same.

It is very peculiar that your patch suddenly appeared after I sent a
patch for --except, and nobody has sent a similar patch, which is not
what you would expect if "this was nothing new".

-- 
Felipe Contreras
