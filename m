From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 15/20] t/t5000-tar-tree.sh: avoid "test <cond> -a/-o
 <cond>"
Date: Tue, 10 Jun 2014 13:08:05 -0700
Message-ID: <20140610200804.GD72977@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
 <1402066563-28519-16-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:08:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSLH-00043a-JJ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbaFJUIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 16:08:18 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:57237 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbaFJUIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 16:08:16 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so549794pdi.41
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 13:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bE6TIVlJYs8uj6EREctbU39xd89VtjDqozwV/2IlMZ8=;
        b=QtegEIB79Nn3oOjmLXl9mz4pxU7tJdF7jmA/Va2l65NQ8mCCdLFOIDhId+jKUC/Sp3
         aFZjJk8Le4JegKlmQ7yWmPY6dm0Prwuc8oQdebmXW6Co4+NNvS24ogGlk5SqBOkX/HgM
         c9tCcqgUA2yZ/APIWaxIb7IMw1yqOF88DpcdXD0/TKkGpdTYs77rC1XRNHIFgrqGTPeU
         l9+SRlhFnFWJ02QFmSwDuwVGwX2tyCys9M/BVkljdZJop/bhzPoX9hKpW7Qa03J9Vbpb
         zQgq1sKd2QCJzis2B2lm3+MruXxeYMslB2h//xEIML8fUvhL1fNNfpSUXkXLRj8hRVmI
         XWHg==
X-Received: by 10.68.103.165 with SMTP id fx5mr14177978pbb.118.1402430895773;
        Tue, 10 Jun 2014 13:08:15 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id oz7sm71008368pbc.41.2014.06.10.13.08.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 13:08:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402066563-28519-16-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251223>

[Resent using Ren=C3=A9's correct email address this time, sorry for th=
e noise]

On Fri, Jun 06, 2014 at 07:55:58AM -0700, Elia Pinto wrote:
> The construct is error-prone; "test" being built-in in most modern
> shells, the reason to avoid "test <cond> && test <cond>" spawning
> one extra process by using a single "test <cond> -a <cond>" no
> longer exists.
>=20
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  t/t5000-tar-tree.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 74fc5a8..ad6fa0d 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -72,7 +72,7 @@ check_tar() {
>  			for header in *.paxheader
>  			do
>  				data=3D${header%.paxheader}.data &&
> -				if test -h $data -o -e $data
> +				if test -h $data || test -e $data
>  				then

This looks okay, but it raises a question for the original author
(Ren=C3=A9, I think that's you so I've added you to the To: line).

Should that be "test -f" instead of "test -e"?

This is a very minor note and should not block this patch.
It's probably a change that's better made in a follow-up patch.

>  					path=3D$(get_pax_header $header path) &&
>  					if test -n "$path"
--=20
David
