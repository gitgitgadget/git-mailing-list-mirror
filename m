From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Aug 2013, #06; Tue, 27)
Date: Wed, 28 Aug 2013 08:39:16 +0200
Message-ID: <521D9B14.2070408@viscovery.net>
References: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com> <20130827205125.GA23783@sigill.intra.peff.net> <xmqqbo4ic0ap.fsf@gitster.dls.corp.google.com> <20130827214808.GA26350@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 28 08:39:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEZPc-00047Y-4x
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 08:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753Ab3H1GjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 02:39:23 -0400
Received: from so.liwest.at ([212.33.55.24]:32469 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694Ab3H1GjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 02:39:21 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VEZPR-0001TP-Cw; Wed, 28 Aug 2013 08:39:17 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EBFD91660F;
	Wed, 28 Aug 2013 08:39:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20130827214808.GA26350@sigill.intra.peff.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233177>

Am 8/27/2013 23:48, schrieb Jeff King:
> The counterarguments I can see are:
> 
>   1. Who cares? If you want to know whether pack-objects will choke on
>      your huge config value, then run pack-objects.
> 
>   2. Such a check would involve knowing which type we use internally to
>      look at packSizeLimit, and that is utterly undocumented (and
>      subject to change; e.g., it seems kind of senseless that we have a
>      4G pack-size limit on 32-bit platforms, and we may want to fix
>      that).
> 
> So if you do not buy the argument that communicating git's internal
> range checks is useful, then we can simply say "--int is magically long
> on every platform, and you can use it for everything numeric". And
> implement it with int64_t. You may be able to read or write some values
> for certain keys that git will barf on internally, but that is git's
> problem.

I'm in the camp of these (counter) arguments.

When my shell script asks for 'git config --int 3g', I expect to be
returned a positive 10-digit. What would I care which type Git or any
other tool is using internally? I only care whether my shell can work with
numbers that large. Or the next tool that I feed the number to. But that's
my business, not Git's.

> The one thing it doesn't get you is that you can currently set unsigned
> values to "-1" in the config to have them treated as ULONG_MAX. This is
> undocumented and as far as I know not used by anyone.

And it better stays that way. Magic numbers should be encoded with magic
strings in the config file.

-- Hannes
