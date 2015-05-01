From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 02/18] is_refname_available(): explain the reason for an
 early exit
Date: Fri, 1 May 2015 10:21:26 -0700
Message-ID: <CAGZ79kZDCMj1P1H3+LiW-Lk8S8TS91yJ_G4scmVSvg++3n7dvw@mail.gmail.com>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
	<1430483158-14349-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 01 19:21:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoEd1-0004q9-CE
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 19:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbbEARV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 13:21:27 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36539 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbEARV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 13:21:26 -0400
Received: by igblo3 with SMTP id lo3so43363534igb.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m39GpRXZ6/t+F5smu3oZuHoBn6xZeIfl53+DpZRop0U=;
        b=oNYdj4LYyXAUyyUITLkNOejmNYPYJEPoi6RnFPS2Ko0KTl/q+nCpgqeSpVV23wLj7J
         FHGGk7H60AoQ0Z4eAa2jdi4+IX96aFWs0ZZXdqRqP1rN4hOb5395n5b2FwF6c5UyZPGA
         8VpojindNY9HS3Ckoj5RUTu0+My8K3ztjvuk6GOzCmSWzNFTK9CfscVH/FyGB4/1XnMB
         w5qfCLkD4itqJzJb5N+uIwtdCBGvhjIcw0GDh23BCGA4f/rpgGuTaINVSYWhVeCqnBHH
         c8DNZdPqkSGKbkX8AEUO90mBkepX2DDAV73ziJTPiTiL0oK786ovLoF4rRcE0T5Zs3oX
         AFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=m39GpRXZ6/t+F5smu3oZuHoBn6xZeIfl53+DpZRop0U=;
        b=E7K6BZoeqJOOM2afYpbLI17LuRLpWXaQoGuDQltTw5A7Nv+c9E2xkgruca0qxYS6H5
         DJM9swjTOrvxmPCgiP0FEN7YA7r+VSadQOOQOkY/sAec7tlKgSs5dANT0PJyyBL6DQiT
         lwWco9ylb6EfN/UNoFv4hiuyGeegvuYym0Xi8IGkHmVV1uKy5AX8UWnvxvz/obvHCvNq
         7zDmc8iSg4bgq6K9abQFsCO8zKnxj3G/MbaPn2hzSRanIJI5S0LBAZYSVPTydvSmsqHH
         hi3JCijWnraSbogLFQh/TjZm9B/f966roxYDGCaM0j9qFJQv6B3Kww8jBLbT/wEQa1mu
         ylyA==
X-Gm-Message-State: ALoCoQm1Y7za9gIW8bGVwDWd6i6DYFS1HzwWD07sNCUm4xmHd7uOiJ2kgufi5sG+6zSgtCtmu9oW
X-Received: by 10.107.132.223 with SMTP id o92mr13697348ioi.49.1430500886176;
 Fri, 01 May 2015 10:21:26 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 1 May 2015 10:21:26 -0700 (PDT)
In-Reply-To: <1430483158-14349-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268161>

On Fri, May 1, 2015 at 5:25 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> The reason why we can exit early if we find a reference in skip whose
> name is a prefix of refname is a bit subtle, so explain it in a
> comment.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 2bdd93c..ab438a5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -907,8 +907,20 @@ static int is_refname_available(const char *refname,
>                 pos = search_ref_dir(dir, refname, slash - refname);
>                 if (pos >= 0) {
>                         struct ref_entry *entry = dir->entries[pos];
> -                       if (entry_matches(entry, skip))
> +                       if (entry_matches(entry, skip)) {
> +                               /*
> +                                * The fact that entry is a ref whose
> +                                * name is a prefix of refname means
> +                                * that there cannot be any other ref
> +                                * whose name starts with that prefix
> +                                * (because it would have been a D/F
> +                                * conflict with entry). So, since we
> +                                * don't care about entry (because it
> +                                * is in skip), we can stop looking
> +                                * now and return true.

At first I thought this is not true, what about:
refs/heads/foo
refs/heads/foobar
They go well together and one is a prefix of the other.
What is crucial is the existence of a '/' just between the
prefix and the ending part, so
refs/heads/foo/bar doesn't fly here.

The assumption may be the case if the prefix itself always
ends with a /, which is probably the case here?
I don't know if that is worth noting as well.

> +                                */
>                                 return 1;
> +                       }
>                         report_refname_conflict(entry, refname);
>                         return 0;
>                 }
> --
> 2.1.4
>
