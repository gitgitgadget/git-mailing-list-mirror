From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/2] entry.c: convert checkout_entry to use strbuf
Date: Wed, 23 Oct 2013 14:58:08 +0200
Message-ID: <CALWbr2z90_LysnZiPaGr-X98EceX_d0yJ6_y_te16bC818xAEQ@mail.gmail.com>
References: <20131021193223.GC29681@sigill.intra.peff.net>
	<1382532907-30561-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: git <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, =?UTF-8?Q?Torsten_B=C3=83=C2=B6gershausen?= <tboegi@web.de>, 
	Wataru Noguchi <wnoguchi.0727@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?UmVuw4PCqSBTY2hhcmZl?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>
X-From: msysgit+bncBD3NZH6HQMJBBYEPT6JQKGQEXTQN2LY@googlegroups.com Wed Oct 23 14:58:10 2013
Return-path: <msysgit+bncBD3NZH6HQMJBBYEPT6JQKGQEXTQN2LY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f61.google.com ([74.125.83.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD3NZH6HQMJBBYEPT6JQKGQEXTQN2LY@googlegroups.com>)
	id 1VYy0n-0005pW-Mr
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 14:58:10 +0200
Received: by mail-ee0-f61.google.com with SMTP id d51sf90717eek.16
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=JfqbR2n7kTpXMVmP+OAJxkIsPYVuzVVHdn+CSNRrtxk=;
        b=T2CLZtSoRxbM9n1pQOGE1P/l6LlOU0kPmYIokGu49GOk2nOIWdM/Qf+kWQyMy/HNeX
         mkZfs3mlCiEjpAiXQQADXWkptadjShXPri4Ps0HM8Bd66N/DgxD5u7gpvjeoDGgGp0/o
         FSD+o578M68UAPpSXnGqCR1Vq8iox6P4QhofcYabSKrYIXVTkelqByn2oxJBVoc6GqP5
         wPvUKzj/G7aR2oGjNSvBEamhbnzRz8+SH2y6d+tqu6Hh+P7f2M38nBI5G8zsysv6qK+F
         ++2Cgenq5bZZrwGnM6vOWHq3OkXOE9QCH+LfmZ5zC1L5qVTaZsQIYel9SoFlFQNzGzEe
         L6OQ==
X-Received: by 10.152.21.9 with SMTP id r9mr19966lae.22.1382533089335;
        Wed, 23 Oct 2013 05:58:09 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.6.98 with SMTP id z2ls133633laz.108.gmail; Wed, 23 Oct
 2013 05:58:08 -0700 (PDT)
X-Received: by 10.112.11.20 with SMTP id m20mr1171466lbb.4.1382533088579;
        Wed, 23 Oct 2013 05:58:08 -0700 (PDT)
Received: from mail-la0-x236.google.com (mail-la0-x236.google.com [2a00:1450:4010:c03::236])
        by gmr-mx.google.com with ESMTPS id re4si2065577bkb.1.2013.10.23.05.58.08
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 05:58:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of apelisse@gmail.com designates 2a00:1450:4010:c03::236 as permitted sender) client-ip=2a00:1450:4010:c03::236;
Received: by mail-la0-f54.google.com with SMTP id gx14so611056lab.41
        for <msysgit@googlegroups.com>; Wed, 23 Oct 2013 05:58:08 -0700 (PDT)
X-Received: by 10.112.141.165 with SMTP id rp5mr2093494lbb.3.1382533088232;
 Wed, 23 Oct 2013 05:58:08 -0700 (PDT)
Received: by 10.112.50.240 with HTTP; Wed, 23 Oct 2013 05:58:08 -0700 (PDT)
In-Reply-To: <1382532907-30561-1-git-send-email-pclouds@gmail.com>
X-Original-Sender: apelisse@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of apelisse@gmail.com designates 2a00:1450:4010:c03::236
 as permitted sender) smtp.mail=apelisse@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236508>

On Wed, Oct 23, 2013 at 2:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> The old code does not do boundary check so any paths longer than
> PATH_MAX can cause buffer overflow. Replace it with strbuf to handle
> paths of arbitrary length.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  To get this topic going again. These two patches kill PATH_MAX in
>  entry.c and builtin/checkout-index.c

Thanks !

> diff --git a/entry.c b/entry.c
> index acc892f..d955af5 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -237,16 +237,18 @@ static int check_path(const char *path, int len, st=
ruct stat *st, int skiplen)
>  int checkout_entry(struct cache_entry *ce,
>                    const struct checkout *state, char *topath)
>  {
> -       static char path[PATH_MAX + 1];
> +       static struct strbuf path_buf =3D STRBUF_INIT;
> +       char *path;
>         struct stat st;
> -       int len =3D state->base_dir_len;
> +       int len;
>
>         if (topath)
>                 return write_entry(ce, topath, state, 1);
>
> -       memcpy(path, state->base_dir, len);
> -       strcpy(path + len, ce->name);
> -       len +=3D ce_namelen(ce);
> +       strbuf_reset(&path_buf);

I think this is not required

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
