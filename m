From: Ben Boeckel <mathstuf@gmail.com>
Subject: Re: [PATCH v3] remote: add get-url subcommand
Date: Wed, 5 Aug 2015 17:33:58 -0400
Message-ID: <20150805213358.GA2592@megas.kitware.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
 <1438700198-4942-1-git-send-email-mathstuf@gmail.com>
 <xmqqio8t325x.fsf@gitster.dls.corp.google.com>
Reply-To: mathstuf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:34:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN6KO-0005Y8-2l
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 23:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbbHEVeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 17:34:03 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34339 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbHEVeC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 17:34:02 -0400
Received: by iodb91 with SMTP id b91so2813819iod.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9E66/PJ1mBoOGrJ+EDOwxZ0M0tvZRO2AY+SnDPZ9dtg=;
        b=sGULHB1SK/3GYFN6TrlpfKs2BOSqu2+42EtQdyvbTxMxL/wzJAXYXLzAcymLJHdcDs
         VLRvvXwscYnUYIYPKN/of8kg/iJaUWOnmrFtPHqz9NR67VzI3T59ZI2i5Wg81Zdioh40
         KwIMRMJjp0fxJlXK8Z74HnymTfiM/1b8bisJkjl43GTg7ub6HNPIxeYDI+0ji1aa89nY
         hr+0PXj/skB5WwP2yKUqieAYRFPu6WBw2VULAc8LkMg5+22G4kPqCfWnWCe4vxnNeB9q
         b+UYF0TwZRwmceNKnrEQ9elRGMAe/n0WsdtBb9XqckkELKF0Nf+lyTvvOdsiz1aBaDUb
         xCjw==
X-Received: by 10.107.31.134 with SMTP id f128mr11688473iof.19.1438810441190;
        Wed, 05 Aug 2015 14:34:01 -0700 (PDT)
Received: from megas (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id c79sm2042533iod.9.2015.08.05.14.33.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 14:34:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqio8t325x.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275401>

On Wed, Aug 05, 2015 at 13:34:18 -0700, Junio C Hamano wrote:
> Changes to these two files look reasonable.
> 
> Don't you want to protect this feature from future breakage by
> others by adding a couple of tests, though, to t/t5505?

Thanks, I've done so locally. It actually brings up this case:

    $ git remote add someremote foo
    $ git remote get-url --push someremote
    fatal: no URLs configured for remote 'someremote'

Is it better to use:

    remote = remote_get(remotename);
    remote->pushurl;

    if (remote->pushurl_nr)
        remote->pushurl;
    else
        remote->url;

or:

    remote = pushremote_get(remotename);
    remote->pushurl;

? What is the actual difference between the two?

Thanks,

--Ben
