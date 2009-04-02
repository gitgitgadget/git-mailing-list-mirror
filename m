From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Thu, 02 Apr 2009 18:22:55 -0400
Message-ID: <49D53ABF.80706@gmail.com>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Marius Storm-Olsen <marius@trolltech.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 00:25:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpVLH-0003NK-EB
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 00:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbZDBWXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 18:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbZDBWXJ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 18:23:09 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:57182 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZDBWXI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 18:23:08 -0400
Received: by gxk4 with SMTP id 4so1772259gxk.13
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7MxkN4qMf7QwMXHNEH2kRB+8l85g0xMFO0tR0DUO7UU=;
        b=jhwMDMqHcBsDymBBsDfj6NWOH5Gn6bbSKbCKOMsIfzY9ZTk8F9NJT1ndxzuWCBzDhJ
         AZXInzBmjBrr4euGBQGbZIFo7pJXdAM4b7zES4DEDKTIaTNmqlL7hDEJHSZKgwOa+aPY
         f9+yfGxzQRW/8ox4MkbkneGqOh+jiQRdU+ypU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=Bb4EzkndX9vdstnaFXoDTiNbcS0JlxRu4kEUkIAegWdzD7LK84ByMievOascf+Wfjb
         YhXLa7f8y5WotGwCP4zcBGSC5WjtkFU4Jki+k1cPoUxKyqZ8wKKnee3saUn6aEJGzE+2
         rDUkk20dKkIy49sXpNd4JcEDBiwxzFtOOu9hI=
Received: by 10.100.105.15 with SMTP id d15mr927459anc.154.1238710985643;
        Thu, 02 Apr 2009 15:23:05 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id c40sm358408anc.48.2009.04.02.15.23.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 15:23:04 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115499>

{I may be late to this change since I'm trying to catch up on the ML.]
Johannes Schindelin wrote:
> Commit 0925ce4(Add map_user() and clear_mailmap() to mailmap) broke the
> lower-casing of email addresses.  This mostly did not matter if your
> .mailmap has only lower-case email addresses;  However, we did not
> require .mailmap to contain lowercase-only email addresses.

What part of the email address is this going to lowercase? Only the 
domain name is case agnostic.

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  lezzee how that goes
>  mailmap.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/mailmap.c b/mailmap.c
> index f12bb45..6be91b6 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -50,6 +50,15 @@ static void add_mapping(struct string_list *map,
>  {
>  	struct mailmap_entry *me;
>  	int index;
> +	char *p;
> +
> +	if (old_email)
> +		for (p = old_email; *p; p++)
> +			*p = tolower(*p);
> +	if (new_email)
> +		for (p = new_email; *p; p++)
> +			*p = tolower(*p);
> +
>  	if (old_email == NULL) {
>  		old_email = new_email;
>  		new_email = NULL;
