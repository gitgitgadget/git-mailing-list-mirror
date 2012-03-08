From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] i18n: keep the last \n even when text is poisoned
Date: Thu, 8 Mar 2012 16:01:32 -0600
Message-ID: <20120308220131.GA10122@burratino>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
 <1331198198-22409-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 23:01:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5lPA-000755-F8
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 23:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758718Ab2CHWBn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 17:01:43 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:47881 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758604Ab2CHWBm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 17:01:42 -0500
Received: by obbuo6 with SMTP id uo6so1213794obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 14:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Wd98njusz8Tw4jtU04xbjIRXaQu/80jg4hVIQQ8Ms6g=;
        b=ORZxr5Yz/aHn1lolZiYH12kP5QI9eGFhLRESyqtnmEHI5nmpCGnh4sJ48Exmm9IPXt
         nu6sLTC+pmIFwXTa+i8eDaFXR7WNdzfg014FW7jeURO9m4rm25LewOvX6nD7KObuKEUD
         LTadhIx8s+lGUDT3qXbCaYdt//jAEDbBdQaR2c/nbkDntG0xQknZ4U18DHH4Ogvmc8zO
         TEMwwOQ9ZDB1Yaw3q13lKUjXd9B+md+9Rv3JuMqo+F2zBWbCpR6ZffNCNRaCJVi+lt5P
         7dNAgVVfpHrD7Q95pQXgC7TZNJ4lbNFNxE91Evk517ay7kf1Z4CVfNApMGpVKutKnnHR
         VN5g==
Received: by 10.182.160.10 with SMTP id xg10mr3025739obb.40.1331244102267;
        Thu, 08 Mar 2012 14:01:42 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a6sm1574114oea.13.2012.03.08.14.01.41
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 14:01:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1331198198-22409-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192656>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/gettext.c
> +++ b/gettext.c
> @@ -24,6 +24,16 @@ int use_gettext_poison(void)
>  		poison_requested =3D getenv("GIT_GETTEXT_POISON") ? 1 : 0;
>  	return poison_requested;
>  }
> +
> +const char *poison_text(const char *msgid)
> +{
> +	int len =3D strlen(msgid);
> +	if (len && msgid[len-1] =3D=3D '\n')
> +		return "# GETTEXT POISON #\n";
> +	else
> +		return "# GETTEXT POISON #";

I realize this was not the motivation behind the above patch, but if
the translation of some message has to end with a newline for git to
function correctly, would we consider that a bug?

I am of two minds on that:

 - on one hand, translators tend to be trustworthy, reasonable folks
 - on the other hand, anything we can do to make the translation
   process less fussy seems like time well spent

The latter wins out for me, so I would prefer not to have this patch
so the test suite can detect important newlines that should be not be
part of the translatable string.

Just my two cents,
Jonathan
