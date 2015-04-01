From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Trying to push into empty repo, get fatal: bad revision 'HEAD'
Date: Wed, 01 Apr 2015 10:51:34 +0200
Organization: gmx
Message-ID: <cb4098391d46cc25b3d4d059e35dc806@www.dscho.org>
References: <CAHkN8V8cpZUmCi6=MUcsCOCBe6H_G6btr6WaV2vVrO1Nm_r4tg@mail.gmail.com>
 <xmqqego4ogxw.fsf@gitster.dls.corp.google.com>
 <xmqq8uecocjg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Samuel Williams <space.ship.traveller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 10:51:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdENG-0002D4-E7
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 10:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbbDAIvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 04:51:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:49777 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbbDAIvk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 04:51:40 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M4WRI-1ZOSEW1J2S-00yjb7; Wed, 01 Apr 2015 10:51:36
 +0200
In-Reply-To: <xmqq8uecocjg.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:xG3q6iZVOO98OxVmyusmvadv6TYRk9bYO3zb8rZVTfz3nFv+Bsc
 mWVvgPP93h6wXoPrCPWPc9OKBN9wLsY1ptq4plPL2cNS943h7q/ovZIJxm2/CIEKPtlpucC
 r0q1J88Uco/S7kb3ZvUvC5og01jaEljFvJsd6BS1Mx6/AdK6KJVwwV8IXM58JneMNRIsaxI
 PRx1cZQDQvNV1o3d8LDTg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266596>

Hi Samuel & Junio,

On 2015-04-01 03:36, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Samuel Williams <space.ship.traveller@gmail.com> writes:
>>
>>> I would expect if you push to an empty repo, it would update it
>>> (because denyCurrentBranch = updateInstead).
>>
>> Good finding.
>>
>> I think the current implementation of updateInstead is set up to
>> bootstrap from an empty repository but only supports incremental
>> updates once the receiving repository and its working tree gets set
>> up.  But I do not think it was a conscious design decison to forbid
>> bootstrapping an empty repository, but was a mere gap in the
>> implementation.  At least, I do not think of a reason why we should
>> forbid it (and I am Cc'ing Dscho to confirm).
> 
> This is a tangent but I think we should unify the "do we already
> have history behind HEAD, or is the current branch still unborn"
> test done by various commands and tighten it.

Right, I did not think about that use case at all.

> As a quick and dirty hack, I just mimicked what builtin/merge.c seems to do, but this would tell a detached HEAD that points at a nonsense object name (i.e. "abcde" not a full 40-hex) as "unborn", where we would be better off stopping the operation instead of making the repository breakage worse by doing further damage.

Yeah, and we could refactor that into a global function, too. But for the moment, I think your proposed patch is good enough.

Ciao,
Dscho
