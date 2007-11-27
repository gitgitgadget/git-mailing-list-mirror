From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] builtin-commit: add --cached to operate only on index
Date: Tue, 27 Nov 2007 13:57:34 +0100
Message-ID: <81b0412b0711270457i1d0a05a2nc2715f1918f26f31@mail.gmail.com>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
	 <Pine.LNX.4.64.0711271115300.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@redhat.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 13:58:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix00j-0003FF-4J
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 13:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbXK0M5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 07:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754691AbXK0M5i
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 07:57:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:10439 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbXK0M5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 07:57:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1227364ugc
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 04:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wfz8WrBeSGU5uVTbxp9aK3w83ctbBlBUiANkEv9FUXs=;
        b=vLdOMtzjxCvZCc6l2GiXVx7Y+BdhIvww7TKyj1qOxeR0r8Gm1RGWADYPkk+Mit+WCiKIS+dscLc+MFhjqRSOcuQoSwJroGABWDHNjOOgC6Qxvtw2xgnD62zRMbl0QHjFfwzOQnhIX2K+S6RwTPR8SrFJFh0t6v9jnQR3xI3Z5us=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PO9ECbQRc9OsfkSZPOQZcG+peqtt6LrhRFnlkT3rsYA91+6mVHyV5ByzOh/ma4addzZTmGK+Eopz+QtezLw0b5bXvnZiOWPoM1rNaEy7iBG90Q27yZGAqIMY10wxgijxDdYGsAslyg7Xt3ErylAP5TaWaWiQ+Shlh8BWv96TDGA=
Received: by 10.78.140.17 with SMTP id n17mr4166304hud.1196168254825;
        Tue, 27 Nov 2007 04:57:34 -0800 (PST)
Received: by 10.78.120.4 with HTTP; Tue, 27 Nov 2007 04:57:34 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711271115300.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66203>

On 27/11/2007, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> [commenting on the patch is a little cumbersome when the mailer does not
> quote it for you...]

Yes, I'm sorry. But being at work I'm extremely lucky to have access
to even gmail (it was blocked for almost a month as a virus source. Of
course it is a virus source! It is a damn mailbox!)

> On Tue, 27 Nov 2007, Alex Riesen wrote:
>
> @@ -550,6 +557,8 @@ static int parse_and_validate_options(int argc, const char *argv[])
>                         free(enc);
>         }
>
> +       if (all)
> +               cached_only = 0;
>
> My reply> I would rather add another !!cached_only to the existing if().

I'm... Not sure. I'm using it like this:

   $ alias gci='git commit --cached'
   $ gci

So sometimes I actually want to override --cached, and just so happens
it is always --all case, which seem  to be in line with proposals to make
--all default commit behavior.

> @@ -678,7 +688,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>         }
>
>         if (!prepare_log_message(index_file, prefix) && !in_merge) {
> -               run_status(stdout, index_file, prefix);
> +               if (!cached_only)
> +                       run_status(stdout, index_file, prefix);
>
> My reply> Would it not make more sense to avoid run_status() when no_edit?

Will try it out this evening at home. I suspect you're right :)
