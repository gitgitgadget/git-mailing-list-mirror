From: Sven Brauch <svenbrauch@googlemail.com>
Subject: Re: [PATCH] git-cat-file: fix output when format string contains no variables
Date: Wed, 06 Nov 2013 20:40:49 +0100
Message-ID: <5085823.Oad8MOHc71@localhost.localdomain>
References: <1748846.6BAMC5enOx@localhost.localdomain> <xmqqsiv98l5y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 06 20:41:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve8yI-0006wq-Fp
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 20:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab3KFTky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 14:40:54 -0500
Received: from mail-ea0-f181.google.com ([209.85.215.181]:51054 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab3KFTkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 14:40:53 -0500
Received: by mail-ea0-f181.google.com with SMTP id d10so5166097eaj.26
        for <git@vger.kernel.org>; Wed, 06 Nov 2013 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=XhiRQ6XITifU2yVV2xbhbuH3aebZYE8UnC8JMbd5ApY=;
        b=bF0SwwHf6tYtkm7Res4efXXhVP7wrJfJaZs9Lyhou/bgup7xSC9AV9jRO602FGfGAZ
         4RNWiwUUg/+MRI5gj2Aoyk9Y3D4+FE2ZkaSvbSYQQFPgEfwALWbQnwsifDg+rKJakGmq
         OqoDVL71dIJxHhFZAHL8+sH5LuQ5HKFCwzNt453SkRlPhp2i2q/vc4rXCTMtrvCLxALo
         nnxRo9QsFxF8VhVWwv6RUnH0C5U9QPVeuBOpP0Y4yJB6L6ZD/GbOBBoAwBSOJduALB6V
         Nb4rxlcfiO5D0aD8CMTH/Mo9uHrUBMnfXyf2fmODbCAUv1G6YJFqDVofNDlMQncP6tbX
         XPIQ==
X-Received: by 10.14.4.1 with SMTP id 1mr5627339eei.21.1383766849934;
        Wed, 06 Nov 2013 11:40:49 -0800 (PST)
Received: from localhost.localdomain (p4FDCD5C2.dip0.t-ipconnect.de. [79.220.213.194])
        by mx.google.com with ESMTPSA id b42sm77593715eem.9.2013.11.06.11.40.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2013 11:40:49 -0800 (PST)
User-Agent: KMail/4.11.2 (Linux/3.11.6-1-ARCH; KDE/4.11.2; x86_64; ; )
In-Reply-To: <xmqqsiv98l5y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237364>

On Wednesday 06 November 2013 10:00:57 Junio C Hamano wrote:
> Thanks; first some procedural issues:
Thanks, I will take care of the mentioned points for future submissions.

> I think the real problem is that sha1_loose_object_info() is called
> by sha1_object_info_extended(), when it does not find a cached or a
> packed object, and the callee assumes that it is asked to fill in
> only the requested pieces of information while the caller does not
> even bother to check if such an object actually exists.
> 
> How about doing it like the attached instead?
Yes; this seems more like a proper fix. I would prefer it over my suggestion.
It is illogical that sha1_loose_object_info sometimes returns an error if the 
object does not exist and sometimes not, depending on which properties are 
requested.

Sven
