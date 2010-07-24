From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [WIP/RFC 12/13] git notes merge: Add automatic conflict resolvers
 (ours, theirs, union)
Date: Sat, 24 Jul 2010 01:18:11 -0700
Message-ID: <4C4AA1C3.8030907@gmail.com>
References: <1279880104-29796-1-git-send-email-johan@herland.net> <1279880104-29796-13-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jul 24 10:18:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcZwN-0000B3-Kh
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 10:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab0GXISU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 04:18:20 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59651 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab0GXISS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 04:18:18 -0400
Received: by pzk26 with SMTP id 26so403011pzk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 01:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=cg7fbmFOoyNSkC76S5Hrw6x5ac+Ju0/X6TOf9fOq+Fs=;
        b=Zw60OWlCGJG2fDL6SRgwa52lSzPdzJm25Cz0BgnXvt0S1gHfnh31TDIOsmjSjKCc7K
         yKvWGzmo9fNiydLJ0H9V9Hpuuv+0+vdDS0oJPIcNrjkO6W9rvZ4WAoCYdXtNYTEkS+M4
         1A0XrBgzU628N7zatMvDxj54VQFUZY5vXBgck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=l/F+kPBPpd6G2BGIAzZGD1+Y/w2Yf33LbcW2Bl8waVtw+33416L5H6lnbrsArwu3IR
         hwQhGmr7N1ohICx6qotm775/piL9Dm9uxeh9OPnqyVvaEobFQAqhcfWD3jvvzFOJKOA3
         RLp4nyHyBPBP/kdHITDmC55qGM1VIY31FIa2Y=
Received: by 10.114.109.10 with SMTP id h10mr7089054wac.132.1279959497753;
        Sat, 24 Jul 2010 01:18:17 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id d38sm2025478wam.20.2010.07.24.01.18.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 01:18:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.4) Gecko/20100713 Thunderbird/3.1
In-Reply-To: <1279880104-29796-13-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151604>

  On 07/23/2010 03:15 AM, Johan Herland wrote:
> +
> +# Set up a notes merge scenario with all kinds of potential conflicts
> +test_expect_success 'setup commits' '
> +	# Create 15 commits with tags ("1st" through "15th")
> +	:>  a1&&  git add a1&&  test_tick&&  git commit -m 1st&&  git tag 1st&&
> +	:>  a2&&  git add a2&&  test_tick&&  git commit -m 2nd&&  git tag 2nd&&
> +	:>  a3&&  git add a3&&  test_tick&&  git commit -m 3rd&&  git tag 3rd&&
> +	:>  a4&&  git add a4&&  test_tick&&  git commit -m 4th&&  git tag 4th&&
> +	:>  a5&&  git add a5&&  test_tick&&  git commit -m 5th&&  git tag 5th&&
> +	:>  a6&&  git add a6&&  test_tick&&  git commit -m 6th&&  git tag 6th&&
> +	:>  a7&&  git add a7&&  test_tick&&  git commit -m 7th&&  git tag 7th&&
> +	:>  a8&&  git add a8&&  test_tick&&  git commit -m 8th&&  git tag 8th&&
> +	:>  a9&&  git add a9&&  test_tick&&  git commit -m 9th&&  git tag 9th&&
> +	:>  a10&&  git add a10&&  test_tick&&  git commit -m 10th&&  git tag 10th&&
> +	:>  a11&&  git add a11&&  test_tick&&  git commit -m 11th&&  git tag 11th&&
> +	:>  a12&&  git add a12&&  test_tick&&  git commit -m 12th&&  git tag 12th&&
> +	:>  a13&&  git add a13&&  test_tick&&  git commit -m 13th&&  git tag 13th&&
> +	:>  a14&&  git add a14&&  test_tick&&  git commit -m 14th&&  git tag 14th&&
> +	:>  a15&&  git add a15&&  test_tick&&  git commit -m 15th&&  git tag 15th
> +'

Can you use test_commit here?
