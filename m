From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 3/5] diff: acknowledge --submodule=short command-line
 option
Date: Sun, 07 Oct 2012 21:55:40 +0200
Message-ID: <5071DE3C.5080206@web.de>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com> <1349196670-2844-4-git-send-email-artagnon@gmail.com> <506B3F74.3020208@web.de> <CALkWK0mbQZjYUR73rdFP2BtOzdL9gQqxnC5fjtsCYq2F29=8qg@mail.gmail.com> <5071DCC8.50004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 21:56:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKwxC-0005MC-3i
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 21:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab2JGTzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 15:55:46 -0400
Received: from mout.web.de ([212.227.15.4]:51397 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab2JGTzo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 15:55:44 -0400
Received: from [192.168.178.41] ([91.3.178.130]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MEEeC-1T9xVm2kIq-00FR3D; Sun, 07 Oct 2012 21:55:42
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <5071DCC8.50004@web.de>
X-Provags-ID: V02:K0:6ykN2LlKsJ1/tNKKIHYdpTd6ptL/PBTNeMNJHsrovLL
 2WgW6jPwabrYdBqEC0EoNpeo6IVaN+wiLaByFhobS0km6UGH/d
 wZJalW1grog2TC4KZAlEv2EgQm2KWKQBqP7aBq0b4482L1sEja
 dN9c2RGR/wd0c/kRpewLaJynKrWG6cyOEqBOW2yoRCfrIOVg/m
 bIMgWU9oOuJmX651F5vvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207189>

Am 07.10.2012 21:49, schrieb Jens Lehmann:
> I forgot to mention that testing submodule_format_cfg would have to
> happen in cmd_diff() (between reading the config and parsing the
> command line options) instead of builtin_diff(). Something like this
> should do the trick (untested):
> 
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 9650be2..180bf44 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -297,6 +297,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix
>         DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
>         DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
> 
> +       if (submodule_format_cfg && !strcmp(submodule_format_cfg, "log"))
> +               DIFF_OPT_SET(options, SUBMODULE_LOG);

Obviously not even compile tested, the line above should read:

+               DIFF_OPT_SET(&rev.diffopt, SUBMODULE_LOG);

> +
>         if (nongit)
>                 die(_("Not a git repository"));
>         argc = setup_revisions(argc, argv, &rev, NULL);
