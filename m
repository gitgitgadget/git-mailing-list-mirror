From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Avoid unportable nested double- and backquotes in shell
 scripts.
Date: Sat, 8 Jan 2011 10:14:41 -0600
Message-ID: <20110108161441.GA28898@burratino>
References: <20110108090105.GB14536@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 08 17:17:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbbTm-0004F9-3h
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 17:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab1AHQOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 11:14:51 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39664 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab1AHQOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 11:14:50 -0500
Received: by gwj20 with SMTP id 20so8091792gwj.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 08:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pVWXtCZdHf1QiDfvFawykRgCAVs2/IZ6V4dKSARvGx8=;
        b=b7V0l3WUStQllYrnygGQ4K9byWY6xbLcXME+NRnJVjyofwsGr79mzgMYsFDaMTVWS5
         uiwtVH0+zGdFsqv6bQabOM5imIR6ck2JXHISQXxOTieG8gMqZuPkESf1wqw2bMHEThI2
         2E/X/wkk32xDdbU5mgKnSBMdcGhJL+PYttd5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qAuEIrA2WrJWo7LiFy74Sl0fodROJp05kM5iD+r7vo/rhzG56zmJWBerTvswiDuU5E
         5hMsx1xaZmj/5QaRCPEzE0KZc7B2fPPeraiXEXWSgJ5m9MUqX+5uUoH7p2pg0OXWdTMG
         INTghNCz89JFOq3ysgqV2Pf6B7mNYuFeffPsI=
Received: by 10.236.109.132 with SMTP id s4mr1724944yhg.83.1294503289742;
        Sat, 08 Jan 2011 08:14:49 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id m49sm872753yha.2.2011.01.08.08.14.47
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 Jan 2011 08:14:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110108090105.GB14536@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164827>

Ralf Wildenhues wrote:

> [Subject: Avoid unportable nested double- and backquotes in shell scripts]
>
> Some shells parse them wrongly, esp. pdksh.

How does it treat $( ) command substitutions?  (We use those more
heavily and they are easier on the eyes anyway.)

> --- a/t/t9107-git-svn-migrate.sh
> +++ b/t/t9107-git-svn-migrate.sh
> @@ -94,7 +94,7 @@ test_expect_success 'migrate --minimize on old inited layout' '
>  		echo "$svnrepo"$path > "$GIT_DIR"/svn/$ref/info/url ) || exit 1;
>  	done &&
>  	git svn migrate --minimize &&
> -	test -z "`git config -l | grep "^svn-remote\.git-svn\."`" &&
> +	! git config -l | grep "^svn-remote\.git-svn\." &&

I thought I remembered portability problems with the

	! a | b

construct but it seems I am wrong; t7810-grep.sh uses that
construct without trouble, at least.
