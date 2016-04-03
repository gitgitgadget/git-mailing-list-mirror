From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v3 4/4] tag: use pgp_verify_function in tag -v call
Date: Sun, 3 Apr 2016 17:43:55 -0400
Message-ID: <20160403214354.GA28933@LykOS>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-5-git-send-email-santiago@nyu.edu>
 <20160403045600.GD1519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 03 23:44:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amppD-0003eO-J9
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 23:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbcDCVn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 17:43:58 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36476 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcDCVn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 17:43:57 -0400
Received: by mail-qg0-f53.google.com with SMTP id f52so39226940qga.3
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 14:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b8TAJpBU9q9hWu1Zdx8OCxBUHzMjqnhmtRORdIIn0bA=;
        b=lsUXgmHGRttQgjq/WFWiVr8KtJ16VM/BLBa9QGep7p8VFXM3bZR3Zom/jfhC7BdZVb
         vMPzfEUP6Yr4dN95dwraaknuofhhY67hfjKn4WYRIAMG7poGzG/N7LxY4wXLkgqUQove
         SUyvujmR1wy6kQYz9tgzbOuZh0PTll6JFwgqY3fvMZf8Ha8pJBs4KaZAGxmnOE3CCP1R
         pZwz11lyjbUf0Idr2GX4ECclpLDPqMXMjda9yDnL/fVt5Y2NnHPlHWzQj95zaPwkB/9Q
         ZNFr4YkIRF7TymJIOLBJB4yvYMXtd2flkDBEr/qAymfhJhW7vTU/eTi7dUB4nlWk5m3h
         appw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b8TAJpBU9q9hWu1Zdx8OCxBUHzMjqnhmtRORdIIn0bA=;
        b=RD2XdMVb3ty/ps8yIc925+pam58JZB3vmh6G49s/FDtDp4jscFmXQMoRr6EjyzLyk3
         ujDrBF1whfUAFzxAoSr6svrNOR1KH8dSLcqyhtiFjPmiZJLZB12dDhFwG/jviUlYN98G
         xGQ2GFF67nh4eChHi2HLMsERK/yWmazG0Vd5b+7dTWQpG6XWSUECr2yf9AqxoXILsCSr
         OWHIG7lHOa9hLkTtzVxk0EJ/M3noz+4FZGCTBgnH7nMgtMkt5X8n4fuFIlDLzu2f6sDX
         1uSDZ7RFiwb3BZfVHISjm52Hev2cX4cwZR37Biw/O52UeCIm1FCk3mm8E1zz+VEtYUeW
         Ygzw==
X-Gm-Message-State: AD7BkJIU5u+1Zid7xvtMfTM9aLSdBwz43BHQ329S6H1OOajunGJG1M6sxc9J8MmXGAbll6lh
X-Received: by 10.140.102.111 with SMTP id v102mr19981453qge.48.1459719836469;
        Sun, 03 Apr 2016 14:43:56 -0700 (PDT)
Received: from LykOS (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id c2sm11042703qkb.41.2016.04.03.14.43.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2016 14:43:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160403045600.GD1519@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290656>

> >  	if (cmdmode == 'v')
> > -		return for_each_tag_name(argv, verify_tag);
> > +		return for_each_tag_name(argv, pgp_verify_tag,
> > +				GPG_VERIFY_VERBOSE);
> 
> but I think that is coupling too closely. What happens later when the
> public, multi-file pgp_verify_tag function changes its interface? Or we
> want to change our interface here, and it no longer matches
> pgp_verify_tag? The results ripple a lot further than they should.
> 
> I think you probably want to keep a simple adapter callback in this
> file, like:
> 
>   int verify_tag(const char *name, const char *ref, const unsigned char *sha1)
>   {
> 	return pgp_verify_tag(name, GPG_VERIFY_VERBOSE));
>   }

Yes, agreed. I'll give this a go

Thanks!
-Santiago
