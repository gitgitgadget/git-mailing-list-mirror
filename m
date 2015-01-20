From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.3.0-rc0
Date: Tue, 20 Jan 2015 22:49:32 +0100
Message-ID: <CACBZZX5s1rZ3exktbisseJSjF8-0=8ByMpBpARy6h+=iP7wEyA@mail.gmail.com>
References: <xmqqmw5n5z8i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 20 22:50:00 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YDggR-0001zb-1Y
	for glk-linux-kernel-3@plane.gmane.org; Tue, 20 Jan 2015 22:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbbATVtz (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 20 Jan 2015 16:49:55 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:58991 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbATVtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2015 16:49:53 -0500
Received: by mail-ob0-f176.google.com with SMTP id va2so12730055obc.7;
        Tue, 20 Jan 2015 13:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Oz9kaybHs7LWq/YxFOnnHlUGagO3EQMb7yhEtDvYXz4=;
        b=k2TEjXBmf330bdohtX5tEiYl2c9Y6h+YVPERwftuR0GybdVYlgauwWLozIgOGXI6ow
         taFHY1j0M0NUaPUg60+6GVhbQMS0vK0VuBGRQG1CzuhE1oz31E2k8IHvtty0944Il2JE
         2dy2PToceJ6fmvTFVXNGPKAhOF5Gz/Iy+mBY5KlOLknNWxoEo7NBm2s05FKHQ3o+rFqL
         R/nQEX3mNjXDJu6Fgl5WzfaMwG2igDn1YqxdVU//KQ1WBoO7hXGIQvD/QRrZV9RVe0IW
         EI/nnDfNyY4ipG57RnlZkECOmvLRqXdN2/7rirwn0Y1w41K4qcVuYImupOG+igWChSyU
         ELxg==
X-Received: by 10.202.227.212 with SMTP id a203mr21983843oih.126.1421790593085;
 Tue, 20 Jan 2015 13:49:53 -0800 (PST)
Received: by 10.76.50.70 with HTTP; Tue, 20 Jan 2015 13:49:32 -0800 (PST)
In-Reply-To: <xmqqmw5n5z8i.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262696>

On Tue, Jan 13, 2015 at 12:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> An early preview release Git v2.3.0-rc0 is now available for
> testing at the usual places.
[...]
> Jeff King (38):
[...]
>       parse_color: refactor color storage
[...]

I've had this in my .gitconfig since 2010 which was broken by Jeff's
v2.1.3-24-g695d95d:

    ;; Don't be so invasive about coloring ^M when I'm editing files
that
    ;; are supposed to have \r\n.
    [color "diff"]
       whitespace = 0

To test this replace \n with \r\n in a file. Before this patch you could do:

    git -c color.diff.whitespace=0 show

And just get:

    [red]-[/red]
    [green]+[/green]

As opposed to:

    git -c color.diff.whitespace=1 show

Which gives you:

    [red]-
    [green]+[/green][red]^M[/red]

Now that just produces:

    error: invalid color value: 0
    fatal: bad config variable 'color.diff.whitespace' in file
'/home/avar/.gitconfig' at line 16

Maybe breaking this is OK (but I can't find what the replacement is),
but the config or the the changelog doesn't mention breaking existing
config settings.
