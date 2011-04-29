From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Fri, 29 Apr 2011 09:24:08 -0700
Message-ID: <4DBAE628.4080501@zytor.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org> <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com> <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com> <4DB93D16.4000603@cs.helsinki.fi> <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com> <4DB941CD.2050403@cs.helsinki.fi> <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com> <BANLkTikt0CU87maPs65WGi0oopD+g0uVDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, Pekka Enberg <penberg@cs.helsinki.fi>,
	Ingo Molnar <mingo@elte.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:27:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqXd-0005Mn-OP
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760156Ab1D2Q1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:27:34 -0400
Received: from terminus.zytor.com ([198.137.202.10]:49294 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760136Ab1D2Q1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:27:32 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2001:470:861f:0:e269:95ff:fe35:9f3c])
	(authenticated bits=0)
	by mail.zytor.com (8.14.4/8.14.3) with ESMTP id p3TGODmN032751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Fri, 29 Apr 2011 09:24:16 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110422 Fedora/3.1.9-7.fc15 Thunderbird/3.1.9
In-Reply-To: <BANLkTikt0CU87maPs65WGi0oopD+g0uVDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172463>

On 04/29/2011 12:05 AM, Alex Riesen wrote:
> 
> Can one take advantage of common expression optimization here?
> Like this:
> 
> +       if (*sha1 - *sha2)
> +               return *sha1 - *sha2;
> 

Or even clue the compiler in explicitly:

	delta = *sha1 - *sha2;
	if (delta)
		return delta;

For newer x86-specific optimization there are a bunch of newer SSE
instructions which can be used to do bulk compares which may be faster
if optimized for the fixed length compare; of course it requires a new
enough processor.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
