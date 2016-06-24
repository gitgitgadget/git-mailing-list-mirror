Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38FD92018A
	for <e@80x24.org>; Fri, 24 Jun 2016 20:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbcFXUHh (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 16:07:37 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38443 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbcFXUHg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 16:07:36 -0400
Received: by mail-wm0-f43.google.com with SMTP id r201so38724953wme.1
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 13:07:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=soVUz3Z6uuNAfVJozvmQBOeH9lHDHlSh4XooH8VV3Ac=;
        b=ydMVansRtke44NIpewiBpUTAkohUqnK6U5zmj9r/iOfDxfHqjlmTv0zRLkUmM/J3dH
         yKBj00N/nsAHarHUFvgafHPLdWSK+5te5x+zlVy0CxpQX7EAjef6X2kKs57fknJ9Bfld
         3DSRKwLBSyIJVmr8RTDKe6daTeV5iXSclqB+hG7rPIQaNpAcgzQFcPa62T9QZAJInnLh
         DqwYTiRYk7ESIRjy4aM1+TdEGEWh4SAHcNIpbdPVnuFGfujfwjdSd7vlssr/uSmnb6eU
         zUofxOS8LdM2liXshmjDMPRbyhVYiVcEAlufV16vIOXZSpoYABaxMe0+vUys/hhloEgo
         Vmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=soVUz3Z6uuNAfVJozvmQBOeH9lHDHlSh4XooH8VV3Ac=;
        b=BRINeC8T73BbWy2CJLYdEapE6gME5aKjZBlOK9MgsQX22Ja02ChLoYLqYCexKpeT+2
         94qeq6js+nCwR26e5XQTUxZX1vHaGmpWGbgFGlXbLfXJgZEBzjl14DnO/hnbJ3sUbNe4
         WtYQcb64LblN1/ztfWvyRzn1II4x6SJPZ2Xh+IsO0XZOWyGVp9hd0iUJsExosKNzE36e
         6/t6G+lhrpknG8B/f5AqUCfdag0Hz8My/DZKI7kfO3adFgToQmWXli79rZ0hAlUhebJ4
         WrDWnEBwDQRbaREnoZ3BM54EY8a6z73YsSpai8M9ZyT/l4zKTLSf2XhtzkdDIyY3Qfia
         cpYw==
X-Gm-Message-State: ALyK8tJg3JMuFANfmRKbLcLmfdVc7fEuQOURSMWSa9O7TgM0iFDHTFtBa469z+6nU1pIGQ==
X-Received: by 10.194.114.106 with SMTP id jf10mr6104531wjb.48.1466798854887;
        Fri, 24 Jun 2016 13:07:34 -0700 (PDT)
Received: from [172.16.254.198] ([193.173.39.54])
        by smtp.gmail.com with ESMTPSA id wo9sm852751wjb.8.2016.06.24.13.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2016 13:07:33 -0700 (PDT)
Message-ID: <1466798850.2642.2.camel@kaarsemaker.net>
Subject: Re: [PATCH v2] Refactor recv_sideband()
From:	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
Date:	Fri, 24 Jun 2016 22:07:30 +0200
In-Reply-To: <20160624181414.GA25768@sigill.intra.peff.net>
References: <20160613195224.13398-1-lfleischer@lfos.de>
	 <20160614210038.31465-1-lfleischer@lfos.de>
	 <20160624153121.GA2494@sigill.intra.peff.net>
	 <alpine.DEB.2.20.1606241942220.12947@virtualbox>
	 <20160624181414.GA25768@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On vr, 2016-06-24 at 14:14 -0400, Jeff King wrote:

> On Fri, Jun 24, 2016 at 07:45:04PM +0200, Johannes Schindelin wrote:
>> Do we *actually* send color via the sideband, like, ever?

> We don't, but remember that we forward arbitrary output from hooks.
> If the consensus is "nah, it is probably crazy and nobody is doing it
> today" then I am fine with that.

It's crazy, so obviously we're doing it :)

Though losing this would not be a big deal for us.

D.
