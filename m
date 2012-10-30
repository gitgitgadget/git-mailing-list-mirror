From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/4] fast-export: trivial cleanup
Date: Tue, 30 Oct 2012 11:55:43 -0700
Message-ID: <20121030185542.GF15167@elie.Belkin>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:56:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTGyn-0005rg-Hv
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab2J3Szs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:55:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42725 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab2J3Szr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:55:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so384475pbb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q37O/StDh8MeX3KFxajJ+PJDYyDm18E9ZrOVFwrTV4o=;
        b=xmEUCmzw5aNjqnH+6WA5ENrklY68qw6so7OJTaFsMdCZ3hhHqJMrnQnV760FNaix/q
         pKK2a0NZEb9MOoMc6pFFfN3sWWZUctLZv2tdJrXx+S1BWQRgAjybf4TNcCDJVi+Dg2bE
         w+sLGtvdwJr30aWZGebIjTINxHxtq+yRRj8x49yJOnTxLKasFu6MuIExtKuv0ffMqHQr
         zAf54mrsz5c/7qlGtyc98Yqgax64Xllt9z4Jum1DjlzfUwhKKRN9DA33smLaSmKnkbGE
         F4wtLydu66mBx1CO9kg9vx/3vh/xrRqbHzcXcj7dvmeb0AxzyOatgFAFGYNDHNGmBfv7
         +Wkg==
Received: by 10.66.78.199 with SMTP id d7mr94933564pax.77.1351623347289;
        Tue, 30 Oct 2012 11:55:47 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id yi9sm932274pbc.39.2012.10.30.11.55.45
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 11:55:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351617089-13036-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208723>

Felipe Contreras wrote:

> Setting commit to commit is a no-op.

Wrong description.  This should say:

	The code uses the idiom of assigning commit to itself to quench a
	"may be used uninitialized" warning.  Luckily at least modern
	versions of gcc do not produce that warning here, so we can drop
	the self-assignment.

	This makes the code clearer to human beings, makes static
	analyzers that do not know that idiom happier, and means that
	if the code some day evolves to use this variable uninitialized
	then we will catch it.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

With that change, for what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Patch left unsnipped since it doesn't seem to have hit the list.

> ---
>  builtin/fast-export.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 12220ad..065f324 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -483,7 +483,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
>  	for (i = 0; i < pending->nr; i++) {
>  		struct object_array_entry *e = pending->objects + i;
>  		unsigned char sha1[20];
> -		struct commit *commit = commit;
> +		struct commit *commit;
>  		char *full_name;
>  
>  		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
