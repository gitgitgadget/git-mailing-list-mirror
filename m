From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 8/9] builtin: check pager.<cmd> configuration if 
	RUN_SETUP_GENTLY is used
Date: Tue, 13 Apr 2010 12:12:43 +0200
Message-ID: <y2yfcaeb9bf1004130312l197983cnf92371acc88464db@mail.gmail.com>
References: <20100413021153.GA3978@progeny.tock> <20100413023003.GH4118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 12:13:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1d7J-00030a-RG
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 12:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab0DMKNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 06:13:07 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:6133 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab0DMKNE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 06:13:04 -0400
Received: by ey-out-2122.google.com with SMTP id d26so539655eyd.19
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=vQh5pljg/u8fCsnn1i14b2bEkpsgUAN832pToNs0BhY=;
        b=OGHWdRCZlYMYthyIhCirNAP9LjkzP26EhKu2UO8e4/QFFoMRzIE/idY0ieI3y79lgg
         h9jZs03DpraFFxMjRmNWzkXLccx/BU1L6s6oRQWTRIGmsMt5FkqQK0inbi0hxuZQPO+7
         qlYszozOeXLnOfrt77zYwLsn8lNesPmnBByQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Cc6W2y/wUmH8u1FNm5n2lrT+9WcSSFkBqZ76+h0fNA5LO02iUNWk/7OjUbH2iA7CSF
         mfYneIMdOP+tXalmRhTy8IFxcqSOYMiaINyzaEEYjz4N1K7ur8d7BVVM/nvVOEkzen7C
         EjHcntCU0tCx8pFecOqjEW89EY4fiCv3KRWKg=
Received: by 10.213.21.197 with HTTP; Tue, 13 Apr 2010 03:12:43 -0700 (PDT)
In-Reply-To: <20100413023003.GH4118@progeny.tock>
Received: by 10.213.58.203 with SMTP id i11mr2781246ebh.0.1271153583464; Tue, 
	13 Apr 2010 03:13:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144806>

2010/4/13 Jonathan Nieder <jrnieder@gmail.com>:
> diff --git a/git.c b/git.c
> index 20e9bfc..56e93cf 100644
> --- a/git.c
> +++ b/git.c
> @@ -251,7 +251,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>                        prefix = setup_git_directory_gently(&nongit_ok);
>                }
>
> -               if (use_pager == -1 && p->option & RUN_SETUP)
> +               if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
>                        use_pager = check_pager_config(p->cmd);
>                if (use_pager == -1 && p->option & USE_PAGER)
>                        use_pager = 1;

On the second look, there's another case, when RUN_SETUP_GENTLY is
set, but no repository is found. git_config() will pick
$(cwd)/.git/config if it exists. I guess it's OK for this series
because the true fix will require more changes.
-- 
Duy
