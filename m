From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 2/2] git-patch-id: do not trip over "no newline" markers
Date: Fri, 18 Feb 2011 15:29:09 +0100
Message-ID: <201102181529.18497.jnareb@gmail.com>
References: <4D5E278F.2010509@drmicha.warpmail.net> <c0ee81b29d902e773dc851aaf86b99c9337079c9.1298023827.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 15:29:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqRLB-00086l-Em
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 15:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153Ab1BRO3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 09:29:39 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41876 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab1BRO3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 09:29:37 -0500
Received: by bwz15 with SMTP id 15so767075bwz.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 06:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=fvw8VXKXbEHEFsHmjsfps1dr9Vosjo952eL1aqnvXQA=;
        b=L8SqaGu1pmr4mvKam2UiTARyfv92i27ojZjLhSazT8IF6j7iifNrzxkcLO+vXjnQ4v
         qpkKuB/CrlbEqEHr7VtvXe71ga91Vgf1sE5qH9nl8ZQGtQxkNqHd9KDkWpAzMBXHMKkX
         v2mVrSo2iLSqGU1nl1v4pe6G65teLx8Ipek7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sacz3MvN3fmoZ1YRl5jOscgAtr5gnpPpWcNmKdLafxurpV72a+n2LQGcf0KLxsX0AQ
         KsSDNgeVicaTXZ0uRfa60SMv9Pz2ejKHBN3khXc059AT1WPfvM9PpVV4KG7ownnuFjxO
         DI14dOJXNLX+BjHGXzEt/BYeEheeS+LVbjszk=
Received: by 10.204.122.65 with SMTP id k1mr711390bkr.80.1298039376437;
        Fri, 18 Feb 2011 06:29:36 -0800 (PST)
Received: from [192.168.1.13] (abwu244.neoplus.adsl.tpnet.pl [83.8.244.244])
        by mx.google.com with ESMTPS id 12sm1507316bki.19.2011.02.18.06.29.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 06:29:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <c0ee81b29d902e773dc851aaf86b99c9337079c9.1298023827.git.git@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167215>

Michael J Gruber wrote:

> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -73,6 +73,8 @@ int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
>  			p += 7;
>  		else if (!memcmp(line, "From ", 5))
>  			p += 5;
> +		else if (!memcmp(line, "\\ ", 2) && strlen(line)>=12)
> +			continue;
>  
>  		if (!get_sha1_hex(p, next_sha1)) {
>  			found_next = 1;

All of those are minor issues:

1. Whitespace (coding style) - it should be

   +		else if (!memcmp(line, "\\ ", 2) && strlen(line) >= 12)

2. Is "\\ " needed, or "\\" would be enough (line[0] == '\')?

3. What is this 12 in "strlen(line) >= 12" about?  Note that 
   strlen(<const>) is optimized out during compiling.

-- 
Jakub Narebski
Poland
