From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Thu, 16 Feb 2012 01:15:27 -0800 (PST)
Message-ID: <m3hayrrvf9.fsf@localhost.localdomain>
References: <vpq39abrxav.fsf@bauges.imag.fr>
	<1329381560-15853-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 16 10:15:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxxRR-0002BU-GG
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 10:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539Ab2BPJPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 04:15:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48949 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757527Ab2BPJPa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 04:15:30 -0500
Received: by eaah12 with SMTP id h12so642539eaa.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 01:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=7e10l59Iw0ChsrY+MYEk8Ybvj1xoZ3DtfY16Kx9wPfs=;
        b=A5oyFXmp81/hiRDq2E9dNPRWQ031QWyZxdICu9TMoeWT2GkpgwQJ9fxKmUcC5Jghyi
         naA96CGRdx6zRm1Tha7yjGMU6m0cjJ5ZsgZq1GTyDs1Uhr9lUQlbpRzZeDy92u9eNaym
         jCxDSSn62JPVNXZimuwsgvaZ541CzT3DyUdDw=
Received: by 10.14.127.4 with SMTP id c4mr1141367eei.7.1329383728158;
        Thu, 16 Feb 2012 01:15:28 -0800 (PST)
Received: from localhost.localdomain (abwb213.neoplus.adsl.tpnet.pl. [83.8.225.213])
        by mx.google.com with ESMTPS id u9sm4171588eem.11.2012.02.16.01.15.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Feb 2012 01:15:27 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1G9FN2r006194;
	Thu, 16 Feb 2012 10:15:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1G9FMNM006191;
	Thu, 16 Feb 2012 10:15:22 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1329381560-15853-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190888>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +verbose "Auto-detecting PDF viewer"
> +for command in xdg-open evince okular xpdf acroread; do
> +    if [ "$PDFVIEWER" = "" ]; then
> +	if command -v "$command" >/dev/null 2>&1; then
> +	    PDFVIEWER="$command"
> +	else
> +	    verbose_progress
> +	fi
> +    fi
> +done
> +verbose_done "$PDFVIEWER"

Why we autodetect PDF viewer unconditionally?  Why we do not stop on
first detected viewer rather than last?  Why not

  +if [ "$PDFVIEWER" = "" ]; then
  +	verbose "Auto-detecting PDF viewer"
  +	for command in xdg-open evince okular xpdf acroread; do
  +		if command -v "$command" >/dev/null 2>&1; then
  +			PDFVIEWER=$command
  +			break
  +		else
  +			verbose_progress
  +		fi
  +	done
  +	verbose_done "$PDFVIEWER"
  +fi

Nb. Documentation/CodingGuidelines says:

  For shell scripts specifically (not exhaustive):
  
  [...]
  
   - We prefer "test" over "[ ... ]".

I know that 'contrib/' is more relaxed...
-- 
Jakub Narebski
