From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: suppress false positive warnings of empty
 format string.
Date: Sun, 29 Sep 2013 10:07:25 -0500
Message-ID: <CAMP44s069BUJiv1K3a2nkwT1A8fo=Vn0+8WFePHqBg_PBx_17g@mail.gmail.com>
References: <7vfvvkpt2k.fsf@alter.siamese.dyndns.org>
	<1380456534-7582-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 17:07:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQIap-0007tI-2h
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 17:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab3I2PH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 11:07:28 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:50025 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab3I2PH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 11:07:26 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so3645690lbj.41
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2cGTfQomoj1wNRkY9iIqYGEQdbkWv4uLZAOOIZRpKZk=;
        b=PzEmmH2uFunfngmK6zK31sphB9itp4Jd4ZJzkFe9mYdwPvcrCLvEvZQ0un1OPHb7E/
         9Ym2aQgmONpMx6v827TbhM4pPrQaSKrnHAXiqW8yrheZRgzsZbLLkyj75K8woDXHBirn
         F3Gw6zyhCpoGkWpAYNZ1LQO98k2PzE6ug/mQGV7eWDBkp4YWvhw3mD0FCkBbgjTfo/Ta
         fYEOLxkBVvAOjPV2PckD0Uy/Y61ieUuhNec3Oua8wgsmPj2yQhEF9n1kOeZrYcRfhKk4
         bvMC8g3BPkDCsQyFpDgUvy9pXCcSW149CejIXLHO7uyi1iIdXJdsLliP6eBLiR0mJBvY
         CSQA==
X-Received: by 10.112.157.67 with SMTP id wk3mr2059256lbb.32.1380467245241;
 Sun, 29 Sep 2013 08:07:25 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sun, 29 Sep 2013 08:07:25 -0700 (PDT)
In-Reply-To: <1380456534-7582-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235599>

On Sun, Sep 29, 2013 at 7:08 AM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index de3d72c..60afa51 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -349,7 +349,7 @@ GIT-VERSION-FILE: FORCE
>
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>
> -CFLAGS = -g -O2 -Wall
> +CFLAGS = -g -O2 -Wall -Wno-format-zero-length

Oh yes please.

However, somebody mentioned that this might break compilers other than
gcc, but perhaps we can do what Linux does:

cc-disable-warning = $(call try-run,\
$(CC) $(CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))

CFLAGS = -g -O2 -Wall $(call cc-disable-warning,format-zero-length,)

-- 
Felipe Contreras
