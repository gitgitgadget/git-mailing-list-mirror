From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 4/4] bisect--helper: `bisect_reset` shell function in C
Date: Wed, 8 Jun 2016 23:34:06 +0530
Message-ID: <CAFZEwPMs+O7r8HKZ0bVxPtT2kNWmmJi0wruR1au_C527M+Ne-g@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-4-pranit.bauva@gmail.com> <CAPig+cSsMg5HznWGiUsngpHskSDMNhauvVw5jvaJTtEtJBw+ew@mail.gmail.com>
 <CAFZEwPPC3WZR4dMphgZWK7UomAXEok-J8ZXvFR22+xDrFP=hEg@mail.gmail.com> <CAPig+cQpBcy+Sdhv7EXorJFZsYvH=ikh0PqGF1YShQEcPjMn_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:15:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhpt-0000iu-J2
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 20:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672AbcFHSEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 14:04:08 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36704 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbcFHSEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 14:04:07 -0400
Received: by mail-yw0-f177.google.com with SMTP id x189so15021736ywe.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FsrquRC4OM0XyxxI5icZGkjPtgLmhCG7Uced0qqDeg4=;
        b=M0d9I0scgRNGkh0VzWTjUPqe8EyCuwrmqEhs03shdQBLYa9XxeIxR84mefysvwuLox
         EjSdeWQzcnP0gYmHGcmR0EDgWu0UjqW/f7EhevlD/fedHyLQ4I/qaKcfIE6Mznk2Vf1Y
         G7BZt2hXWD0WIl0AKJZKd8Crz0l4b3XC/Nhm3tEBJIX0bCSS/MwHlTbL3qJp9kfRdT8M
         MhLdU0WaAi8JAJXovVhhZECspKDkKseVRsmMA9mhcLZMcPoyrlw6xv0FYP8N6ehCZ5uO
         yA1jclaMCAdkpHRZzP9U1B42go9dWUc4CUtxS5ImgnHx/n0WmhQvT8MVXEW2IUFjPzEf
         WKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FsrquRC4OM0XyxxI5icZGkjPtgLmhCG7Uced0qqDeg4=;
        b=PGGb6ihbDfwEpHYksjbFqh5pdNXc5ckj2qiZNmhhXlSmgIezlXQREbdId/l4I0y4pz
         RmfAkeepvB3a9YCj06OTe27AI2HhggEWuGb1DqXpDR1QyhVWYen2P8wJpf9Le4sIQANx
         gdNhmNK+nY0XGnS8NVaadUeeePp8cBthowGK6fIbybA5jsbdf0aVKqVSJO15jG67O+j+
         lUXzQc4x1UCdWkL4LGdfi4jPfFHGspPTSeLB5bn+uNhOdCM4HyxlMuDpu+LRFaXLjUlO
         BIOzCa8dGVwaCqWLTCJtPRV38vy/rNQ4AyXmBCBJ9UyXP/SCAOZFAjXmVmjzlCvIprR0
         iWww==
X-Gm-Message-State: ALyK8tK+yOqlBmK7OV7FPlKLndra3cU4XdkP9sVM+AA5CkVfLp8oHW6DZa0RB4LUseQI53gIIU3B2eXt3VsdDA==
X-Received: by 10.37.20.7 with SMTP id 7mr3430987ybu.21.1465409046747; Wed, 08
 Jun 2016 11:04:06 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Wed, 8 Jun 2016 11:04:06 -0700 (PDT)
In-Reply-To: <CAPig+cQpBcy+Sdhv7EXorJFZsYvH=ikh0PqGF1YShQEcPjMn_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296824>

Hey Eric,

On Wed, Jun 8, 2016 at 11:23 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 8, 2016 at 9:20 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Wed, Jun 8, 2016 at 1:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> +       if (!file_exists(git_path_bisect_head())) {
>>>> +               struct argv_array argv = ARGV_ARRAY_INIT;
>>>> +               argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
>>>> +               status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
>>>> +               argv_array_clear(&argv);
>>>> +       }
>>>> +
>>>> +       if (status) {
>>>
>>> What's the purpose of having this 'status' conditional outside of the
>>> above !file_exists() conditional, which is the only place that
>>> 'status' gets assigned. Likewise, 'status' itself could be declared
>>> within the scope of that conditional block.
>>
>> I wanted to avoid nesting. In a few other parts of the code also,
>> nesting is avoided as much as possible.
>
> I figured as much, but I'm not sure that that is such a good idea in
> this case since it makes the code more difficult to reason about. To
> wit: as a reader of the code, I spent extra time trying to figure why
> it was structured this way and if 'status' is assigned or accessed in
> some other non-obvious way.

I can put status inside the if() .

Regards,
Pranit Bauva
