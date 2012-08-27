From: BJ Hargrave <bj@bjhargrave.com>
Subject: Re: git no longer prompting for password
Date: Mon, 27 Aug 2012 09:33:42 -0400
Message-ID: <BE91037D-8D8A-436C-BA21-6D18CB9BC87B@bjhargrave.com>
References: <5037E1D0.6030900@gmail.com> <20120824212501.GA16285@sigill.intra.peff.net> <5038E781.1090008@gmail.com> <20120825203904.GA10470@sigill.intra.peff.net> <5039F327.9010003@gmail.com> <503B2FA9.6030700@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:33:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5zRx-0006Vc-SD
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 15:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927Ab2H0Ndr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 09:33:47 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40038 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab2H0Ndq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 09:33:46 -0400
Received: by yenl14 with SMTP id l14so849399yen.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 06:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer
         :x-gm-message-state;
        bh=NUQtcx2O41L1lUKB4d/szvpf9OhOxI++LmvsWLWjkGQ=;
        b=a0qvnPu9R8HG0Y2Ula13KqYv8cCpIJ6FUecd+OZkL8XLQHi0EOaBs17JnDriZeHhqj
         B4b2uJmqSyiBgxoOeUulgySFYoZnxZfhC5HZ2IED55mlpll/X6bjCogv0FOIQ4+TYQZO
         fXK32cuynCg9Uny5IPQJlVfz82lWXoApUgKJEX8gq+LeWx5qM84NQQch2wpaGp0T9sPn
         8UBqIwJcVerIuJGTvePWC0Mf+1lxg28pfwb4vy1Ehb1jkEr7gqnIpSY78j52ARpZTQoC
         p5JDvjC8o7XLI0/O9Nlqv30JdgjnJHvqyePUy4dpF64XOwPEMGgz6L334Fcrh4Cl3HU8
         3lWQ==
Received: by 10.236.191.6 with SMTP id f6mr10810481yhn.126.1346074425707;
        Mon, 27 Aug 2012 06:33:45 -0700 (PDT)
Received: from macbookpro2.hargrave.local ([68.204.6.187])
        by mx.google.com with ESMTPS id l10sm16935769ang.12.2012.08.27.06.33.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 06:33:44 -0700 (PDT)
In-Reply-To: <503B2FA9.6030700@gmail.com>
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQnp98EPpN/SEki1vzJ8LqdPhUqqyZPVJS0sS85kEJej1bI2UaBlnZAfdA2MFURpm3N5Vrw+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204342>

On Aug 27, 2012, at 04:28 , Iain Paton wrote:

> On 26/08/12 10:57, Iain Paton wrote:
> 
>>        <If "%{THE_REQUEST} =~ /git-receive-pack/">
> 
> I've just discovered that the <If ..> directive only appears in apache 2.4 
> so something more generic will probably be a better idea. Not everyone will 
> be running 2.4.x for a while yet.


You could try something like this:

<Location /git>
  # Require authentication for git push
  RewriteCond %{QUERY_STRING} service=git-receive-pack
  RewriteRule .* - [E=AUTHREQUIRED:yes]
  Order Allow,Deny
  Deny from env=AUTHREQUIRED
  Allow from all
  Satisfy Any
  # Whatever auth rules you want ...

I haven't tested this specific example but it is based upon similar rules I use on a 2.0 server to require auth when specific query parameters are present. In my case, I have the Rewrite rules in the <VirtualHost> and the other directives in the <Directory> being protected.
-- 

BJ
