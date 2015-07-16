From: "Luis R. Rodriguez" <mcgrof-3uybbJdB1yH774rrrx3eTA@public.gmane.org>
Subject: Re: GNU diff and git diff - difference on myers algorithm?
Date: Thu, 16 Jul 2015 12:07:50 -0700
Message-ID: <CAB=NE6UFMv0qu8fJ1P2-pJCF0tSGKoW+uKhfwt0jV5fj2wZGSQ@mail.gmail.com>
References: <CAB=NE6XRnKAY6t+dxT7vO_4wqngXvULh-CqezEAs2r99FkNCTg@mail.gmail.com>
 <0add7d95076f5b112af90d8566c29203@www.dscho.org> <CAB=NE6VGX332=CvhQM4sc27AM8ae5S1kdRnm5sMfoqkU=b=ebg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>,
	"Luis R. Rodriguez" <mcgrof-IBi9RG/b67k@public.gmane.org>,
	"cocci-/FJkirnvOdkvYVN+rsErww@public.gmane.org" <cocci-/FJkirnvOdkvYVN+rsErww@public.gmane.org>,
	"backports-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <backports-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Johannes Schindelin <johannes.schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Thu Jul 16 21:08:13 2015
Return-path: <backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glb-backports-wOFGN7rlS/M9smdsby/KFg@public.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>)
	id 1ZFoVw-0005X7-GS
	for glb-backports-wOFGN7rlS/M9smdsby/KFg@public.gmane.org; Thu, 16 Jul 2015 21:08:12 +0200
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1755417AbbGPTIL (ORCPT <rfc822;glb-backports@m.gmane.org>);
	Thu, 16 Jul 2015 15:08:11 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35547 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762AbbGPTIK (ORCPT
	<rfc822;backports-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>); Thu, 16 Jul 2015 15:08:10 -0400
Received: by oihq81 with SMTP id q81so56861971oih.2;
        Thu, 16 Jul 2015 12:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=j/qeITBh9poIW8GMoJKoBnfWTNcEkllN2I1KdmRGBJg=;
        b=yKeisjKOXAML9F+o6rdV19pd8koZ2UtiZwjtr7Le6iaaWPl4pBgTLl2mmv/dFQqRc0
         PUGX8G/O/kF9BNUS/IGYUGgr+yWFds0Y4zDalPwhiVWki/JrpunKm4OO9Ddc833D60we
         W9F/eLoyc075PBzCz+SdSvCOM5J5ApEzMDNobQy4Ye71mma3QlXNqfmqiYMpqSDwfBbi
         6ZQ7Jj3tJ+XySTB6Ym+ZFkm4LB+lI5xwCGNEXSQ8DLCu82SY8VforpE4THXxBNN/TCEn
         +dQJnIqvEdeDHiiU1M6POaLYyjf8OlGZjKHYlIPVJCsiiYdL8N74/vYArtLVi2KSDMQL
         qx8w==
X-Received: by 10.182.153.197 with SMTP id vi5mr10060886obb.28.1437073689980;
 Thu, 16 Jul 2015 12:08:09 -0700 (PDT)
Received: by 10.202.49.68 with HTTP; Thu, 16 Jul 2015 12:07:50 -0700 (PDT)
In-Reply-To: <CAB=NE6VGX332=CvhQM4sc27AM8ae5S1kdRnm5sMfoqkU=b=ebg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-Google-Sender-Auth: jgAza2biYF6htQ1icO_YiWI5UBc
Sender: backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274037>

On Fri, Jun 12, 2015 at 11:52 AM, Luis R. Rodriguez
<mcgrof-3uybbJdB1yH774rrrx3eTA@public.gmane.org> wrote:
> OK wells I'm curious about more research / effort when trying to
> evaluate a diff with two seprate but adjoining preprocessor directives
> and if anyone has implemented an optimizaiton option to let the diff
> generator join them.
>
> For example, to let it infer that:
>
> --- a/test.c
> +++ b/test.c
> @@ -10,8 +10,6 @@ int main(int argc, char *argv[])
>
>  #ifdef FOO
>         a = 4;
> -#endif /* FOO */
> -#ifdef FOO
>         a = 5;
>  #endif /* FOO */
>
> is possible.

Anyone familiar if any tool exists today that would optimize this? Is
anyone working on it? Would git be a good place for such a thing? I'd
consider it as an option to optimize a diff. This for example is
extremely useful for us working with Coccinelle where we have a tool
writing code for us, while such an optimization might be useful to
Coccinelle it would seem like a rather generic feature, its just not
clear to me where to give such a tool a proper home.

 Luis
