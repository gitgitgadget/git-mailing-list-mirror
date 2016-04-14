From: Isaac Levy <isaac.r.levy@gmail.com>
Subject: Re: Default authentication over https?
Date: Thu, 14 Apr 2016 17:32:16 -0400
Message-ID: <CAPf1peDf_YbDsaz1ykvzKLkdUWtSqrHT7yrgfUgjE4R1eS4r6g@mail.gmail.com>
References: <CAPf1peAW11hZpN6_ztA62tcu6mgCfV3VwwjjtXT5yySUPD9Qpw@mail.gmail.com>
 <20160413223613.GB10011@sigill.intra.peff.net> <alpine.DEB.2.20.1604141142190.23813@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:33:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqoso-00041R-8g
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 23:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbcDNVc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 17:32:57 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36410 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbcDNVc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 17:32:56 -0400
Received: by mail-ig0-f181.google.com with SMTP id f1so4592091igr.1
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AtUloWRzyP8nQAgvNZhrseCMf9X/izK5gGDoNQuOZYc=;
        b=V4p+UYsB/zStZwWm2QlT5ebj2XXfcbFxBONOJnuRwe0in9DcNM2jsf7Gxlcs48S5BJ
         LRkH1bBOJOWD8GDCh4ytyqSSMnbHna81ZLL0ZBXJG4P7mvsCIxlUqH19YTzHk2AnidyK
         Qa11CSo8+yuqV8Ef+cpx/hT/LJdHpj9odFcQpG3Alb4Xt50GxvOCP2z1pM38jQiH63gX
         Mm6VfysEioB5dgYpdwERTop2rzLdgell2Yfq+4wNgxV4YmKplqegBH61sH2NCK1i9eqW
         YMcfIcnr0tXe2J+Ah8s9M5LNEwRXSXOxcM3+LTnx/LiMrHde/hsdkRkP+dtNiQtSGXZV
         aVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AtUloWRzyP8nQAgvNZhrseCMf9X/izK5gGDoNQuOZYc=;
        b=JXHCcHFq/a9JC6xYYksPbf9/5xRHhrPPVADaZGoes8KjSarnq2r1YWf1DwrDU8l3qn
         SBSipOcVe7rX61g2Y4CwHbITHlklkpVTP7mHwMx+vjs1l+J2dY6ivWGLpxRId52UxgD2
         E4sAzT2oViwrgSFMMRNJnds/om6vUn78DH722aC7WTyHAc40C6HzH2XL48+f2R7EtwV2
         0loeIYO4Ro5EDfyBST+xQxtLjqlIM+flIy5sBqp3x0NosxZ1+QDekJ2QgFvbp115G6b2
         k5XuEhereNrREIwFFyXnr++PAkyUq64k4pueEhXZMdxggsAL0vges2RN4VAscHLk/Ohg
         JHaA==
X-Gm-Message-State: AOPr4FWOiVX/dGic5eHRyShiXAhYICfeD00pipxVt2yegfbDlNCaNNsAIbA0aDiuxINqYLhuFSNTSCRk7opzuQ==
X-Received: by 10.50.226.179 with SMTP id rt19mr908935igc.36.1460669575773;
 Thu, 14 Apr 2016 14:32:55 -0700 (PDT)
Received: by 10.107.41.202 with HTTP; Thu, 14 Apr 2016 14:32:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604141142190.23813@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291567>

After the authenticated request, curl says it's keeping the connection
open, but the next fetch seems to do two handshakes again.  The
unauthenticated request closes the connection, so the 2nd handshake is
forced, but I'm not sure why subsequent git fetches still do
handshakes.  I did a bit of sleuthing w/ source, GIT_CURL_VERBOSE and
wireshark.

We're using GitHub enterprise -- it'd just be nice if there was a
better way to configure for super fast fetches.  ssh with cached
connections does avoid the SSL this overhead -- though as I recall git
protocols over ssh are less performant.

Finally I also checked out the persistent-https contrib section as a
workaround but couldn't get it to work. Is that project dead?

Thank you for your replies and support.

Regards,
Isaac

On Thu, Apr 14, 2016 at 5:46 AM, Daniel Stenberg <daniel@haxx.se> wrote:
> On Wed, 13 Apr 2016, Jeff King wrote:
>
>> However, I don't think even that would give you what you want. Because I
>> think that even if we provide a credential, curl will make an initial
>> request (presumably to find out which auth type it should use, but that
>> is just a guess). I don't know if there is a way to convince curl to
>> stick the credential in the first request
>
>
> curl supports this. but then you must do exactly that: tell libcurl to use
> that single auth method only. It will of course make it fail if you select
> the wrong method etc.
>
> The unauthenticated first request is both to probe for which methods the
> server wants, but also works for the case when users provide credentials
> without the server actually ending up asking for them...
>
> --
>
>  / daniel.haxx.se
