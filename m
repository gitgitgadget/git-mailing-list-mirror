From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 66/67] use strbuf_complete to conditionally append slash
Date: Wed, 16 Sep 2015 15:18:59 -0700
Message-ID: <xmqq8u86m2i4.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915161619.GN29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 00:19:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcL2h-0006Q7-RQ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 00:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbbIPWTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 18:19:03 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32910 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbbIPWTC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 18:19:02 -0400
Received: by pacex6 with SMTP id ex6so347542pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Io81EivnHW98MyzDCfcs3j1n0s5yHpJ7OSKQzLwqwaU=;
        b=PSD4ttgHAxC4+nVoVGr7cTWpkO5jfPlp3wYTnRKdgudfaA1Zhia/gi6z02FDm7Me4S
         aPjdqjirnjElN9h8hczszu6rJGn0d6lexESUre1tswg+ckaLMTEvlYJgiQMyevRMh6aP
         NpAL6NnA5U4M1f7q581LHRYaIjRI6UH/yHxhQQYY7MzSJsDs5uWb8YUzK9U9p1lOSzk1
         tU60mP4HMYfASGVagJu4zI2ybF23csuTdBJpXBxDRd6oproKBkRKfvN8j6DyLq4Z29V5
         YFDdDQZ3pH5ITex2x+hkLMXvVcpnHYXnKlr+i/5k9yrskqz41CP5GjbCUwkOdVpMX5MB
         o7dQ==
X-Received: by 10.68.65.3 with SMTP id t3mr64525947pbs.127.1442441941205;
        Wed, 16 Sep 2015 15:19:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id co4sm83517pbb.91.2015.09.16.15.19.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 15:19:00 -0700 (PDT)
In-Reply-To: <20150915161619.GN29753@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Sep 2015 12:16:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278079>

Jeff King <peff@peff.net> writes:

> diff --git a/imap-send.c b/imap-send.c
> index 01aa227..f5d2b06 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1412,8 +1412,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
>  	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
>  
>  	strbuf_addstr(&path, server.host);
> -	if (!path.len || path.buf[path.len - 1] != '/')
> -		strbuf_addch(&path, '/');
> +	strbuf_complete(&path, '/');
>  	strbuf_addstr(&path, server.folder);

Is this conversion correct?  This seems to me that the caller wants
to create an IMAP folder name immediately under the root hierarchy
and wants to have the leading slash in the result.
