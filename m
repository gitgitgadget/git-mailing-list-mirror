From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [PATCH] Avoid segfault in diff --stat rename output.
Date: Tue, 23 May 2006 21:06:44 +0200
Message-ID: <e7bda7770605231206t651d4b22xb30c07ad95cfcb39@mail.gmail.com>
References: <e7bda7770605221609h7c18c2ccpe92db34050d46f9f@mail.gmail.com>
	 <BAYC1-PASMTP115C9137E5BDABD705881BAE9B0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 23 21:07:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FicDW-0002cK-Bu
	for gcvg-git@gmane.org; Tue, 23 May 2006 21:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWEWTGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 15:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWEWTGq
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 15:06:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:63955 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750890AbWEWTGp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 15:06:45 -0400
Received: by nf-out-0910.google.com with SMTP id y25so793354nfb
        for <git@vger.kernel.org>; Tue, 23 May 2006 12:06:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VqvyEr/RC16avyyKPq1oOsbBYeejDEoIBKWZCW/tfZWRKv4RqJMyYiZwCqwpUagYVgA9d7V+JQKc7h4S7Wt/2SxHtVLHKWdP0qsvyGMXWPC8kOWODD4icmxsMrXd6IlHoVzUDBVANnVTk5seVwFmcDczgQHxyuLlNrJfMxSncyo=
Received: by 10.49.12.2 with SMTP id p2mr3830040nfi;
        Tue, 23 May 2006 12:06:44 -0700 (PDT)
Received: by 10.48.80.6 with HTTP; Tue, 23 May 2006 12:06:44 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <BAYC1-PASMTP115C9137E5BDABD705881BAE9B0@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20621>

This patch fixed the issue for me.

On 5/23/06, Sean <seanlkml@sympatico.ca> wrote:
>
> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
> ---
>  diff.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> On Tue, 23 May 2006 01:09:43 +0200
> "Torgil Svensson" <torgil.svensson@gmail.com> wrote:
>
> > Hi
> >
> > It seems like git-diff-tree has some problems with moved files:
> >
> > $ git-diff-tree -p --stat --summary -M
> > 348f179e3195448cea49c98a79cce8c7f446ce26
> > 343ca16424ba031b37e4df49afddaee098a8f347 | wc -l
> > *** glibc detected *** free(): invalid pointer: 0x12ecbbf0 ***
> > 6101
>
>
> diff --git a/diff.c b/diff.c
> index 7f35e59..a7bb9b9 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -237,7 +237,7 @@ static char *pprint_rename(const char *a
>                 if (a_midlen < 0) a_midlen = 0;
>                 if (b_midlen < 0) b_midlen = 0;
>
> -               name = xmalloc(len_a + len_b - pfx_length - sfx_length + 7);
> +               name = xmalloc(pfx_length + a_midlen + b_midlen + sfx_length + 7);
>                 sprintf(name, "%.*s{%.*s => %.*s}%s",
>                         pfx_length, a,
>                         a_midlen, a + pfx_length,
> --
> 1.3.GIT
>
>
