From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] sideband.c: Use xmalloc() instead of variable-sized
 arrays.
Date: Wed, 09 Jan 2008 08:26:34 +0100
Message-ID: <4784772A.1060704@viscovery.net>
References: <4783A3B2.3060801@viscovery.net> <7v4pdotdtl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 08:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCVL8-0007k4-53
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 08:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbYAIH0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 02:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYAIH0j
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 02:26:39 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12528 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbYAIH0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 02:26:38 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JCVKc-0004A7-P9; Wed, 09 Jan 2008 08:26:34 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3A0114E4; Wed,  9 Jan 2008 08:26:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v4pdotdtl.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69958>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> @@ -19,7 +19,10 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
>>  {
>>  	unsigned pf = strlen(PREFIX);
>>  	unsigned sf = strlen(SUFFIX);
>> -	char buf[pf + LARGE_PACKET_MAX + sf + 1];
>> +	char *buf, *save;
>> +
>> +	save = xmalloc(sf);
>> +	buf = xmalloc(pf + LARGE_PACKET_MAX + sf + 1);
> 
> I have to wonder if the malloc() overhead is small enough
> compared to the network bandwidth to make a two malloc-free
> pairs per packet a non-issue...

recv_sideband() is called _once_per_connection_ and not for each packet.
Hence, these two mallocs should not concern us.

-- Hannes
