From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Do not make trace.c/getnanotime an inlined function
Date: Mon, 29 Sep 2014 19:44:20 +0700
Message-ID: <CACsJy8ArOU7WF4fiy5vn8zq5y6Vm5JxgTf+Tiai_WOeMSj--Ug@mail.gmail.com>
References: <1411890626-28237-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 14:44:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYaJz-0002tz-Im
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 14:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbaI2Mov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 08:44:51 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:65223 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbaI2Mov (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 08:44:51 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so1626164yhl.34
        for <git@vger.kernel.org>; Mon, 29 Sep 2014 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r+3lOysKf2TC+IyqEW1F7tQ5YpXsnZ0dvRM6M5NF4F4=;
        b=R/J+PcSbx8EL3P/A4th3gH8sHlb1JC/utwwoCPOlCmMR8CbB9PM5j7Xu9J9cupM8h2
         U8XgKQU71m/Rq4y2q1IPVJSKW2brYf05idsCHPjWEfhpMFvCx4cG8Uv+XZulCNUzPeOM
         hrsXm/bQo8kzJ2uhkYjcb14U8WEMTT+cgZ/VBMJUHdl9xt367Idw+V/v46LFJOQNXgrs
         UXGKd4YQGySKq7/sbJFO6mAS18CbYH3MKc1kdD+KVKPJ6tuhL4LjKEvj/5H4Gs7t9utN
         mgDv1Z8lo2OWblHR6uXYIyEGNjWW36wcSvG38i5VWowMPTQYgsaHat2pWhXrpvrDb51T
         m2gA==
X-Received: by 10.236.160.100 with SMTP id t64mr54875473yhk.7.1411994690318;
 Mon, 29 Sep 2014 05:44:50 -0700 (PDT)
Received: by 10.170.62.136 with HTTP; Mon, 29 Sep 2014 05:44:20 -0700 (PDT)
In-Reply-To: <1411890626-28237-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257624>

On Sun, Sep 28, 2014 at 2:50 PM, Ben Walton <bdwalton@gmail.com> wrote:
> Oracle Studio compilers don't allow for static variables in functions
> that are defined to be inline. GNU C does permit this. Let's reference
> the C99 standard though, which doesn't allow for inline functions to
> contain modifiable static variables.
>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
>  trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/trace.c b/trace.c
> index b6f25a2..4778608 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -385,7 +385,7 @@ static inline uint64_t gettimeofday_nanos(void)
>   * Returns nanoseconds since the epoch (01/01/1970), for performance tracing
>   * (i.e. favoring high precision over wall clock time accuracy).
>   */
> -inline uint64_t getnanotime(void)
> +uint64_t getnanotime(void)
>  {
>         static uint64_t offset;

Would moving this offset outside getnanotime() work?
-- 
Duy
