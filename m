From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] t5523: test push progress output to tty
Date: Wed, 13 Oct 2010 22:16:42 -0500
Message-ID: <20101014031642.GB14664@burratino>
References: <20101014030220.GB20685@sigill.intra.peff.net>
 <20101014030505.GC5626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 05:20:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6EMZ-0003CU-ST
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 05:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417Ab0JNDUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 23:20:07 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50650 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399Ab0JNDUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 23:20:06 -0400
Received: by ywi6 with SMTP id 6so1828284ywi.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 20:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=18HKRkpCvEGyKkGw0Kp5omwhidlknONMz5SpgJikgH0=;
        b=jaeXEviu86VpDz7OFM3C+HRvKyL9F0fglJgZiYuWuDNsbbnqvsZL08QD27/b4Ab0rS
         RBRJUhTMCtUi0SrMPmBJHUha1YUlYKegxlIPkGrCIH9hDqG2S6V4GelAAWbaIRgfC9RI
         a3slV3kVyTH6mItTQgBykTbyk+8a3rOzyyhBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aEco4Oin5Jsnp9f+pOjWeVNei1QytboBZH0jk/WNUAo883v5AwkmpYZ9UvrQKjGvaM
         Jbb4MFiLhcyZVO1NQKNfZI/B9KXlKXJdSsPxI1g8Ogi+hH9D5h4OwICHF1nl/yvZKv22
         22cyxGaHTEgC80lYa1vLOclJLmETvwe3yCl5g=
Received: by 10.151.8.8 with SMTP id l8mr2425255ybi.251.1287026405766;
        Wed, 13 Oct 2010 20:20:05 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 64sm4381984yhl.16.2010.10.13.20.20.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 20:20:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101014030505.GC5626@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159020>

Jeff King wrote:

> --- a/t/t5523-push-upstream.sh
> +++ b/t/t5523-push-upstream.sh
[...]
> @@ -72,7 +73,14 @@ test_expect_success 'push -u HEAD' '
>  	check_config headbranch upstream refs/heads/headbranch
>  '
>  
> -test_expect_success 'progress messages to non-tty' '
> +test_expect_success 'progress messages go to tty' '
> +	ensure_fresh_upstream &&
> +
> +	test_terminal git push -u upstream master >out 2>err &&
> +	grep "Writing objects" err
> +'

Missing TTY prerequisite.  (Do you think test_terminal should check
$prereq to prevent this?)

> @@ -88,4 +96,18 @@ test_expect_success 'progress messages to non-tty (forced)' '
>  	grep "Writing objects" err
>  '
>  
> +test_expect_success 'push -q suppresses progress' '
> +	ensure_fresh_upstream &&
> +
> +	test_terminal git push -u -q upstream master >out 2>err &&
> +	! grep "Writing objects" err
> +'

Likewise.

> +
> +test_expect_failure 'push --no-progress suppresses progress' '
> +	ensure_fresh_upstream &&
> +
> +	test_terminal git push -u --no-progress upstream master >out 2>err &&
> +	! grep "Writing objects" err
> +'

Likewise.

Regards,
Jonathan
