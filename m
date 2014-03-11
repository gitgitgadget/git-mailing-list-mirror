From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Tue, 11 Mar 2014 11:56:12 +0100
Message-ID: <531EEBCC.10409@gmail.com>
References: <531D9B50.5030404@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 11:56:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNKM6-0003iI-BN
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 11:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbaCKK4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 06:56:14 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:49239 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbaCKK4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 06:56:13 -0400
Received: by mail-wg0-f46.google.com with SMTP id b13so3727307wgh.17
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ECRYF715lf4y29e7uEgFH9QIqki0Q0VyEume/mZPl88=;
        b=vfd+lQxe7PWfVhpZOYeb3QnvfuXC+EPv8iJX3v3M8EDjmmjf5b8XWicICACAWtMtsx
         VtxkawW1dyrmyh5tg3Pf3QPQRgZIte1rMSeUQS5gOEGhnI44gZJdAgYN/PGgGYpZb75G
         rhFHYGbm3CGStsgkXMimI3TpGcRiUIUNUxAschA7BB1AK3XNBQz7oPPyAxcr1lYDqjwF
         KoT2PGJ45yP0Uja1knV5QgCwnt07+pQrUWRTwfPTS3I35vNJpzNmOsCmVSCHCwvM6576
         jhdkYRO2X8uZhfPrOMCjeAi47kg3N9qW5r3991LXi0bwEviFRigu8GSDcpsBQDe/Ytfb
         0Zqg==
X-Received: by 10.180.8.170 with SMTP id s10mr2500175wia.35.1394535372634;
        Tue, 11 Mar 2014 03:56:12 -0700 (PDT)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ci4sm60533245wjc.21.2014.03.11.03.56.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 03:56:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <531D9B50.5030404@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243855>

Am 10.03.2014 12:00, schrieb Michael Haggerty:
> 
> Reference transactions
> ----------------------
> 

Very cool ideas indeed.

However, I'm concerned a bit that transactions are conceptual overkill. How many concurrent updates do you expect in a repository? Wouldn't a single repo-wide lock suffice (and be _much_ simpler to implement with any backend, esp. file-based)?

The API you posted in [1] doesn't look very much like a transaction API either (rather like batch-updates). E.g. there's no rollback, the queue* methods cannot report failure, and there's no way to read a ref as part of the transaction. So I'm afraid that backends that support transactions out of the box (e.g. RDBMSs) will be hard to adapt to this.

Just my 2cents,
Karsten

[1] http://article.gmane.org/gmane.comp.version-control.git/243748
