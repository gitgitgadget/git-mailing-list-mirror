From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2] build: do not automatically reconfigure unless
 configure.ac changed
Date: Wed, 2 Jan 2013 09:07:11 -0800
Message-ID: <CANiSa6gqG_tBja_SyLSR5HCphaV7PYAk=ScXDdSk4VWpd-8uMw@mail.gmail.com>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com>
	<20130102072141.GB18974@elie.Belkin>
	<CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com>
	<20130102082544.GD18974@elie.Belkin>
	<20130102083837.GA9328@sigill.intra.peff.net>
	<20130102084807.GB22919@elie.Belkin>
	<50E4409B.4070203@gmail.com>
	<7va9sr4jgu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 18:07:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqRnD-0001Ge-Dm
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 18:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab3ABRHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 12:07:17 -0500
Received: from mail-ia0-f170.google.com ([209.85.210.170]:56659 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab3ABRHL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 12:07:11 -0500
Received: by mail-ia0-f170.google.com with SMTP id i1so12045252iaa.1
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 09:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mEoWkxId7CHP7qAtE7swA6xlMZ6bLQmpupbXObHShcE=;
        b=zuIxs98Xy0VNb4ekeKDlaPYk8zV8paFl+I72VJ6lD6OFmWBbb420uiGE9QJg9QCgxE
         jvMCJ/5WHaG06fVNLd+1BNLexK4Tx3ZNEmIUPQ8D1YXP35R/ZuBHH+Zl9q5ZkXGnxFRS
         +/wEJWqBBjRl2oFOBaGWp64giuGe6hAUg+L38zxcfC6TOTgygW8y0uxJd/f2Ep1EhghL
         iYxrvhpT4udeNK9ko8vHKDDZFV1crQ+vERvJ1sDUkq5YrO4c2F5cs0S5A0+QT3O5Wq7p
         71/7NzUGIf4/H8O3rqPXy+dljbtOyrwxpy3F6Hkl6Aj7SGTrc8CW/Lq2yBRNFpFROe0X
         nf/g==
Received: by 10.50.158.201 with SMTP id ww9mr35211608igb.22.1357146431386;
 Wed, 02 Jan 2013 09:07:11 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Wed, 2 Jan 2013 09:07:11 -0800 (PST)
In-Reply-To: <7va9sr4jgu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212527>

> diff --git a/Makefile b/Makefile
> index 26b697d..2f5e2ab 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2167,8 +2167,14 @@ configure: configure.ac GIT-VERSION-FILE
>         $(RM) $<+
>
>  ifdef AUTOCONFIGURED
> -config.status: configure
> -       $(QUIET_GEN)if test -f config.status; then \
> +# We avoid depending on 'configure' here, because it gets rebuilt
> +# every time GIT-VERSION-FILE is modified, only to update the embedded
> +# version number string, which config.status does not care about.  We
> +# do want to recheck when the platform/environment detection logic
> +# changes, hence this depends on configure.ac.
> +config.status: configure.ac
> +       $(QUIET_GEN)$(MAKE) configure && \
> +       if test -f config.status; then \
>           ./config.status --recheck; \
>         else \
>           ./configure; \

Looks great (at least from my 'make'-incompetent point of view :-)). I
do appreciate the comment. Thanks, everyone.
