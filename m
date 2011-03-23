From: David Barr <david.barr.cordelta@gmail.com>
Subject: Re: [PULL svn-fe] vcs-svn: simplifications, error handling improvements
Date: Wed, 23 Mar 2011 18:11:25 +1100
Message-ID: <2DDB3B13-8C13-4F41-BA38-F97C035CBDE8@gmail.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com> <1300751400-7427-1-git-send-email-david.barr@cordelta.com> <20110323003240.GA4949@elie> <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 08:11:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2IEI-000446-Ip
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 08:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab1CWHLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 03:11:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52440 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab1CWHLg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 03:11:36 -0400
Received: by iyb26 with SMTP id 26so8260610iyb.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 00:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-mailer;
        bh=dqJHeKC0p524ycy6+GwP5EL9bms3i5L+7C+Ks/ryUog=;
        b=Ww8jLTbMOIfqpz5mYCbxhr9WErABiBFGon93F+dAuTlUcbhdN3wz1UHkmzPLYfW3yQ
         bXK6tr/Q+ZwSNa/cYMDiM4xqAgonqGVqOECVeRe2RTIEZyq85LpceIaHyMN6CINfWUjr
         k35etxfPhJUJuu/wubqSDoTxzJHmHpvP/uiYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=V5ggWLqQXCGBKdY3viEr7tt3L605BGonhllcqCdB7ahB6B+v3yqjChHYwYS66sUSb2
         H6eAXy/wfDU+g9RuygNB9SEdulDedzDmDfjpxFF+BI2mMBLwj7ofKBUezxdaUyQWTwmN
         ZAHLjZzPjw3/aQCC+mTeNBUrEQ2QVMUlmOHnQ=
Received: by 10.231.130.22 with SMTP id q22mr6476470ibs.97.1300864294903;
        Wed, 23 Mar 2011 00:11:34 -0700 (PDT)
Received: from [192.168.1.1] (d110-33-88-245.mit3.act.optusnet.com.au [110.33.88.245])
        by mx.google.com with ESMTPS id 19sm4915977ibx.52.2011.03.23.00.11.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Mar 2011 00:11:33 -0700 (PDT)
In-Reply-To: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169803>

Hi,

Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> Please pull
>> 
>>  git://repo.or.cz/git/jrn.git svn-fe
>> 
>> to get the following changes on top of master.
> 
> Done.
> 
> I only gave a cursory look at "git diff ORIG_HEAD" output immediately
> after pulling, but I found that the majority of lines deleted were of
> questionable style and the added ones looked more like normal C ;-)
> 
> Except for
> 
> 	switch (keylen + 1) {
>        case sizeof("constant string"):
>        	...
>                break;
>        case sizeof("another constant string"):
>        	...
> 	}
> 
> which looked a bit unusual. But mistakes in this construct can be easily
> caught by the compiler that would notice duplicated case labels, so it
> probably is not so brittle as it first looks.

Agreed, it is quite an odd construct but it took quite a bit of refinement to
arrive there. It is a compromise between moderately readable and
reasonably fast. I did play around with perfect hash generators prior to
settling on this approach. Ditto re compile time checking.

Jonathan, I suppose I should set up a performance test for these patches
because my first thought was "I wonder what these buy us on their own?"

--
David Barr.
