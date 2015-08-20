From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wt-status: move #include "pathspec.h" to the header
Date: Thu, 20 Aug 2015 12:05:34 -0700
Message-ID: <xmqq61497pc1.fsf@gitster.dls.corp.google.com>
References: <1440079587-26491-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 21:05:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSV9k-0000wP-9o
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 21:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbbHTTFi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 15:05:38 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36551 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbbHTTFg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 15:05:36 -0400
Received: by pawq9 with SMTP id q9so34184913paw.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 12:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=6+03vHGypaMCbJchslDl35shssLgXfPFcysWcm93ln4=;
        b=qdgPlYkmOwlAkYzjZZ2BOEXuJeQhj2RR4Uzw/mealVE7zoT9r9frvVp33B4JFhwiQp
         0ie4QUAInr1tOhZdAAJTTrvkKIfiJ0UE96kHTyUcZ4ctyMabzH4mrcnWMEEyJN4m+pKT
         QComDyN/E6VzJWYVOXmE9M+zpUZAOwm+OrU1G2V0MvN45Te/fuBxOteQm0QQdnZJZTxZ
         mOq4HvtukTGLcqaGAzNw1qfJq2UG/9h82v6IZfOWNynEDgZ+Kw6qpzjvHSGHbDHDLOcE
         xOjraBJ+iuFGATYI8DfKrLWBTPqk+OBu5GtWzspd5HGPUhN76wP6ECxSSuSvGHJuwwHz
         Z28A==
X-Received: by 10.66.219.227 with SMTP id pr3mr7430472pac.140.1440097536243;
        Thu, 20 Aug 2015 12:05:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id am4sm5169125pbd.58.2015.08.20.12.05.35
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 20 Aug 2015 12:05:35 -0700 (PDT)
In-Reply-To: <1440079587-26491-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 20 Aug 2015 16:06:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276262>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> The declaration of 'struct wt_status' requires the declararion of 'st=
ruct
> pathspec'.

I think this is fine.

I am guessing that you are saying it is wrong to force wt-status.c
to include pathspec.h before including wt-status.h; I am fine with
that.

This is a tangent, but the above is different from saying that with
a single liner test.c that has

    #include "wt-status.h"

your compilation "cc -c test.c" should succeed.  But for that goal,
direct inclusion of <stdio.h> to wt-status.h is also iffy.  We
include the system headers from git-compat-util.h because some
platforms are picky about order of inclusion of system header files
and definitions of feature test macros.

Right now, the codebase is correct only because it is NOT our goal
to guarantee that such a single-liner test.c file compiles.
Instead, everybody is instructed to #include "git-compat-util.h" as
the first thing, either directly or indirectly.

So in that sense, we should also remove that inclusion from
wt-status.h, I think.

Thanks.

> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  wt-status.c | 1 -
>  wt-status.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 717fd48d13..c327fe8128 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1,5 +1,4 @@
>  #include "cache.h"
> -#include "pathspec.h"
>  #include "wt-status.h"
>  #include "object.h"
>  #include "dir.h"
> diff --git a/wt-status.h b/wt-status.h
> index e0a99f75c7..c9b3b744e9 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -4,6 +4,7 @@
>  #include <stdio.h>
>  #include "string-list.h"
>  #include "color.h"
> +#include "pathspec.h"
> =20
>  enum color_wt_status {
>  	WT_STATUS_HEADER =3D 0,
