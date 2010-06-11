From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH] diff: bugfix: binary file permission regression
Date: Fri, 11 Jun 2010 15:06:02 +0800
Message-ID: <AANLkTimwmkMnaqMY44SeHz1L8hE2Lp324PXPY4eqvTGb@mail.gmail.com>
References: <1276194685-28098-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 11 09:06:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMyJg-0001zB-5Y
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 09:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134Ab0FKHGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 03:06:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33300 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0FKHGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 03:06:04 -0400
Received: by gwj15 with SMTP id 15so506285gwj.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=/TbdcjgZh6+3Y8pdZa2NWl92Gy3dng25PBAaeylu930=;
        b=Df82zlLsHcxRRxZgkfs+0XPaIgPm9u9DIhO4Nk38v/N2QbjNXWMIik1uB4KXPdUPFx
         UXJi4zkOi+bmVnBYqyUzi7gjByE5FEZwXkgVQ+E9DEKCJl7oaRp8iQybUHUtj4xpWiGi
         utaXYlkVgIyH/PGbtFZoIVBS+F0uwKEL3qZAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=rL4RrehtnPaGaXEKQcK9ZsYSswmX3M4CWQtuNTunAknBJCcD5/w27eyK9D7Y4EPLvX
         7iCxM3Kz6PlMkrUcfiib7LyStIy+SrPL3u5owC0Dd1ArX8QgHx3RNnUOyNAFGO2MB2kZ
         WyCwxzFva4AKdMnBsYR8YiwHOxT9fFTxtzodg=
Received: by 10.90.204.19 with SMTP id b19mr2001889agg.139.1276239962627; Fri, 
	11 Jun 2010 00:06:02 -0700 (PDT)
Received: by 10.90.114.16 with HTTP; Fri, 11 Jun 2010 00:06:02 -0700 (PDT)
In-Reply-To: <1276194685-28098-1-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148926>

On Fri, Jun 11, 2010 at 2:31 AM, Nazri Ramliy <ayiehere@gmail.com> wrote:
>              (!textconv_two && diff_filespec_is_binary(two)) )) {
>                if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
>                        die("unable to read files to diff");
> +               fprintf(o->file, "%s", header.buf);
> +               strbuf_reset(&header);

 Since the fill_mmfile()s could result in a die maybe it's
 better if the header is printed before the read attempt?:

              (!textconv_two && diff_filespec_is_binary(two)) )) {
+               fprintf(o->file, "%s", header.buf);
+               strbuf_reset(&header);
                if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
                        die("unable to read files to diff");

I did this on my work tree and ran 'make' in the test directory and no errors
were reported.

nazri.
