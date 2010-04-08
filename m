From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2] Replace hard-coded path with one from <paths.h>
Date: Thu, 8 Apr 2010 14:08:30 +0200
Message-ID: <z2o40aa078e1004080508z17c5e71by371bbe6e1cdb8c50@mail.gmail.com>
References: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
	 <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
	 <20100404222801.GB31315@arachsys.com>
	 <20100406163525.GF15306@arachsys.com>
	 <20100406163643.GG15306@arachsys.com>
	 <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
	 <20100408105850.GD2146@arachsys.com>
	 <m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
	 <20100408115706.GE2077@arachsys.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 14:08:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzqXG-0003k2-Un
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 14:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341Ab0DHMId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 08:08:33 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:60444 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab0DHMIc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 08:08:32 -0400
Received: by bwz1 with SMTP id 1so1716635bwz.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A/H8+vRhIa/LZSRjSoU3NariJ2EB7zUe4C9bXVApO/E=;
        b=jW3XYdA+lv+/ElQR2V15viXehSYqc2Xu4t//1q3wdLNDULLM8t6Gyl681Oll9e38ex
         HfrQz0NgCBb/4uRizPalx8tdjGFm45vMrHea4vNuL69kQEOI6Rg3Bps6ffqU7W2yxnL2
         GigoU65nt+HmtYFlUMovl8h03HtOExpNHAEMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=KZVsEXdhTv7/t2KxUPcPSs/G1yZdrOvWGjTSf2UEHVoksXBMKc62LazScRk1iFEEpO
         EDLfJCATM6KmJ0PfGThrlpKXjdO7Q5MJ4/0Iys1aQpZfKeMsu4AmZ6ZEtGN3g+p9CPpa
         OScWJbGKt49GK5RH9KGC4ig0kuLzrta3sZkDE=
Received: by 10.204.72.202 with HTTP; Thu, 8 Apr 2010 05:08:30 -0700 (PDT)
In-Reply-To: <20100408115706.GE2077@arachsys.com>
Received: by 10.204.15.23 with SMTP id i23mr48224bka.106.1270728510866; Thu, 
	08 Apr 2010 05:08:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144354>

On Thu, Apr 8, 2010 at 1:57 PM, Chris Webb <chris@arachsys.com> wrote:
> In exec_cmd.c, git hard-codes a default path of /usr/local/bin:/usr/b=
in:/bin.
> Get an appropriate value for the system from <paths.h> if possible in=
stead.
> Do not attempt to #include <paths.h> under Windows.
>
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
> =A0exec_cmd.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0git-compat-util.h | =A0 =A06 ++++++
> =A02 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index b2c07c7..bf22570 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -107,7 +107,7 @@ void setup_path(void)
> =A0 =A0 =A0 =A0if (old_path)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addstr(&new_path, old_path);
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addstr(&new_path, "/usr/local/bi=
n:/usr/bin:/bin");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addstr(&new_path, _PATH_DEFPATH)=
;
>
> =A0 =A0 =A0 =A0setenv("PATH", new_path.buf, 1);
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 7e62b55..9443b9b 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -70,6 +70,8 @@
> =A0#define WIN32_LEAN_AND_MEAN =A0/* stops windows.h including winsoc=
k.h */
> =A0#include <winsock2.h>
> =A0#include <windows.h>
> +#else
> +#include <paths.h>
> =A0#endif
>

Are you sure that all non-Windows platforms have paths.h? It seems
that at least some Open Solaris versions[1] are missing it as well.
Perhaps this should be guarded by a HAVE_PATHS_H define instead?

[1]: http://mail-index.netbsd.org/tech-pkg/2008/11/24/msg002103.html

--=20
Erik "kusma" Faye-Lund
