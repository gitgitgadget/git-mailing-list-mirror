From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw-multibyte: fix memory acces violation and
 path length limits.
Date: Sun, 29 Sep 2013 01:18:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1309290112380.1191@s15462909.onlinehome-server.info>
References: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Wataru Noguchi <wnoguchi.0727@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBT6HTWJAKGQEQ5OWAWQ@googlegroups.com Sun Sep 29 01:18:44 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBT6HTWJAKGQEQ5OWAWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f59.google.com ([209.85.214.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBT6HTWJAKGQEQ5OWAWQ@googlegroups.com>)
	id 1VQ3mb-0001RK-Iz
	for gcvm-msysgit@m.gmane.org; Sun, 29 Sep 2013 01:18:41 +0200
Received: by mail-bk0-f59.google.com with SMTP id r7sf442613bkg.4
        for <gcvm-msysgit@m.gmane.org>; Sat, 28 Sep 2013 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=TAlLJ4w5BQDKaiIyFX/f7nKsxe2aZgEzv8ZytaHLCD0=;
        b=hJdcg8ea17xDtUxuCBShGKaTnhPhJdbEfiDtf5K9LtT8j2Sm51/eba5i33BL62zImH
         361vA0N0vxl6L40rwOFoJfEF6c+e+gc9Jr1wCOvASuivq5yvCrcBCKydePVMUhQ2LCJJ
         9CMhqGdDT4FmfxiUfqbrsvU5uUP1i6jtQGsw+K1IgWie7jsiWCMxGstxW29qxrD9F/bt
         m1gZr8zIFbuY4S9f8ZX3Yj0pyxynRFmLA+dKoPIKh6H7JWO46CnbazJ+XwhIA1wSZSAD
         NTs/MhZPVOlciOQHxbdqCBNERVMmQ4OQbE/+G5+dSJNAEr+cnYqSkBp4N7xXgaJ4kq0D
         aZZw==
X-Received: by 10.180.19.70 with SMTP id c6mr241107wie.6.1380410321087;
        Sat, 28 Sep 2013 16:18:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.13.232 with SMTP id k8ls313436wic.54.gmail; Sat, 28 Sep
 2013 16:18:39 -0700 (PDT)
X-Received: by 10.14.7.8 with SMTP id 8mr13611472eeo.4.1380410319542;
        Sat, 28 Sep 2013 16:18:39 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id a1si2254052ees.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=AES128-SHA bits=128/128);
        Sat, 28 Sep 2013 16:18:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MAyVY-1VXjIJ1Fau-009ugE
 for <msysgit@googlegroups.com>; Sun, 29 Sep 2013 01:18:39 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:bqSBlj6G/SAMCECqItBTEFuxq4CSAOUQkGm5zA/k3wERL2zzeXn
 aGU7exQ+df4TxsJ5q9U0HVPioO+X9dJ8KjQH7e5+/gib9ZMV7HsckTAnU8RuQwonOnXs/NG
 WYWITKvDHNJ5wCqUY7FaXjwEKJ8Ad42tzDCz/gLRvJ/Gw7bu5cO914aljVWm19CwZuWBRNa
 gkU9+PTZTQcQmmjQinxog==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235569>

Hi,

On Sun, 29 Sep 2013, Wataru Noguchi wrote:

> --- a/convert.c
> +++ b/convert.c
> @@ -724,6 +724,11 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>  {
>  	int i;
>  	static struct git_attr_check ccheck[NUM_CONV_ATTRS];
> +	
> +	if (NUM_CONV_ATTRS != 0) {
> +		ccheck[0].attr = NULL;
> +		ccheck[0].value = NULL;
> +	}

I wonder whether it would make more sense to use

	memset(ccheck, 0, sizeof(ccheck))

? But then, ccheck is static and *should* be initialized to all 0
according to the C standard. And re-initializing it to NULL would
invalidate the values that were set earlier.

Also, if NUM_CONV_ATTRS == 0, I would expect

>  	if (!ccheck[0].attr) {

to access an invalid location...

> diff --git a/git-compat-util.h b/git-compat-util.h
> index a31127f..ba02c69 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -237,6 +237,16 @@ extern char *gitbasename(char *);
>  #ifndef PATH_MAX
>  #define PATH_MAX 4096
>  #endif
> +#ifdef GIT_WINDOWS_NATIVE
> +/* Git for Windows checkout PATH_MAX is reduce to 260.
> + * but if checkout relative long path name, its length too short.
> + * thus, expand length.
> + */
> +#ifdef PATH_MAX
> +#undef PATH_MAX
> +#endif
> +#define PATH_MAX 4096
> +#endif

This looks fine, but I am wary... did you not say that a crash was caused
by this? In that case, we would have a user that accesses the respective
buffer without checking the size and we would still have to fix that bug..

Ciao,
Dscho

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
