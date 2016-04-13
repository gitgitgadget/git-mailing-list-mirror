From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 4/6] parse-options.c: make OPTION_COUNTUP respect
 "unspecified" values
Date: Wed, 13 Apr 2016 13:33:14 -0400
Message-ID: <CAPig+cRUr2sgvQimGWy1WhRZ160d_RyafO-69q5hDrPCy4EMXw@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60971-0bf3b786-4acd-4317-bd3c-3397dc2b51f9-000000@eu-west-1.amazonses.com>
	<CAPig+cQM_E9VgsxifBcT_XGyTCCaanNcfQEm6rU85pSNaQG7MQ@mail.gmail.com>
	<CAFZEwPMjDxFHOdbOgqXmBoud=2gmrpfiR4Aa83_7+bjka1bk4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:33:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqOfI-0001AN-5x
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbcDMRdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:33:16 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34628 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbcDMRdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:33:15 -0400
Received: by mail-io0-f193.google.com with SMTP id z133so7680530iod.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=cwkvesNh91N/NjeuKCfPqkvSTLdxkQog1wawInnHep0=;
        b=QCmqAltRmDBMKtJ0d6FCckmQk5FJU3J6QHfMdpI+mrlR/HargJ3QmmlsphgPcI9ipJ
         AEYPXz4YCiXlh/5me5l5oADafhRYdFUsO7/p/OB42XsvcwiqBssid597l0q90UoNtmej
         cNeLgzFVrFEAYVKpAxODw+xR67xWdnhwiKsZdw6nQjs+TkpmU+j9YLgG1uYO8+ypRnHJ
         geVanovG1c2kJa+Preh0x+PejBxnLuGXQrUrwy9xSu/fmwBDQEwrAoGijT4IE7qBZD+n
         XLU7xXFCGh8nK73yj10fE78bmrkoQ6qUveDke7dRPRsz0mS67W/L1LRxonHEtbYTTGgW
         xecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=cwkvesNh91N/NjeuKCfPqkvSTLdxkQog1wawInnHep0=;
        b=FufdSFyWsWFB56ifXW4AZo0xofa6njTp73RpA9j5e0GrcDrmByHcSBgdA9MSDv6pO7
         +wJcIcHsHpgOUJ6IP4sE3V6gpWaKwByntEPWABmUSF/TnxpyCnclAG15pwFlvwrE5fyv
         LhjVGLZQOOyp21qfASD6S3EKcnAFCqKB1KI9G7mpD8+AeCNBbDOoCCrwzh2UPtXQj0i+
         qCkLEH6X+p1girLU/TTPVfWrzqIjjemQUsjvd8eTpVcXbrGW+gcsdpmjHsx+lqAddbyp
         JdwoP6rsDUYJFBu/CcSezPHsvNFpfcAidgEAOQCxZw82PhefD4yRVkx+TlXXKCdikQnW
         EktQ==
X-Gm-Message-State: AOPr4FUaed1xO6CrqaqnzZTCicBhl3TfWe1B4F/DTMAAH1nxNTZhbXVtLcZjrlAz7G/2BDdmzuBfDpPmUxmESg==
X-Received: by 10.107.47.41 with SMTP id j41mr11031902ioo.168.1460568794863;
 Wed, 13 Apr 2016 10:33:14 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Wed, 13 Apr 2016 10:33:14 -0700 (PDT)
In-Reply-To: <CAFZEwPMjDxFHOdbOgqXmBoud=2gmrpfiR4Aa83_7+bjka1bk4g@mail.gmail.com>
X-Google-Sender-Auth: N_4QMBUxRQdOmsGPfzTzEP9higU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291465>

On Wed, Apr 13, 2016 at 4:39 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, Apr 13, 2016 at 11:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> +test_expect_success 'OPT_COUNTUP() resets to 0 with --no- flag' '
>>> +       test-parse-options --no-verbose >output 2>output.err &&
>>> +       test_must_be_empty output.err &&
>>> +       test_cmp expect output
>>> +'
>>
>> In my v12 review, I noticed that neither --no-verbose nor --no-quiet
>> was being tested by t0040 (which is conceptually independent of the
>> OPT__COUNTUP change) and suggested[3] that you add a new patch to
>> address that shortcoming. This idea was followed up by [1] saying that
>> this test (here) could then be dropped since the case it checks would
>> already be covered by the new patch. My impression was that you
>> agreed[4] that that made sense, however, this test is still here. Did
>> I misunderstand your response[4]?
>>
>> [1]: http://article.gmane.org/gmane.comp.version-control.git/290662
>> [2]: http://article.gmane.org/gmane.comp.version-control.git/289991
>> [3]: http://article.gmane.org/gmane.comp.version-control.git/290655
>> [4]: http://article.gmane.org/gmane.comp.version-control.git/290787
>
> I actually did include the tests in the patch 3/6[1]. I mentioned in
> my response[2] that I will include the tests between 2/5 and 3/5.
> Since, after that no email was exchanged, I thought you agreed.

I'm not sure that I understand what you are saying since the
--no-verbose test does not seem to be included in the patch you cite
(it is instead in the present patch under discussion).

Perhaps there is some miscommunication and misunderstanding.

> [1]: http://article.gmane.org/gmane.comp.version-control.git/291310
> [2]:http://article.gmane.org/gmane.comp.version-control.git/290787
