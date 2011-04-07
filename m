From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/9] gettext.h: Avoid using a non-standard C construct
Date: Thu, 7 Apr 2011 17:10:15 -0500
Message-ID: <20110407221015.GA20080@elie>
References: <4D9E056C.1070906@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Apr 08 00:10:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7xPK-0006f6-IX
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 00:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414Ab1DGWKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 18:10:25 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52592 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab1DGWKY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 18:10:24 -0400
Received: by gxk21 with SMTP id 21so1214379gxk.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xVvhRHPVIz+bwBIJhfcK1XDjS2TX+d8Oh7ZhvVLvbDo=;
        b=nU7RRMZUeXNrfXrcyQxy+rVcbwu4wYUNxDD0qvpdTcSlvUCiwdLYKc1JbD8Jz5S7Hw
         PV+/CxIBvUh0DGBjDSz/yXNEO0na6QKhAyqBJyTkzzV6wfXfvKl0Ysq1ZxT6sxkUXXzH
         zL/KUTTF39wquZ+N1f67M7UBAl9WfWZuxzSyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EgRXdCp8EPQTo8sjZ8mQa0kvFWPJi/BKzr1/0X6nd8jbkdry7QI4Yxa8yh9nmN7WyF
         FU5p+Ousao42RhchPnVCfyhB5NTKtUgUcwz51YHutuNzYVyoYI4s355vJL374/EBcPsa
         8PYS7Gs0Wcxt9BY/2WAv2Ffv8Qv0x/38vLfno=
Received: by 10.236.79.74 with SMTP id h50mr1913392yhe.82.1302214223335;
        Thu, 07 Apr 2011 15:10:23 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.sbcglobal.net [69.209.53.77])
        by mx.google.com with ESMTPS id u33sm943808yhn.60.2011.04.07.15.10.21
        (version=SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 15:10:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9E056C.1070906@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171086>

Hi,

Ramsay Jones wrote:

> +++ b/gettext.h
> @@ -35,6 +35,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
[...]
> -#define N_(msgid) (msgid)
> +#define N_(msgid) msgid

Good catch.  Thanks!

> In particular, standard C does not allow a parenthesized string
> as an array initializer.

The subject line seems unnecessarily vague.  Why not:

	i18n: avoid parenthesized string as array initializer

	The syntax

		static const char ignore_error[] = ("something");

	is invalid C.  GCC and MSVC can parse it, but for example
	tcc cannot.  So remove the parenthesis from the definition
	of the N_() macro.

	Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
	Acked-by: Jonathan Nieder <jrnieder@gmail.com>
