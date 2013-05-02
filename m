From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] sha1_name: reorganize get_sha1_basic()
Date: Thu, 2 May 2013 14:59:29 -0500
Message-ID: <CAMP44s3-TM1PW6qKAFRf=Sdojw3RNscM_VJZfBy3C7xHZst_Wg@mail.gmail.com>
References: <CALkWK0=1qxWWRT9ic_4uVg_ZF_5T0_ogpWwTHotqxWqsi9GOnA@mail.gmail.com>
	<1367524078-13266-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 21:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXzfF-0005Uq-IV
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 21:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761277Ab3EBT7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 15:59:33 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:43716 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760731Ab3EBT7c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 15:59:32 -0400
Received: by mail-lb0-f176.google.com with SMTP id v20so914299lbc.35
        for <git@vger.kernel.org>; Thu, 02 May 2013 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RcfTGUiYEOUZ4HUcYjjppPb3Ntd8M7C1awcN7UPyRfE=;
        b=irZnQBNn+4Wi9H+Odey6lxCO2aimJUlpD9MwyqCVNWKVO+fs7ObpdFy7Sfji7H1Dm/
         7KgnEuQvxu7ZqBZNQhwD464OylgLiDTqDsob+uQGTWbqvawYMLrpaB259eOEm0cjN+8T
         eIeoQLXjuZxO5w70+hjhMV4WwzkHFKOSoX1Bi11i9M1IooyKRn7oHCWgKVWKgERABMs1
         b9pDr8xXnWEl2wKYgCh/LhO8x8EhBYhiX9sp0qmxUxbB90Kteg61I1uoFQMEqnwRuvRp
         kgwgkY2dqHqtUKYUlku0v7H+PLSelycmYn6LmmJalBNG9aNGzPZrPORp1Uub/3qbYJIY
         4Tgw==
X-Received: by 10.152.22.168 with SMTP id e8mr3081736laf.20.1367524769622;
 Thu, 02 May 2013 12:59:29 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 12:59:29 -0700 (PDT)
In-Reply-To: <1367524078-13266-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223258>

On Thu, May 2, 2013 at 2:47 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> A small suggestion.  Squash this in if you like; optionally submit it
> as a separate part.
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 6428001..109ab41 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -448,11 +448,12 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         if (len && str[len-1] == '}') {
>                 for (at = len-2; at >= 0; at--) {
>                         if (str[at] == '@' && str[at+1] == '{') {
> -                               if (at == 0 && str[2] == '-') {
> -                                       nth_prior = 1;
> -                                       continue;
> -                               }
> -                               if (!upstream_mark(str + at, len - at)) {
> +                               if (str[at+2] == '-') {
> +                                       if (at != 0)
> +                                               return -1;
> +                                       else
> +                                               nth_prior = 1;
> +                               } else if (!upstream_mark(str + at, len - at)) {

Generally I don't like this style, it's prone to multiple indentation levels.

                        if (str[at] == '@' && str[at+1] == '{') {
-                               if (at == 0 && str[2] == '-') {
+                               if (str[at+2] == '-') {
+                                       if (at != 0)
+                                               /* @{-N} not at start */
+                                               return -1;
                                        nth_prior = 1;
                                        continue;
                                }

Otherwise makes sense, but I would do it as a separate patch.

-- 
Felipe Contreras
