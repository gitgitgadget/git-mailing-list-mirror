From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 1/4] t5541-http-push: add test for chunked
Date: Wed, 04 May 2011 04:51:22 -0700 (PDT)
Message-ID: <m3wri6vg5h.fsf@localhost.localdomain>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
	<1304503896-5988-1-git-send-email-rctay89@gmail.com>
	<1304503896-5988-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 13:51:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHac6-00089J-4v
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 13:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab1EDLvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 07:51:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40111 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab1EDLvY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 07:51:24 -0400
Received: by fxm17 with SMTP id 17so753497fxm.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 04:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=86bjI1Mxf9lTSD9YPd3KfGmust20zwrIdMWWYysH7Yw=;
        b=L9Okq30b7ErJ3nzcO6yyBBrTwAbxHp+K8bPKhbNsPLt80EQXu0rUeuZDRi/+XxLgn9
         EZvKTWf1vCtsnvfdbAae/eznBc0Ju3YP2HFhgm6MH2qOaUkJgwn5/BF/iXA0myXPHiNY
         /VvPp7S46Zv//O7FM+wslfnfI2cCKcqpCRO3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=S7/JZIq8RxfWp4hbxFKqN4h2yVW7w0qTzelyAkqoe8pNcFg9CzDaHlxfh4D/Uwv6iF
         BcTnd+337J8QzM7uWtSh4NSWedXRDsf2nc2iFodGjKg04y1O1hBMidyeTO7xOQiL1jhS
         VzfSBYcHERqa+D4Kxak9Mcen7s/kvXT7wloak=
Received: by 10.223.24.213 with SMTP id w21mr1156864fab.113.1304509883559;
        Wed, 04 May 2011 04:51:23 -0700 (PDT)
Received: from localhost.localdomain (abvb15.neoplus.adsl.tpnet.pl [83.8.199.15])
        by mx.google.com with ESMTPS id o17sm365018fal.1.2011.05.04.04.51.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 04:51:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p44BofRp008961;
	Wed, 4 May 2011 13:50:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p44BoISN008957;
	Wed, 4 May 2011 13:50:18 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1304503896-5988-2-git-send-email-rctay89@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172739>

Tay Ray Chuan <rctay89@gmail.com> writes:

> +test_expect_success 'push (chunked)' '
> +	git checkout master &&
> +	test_commit commit path3 &&
> +	HEAD=$(git rev-parse --verify HEAD) &&
> +	git config http.postbuffer 4 &&
> +	git push -v -v origin $BRANCH 2>err &&
> +	grep "POST git-receive-pack (chunked)" err &&
> +	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> +	 test $HEAD = $(git rev-parse --verify HEAD)) &&
> +	git config --unset http.postbuffer
> +'

It is a very minor issue, a nitpick really; but wouldn't it be better
to use

  +	git config http.postbuffer 4 &&
  +	test_when_finished "git config --unset http.postbuffer" &&  

This way you would have `http.postBuffer` unset even if any of
intermediate commands fail, preparing clean state for next test.
Though in this case that doesn't matter, as it is the very last test.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
