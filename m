From: "Giovanni Funchal" <gafunchal@gmail.com>
Subject: Re: Files with colons under Cygwin
Date: Sun, 5 Oct 2008 11:28:03 +0200
Message-ID: <c475e2e60810050228g64a53842i7ecf8e61d37bf9bf@mail.gmail.com>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com>
	 <20081004233945.GM21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 11:32:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmPwn-0001ZU-JS
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 11:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbYJEJ2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 05:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbYJEJ2H
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 05:28:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:23194 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbYJEJ2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 05:28:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1563043fgg.17
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 02:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RP67tzkEkse/r3Z0KO1sL52gl5ZKC2m1hbkK7h8dUBs=;
        b=HPwZtaQlyEoexM99FZe1/CViUuRTcRMmRW/JUVwfU7T85Av0C9+JjWn8/lZ+o0aQ4Y
         jRMsMSPSHee+xG6+egla2AQyoiEa52hXqrOJFeeohNDNrs1ZNqwJc79Pi7bg+jlIEkCW
         WneASb1wVtdfvCfvFQiTe6d1zvYJvlXuzA3p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T8fwJ2B5ERY3T5NFNvgqm+9VVfM43oLspsmjTU2C7HR9C0YgH0IH5UpjcY0v1d08HW
         7GZD0p1dqe6xB9Y3jBa4ggarsw+RqTocU+AtLtGrRZtrZV+VPlcFmr9Vd6BVPz0g/xK+
         yrS018/53y38+aLb2X1OSzUggQE0WnBq8Otbw=
Received: by 10.187.198.8 with SMTP id a8mr823961faq.78.1223198883662;
        Sun, 05 Oct 2008 02:28:03 -0700 (PDT)
Received: by 10.187.245.17 with HTTP; Sun, 5 Oct 2008 02:28:03 -0700 (PDT)
In-Reply-To: <20081004233945.GM21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97504>

> Strange...  What version of Cygwin did you use?  When I tried this with
> Cygwin 1.5.25, I got the following error:
>
>  error: git checkout-index: unable to create file a:b (No medium found)

I'm on 1.5.25-15 on WinXP over a mounted network file system, but no
errors/warnings here...

Thanks for the clarifications and the patch,
-- Giovanni

On Sun, Oct 5, 2008 at 1:39 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Thu, Oct 02, 2008 at 04:02:23PM +0200, Giovanni Funchal wrote:
>>
>> Cygwin does not allow files with colons, I think this is Windows stuff
>> one just can't avoid.
>
> At least, you cannot use colon in Win32 API. They say Windows "native"
> API has less restrictions over what symbols are not allowed in file
> names, but I guess it is still not allowed.
>
>> If you have files with colons in a git
>> repository and try pulling them on cygwin, the file is empty, its name
>> is truncated and the status is wrong.
>>
>> linux $ date > a:b
>> linux $ git init
>> linux $ git add a:b
>> linux $ git commit -m test
>> linux $ git push
>> cygwin $ git pull
>
> Strange...  What version of Cygwin did you use?  When I tried this with
> Cygwin 1.5.25, I got the following error:
>
>  error: git checkout-index: unable to create file a:b (No medium found)
>
> Apparently, Git tried to create 'b' file on the drive 'a', and creating
> files outside of the working tree is not a very good thing to do from
> the security point of view, as it can easily overwrite anything in
> c:/windows/.
>
> So, here is a patch. It basically disallow backslashes and colons in
> file names on Windows (whether it is MinGW or Cygwin).
>
> I wonder if the problem exists on Mac OS X too. From what I heard, it
> does not treat ':' as a normal symbol. But I have no access to Mac OS X,
> so here is a patch for Windows only.
>
> -- >8 --
> From: Dmitry Potapov <dpotapov@gmail.com>
> Date: Sat, 4 Oct 2008 22:57:19 +0400
> Subject: [PATCH] correct verify_path for Windows
>
> Colon and backslash in names may be used on Windows to overwrite files
> outside of the working directory.
>
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> ---
>  read-cache.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 901064b..972592e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -701,6 +701,16 @@ inside:
>                        }
>                        return 0;
>                }
> +#if defined(_WIN32) || defined(__CYGWIN__)
> +               /*
> +                * There is a bunch of other characters that are not allowed
> +                * in Win32 API, but the following two create a security hole
> +                * by allowing to overwrite files outside of the working tree,
> +                * therefore they are explicitly prohibited.
> +                */
> +               else if (c == ':' || c == '\\')
> +                       return 0;
> +#endif
>                c = *path++;
>        }
>  }
> --
> 1.6.0.2.445.g1198
>
> -- >8 --
>
