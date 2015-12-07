From: David Ware <davidw@realtimegenomics.com>
Subject: Re: git subtree bug produces divergent descendants
Date: Tue, 8 Dec 2015 10:01:32 +1300
Message-ID: <CAET=KiXHoasXv6_y=SLZEAd=CCzj0T3zW6Wb7rF42=8v2LxZ+w@mail.gmail.com>
References: <CAET=KiVXh2UZwRSpM_+wX_QpfjBsyfdPPUVDSDoCRVe_0wbhCg@mail.gmail.com>
	<20151207045307.GA624@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:01:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a62ug-00084y-0F
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 22:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933109AbbLGVBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 16:01:34 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35758 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813AbbLGVBd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 16:01:33 -0500
Received: by vkha189 with SMTP id a189so110243972vkh.2
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tmVZ2oFycWHSQf28GQ/A9xGBqDmRp3VzRtsxbct7Vjc=;
        b=RDH3QD3UU84L6RPQzv+TNvlvbR2C4on7ya5LcOEQMy+cfP/RCaOh9hMgGhNFNfv8pM
         IO2G7+O9pZZCkHh4Eu5CUYwTlz56swHDtUOxfYLW0i3VFjWwhNdeJDDoGYydevYqoYIy
         KZqSHje6ar4PVBLY8kZ787P3lrF5u1TY2m03i1/lFLpA6Mu5Uu027vDjgtaAvy99kHA1
         Q/0EdvRW+N+ODluLadkA4mVFMfnsFaAof5TBx/anAqOC/Q20KpIkDRfiWE2DJtX0+BHl
         G1+5spDTouCA19q8fzyTJqKh4tfdRDczBwFmt9e1mX6DzuPmKb58zJHs2bJOfLwDJRwA
         zQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tmVZ2oFycWHSQf28GQ/A9xGBqDmRp3VzRtsxbct7Vjc=;
        b=j6eigkOPj7UPAWLuFreylyqVFrD9hdh0HpwypjFhsP2GGt0WrdxERLz6tcy+jOk6Tm
         thpwtnJYGPljuXg+VBakbEXFlNbzMdqOv+gKA15JHpPVsdnBVa5RNLNXdIWT9eNZnXsn
         oWc14t2BhLasUHklCJ+XH5GiNBURdPDZOj8NyUvdfZuywugVS0bFV+0hNaxK24MTSzDY
         zQ0QsKuAGvJd0GpiXIUckyYp15WjIvgUpuwgr64VuS27UJlsPYX5Rp3C6SLIwsMu/855
         ekhTogf8yucmsOMTqAgBs6iJZrm8ytW+0bNaIwapfe/EYAATFgF7MV9QgXXi8aKTENH3
         /G5A==
X-Gm-Message-State: ALoCoQn7fGS3/3Ht+9NUA82DqFdCoMlsIAArmFv5+yMfpCAfQK5wq2H5wNUkeXZJXy0blphzwskd
X-Received: by 10.31.167.216 with SMTP id q207mr9118523vke.79.1449522092302;
 Mon, 07 Dec 2015 13:01:32 -0800 (PST)
Received: by 10.31.236.4 with HTTP; Mon, 7 Dec 2015 13:01:32 -0800 (PST)
In-Reply-To: <20151207045307.GA624@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282123>

Thanks for taking the time to look over it. I'm not familiar with the
process here.

On Mon, Dec 7, 2015 at 5:53 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Tests don't automatically return to the directory prior to the 'cd',
> so when this test ends, the current directory will still be
> 'git_subtree_split_check'. If someone later adds a test following
> this one, that test will execute within 'git_subtree_split_check',
> which might not be expected by the test writer.
>
> To ensure that the prior working directory is restored at the end of
> the test (regardless of success or failure), tests typically employ a
> subshell using this idiom:
>
>     mkdir foo &&
>     (
>         cd foo &&
>         ... &&
>         ...
>     )
>

I'm not at all familiar with this test harness so I had a few problems
here (like this, and the bash variable). Thank you for the advice.

Cheers,
Dave Ware
