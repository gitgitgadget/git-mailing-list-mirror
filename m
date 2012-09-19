From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: possible bug in autocompletion
Date: Wed, 19 Sep 2012 19:08:09 +0200
Message-ID: <CAMP44s2X5-BUyLtkTqGMa6w5K6uT25YLEp+Q2TdVR_qCObOpeA@mail.gmail.com>
References: <BLU0-SMTP405CDB35308082B180185A6B4DB0@phx.gbl>
	<20120717121232.GA32571@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeroen Meijer <jjgmeijer@hotmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:08:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TENlM-0006K1-5I
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701Ab2ISRIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:08:22 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45868 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932372Ab2ISRIK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:08:10 -0400
Received: by oago6 with SMTP id o6so1284102oag.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 10:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D6/qD1HuUoqtApJA6Cjidokrws3/pldpT19f4n144G0=;
        b=dZEv5gtytqEVwVD/+QuMBZ+L/3vyOjQxf9cTyO4wmK63FG/RwUQ6ZZjGwciis/QHVV
         yYOo6nw5sLluvDyypcm7OHZFYorHnojRZA5htUQ9Anx2VgisOA4AX+U9RIxfJOL0Aywo
         RZWfJdtBW5wot1qDsM4wuCLevrz0uGLFfKR/SqGNSsGUFpvQljxVeQ/5IJ/sxZvH+nNh
         8tXXQdswfwLOKjwDdfoW0UuV5SEbTiutOpBM9PM2NKyDV1ZjuCfb2obvfaDy/B+VU6ML
         TjyhPS2cUV+18fks6wtu0yNztVNKkmWl2FzW1hVf5iKOp3qHpH2c7YFgmvwuIHdjYBGT
         XHng==
Received: by 10.182.152.65 with SMTP id uw1mr3349491obb.91.1348074489646; Wed,
 19 Sep 2012 10:08:09 -0700 (PDT)
Received: by 10.60.164.7 with HTTP; Wed, 19 Sep 2012 10:08:09 -0700 (PDT)
In-Reply-To: <20120717121232.GA32571@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205947>

On Tue, Jul 17, 2012 at 2:12 PM, Jeff King <peff@peff.net> wrote:

> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -261,7 +261,12 @@ __gitcomp ()
>  __gitcomp_nl ()
>  {
>         local IFS=$'\n'
> -       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
> +       local words=$1
> +       words=${words//\\/\\\\}
> +       words=${words//\$/\\\$}
> +       words=${words//\'/\\\'}
> +       words=${words//\"/\\\"}
> +       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$words" -- "${3-$cur}"))
>  }

What about something like this?

local words
printf -v words "%q" "$w"
COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$words" -- "${3-$cur}"))

Cheers.

-- 
Felipe Contreras
