From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v6 5/7] submodule: fix segmentation fault in
 submodule--helper clone
Date: Mon, 29 Feb 2016 15:36:40 -0800
Message-ID: <CA+P7+xpOBa5sKQyZRVpGU9kxn9281vpnF4rUYyNOeBtWiqjjSg@mail.gmail.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
 <1456786715-24256-6-git-send-email-jacob.e.keller@intel.com> <CAGZ79kZdct21==TeRoVr4NpgeKuHeUfpJ1Qsh+_tPJt0apr5DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:37:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaXNE-00017t-HT
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 00:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbcB2XhC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 18:37:02 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35072 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcB2XhB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 18:37:01 -0500
Received: by mail-ig0-f181.google.com with SMTP id hb3so6579900igb.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 15:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tEtLNqHQhGg0zYnxrDXCYO0wUI/OQ3dERrJHLhflFP8=;
        b=paWk4URZ8fxE0mctAykV7GLygDOcfpN95hrlHLOuO+xMBCS+doYwrkCb8XWrz34oXE
         psMVdIDbmRbj5qEbL3UHOtoFx4tZhdaJbCL94qmLNp1AkkijwP8/5AnelOG+f3eHCDos
         d+WEOJ5U3732h5gPVVsE+o329FuKvKXd++w9Eiy323Qx64dk+pRJ3L+jzQTAv5RxxnA4
         zFtSYqO64jIneNTR0oMs4pZeYoyI5QAZI6hsTFWQQUBI62GlD7YFPwx3iMKBM1ZFBRl4
         ox6EU2reAY1l//ZrJBmE/t21iPixeqU6tDv75i4JJgLpK5dPzGGXwlD4G/iCFzO5EiTe
         wWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tEtLNqHQhGg0zYnxrDXCYO0wUI/OQ3dERrJHLhflFP8=;
        b=iAiCOmEsKNzrQ1hE1mPrMvdWEjoMV9wpI8ptncivW6cfhIq+H00BY1YPKTnoXEi9g9
         R9bxPvIjJoVdoDQzTineAxU33CsMsvA9triS07GPnTNZUd57es/v628gpnUVQYLFv5ZG
         Xsj9Sg3L4oCCs/GMATdQa6Q0ojJbkgSxjyEjm+dhdhTCX6mDgqUSS6v4MW+Nmenjq2xT
         gYL57W8eHAUQqN/LltDWVgsS5QuprMzZy+/8rihG3nK/xNFo/+4x9Q/lAB7WdydgVAlx
         vcDOB3P17Mph8cYjGW2yvwzoT/wJ1ghyH1RjbfZyxYW7oK624gTcdfZZa7P2muiKjAxL
         F7Lw==
X-Gm-Message-State: AD7BkJJ1z8ySN8FNqWfOsQCxzvxBYRIx1kftmlJkbbyUX6aaqpFi0mcC87FkQrj+T4sib5izKNKfUWwG5wABEg==
X-Received: by 10.50.43.168 with SMTP id x8mr547885igl.92.1456789020235; Mon,
 29 Feb 2016 15:37:00 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Mon, 29 Feb 2016 15:36:40 -0800 (PST)
In-Reply-To: <CAGZ79kZdct21==TeRoVr4NpgeKuHeUfpJ1Qsh+_tPJt0apr5DA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287938>

On Mon, Feb 29, 2016 at 3:20 PM, Stefan Beller <sbeller@google.com> wrote:
>
> I think this bug was put in, by "literally" translating from shell,
> see ee8838d15776, where the shell code was rewritten to C,
> specially:
>
>  git clone $quiet ${depth:+"$depth"} -n ${reference:+"$reference"} \
>      --separate-git-dir "$gitdir" "$url" "$sm_path"
>
> Anything except url and path are done optionally, but url, and path not so.
> The C code was inspired by this and aligned.
>
> This patch makes sense to me,
> Thanks,
> Stefan
>

The only thing that bothers me is that git submodule--helper clone
uses --path and --url instead of just taking two arguments after all
the optional parameters. Traditionally options are supposed to be just
that, optional. However given that long term we do not intend to keep
submodule--helper, I am not too worried about how it works here.

Thanks,
Jake
