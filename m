From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/10] git submodule update: Redirect any output to stderr
Date: Thu, 17 Sep 2015 16:31:48 -0400
Message-ID: <CAPig+cT=vTJvwRkqdHw6w04HYbZM7dsUvZ0pzy9Ppe_2n-2bbg@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 22:39:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcfy5-0006x7-S7
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 22:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbbIQUjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 16:39:42 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33895 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbbIQUjl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 16:39:41 -0400
Received: by vkhf67 with SMTP id f67so18445403vkh.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IY2BsKVKoYWvwg1lwotdcxq+jG/WIc6uPe4ZUDlCogQ=;
        b=K4P0GiPEYnP2Jkr2il2O3UmJNYfpF/JP7fxiKIkp7zF1iZ/+KJHK0du9wk8gqiP/iK
         s0g5ZTE0e6XvHQeJY/zZtkrD7VS3C/5hKx3R/jD7Taux+7E7TFbdUoyzYttZTPt/leTn
         qwF8VvaP3GOsgO4X9TOY2He8LtnKFmymthLPJUAJ/HKqoOZilx8S4iDjZr+E55d47mgd
         86RyajCHADMRnWYwpnPq3+rBn3UCiID4boaZS3K/no9HD6+amfqIpvxmbwMrhg87QRdb
         ZQxwzSYVUGVj6x5nzxVTiF4LBNpUR6iaH1GozYPoBxhzWOnljgTkERm/kAk9Py0YzFFy
         J9Ew==
X-Received: by 10.31.56.193 with SMTP id f184mr1177312vka.115.1442521908122;
 Thu, 17 Sep 2015 13:31:48 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Thu, 17 Sep 2015 13:31:48 -0700 (PDT)
In-Reply-To: <1442453948-9885-7-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: RWPdTtGNsTBkPH3c24d-dM07MAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278168>

On Wed, Sep 16, 2015 at 9:39 PM, Stefan Beller <sbeller@google.com> wrote:
> git submodule update: Redirect any output to stderr

This commit message seems to be lacking an explanation of why this is
being done.

> There are no tests, which fail by this.

Not sure what this means. I suppose you're trying to say that this
patch doesn't break any existing tests, but isn't that an implied goal
of all patches posted to this list?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8b0eb9a..7ef3247 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -663,7 +663,7 @@ cmd_update()
>                 die_if_unmatched "$mode"
>                 if test "$stage" = U
>                 then
> -                       echo >&2 "Skipping unmerged submodule $prefix$sm_path"
> +                       say >&2 "Skipping unmerged submodule $prefix$sm_path"
>                         continue
>                 fi
>                 name=$(git submodule--helper name "$sm_path") || exit
> @@ -684,7 +684,7 @@ cmd_update()
>
>                 if test "$update_module" = "none"
>                 then
> -                       echo "Skipping submodule '$displaypath'"
> +                       say >&2 "Skipping submodule '$displaypath'"

These changes seem to be doing more than what the commit message
claims. The changed code isn't just redirecting to stderr, but is also
now respecting $GIT_QUIET.

>                         continue
>                 fi
>
> --
> 2.6.0.rc0.131.gf624c3d
