From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 1/8] update-index: add untracked cache notifications
Date: Wed, 2 Dec 2015 20:16:01 +0100
Message-ID: <CACsJy8BWEQNnpoXNBWSmmm-Ff7jJ9=+D6748TMXFyospU7jt1A@mail.gmail.com>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org> <1449001899-18956-2-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:16:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4CtJ-0007Nb-Av
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 20:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbbLBTQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 14:16:33 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34721 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbbLBTQc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 14:16:32 -0500
Received: by lffu14 with SMTP id u14so63890032lff.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 11:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9wDOA4Fyk+BymIxpd1CUNcwc2QbzsZauvFEOsCwgx5c=;
        b=XRrNwGTgmn+SpO72vR3q2d7SZfpm6ut3yaNdCCELoeOLzQ3TjLATd9/hhy+CEyzTG7
         VWAIrkqU8d79js1KF0xBKSzBF7wXxFjca9u9gPkO/juIEbWPT//bp16YN0WplD/GWtEe
         kIDaYDTbCqSnuCLp9ysAg+0IJ84853Ecgv802fIz6HgUwB/+pQQcRZwzY8SmQA7OeA0q
         HoSSc58wQTKY/Vj9u4wVHb1BYTatbLJCgIBixExmMb+hvILVFczEErZJbGNL5AgVaaID
         bKt6wYcxAYeawiFfTHIvP/j1KfbzAVn0mMmXAw/lAf2vmwHxGm+LzzD/OvrfuiIeKXeq
         9QyA==
X-Received: by 10.112.134.169 with SMTP id pl9mr3886598lbb.145.1449083790982;
 Wed, 02 Dec 2015 11:16:30 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 2 Dec 2015 11:16:01 -0800 (PST)
In-Reply-To: <1449001899-18956-2-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281907>

On Tue, Dec 1, 2015 at 9:31 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Doing:
>
>   cd /tmp
>   git --git-dir=/git/somewhere/else/.git update-index --untracked-cache
>
> doesn't work how one would expect. It hardcodes "/tmp" as the directory
> that "works" into the index, so if you use the working tree, you'll
> never use the untracked cache.
>
> With this patch "git update-index --untracked-cache" tells the user in
> which directory tests are performed and in which working directory the
> untracked cache is allowed.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/update-index.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 7431938..e568acc 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -121,7 +121,7 @@ static int test_if_untracked_cache_is_supported(void)
>         if (!mkdtemp(mtime_dir.buf))
>                 die_errno("Could not make temporary directory");
>
> -       fprintf(stderr, _("Testing "));
> +       fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());

We probably should respect --verbose. I know I violated it in the first place.
-- 
Duy
