From: Stefan Beller <sbeller@google.com>
Subject: Re: Re* [BUG-ish] diff compaction heuristic false positive
Date: Fri, 10 Jun 2016 11:21:34 -0700
Message-ID: <CAGZ79kZpiPKLS_RFzROznQAE8iT35hV0QXknFMsVcDR7siLOTw@mail.gmail.com>
References: <20160610075043.GA13411@sigill.intra.peff.net> <20160610083102.GA14192@sigill.intra.peff.net>
 <xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com> <CAGZ79kZLT8AfmWTrrW+a-v7aXw5sm68P2H=vT7QZr2hj4Z2gDA@mail.gmail.com>
 <CA+P7+xp=bTPiwRRTH=h7v5pV8+=he4+789_3PNz227mv1387MA@mail.gmail.com> <xmqqeg84gbex.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 20:21:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBR3w-0001Gf-32
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 20:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbcFJSVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 14:21:36 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36478 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbcFJSVf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 14:21:35 -0400
Received: by mail-qg0-f49.google.com with SMTP id v76so8374157qgv.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=InUa98JojGbTDFEacAlTdlT9KIrIaSjiRqrlOLgc63A=;
        b=gKxCR9iOiRCYnuglFr22sskq0ndknfuJ3gnSsyE3m8nG2hKNVn0a0MSjBfrJyWBvkB
         N6Z/P5Tvj9ZdeSnQBln9ljMnTbhzdkjunfgsV8UJqOpp+TYETFPoOwHMG7wNlLJjFlXm
         NAEJ0yQjOWkigop9tToFf5fp8s3lUeYAMfmJijTy65n4NkHtRahw0GUsg28fE1CA1wBq
         WaROi53zJT1kUJfeVteBfoYssyt2u7+bthRl7aNHQX4ZPx08uWQpxW5i4LjnJqdtn9Lh
         AGTQy2fLgiBNWPpLlcpHOECvasVIvJmEeu1kiNR8NjUno8LgaIIdnMgftPekJZPTVs9Q
         G/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=InUa98JojGbTDFEacAlTdlT9KIrIaSjiRqrlOLgc63A=;
        b=gz0/6Dy+6Zgy3CqHmv3GCv6AhOwOs53gQf86kVvqRiMfEUD8Gn2Bv22jLbiRiHWf8I
         UB6lRPhW9dRWEcA7Rx+OhWIqtU61NtcaJvII/3WM9/rOej9QrefQYBWMhmcKOFmGCKqB
         4suH5IwDZrETZb4DR7QxiMkc27p6/5A2jDbmXTRpWu2aAuKirJJo7rgPBcwVaBDHYsX8
         wId6cn/zE8KFEOZ9kzS9gMfZ7IN0qh9LTs9HAadgfev86VuZ2karotFdcfzAeZc2oyNV
         MrkE+1ozWPSc28eWfF8y2C/jgCXYyLYa2Qb+Xo9IlzsYhXTewiCAaRiM24E2CS+ROWoV
         Vbpw==
X-Gm-Message-State: ALyK8tJPgl7x9/7J8QaVfSPH8e/QH0U16uth/eHDF2RQ4Wg+c9uOlv5nZV+lTI0NjMYHib4m4d3juj4SxLfs2mHT
X-Received: by 10.140.238.66 with SMTP id j63mr3278390qhc.48.1465582894716;
 Fri, 10 Jun 2016 11:21:34 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Fri, 10 Jun 2016 11:21:34 -0700 (PDT)
In-Reply-To: <xmqqeg84gbex.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297015>

On Fri, Jun 10, 2016 at 11:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] diff: disable compaction heuristic for now
>
> http://lkml.kernel.org/g/20160610075043.GA13411@sigill.intra.peff.net
> reports that a change to add a new "function" with common ending
> with the existing one at the end of the file is shown like this:
>
>     def foo
>       do_foo_stuff()
>
>    +  common_ending()
>    +end
>    +
>    +def bar
>    +  do_bar_stuff()
>    +
>       common_ending()
>     end
>
> when the new heuristic is in use.  In reality, the change is to add
> the blank line before "def bar" and everything below, which is what
> the code without the new heuristic shows.
>
> Disable the heuristics by default and leave it as an experimental
> feature for now.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Thanks,
Stefan
