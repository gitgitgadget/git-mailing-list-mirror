From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Sat, 08 Aug 2009 07:34:51 +0200
Message-ID: <4A7D0E7B.3030601@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain> <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <alpine.LFD.2.01.0908061909310.3390@localhost.localdomain> <alpine.LFD.2.01.0908071614310.3288@localhost.localdomain> <4A7CBD28.6070306@gmail.com> <4A7CBF47.9000903@gmail.com> <alpine.LFD.2.01.0908071700290.3288@localhost.localdomain> <4A7CC380.3070008@gmail.com> <alpine.LFD.2.01.0908072107170.3288@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 07:35:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZeaN-0005cZ-Su
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 07:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbZHHFez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 01:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbZHHFez
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 01:34:55 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:37450 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbZHHFey (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 01:34:54 -0400
Received: by fxm28 with SMTP id 28so132784fxm.17
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 22:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=r60Y4TWaRhQLoZf1qyWS9o5F6i7IwZleYn/2yNaWSjM=;
        b=MchRkQhaMox6fxnB0FVlyPjgvgtvpVqmxEoW3NVyPc6SRwavEqrS3s2lOByXqHIe7n
         9G+KpJrqcD0ulJk2HQ4Ws4L41qQ0lk9ZeNNUNc1g9NDKv1BlCOJDC72pFSItLL55kMJI
         AXExFRrhxVIfAbOKm05CgSwvrh7Cao+HDCPkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=AzYIc1k8DheatkgFGc4EhelBwiMXhFkR+kCkYHdRvrB1ah5zy8JH7i/J0rrP18PRhI
         MP1V8PvuyywLJYDd2bv9maAVMPOKrYq4MHgoZ2zcnNQZWXSws9ColjU9uoSdD69BIDw4
         DDwiHyBuvopQNLY+o2+LQYmX6b0rQQrGA3NRU=
Received: by 10.204.116.212 with SMTP id n20mr3845276bkq.138.1249709693578;
        Fri, 07 Aug 2009 22:34:53 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-124-113.multimo.pl [89.174.124.113])
        by mx.google.com with ESMTPS id 1sm3507600fks.11.2009.08.07.22.34.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 22:34:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908072107170.3288@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125245>

Linus Torvalds wrote:
> 
> I think I have found a way to avoid the gcc crazyness.
> 
> Lookie here:
> 
> 	#             TIME[s] SPEED[MB/s]
> 	rfc3174         5.094       119.8
> 	rfc3174         5.098       119.7
> 	linus           1.462       417.5
> 	linusas         2.008         304
> 	linusas2        1.878         325
> 	mozilla         5.566       109.6
> 	mozillaas       5.866       104.1
> 	openssl         1.609       379.3
> 	spelvin         1.675       364.5
> 	spelvina        1.601       381.3
> 	nettle          1.591       383.6
> 
> notice? I outperform all the hand-tuned asm on 32-bit too. By quite a 
> margin, in fact.
> 
> Now, I didn't try a P4, and it's possible that it won't do that there, but 
> the 32-bit code generation sure looks impressive on my Nehalem box. The 
> magic? I force the stores to the 512-bit hash bucket to be done in order. 
> That seems to help a lot.

I named it 'linusv':

P4/i686:
#             TIME[s] SPEED[MB/s]
rfc3174         1.456       41.92
rfc3174         1.445       42.22
linus          0.5865       104.1
linusph        0.5643       108.2
linusv         0.3697       165.1
linusvph       0.3618       168.7
linusp4        0.4312       141.5
linusas        0.4091       149.2
linusas2       0.4364       139.9
mozilla         1.102       55.37
mozillaas       1.297       47.07
openssl         0.261       233.9
opensslb       0.2395       254.9
spelvin        0.2653         230
nettle          0.438       139.4

and when tuning for prescott:

linus          0.6544       93.27
linusph        0.6523       93.57
linusv         0.3439       177.5
linusvph       0.3547       172.1
linusp4        0.3585       170.3

so it isn't as fast as the openssl asm ones, but it does win
in the C category.

> I outperform all the hand-tuned asm on 32-bit too. By quite a 
> margin, in fact.

I've inlined the byteswapping in 'opensslb', maybe that one will
do a bit better.

http://www.src.multimo.pl/YDpqIo7Li27O0L0h/sha1bench.tar.gz

artur
