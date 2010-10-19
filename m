From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: [PATCH] ignore SIGINT&QUIT while waiting for external command
Date: Tue, 19 Oct 2010 14:06:03 -0700 (PDT)
Message-ID: <m3fww1lwqw.fsf@localhost.localdomain>
References: <20101019045300.GA18043@gnu.kitenet.net>
	<AANLkTi=tvyzyz2xpezufHLFc44HDbtMibkhNEvYxPB2g@mail.gmail.com>
	<20101019115943.GA8065@dpotapov.dyndns.org>
	<20101019133236.GA804@sigill.intra.peff.net>
	<20101019134040.GA3956@sigill.intra.peff.net>
	<20101019191638.GI25139@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Joey Hess <joey@kitenet.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 23:06:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8JNw-0005a3-SP
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 23:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757654Ab0JSVGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 17:06:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46032 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab0JSVGG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 17:06:06 -0400
Received: by bwz10 with SMTP id 10so770319bwz.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yGOtkTqBwDzMWF9QkKgb57BhZ/canJlU6+d1nVXR9GA=;
        b=c3FuZ7HpVmDErO1h0uYBPPbjPMUl5+CGQ8PK+1cJFf/6P/TncOS94XVyG6GUHAeruF
         /qxytlBoOsatpH9N4XJzgLscQsolaI753VnWjDNaKWmm6rfsy6Mif8QxSBS16eEGWmuW
         XzphPJEaQYjoXp3BS8Gff2p6Qs9yfQ5IVGsCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=YgGuqLejLT8lHblIWNMpT1mlPk2MOtGmvRC/OTIMdugpEHNht9BV1cVMcQVoJWxXV+
         dG7IPZpqAAXTHQqjbgjjTcr/rvsZ6DF9Xqz1nWE0sQVokli9eIrR2beETcp3tIBTzxRY
         TTEGPbBKw8LRHnGBefmC1/EBjrQIkIlxCY6ts=
Received: by 10.204.80.97 with SMTP id s33mr6018651bkk.182.1287522365111;
        Tue, 19 Oct 2010 14:06:05 -0700 (PDT)
Received: from localhost.localdomain (abvs158.neoplus.adsl.tpnet.pl [83.8.216.158])
        by mx.google.com with ESMTPS id d12sm6791127bkw.19.2010.10.19.14.06.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 14:06:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9JL5MBO018458;
	Tue, 19 Oct 2010 23:05:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9JL4tiQ018454;
	Tue, 19 Oct 2010 23:04:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101019191638.GI25139@burratino>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159366>

Jonathan Nieder <jrnieder@gmail.com> writes:

> -	sigchain_push(SIGINT, SIG_IGN);
> -	sigchain_push(SIGQUIT, SIG_IGN);
> +	if (the_child)
> +		die("What?  _Two_ children?");
> +	the_child = cmd;
> +	sigchain_push(SIGINT, interrupted_with_child);
> +	sigchain_push(SIGQUIT, interrupted_with_child);

Please, don't do this.  It is almost as bad as error message as 
"You don't exist.  Go away".

-- 
Jakub Narebski
Poland
ShadeHawk on #git
