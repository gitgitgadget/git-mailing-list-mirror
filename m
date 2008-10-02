From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH] xdiff-interface.c: strip newline (and cr) from line before pattern matching
Date: Thu, 2 Oct 2008 11:29:27 +0100
Message-ID: <57518fd10810020329w257d91f1u3e2205fdaed888eb@mail.gmail.com>
References: <mJtumbyBuR0sRaFjwb6O5_D_ps0fVfz6APTAAjYMixV0MvzP8nEZRw@cipher.nrlssc.navy.mil>
	 <o5dqpNECJusQHKCTvRWiIqN2ZJ7w-fyC-0vM99FajJIgLsOwP3RNug@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Andreas Ericsson" <ae@op5.se>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 02 12:30:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlLSB-0002gO-B9
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 12:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbYJBK33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 06:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbYJBK33
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 06:29:29 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:55115 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbYJBK32 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 06:29:28 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1028727wfd.4
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=fkvzhD+69YSmn3dHgH6QFK1n4kDzIgSzkqSn8VrT/1A=;
        b=HhmiGP3Qx8vL74iBSJuHw2PQ+VJbl1mczbvnNJKtRLD/xCBBqxoTX9o7MIret0lYju
         FVExsaQm5PzhY7Kd7nQ9MnepjFRxjm9z+eHoyejPXt+VPDcgtLoYvfCFv/rd76+WZ6WM
         F4ETZfW8r6YpbISUae2MM+uiQKICYiUEiwEMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=qDLyDWkSfVUSbEU38c1uBsvPVZerxgR1mPHhoSS9sZWY7KTLGlN7yvTDRkT0aAaNr7
         Qh8GIzDWQVv/ZXMXSzowmN0ix5Yu/GJgoEHSbUSxlGqNHTGCqKUrAtwFBA6Dq3b8S6ls
         XjwIJYUN0CETKLuxKGWdDclMarYVdy5fmQB04=
Received: by 10.142.188.4 with SMTP id l4mr3805756wff.183.1222943367526;
        Thu, 02 Oct 2008 03:29:27 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Thu, 2 Oct 2008 03:29:27 -0700 (PDT)
In-Reply-To: <o5dqpNECJusQHKCTvRWiIqN2ZJ7w-fyC-0vM99FajJIgLsOwP3RNug@cipher.nrlssc.navy.mil>
Content-Disposition: inline
X-Google-Sender-Auth: 55e3b7d9800bea0a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97310>

On Wed, Oct 1, 2008 at 8:28 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> POSIX doth sayeth:
>
>   "In the regular expression processing described in IEEE Std 1003.1-2001,
>    the <newline> is regarded as an ordinary character and both a period and
>    a non-matching list can match one. ... Those utilities (like grep) that
>    do not allow <newline>s to match are responsible for eliminating any
>    <newline> from strings before matching against the RE."
>
> Thus far git has not been removing the trailing newline from strings matched
> against regular expression patterns. This has the effect that (quoting
> Jonathan del Strother) "... a line containing just 'FUNCNAME' (terminated by
> a newline) will be matched by the pattern '^(FUNCNAME.$)' but not
> '^(FUNCNAME$)'", and more simply not '^FUNCNAME$'.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
>
> This could be a little simpler if I knew what was guaranteed from xdiff.
> Such as whether the len elements of line were guaranteed to be newline
> terminated, or be greater than zero. But, the code in def_ff() in xemit.c
> is wrapped in 'if (len > 0)', so..
>
> -brandon
>
>
>  xdiff-interface.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 8bab82e..61f5dab 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -191,12 +191,22 @@ struct ff_regs {
>  static long ff_regexp(const char *line, long len,
>                char *buffer, long buffer_size, void *priv)
>  {
> -       char *line_buffer = xstrndup(line, len); /* make NUL terminated */
> +       char *line_buffer;
>        struct ff_regs *regs = priv;
>        regmatch_t pmatch[2];
>        int i;
>        int result = -1;
>
> +       /* Exclude terminating newline (and cr) from matching */
> +       if (len > 0 && line[len-1] == '\n') {
> +               if (len > 1 && line[len-2] == '\r')
> +                       len -= 2;
> +               else
> +                       len--;
> +       }
> +
> +       line_buffer = xstrndup(line, len); /* make NUL terminated */
> +
>        for (i = 0; i < regs->nr; i++) {
>                struct ff_reg *reg = regs->array + i;
>                if (!regexec(&reg->re, line_buffer, 2, pmatch, 0)) {
> --
> 1.6.0.2.323.g7c850
>
>

Looks good to me, or at least, works as advertised with a bunch of my
funcname patterns.
