From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman/inotify support and other ways to speed up git status
Date: Thu, 22 Oct 2015 09:29:57 +0200
Message-ID: <CACsJy8BjTZkeq_AhQ+3F99NW0HTK--A0z5u42Z50vz08=0VapQ@mail.gmail.com>
References: <CAP8UFD3Cd9SOh6EYwcx9hTVv7P24M5bEJRCYCT5Qgj=qPRJ8hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 09:32:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpALu-0007Gj-P8
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 09:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831AbbJVHaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 03:30:30 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33121 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbJVHa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 03:30:28 -0400
Received: by lffv3 with SMTP id v3so37642021lff.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2015 00:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hsHqSXJqCmLGhjqAetQ72ZSq3CELbF0xrg1kSwilOKM=;
        b=K/sCkZe3sdBwA1FQgS4TQyDjSSO68fNCo/fLS/+iBSxlR9ynNYwpzh7qhBa8aCn2d+
         5UTcJQxQHF1Ka4o2tZVVB2sCgVOAgFQxbVjYN4MWqsfY633S639S0a2mxEYni5A02jtO
         GMZMrkiv9p0/6f5FfM+tklZC1TE7ZTj9TOOOICJdpwEVnJY3RQJEz3ejMxdFNz27i0ov
         C1m1jVf4eIFpeLfPun13wF4FRzLEMS/+f1ZHzVLc/YxVcYD/iF6Q6m5iAmgCuQ3dtSGd
         7ryddUfW7onzAXS80cEXh507NBUikyt0apsxMbEg9UNjRvlAybSkRSIkCFMjD1soD4iJ
         ZgGw==
X-Received: by 10.112.16.67 with SMTP id e3mr7470685lbd.5.1445499026949; Thu,
 22 Oct 2015 00:30:26 -0700 (PDT)
Received: by 10.112.255.229 with HTTP; Thu, 22 Oct 2015 00:29:57 -0700 (PDT)
In-Reply-To: <CAP8UFD3Cd9SOh6EYwcx9hTVv7P24M5bEJRCYCT5Qgj=qPRJ8hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280041>

On Thu, Oct 22, 2015 at 7:59 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi everyone,
>
> I am starting to investigate ways to speed up git status and other git
> commands for Booking.com (thanks to AEvar) and I'd be happy to discuss
> the current status or be pointed to relevant documentation or mailing
> list threads.
>
> From the threads below ([0], [1], [2], [3], [4], [5], [6], [7], [8]) I
> understand that the status is roughly the following:
>
> - instead of working on inotify support it's better to work on using a
> cross platform tool like Watchman

Definitely. Especially because watchman has recently gained
(experimental?) Windows support

> - instead of working on Watchman support it is better to work first on
> caching information in the index
>
> - git update-index --untracked-cache has been developed by Duy and
> others and merged to master in May 2015 to cache untracked status in
> the index; it is still considered experimental
>
> - git index-helper has been worked on by Duy but its status is not
> clear (at least to me)

My roadmap is speeding up index write speed (split index), then read
speed (index-helper) and watchman can be run on top of the
index-helper. Untracked cache solves another performance problem with
.gitignore. All these four pieces are big and getting slowly into
git.git.

The last piece is using watchman with untracked cache to kill the
(small) last stream of lstat() calls. But we'll see if we actually
need it.

> What are the possible/planned next steps in this area? improving
> --untracked-cache? git index-helper? watchman support?

The index-helper needs some polishing and perhaps more eyeballing. I
have the watchman patch on top of it, but I don't remember if I have
ever sent it out. If anyone wants to help I can resend everything I
have. I don't think I can resume the work soon.
-- 
Duy
