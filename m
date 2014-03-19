From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] [GSoC] diff: rename read_directory()
Date: Wed, 19 Mar 2014 04:12:55 -0400
Message-ID: <CAPig+cQ+9WNoNU54DHE-GnHQ=BCix9Efm+O_jP+a6mFL_yvmxg@mail.gmail.com>
References: <1395210578-1532-1-git-send-email-ba.bourn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Brian Bourn <ba.bourn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 09:13:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQBcn-0007u3-NL
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 09:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbaCSINN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 04:13:13 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:56732 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348AbaCSIM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 04:12:56 -0400
Received: by mail-yk0-f172.google.com with SMTP id 200so22273122ykr.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/LPp2maA2KcmAq53nJAB+2d0gHJBc0DbWUvBQ+OGVx0=;
        b=d3xpuQHR2G0w/Q79FQ1Yp739W5xtXStVf/P13myUpdPxYW2ljotP9FifLHYc28raQ4
         lipWfPnB9PbHXcn+Z01ITkctA0ZgG58AGf0scHCHadf+tE83WiF7ZszpPZi6vftE0JEU
         HKpOv0Mk6eNoDkawFz/dGIpS7hgyyEmpgFaY9j5sxHs8iWJdHD39vgD0kxcqVOcZsX4/
         BqOEUXRzYWKecRKslS+uOppWi39aZMVzeNjJE3Li0ls4FxE6D8kucXBmdaniJThLaeC+
         WqvWScKYBGpxbyqLGwWxJJiYSLp3Qze62EK03RiuNOumwoY1ltQZvwHaKnwxjF7vHvtN
         WZOg==
X-Received: by 10.236.229.130 with SMTP id h2mr24487533yhq.68.1395216775586;
 Wed, 19 Mar 2014 01:12:55 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 19 Mar 2014 01:12:55 -0700 (PDT)
In-Reply-To: <1395210578-1532-1-git-send-email-ba.bourn@gmail.com>
X-Google-Sender-Auth: b2MMfjHid0QvzIRuKWMDNrdOMFY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244418>

On Wed, Mar 19, 2014 at 2:29 AM, Brian Bourn <ba.bourn@gmail.com> wrote:
> Subject: diff: rename read_directory()

I think you mean "diff-no-index" rather than "diff".

> From: Brian Bourn <ba.bourn@gmail.com>

Unless this is intentionally different from the address from which you
sent the email, you shouldn't include it here. "git am" will
automatically pick up your name and address directly from the email
header when applying your patch.

> It is desirable to replace manual checking of "." or ".."
> in diff-no-index.c with is_dot_or_dotdot(), which is defined
> in dir.h. However, dir.h declares a read_directory which conflicts
> with a (different) static read_directory() defined in
> in diff-no-index.c. As a preparatory step, rename the local
> read_directory() to avoid the collision

Better. Add a period at the end.

Other than these minor points, the patch looks good.

> Signed-off-by: Brian Bourn <ba.bourn@gmail.com>
> ---
> Part 1 of my GSoC submission
>  diff-no-index.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8e10bff..ec51106 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -16,7 +16,7 @@
>  #include "builtin.h"
>  #include "string-list.h"
>
> -static int read_directory(const char *path, struct string_list *list)
> +static int read_directory_contents(const char *path, struct string_list *list)
>  {
>         DIR *dir;
>         struct dirent *e;
> @@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
>                 int i1, i2, ret = 0;
>                 size_t len1 = 0, len2 = 0;
>
> -               if (name1 && read_directory(name1, &p1))
> +               if (name1 && read_directory_contents(name1, &p1))
>                         return -1;
> -               if (name2 && read_directory(name2, &p2)) {
> +               if (name2 && read_directory_contents(name2, &p2)) {
>                         string_list_clear(&p1, 0);
>                         return -1;
>                 }
> --
> 1.9.0
