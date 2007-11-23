From: Dan Zwell <dzwell@gmail.com>
Subject: Re: [PATCH 2/5] Don't return 'undef' in case called in a vector context.
Date: Thu, 22 Nov 2007 22:15:50 -0600
Message-ID: <474653F6.2060803@zwell.net>
References: <47112491.8070309@gmail.com>	<20071015034338.GA4844@coredump.intra.peff.net>	<20071016194709.3c1cb3a8@danzwell.com>	<20071017015152.GN13801@spearce.org>	<20071022164048.71a3dceb@danzwell.com>	<20071023042702.GB28312@coredump.intra.peff.net>	<20071023035221.66ea537f@danzwell.com>	<20071102224100.71665182@paradox.zwell.net>	<20071104045735.GA12359@segfault.peff.net>	<7v640ivagv.fsf@gitster.siamese.dyndns.org>	<20071104054305.GA13929@sigill.intra.peff.net>	<20071110180109.34febc3f@paradox.zwell.net>	<20071122045534.435f01bb@paradox.zwell.net> <7vd4u23rpg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 05:16:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvPxt-00061w-0r
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 05:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbXKWEQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 23:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753618AbXKWEQL
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 23:16:11 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:42991 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbXKWEQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 23:16:09 -0500
Received: by py-out-1112.google.com with SMTP id u77so8271256pyb
        for <git@vger.kernel.org>; Thu, 22 Nov 2007 20:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=ec+iBiZmHG8NDTicsnCsMS+0fOq6gn7ng5KTZCn01rQ=;
        b=gOC4LCkuGoWfLNWpvAQq637dpeAdJH4U5aNV/vpnvYnUbhgSZx3lk6cTZLAiCxKb17ho+OIIwGEoaQtIQiCZyHYWPyoQTNzow9FtgpZgUjZjlz/4oMlC2ISKvP02pCSMKVfqy1SgsuxbfZxX/Av1ZU6ahuLkyuCP2vC4Lp1Ejow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=H3s4LdE1U2/WLdrPuzI+FdNwfDOzbD86UdyDiGp1RpMH/Zesh1e0A3udvQRAUUsVwJPqpPYT9+G25U6cSQuTqY8dMxNXCpooLScCrix0SHPIFZLR9SxpJCV6mSV7St/68SbxhB+xYHSSDvB1dTZzM/GDsse974jDPBLnO1HzDWw=
Received: by 10.35.68.3 with SMTP id v3mr11232772pyk.1195791368800;
        Thu, 22 Nov 2007 20:16:08 -0800 (PST)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id v15sm3846720pyh.2007.11.22.20.16.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Nov 2007 20:16:08 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071121)
In-Reply-To: <7vd4u23rpg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65871>

Junio C Hamano wrote:
> Dan Zwell <dzwell@zwell.net> writes:
> 
>> diff --git a/perl/Git.pm b/perl/Git.pm
>> index dca92c8..6603762 100644
>> --- a/perl/Git.pm
>> +++ b/perl/Git.pm
>> @@ -508,7 +508,7 @@ sub config {
>>  		my $E = shift;
>>  		if ($E->value() == 1) {
>>  			# Key not found.
>> -			return undef;
>> +			return;
>>  		} else {
>>  			throw $E;
>>  		}
> 
> Shouldn't the same fix made to config_bool as well?
> 

I didn't realize it at the time, but yes, config_bool needs this (though 
the only time config_bool is evaluated in a list context should be when 
it is evaluated as an argument to another function). I'll make the change.

Dan
