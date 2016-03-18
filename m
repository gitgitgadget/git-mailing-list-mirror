From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Fri, 18 Mar 2016 13:28:01 +0700
Message-ID: <CACsJy8CrXFUPqJz4kt6fsvFhGDavOfZBQtHD98FuEW14UMmMtg@mail.gmail.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
 <1458219254-16343-1-git-send-email-pclouds@gmail.com> <xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com>
 <56EB8961.70302@fb.com> <CACsJy8A2FKn-8nWtK4QPMHDCDYvTZBrQs1RVMApnuejXQis19g@mail.gmail.com>
 <56EB9E67.1000306@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mateusz Jakub Kwapich <mitrandir@fb.com>
To: Durham Goode <durham@fb.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 07:28:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agntm-0001eX-IC
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 07:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbcCRG2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 02:28:35 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34416 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbcCRG2d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 02:28:33 -0400
Received: by mail-lb0-f182.google.com with SMTP id k12so82037383lbb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 23:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CtYGKYMByqWk/55K2XNGsBLyJYmOr5T8MDW9+XF+5UU=;
        b=ZdvsFhso3uBlr9j3uflA6nWxW2wIWYY4EQ8vYyKqapvIeB63rlyatJ2XmZpUTB3Mj7
         7PtMj4huippxSNvhuE1/ARQ7hXvuZ/ip+DNpbDhgbRL3ef7p+cDEaSPOQV/VtoxamzL+
         QLO521huj0c77o93TCJJEZ1FUcUdC5I//mLCgqXqKqhBAE3sGc7pnJhTocwg+DWpheP6
         6DfhT1DyvrzmfALKhys27G1bmgW5EE8gkVNzF53l+QXD9Y2zczNvQjoEEYHnu4JtXSvc
         ABKMn9bd648430lbgYQ+V/JF+0kzV6d+h6SuJuozc+sqQpsMsZmb0xqgZNF9KRZHxDQu
         Kmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CtYGKYMByqWk/55K2XNGsBLyJYmOr5T8MDW9+XF+5UU=;
        b=RkS4fk49CWTVX61ev4OHo3+1pVFkaNtRsIq8bcy4ODIlr0cDKZS8Lj/lSSYfqy03O7
         5vVs/CnWih2UE8ZfaJJNA5D7deoAFBftiGSHWjmg5Mi8Df4kilv79QqFR3Ca+z/1KreO
         Kmbprf0+rDB3lvL8d+rM4guK4LmCT/tPHym15Cqb5GLwSB2m1E/9iUsFIC2NRKScCc4+
         yYiMWoBrRIZjoIh8JBLQXBIiErbOflEzOjg0IeBiicw9zB1SOxhPhwmMwHy4FfpfVzno
         wyfyFu8GAbJkoT0dy65s8sk2D4byHGULcPOIu4DM1dsf8OvHNpebU052Q+VnP80RJH5O
         S6pA==
X-Gm-Message-State: AD7BkJIpLVo41hSUv70N1H7cnCc4UULQFOyAOQrsMzsy5gUplm8FimnTNRrnil13LZzk+ryVJpfnX9S6KjwPOQ==
X-Received: by 10.112.130.41 with SMTP id ob9mr4972424lbb.81.1458282511369;
 Thu, 17 Mar 2016 23:28:31 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 23:28:01 -0700 (PDT)
In-Reply-To: <56EB9E67.1000306@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289204>

On Fri, Mar 18, 2016 at 1:21 PM, Durham Goode <durham@fb.com> wrote:
>> Skipping that tricky pair, the pairs "/*" and "!/dir1/dir2/" means
>> "exclude everything except dir1/dir2" (in .gitignore sense) or
>> "include everything except dir1/dir2" in sparse checkout sense. Which
>> results in empty worktree. 1+2 trips when the trailing slash in the
>> last rule exists and includes both files in show/hide. Patch 3/2 fixes
>> the tripping and exclude both. If the last rule is "!/dir1/dir2" then
>> 1+2 results in empty worktree as well.
>>
> I'm not sure I fully understand.  Here's what I'm seeing, with patch 1, 2,
> and 3 applied:  with patterns "/*', "!/dir1/dir2", "/dir1/dir2/show", I see
> the contents of dir1/dir2/show/ (good). If I add a trailing slash to the
> last pattern (so it becomes "/dir1/dir2/show/"), it now results in an empty
> working copy. That seems funky, given that the last rule is to include that
> directory. Am I misunderstanding the trailing slash?

Ah.. I meant the last slash in !dir1/dir2/, not in dir1/dir2/show. But
that's interesting, will need to run some more tests.

> We're pretty far beyond my ability to understand ignore patterns now.

I'm right there with you. I'm starting to fear that I don't (and
probably won't) understand this thing.
-- 
Duy
