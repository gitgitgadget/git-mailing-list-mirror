From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] rev-parse: fix --git-common-dir when executed from
 subpath of main tree
Date: Thu, 19 May 2016 10:15:49 -0400
Message-ID: <CANoM8SUDVtGa12i2LXor6-bEwgH100zztYFR5mmQbs4z-5K4tg@mail.gmail.com>
References: <1459734143-95832-1-git-send-email-rappazzo@gmail.com>
 <CACsJy8CgNy8+s0j+UUVVDk1ru702mtkTrO6QsYNpisGY-eAYGw@mail.gmail.com>
 <CANoM8SWCiJch-nXq=-=ELKOc6tV-TNg6U-hcc9W69Fz4rz+j+g@mail.gmail.com> <20160519074939.GA22796@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu May 19 16:16:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3OkK-0005rW-Na
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 16:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbcESOQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 10:16:12 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36159 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbcESOQK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 10:16:10 -0400
Received: by mail-io0-f172.google.com with SMTP id i75so108703223ioa.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CQubids2o//HeBwlHjAS/dq5cROyIC7yQq+ii5mpoS8=;
        b=xqvfqp0YnCbg5Ucgyj6ROGdXQAuCmcSoR40TdSSe0v7fIIENtU40tkNhtnakMfErZD
         DMELq7HoKapIb7Mzs7JANWH9vawnrJlISc+N87ElirLXK6V35p5Ohnpn/8N+u3p0nT+Z
         j4Xpk4IHWXCTKRrNcgfidWm0PuCmn1nmMSd4fnrVPybskhExs1MuxFaJME0HFYj3TOmV
         RfHRYkvG0XzLOptmBnsenw3f9uFfD1x6wYBnFKqydAHw0LpA2ei+4EMVSiUwk37ZflCu
         UhAZIEx+eAq/SXNJEqgvcADdd7zZu5QyIydgHZcebT0cQATJTmjbmI4+cbxwfz9QD3SZ
         VEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CQubids2o//HeBwlHjAS/dq5cROyIC7yQq+ii5mpoS8=;
        b=J9fVgVwDDkPov+y9lmUDxy3u97KLURFFoLB3Xq1M1NFvJ6okVbhoKL+Nt2KN/PjBQW
         t2Vz8dIZpr/Nt9cZlJXPkoshFfgXS5CY5E5uVitCpdSO4dlf9JpDjCHHCS3PorbLdIKg
         dndMYwOOsbcewDdGdKX0gl/SniMKavHR9fVlOmSvGq9+Dopfn/Crip3se8XIP0QNqqec
         m1LLnVSc+AOsKHOkBA9DQrFMvt9GjugqKwUN5imtYRa7lvkSKk9KHL0Eso+qayi2rWJh
         PMteWfWsVaDfSruQQB25MHzqjbSf8kzJqR/RLdM7eGZXeWErpdz9biPkdkcaBKLuVbUw
         qWyw==
X-Gm-Message-State: AOPr4FVbW2u6F3JfWaGrsl9N16nEIBkjePQgjfAqhKqpLg17murq4AVBOlFOBSob0w9ol/jmFMIzmKE+nacidA==
X-Received: by 10.107.11.213 with SMTP id 82mr3755139iol.55.1463667369097;
 Thu, 19 May 2016 07:16:09 -0700 (PDT)
Received: by 10.107.7.220 with HTTP; Thu, 19 May 2016 07:15:49 -0700 (PDT)
In-Reply-To: <20160519074939.GA22796@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295063>

On Thu, May 19, 2016 at 3:49 AM, Mike Hommey <mh@glandium.org> wrote:
> On Fri, Apr 08, 2016 at 08:35:51AM -0400, Mike Rappazzo wrote:
>> On Fri, Apr 8, 2016 at 7:47 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> > On Mon, Apr 4, 2016 at 8:42 AM, Michael Rappazzo <rappazzo@gmail.com> wrote:
>> >> Executing `git-rev-parse --git-common-dir` from the root of the main
>> >> worktree results in '.git', which is the relative path to the git dir.
>> >> When executed from a subpath of the main tree it returned somthing like:
>> >> 'sub/path/.git'.  Change this to return the proper relative path to the
>> >> git directory (similar to `--show-cdup`).
>> >
>> > I faced a similar problem just a couple days ago, I expected "git
>> > rev-parse --git-path" to return a path relative to cwd too, but it
>> > returned relative to git dir. The same solution (or Eric's, which is
>> > cleaner in my opinion) applies. --shared-index-path also does
>> > puts(git_path(... and has the same problem. Do you want to fix them
>> > too?
>>
>> Sure, I can do that.  I will try to get it up soon.
>
> If I'm not mistaken, it looks like this fell off your radar. (I haven't
> seen an updated patch, and it doesn't look like the fix made it to any
> git branch). Would you mind updating?
>
> Cheers,
>
> Mike

There is a newer version submitted on May 6th[1].  Eric Sunshine has
submitted a patch [2] which fixes
up t1500.  It looks like that is in a stable form, so I will rebase my
v2 onto those changes, and resubmit
in the near future.

[1] http://thread.gmane.org/gmane.comp.version-control.git/293778
[2] http://thread.gmane.org/gmane.comp.version-control.git/294999
