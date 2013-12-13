From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 3/4] remote-hg: fix 'shared path' path
Date: Fri, 13 Dec 2013 18:58:04 +0100
Message-ID: <CALWbr2wkSNDh2VTz05sndymUe=fOsApMrg6Jjp0a6mbEfhru=g@mail.gmail.com>
References: <1386421783-27781-1-git-send-email-felipe.contreras@gmail.com>
	<1386421783-27781-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 18:58:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrX08-0003Rt-TZ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 18:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab3LMR6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 12:58:06 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44466 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab3LMR6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 12:58:04 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so2875266pbb.31
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 09:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G67kRikIsjLLf5dDmBfDHsaDWRHkQh5oyp6TdObZZE4=;
        b=Um+X23hSnm+2WYsXulTU35/8AhPC3s1s+BTuAmJdWl2a2z0Q2Jn4L7bxxPbq1ML0pI
         uWzJMZE+D0DwuBZ7JNfmB4GS9T+HE6P9CRpLmHWGqZ4W4wp0OhRSk388xkmnPiTx/i+f
         aHGV0t2XClCVJmR2w3geH2ZDRNk43iMhbGlGt5eSZxd/Yd2ixxRAyN32SGEN5i6s3hs6
         6vijWynBddsuEleUPQw4LBgabjaaj+o94f57KMpxcqeoawRSF1JCw8ms8/aNvoZBewF3
         YuoIDSBI9OP4m1PrFd41BcsXonafNr5q2jt4igp3E1EX+vQqWyzXk5Bpwky7Z1z9/k1O
         AWhg==
X-Received: by 10.68.29.103 with SMTP id j7mr4824285pbh.17.1386957484206; Fri,
 13 Dec 2013 09:58:04 -0800 (PST)
Received: by 10.70.124.228 with HTTP; Fri, 13 Dec 2013 09:58:04 -0800 (PST)
In-Reply-To: <1386421783-27781-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239260>

On Sat, Dec 7, 2013 at 2:09 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> If the repository is moved, the absolute path of the shared repository
> would fail.
>
> Make sure it's always up-to-date.
>
> Reported-by: Michael Davis <mjmdavis@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index aa1d230..718ef95 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -416,6 +416,9 @@ def get_repo(url, alias):
>          local_path = os.path.join(dirname, 'clone')
>          if not os.path.exists(local_path):
>              hg.share(myui, shared_path, local_path, update=False)
> +        else:
> +            # make sure the shared path is always up-to-date
> +            util.writefile(os.path.join(local_path, '.hg', 'sharedpath'), hg_path)

Considering this is modifying a "private mercurial file", would it
make sense to include a test like I did in my equivalent patch ?
