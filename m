From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 1/2] remote.c: don't leak the base branch name in format_tracking_info
Date: Sun, 10 Aug 2014 17:14:33 +0200
Message-ID: <53E78C59.2010704@gmail.com>
References: <1407679076-20300-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 10 17:14:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGUpV-0008AN-7B
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 17:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbaHJPOh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2014 11:14:37 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:64703 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbaHJPOh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 11:14:37 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so7638695wes.18
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=jyel6KHtJuaJKm5L4wGJ0WZd0Wh3HM6PjioZx9lgRWk=;
        b=VrANGxHQjWyrWOZn5lv3+woujNP0e52SDHP0H+YjbwttvMtRuFO/xwRrMs5xvysMg3
         91fLUzCwns3tjDVwddJszeMgT9DPQZgoxe15Zlrhafo4PCU30mom+q0P151UOnK5Vk/V
         5zWqWfjnLD4XjWQudLqjLF1VHyWUNOK+A+qg7lRmX3/wLXXprtZZyaCOD+oQmXJwtOWF
         lIY4W8mID+XRj4ayWVK77YkgSa4y1M3nQE8R1bcyAdhIp1zidJiS2MNLC9syPJLJNi7B
         s8mL53CfJTZ61+EoulCt01WAuPL5fYo8Y6fw283nRrjQWAI4AMESiyOR/i/n2MthlDlH
         lRMw==
X-Received: by 10.194.3.51 with SMTP id 19mr47199595wjz.93.1407683676174;
        Sun, 10 Aug 2014 08:14:36 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id a4sm32084185wie.21.2014.08.10.08.14.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2014 08:14:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1407679076-20300-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255096>

On 10.08.2014 15:57, Stefan Beller wrote:
> Found by scan.coverity.com (Id: 1127809)
>=20
> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> ---
>  remote.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/remote.c b/remote.c
> index 3d6c86a..2c1458f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1983,6 +1983,7 @@ int format_tracking_info(struct branch *branch,=
 struct strbuf *sb)
>  			strbuf_addf(sb,
>  				_("  (use \"git pull\" to merge the remote branch into yours)\n"=
));
>  	}
> +	free(base);
>  	return 1;
>  }
> =20
>=20

Upon testing this one again, I get a warning
remote.c: In function =91format_tracking_info=92:
remote.c:1986:2: warning: passing argument 1 of =91free=92 discards =91=
const=92 qualifier from pointer target type [enabled by default]
  free(base);
  ^
In file included from git-compat-util.h:103:0,
                 from cache.h:4,
                 from remote.c:1:
/usr/include/stdlib.h:483:13: note: expected =91void *=92 but argument =
is of type =91const char *=92
 extern void free (void *__ptr) __THROW;
             ^

Please ignore this patch.
