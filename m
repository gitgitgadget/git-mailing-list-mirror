From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] sha1_name: fix error message for @{<N>}, @{<date>}
Date: Wed, 22 May 2013 16:39:54 -0400
Message-ID: <CAPig+cQwcNxvvXZ_PFtUZ3HnH5tdpsL8RLQ02dTDz37y0XpJhg@mail.gmail.com>
References: <1369219195-20096-1-git-send-email-artagnon@gmail.com>
	<1369219195-20096-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 22:40:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfFpI-0002vd-Ce
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 22:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110Ab3EVUj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 16:39:57 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:58567 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757056Ab3EVUj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 16:39:56 -0400
Received: by mail-la0-f51.google.com with SMTP id lx15so2474908lab.38
        for <git@vger.kernel.org>; Wed, 22 May 2013 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=D9qx2DAwuPxm4TKIVaw2WLK581+WnCq5FwuJzH6lokA=;
        b=ULSDLlFu+iq3PkJhjUrxL1h30aG97KQ8LRb2jpT7m2Gj5czs2dXg+gvY/OI1Cf7hGt
         AQLYIZquwjDlGaKQjeyHCA8jbBY929RpIiFd2bBEBKDcyO48hJkvhD7JMM/hVhziBHty
         nal+Wg/G1g2+6TfVUzsR8RK6brwS1savVrbAPiIw7JXXOfHul7KluozcB437+ZJ3M2Je
         wB6Mf078yp7xXcBJspf5zcDOI8I2STB9kQEKf19prBAQqR33cRuxy11oZIJcLzxTc1lr
         PoJdV7xN+gsASvrPNH2BXH8irCdXNN6BP8pvQBOVLt7PpvOrH+Wq7qOfsdzdt4r7lSpm
         tPBw==
X-Received: by 10.112.145.100 with SMTP id st4mr4878680lbb.102.1369255194229;
 Wed, 22 May 2013 13:39:54 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Wed, 22 May 2013 13:39:54 -0700 (PDT)
In-Reply-To: <1369219195-20096-3-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: pIjrK0IbbStsKFMMEDdF86AYOzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225191>

On Wed, May 22, 2013 at 6:39 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Currently, when we try to resolve @{<N>} or @{<date>} when the reflog
> doesn't go back far enough, we get errors like:
>
>   # on branch master
>   $ git show @{10000}
>   fatal: Log for '' only has 7 entries.
>
>   $ git show @{10000.days.ago}
>   warning: Log for '' only goes back to Tue, 21 May 2013 14:14:45 +0530.
>   ...
>
>   # detached HEAD case
>   $ git show @{10000}
>   fatal: Log for '' only has 2005 entries.
>
>   $ git show master@{10000}
>   fatal: Log for 'master' only has 7 entries.
>
> The empty string '' is ugly, inconsistent, and failing to convey

s/failing/fails/

> information about whose logs we are inspecting.  Change this so that we
> get:
>
>   # on branch master
>   $ git show @{10000}
>   fatal: Log for 'master' only has 7 entries.
>
>   $ git show @{10000.days.ago}
>   warning: Log for 'master' only goes back to Tue, 21 May 2013 14:14:45 +0530.
>   ...
>
>   # detached HEAD case
>   $ git show @{10000}
>   fatal: Log for 'HEAD' only has 2005 entries.
>
>   $ git show master@{10000}
>   fatal: Log for 'master' only has 7 entries.
>
> Simple, consistent, and informative; suitable for output even from
> plumbing commands like rev-parse.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
