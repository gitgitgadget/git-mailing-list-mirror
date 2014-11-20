From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] refs.c: make ref_transaction_create a wrapper for
 ref_transaction_update
Date: Thu, 20 Nov 2014 10:03:15 -0800
Message-ID: <20141120180315.GA15945@google.com>
References: <1416433224-29763-1-git-send-email-sbeller@google.com>
 <1416433224-29763-2-git-send-email-sbeller@google.com>
 <20141120160000.GA31738@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	sahlberg@google.com, git@vger.kernel.org, mhagger@alum.mit.edu
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:03:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrW4g-00078M-8S
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291AbaKTSDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:03:18 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:59314 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbaKTSDR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:03:17 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so3300704iec.10
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 10:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eVPerS1d0Lz+GE1d8PgLlY4FGa1uIwZ4EtFG13TBoUc=;
        b=xBas0ddMMGhYQGRKbdq2dv/viH9qrT2V0D/Vxh2Z9fA17LDe/IVfa7E8acMHc1yLVc
         g69Hk9GgQ/5inlDo5oQ89FW5qrM5HjZXPf6w4/nX3ZYRj/aPZN+cbosrClMQq3p28xOb
         I0jWf5YBaw82jhFvC7A7o84im1iOByQofkA+m8+2jUjN9UPUpYPrH0s059qChm3V9SgZ
         KjV1eHaFFL13Mq/1sRP1yagOlm7VzhvHd2r44nw0EvHHLf52aH7Jy9UgpuxH622kaqyP
         Aex7P6l+gKzLhrJSoGwZ0e3GqoIMo3cRjDkbZMb/XZcVnLWxVl/UooKhTs+U0qBjikKx
         xPTg==
X-Received: by 10.42.39.6 with SMTP id f6mr9067874ice.14.1416506597062;
        Thu, 20 Nov 2014 10:03:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id c8sm2825904igl.1.2014.11.20.10.03.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 10:03:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141120160000.GA31738@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Nov 19, 2014 at 01:40:23PM -0800, Stefan Beller wrote:

>> -	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
>> -		strbuf_addf(err, "refusing to create ref with bad name %s",
>> -			    refname);
>> -		return -1;
>> -	}
>
> You claimed in the cover letter that only BUG messages were changed. But
> I think this third one is a real user-visible message.
>
> That being said, I think the sum total of the change to the message is
> s/create/update/, and it's probably fine.

Yeah, it we want to get the 'create' back, we could handle it by
checking if old_sha1 is null_sha1 in transaction_update (that would
take of other callers, too, like 'git update-ref <ref> <commit> ""').
But I haven't convinced myself that's worth the complication --- in
any event it could be a separate patch to avoid blocking this one.

Thanks,
Jonathan
