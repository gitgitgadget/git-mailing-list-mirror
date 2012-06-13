From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git: Wrong parsing of ssh urls with IPv6 literals ignores port
Date: Wed, 13 Jun 2012 15:39:59 -0500
Message-ID: <20120613203959.GD7967@burratino>
References: <20111022001704.3115.87464.reportbug@hejmo>
 <20120610090516.GA30177@burratino>
 <4FD78EA0.2090306@lsrfire.ath.cx>
 <20120612202953.GG9764@burratino>
 <20120612210003.GA16816@burratino>
 <4FD8C0F6.8060609@lsrfire.ath.cx>
 <7v4nqfi0vz.fsf@alter.siamese.dyndns.org>
 <20120613194347.GA7967@burratino>
 <7vbokngehi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Eduardo =?utf-8?Q?Tr=C3=A1pani?= <etrapani@gmail.com>,
	git@vger.kernel.org, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 22:40:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeuMP-0000zN-UG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 22:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392Ab2FMUkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 16:40:06 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:61427 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab2FMUkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 16:40:05 -0400
Received: by gglu4 with SMTP id u4so826022ggl.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8MKR6OcNd2x6GVJCSPrP1WVfFNilkINDM1g7nTg0ZfM=;
        b=TDuRk74hiKUc8YYmph0Ym1AB+2LE21q2iXU7AdmzYT21nJuDdGv3ejaO6wp2kwDq/C
         2xZBstZ6SfWkEvxcd4SprdNRyVUXozq2znrysX/dWN3KISQs96mNDeaXcEHUEfcYCtLd
         BE7SFAJWNs2b9npL6oJ1A8PzDdtiUPaEERJIcEc+zBCjzDAON58ygMeQjDonrYvaDHJ6
         grnPH5gE0Cos/V4q0XZxjTlG8+/Nd2XUsepO6w7iLBLAMxhQzbPfDpxzrqgl9DHQasVK
         c2FwVFpE25ZtoM1qDXm8dU4oY0whW/vG36iRQ+UudB6ijTlR/wJAsoCZVWh9ClDR/Bsu
         yEnA==
Received: by 10.101.128.33 with SMTP id f33mr4153812ann.73.1339620004553;
        Wed, 13 Jun 2012 13:40:04 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i16sm6658811anm.12.2012.06.13.13.40.03
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 13:40:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbokngehi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199943>

Junio C Hamano wrote:

> By the way, it seems that Debian/Ubuntu are still carrying a bit
> more changes and rewrites in the connection code as local
> patches. Mind upstreaming them for the next cycle?

Sure --- based on Erik's advice I think the right thing to do is to
make a simple compatibility wrapper that acts like normal getaddrinfo,
so no one has to learn a new API.  It's a little more expensive (some
malloc() / free() noise) but probably not enough so to be noticeable.

Debian has these patches because the SRV patch is on top of them.
