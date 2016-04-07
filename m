From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] commit: --amend -m '' silently fails to wipe message
Date: Thu, 7 Apr 2016 10:50:06 +0100
Message-ID: <20160407095006.GB2345@dinwoodie.org>
References: <20160406171503.GA2345@dinwoodie.org>
 <20160407044219.GA29710@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Webb <chris@arachsys.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 11:50:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ao6aA-0002iH-9F
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 11:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858AbcDGJu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 05:50:29 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35990 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386AbcDGJuK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 05:50:10 -0400
Received: by mail-wm0-f52.google.com with SMTP id v188so50282692wme.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 02:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ed4DVyQzru3gVG38TSF9tQ51YvHQQ5WlHoygoAvzz/8=;
        b=i3K0ZbNNjF9BiIfDF9Dp2RD91bX91oVvZImWtdyaCSKFfvEwUbQ0P9H16SeNvzwRwf
         cvqYJv7sklwSY2riDmp5zsBjOk7HA9HCPXgXylLwo3IExj9+YdjHhwp7Y3xIoW1OlV2p
         cPJ4diGMin/SlcY4M4MQs7pCozXFUe/N3h9Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ed4DVyQzru3gVG38TSF9tQ51YvHQQ5WlHoygoAvzz/8=;
        b=O1ynSJy7Hsj1j0tuisfAPe4vZdfDwxoZEYK7u3zhu4LBjHaxw6ub1KBNOspJSHpB9j
         iTrFeC1VTEgquo3+kqZ8D1FClfPVCTG1T/EpyE+Pg4YrO8Rs8Z3oWWqXbYQZ636oqKGO
         WnF/2GWP8Ug4fl2sc/h98S72mi1mqtl7eHW1qvONU+sdl1CJ0wDXP4h2OkoseJop8pSD
         SWqiJFEmDmMt+h/VKqEsuguWGTDRGtBE3Mugn4HP0lDeQ62mJIdZXa8wXzvbiWwH1A09
         NyzcDiG+XzptDBzHRL1+N5mQZCZGA8RlOZy0ib2Xjuu0IRkahYh9WGNszYIk75GgALdn
         1CYA==
X-Gm-Message-State: AD7BkJK3D68AO4+2y7/Lh8+rxSf77vpz6oCG2J0ZGpSIDq2BpZS6uWwcKOFV9/fwUtmEpQ==
X-Received: by 10.194.158.226 with SMTP id wx2mr2325818wjb.91.1460022608830;
        Thu, 07 Apr 2016 02:50:08 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id s10sm4733404wjp.3.2016.04.07.02.50.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Apr 2016 02:50:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160407044219.GA29710@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290911>

On Thu, Apr 07, 2016 at 12:42:19AM -0400, Jeff King wrote:
> On Wed, Apr 06, 2016 at 06:15:03PM +0100, Adam Dinwoodie wrote:
> > `git commit --amend -m ''` seems to be an unambiguous request to blank a
> > commit message, but it actually leaves the commit message as-is.  That's
> > the case regardless of whether `--allow-empty-message` is specified, and
> > doesn't so much as drop a non-zero return code.
> > 
> > Add failing tests to show this behaviour.
> 
> Hmm. Is it just that we check "message.len", which cannot tell the
> difference between "-m was not given" and "-m was given the empty
> string"?
> 
> IOW, would this fix it?
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 109742e..3cdc44e 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -695,7 +695,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		}
>  	}
>  
> -	if (message.len) {
> +	if (have_option_m) {
>  		strbuf_addbuf(&sb, &message);
>  		hook_arg1 = "message";
>  	} else if (logfile && !strcmp(logfile, "-")) {
> 
> It passes the test suite and your two new tests, but I didn't look too
> deeply to see if there are other fallouts. I don't think anybody should
> be using it to counteract a previous "-m" or anything like that; we have
> "--no-message" for that.

That makes sense as a fix to me, but I'm not going to claim to be even
slightly familiar with the code here.

> PS Is there a previous thread? I see a couple people cc'd, including me,
>    but I don't remember a previous discussion. Did I just forget it?

No previous thread: I noticed the odd behaviour, and figured I'd report
it.  The best way to report a problem seemed to be providing a test
showing the behaviour, and the SubmittingPatches doc said I should CC
folk who looked they're involved in the area...

Adam
