From: Christian Himpel <chressie@googlemail.com>
Subject: Re: [PATCH] git-am: force egrep to use correct characters set
Date: Mon, 28 Sep 2009 14:09:49 +0200
Message-ID: <20090928120949.GA3964@mrslave>
References: <215cc4f241162377b9249c2b3d74050cc77bac16.1253893253.git.chressie@gmail.com>
 <f0bd48168975c3b2328cf26f9a37a0f54b898473.1253896646.git.chressie@gmail.com>
 <20090927074015.GB15393@coredump.intra.peff.net>
 <4AC06FFF.20008@viscovery.net>
 <20090928093216.GA31459@lamagra.informatik.uni-ulm.de>
 <4AC0877E.7020204@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Himpel <chressie@googlemail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 28 14:10:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsF3J-0007oX-K2
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 14:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZI1MJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 08:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbZI1MJt
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 08:09:49 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:56422 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbZI1MJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 08:09:49 -0400
Received: by fxm18 with SMTP id 18so3592732fxm.17
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PEt/oIlxbNgMUa8QR7hmTzH1SaZbiUdkTb/yPqhNwlc=;
        b=cOZ6oyf2AnpHcRvE6Fgg7kPotxLOaV4QBtrVE1+ahzhyObxTVB51iIfwS1VUWebEVU
         RKUbwjowgtWxhwK44mwTU7rFhbWw8ZhvpYLGDsA1nJ/doeeDjx9V8Mo8sdrhUYAph7ur
         LSddww8xMv3i1bYJkfVt8XpnAPH2UToSHWOkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YmZunMfGDMU6wsaZNrv6j3u7yTYAww7qj6oL8bsewDbO+lPG/rc+P0o03xjRb1cBX5
         tcUiNet17uafxNB5Nsslk578k+lsROhCkzcdGVuXCgkXfkI9v26JHH+/PyKE8oZI7X1C
         TyiBxTqNNm9RwHIqdordCOYMHSzDACRtFxkGQ=
Received: by 10.204.150.69 with SMTP id x5mr2771242bkv.197.1254139792310;
        Mon, 28 Sep 2009 05:09:52 -0700 (PDT)
Received: from mrslave (HSI-KBW-078-043-091-043.hsi4.kabel-badenwuerttemberg.de [78.43.91.43])
        by mx.google.com with ESMTPS id 26sm4983616fks.1.2009.09.28.05.09.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 05:09:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AC0877E.7020204@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129255>

On Mon, Sep 28, 2009 at 11:53:02AM +0200, Johannes Sixt wrote:
> Christian Himpel schrieb:
> >> The case identified by Christian is certainly important because it is
> >> applied to a file whose contents can be anything, and the purpose of the
> >> check is to identify the text as an mbox file, whose header section can be
> >> only US-ASCII by definition. So, I think it has merit to apply the patch.
> > 
> > Yes.  It seems that this is the only place where it is important to match
> > just the ASCII printable characters.
> 
> There is another place in git-am.sh where a sed expression with a range
> looks at the input file, doesn't it? Isn't it critical, too?
> 
> 		if test -f "$dotest/rebasing" &&
> 			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
> 				-e q "$dotest/$msgnum") &&
> 			test "$(git cat-file -t "$commit")" = commit
> 		then ...

It seems to be the line generated from 'git format-patch' that is tested
here.  It specifies the SHA1 of the commit that is converted into a mbox
patch by 'format-patch'.  Hence, I don't see it critical here (until
someone edits this line by hand).


Regards,
chressie
