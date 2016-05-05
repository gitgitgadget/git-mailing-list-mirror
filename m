From: Stefan Beller <sbeller@google.com>
Subject: Re: Submodule's .git file contains absolute path when created using
 'git clone --recursive'
Date: Thu, 5 May 2016 10:22:09 -0700
Message-ID: <CAGZ79kYmh9wtzXdThzPTdEZ5SsKznYxze6EvmbaZdGog4yydNA@mail.gmail.com>
References: <loom.20160505T140253-275@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Loet Avramson <loet@forter.com>
X-From: git-owner@vger.kernel.org Thu May 05 19:22:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayMyd-0006oP-BA
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 19:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbcEERWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 13:22:11 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34235 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbcEERWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 13:22:10 -0400
Received: by mail-io0-f175.google.com with SMTP id 190so91297251iow.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=H6tehFh8N4n3DcCkWQiWGKkkB99xVChT9Wr5iy6tvOo=;
        b=jcVD4FQHTkz/sTuxtvGktEl61oCgzJ5OYys9oNFwweyqrOrdCmQR8yVvxQ4hdlxTZL
         6vzsIwviLYjGAkEGFG3X9l2OMRp6bSJ4TJxFpaJlxYktMX7iIKFaCtGtSZ0wvNJf1wNQ
         T6moTDHeXAaAI1Ah/laoow34wFRrsAY4sienu9uLyM6UMknoEE0A95KlvDhIkNKicxBx
         bvrEtVJZDmH0IaF6SEH01HfRLYrHHB33gLfmBG7VL165WXksEG16Mr8pEvDsFU0MXuFJ
         Ub9fg45wIbgzsFusFW5L3/HVS0US+ikQQ0FUmU6rmo9eQLmtqX1W56627lWlWIno/yHx
         DRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=H6tehFh8N4n3DcCkWQiWGKkkB99xVChT9Wr5iy6tvOo=;
        b=EKb1hYJynycGVCODZ5XcyEKH966rIro/t7cheJbYLDY5Symc/HOY4k9AcyrM/YrwVi
         i36jJDKdk/kqt5lV0mHtxv5rOynro43Y47JEBaQZsVCvWpyoauQbkGsM8iC6CBZt1kes
         iK2AXNPLG/xceea5etdcjpZdUXeYqMbYD/CXNMr3h6ArYF+ZlIv4SfzDSuCmtRVsPvQ+
         THAMSgnh/Eg2rE6Uuv6s4NDis3I+MDJb80eoR/9wKH/lWC/RC2C5vfwf5wYZmsn5EodU
         j6gZ/aVOmSgPs8yrzbWmMq3MC/Ns5wxiTNz9IRzZfnqM2WgbLsB4woCYIsmBTCsmS2Np
         NbZA==
X-Gm-Message-State: AOPr4FX6ewWcdLV3sVkxym2kXiQ1MSjF5Yk0sXm2TaJjVdaV2I/MQF4oB40CYzLdNEHWOFlDVEVGN57ivzGtdnUC
X-Received: by 10.107.174.205 with SMTP id n74mr18485897ioo.96.1462468929520;
 Thu, 05 May 2016 10:22:09 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 10:22:09 -0700 (PDT)
In-Reply-To: <loom.20160505T140253-275@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293654>

On Thu, May 5, 2016 at 5:51 AM, Loet Avramson <loet@forter.com> wrote:
> Hi,
>
> According to git-clone man page - running 'git clone --recursive' "...is
> equivalent to running 'git submodule update --init --recursive' immediately
> after the clone is finished...", though I found a little difference between
> the two regarding the submodule's .git file:
>
> 1. Running 'git clone' and 'git submodule update --init --recursive'
> separately will create the .git file in each submodule containing a relative
> path to the superproject's .git directory as expected.
>
> 2. Running 'git clone --recursive' will create the .git file containing an
> *absolute* path to the superproject's .git directory. (as it was expected
> using git versions 1.7.8 - 1.7.10 as far as I understand)
>
> Not sure if that's a bug but it got stuff behaving really weird in a specific
> usecase on one of our environments. It would be highly appreciated to update
> the docs at least.

Which version of Git are you using?

See[1] for how clone handles submodules. (It's a call to submodule
update --init --recursive)

There was a bug with recursive submodules in the 2.7 time frame and
that got fixed in [2].

So could you make sure your version of Git contains these fixes?



[1] https://kernel.googlesource.com/pub/scm/git/git/+/master/builtin/clone.c#734
[2] https://kernel.googlesource.com/pub/scm/git/git/+/7307dd898988c79fc687051e783b3cac8488a559
specially https://kernel.googlesource.com/pub/scm/git/git/+/f8eaa0ba98b3bd9cb9035eba184a2d9806d30b27



>
> Thanks.
>
>  -Loet
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
