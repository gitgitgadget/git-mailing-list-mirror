From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fsck: report errors if reflog entries point at
 invalid objects
Date: Mon, 08 Jun 2015 19:08:09 +0200
Organization: gmx
Message-ID: <9adde72489de0b1ad66bd2c4730b18e9@www.dscho.org>
References: <cover.1433769878.git.mhagger@alum.mit.edu>
 <2ba9ee48a062b049c8b64fed4caba32c42f03031.1433769878.git.mhagger@alum.mit.edu>
 <e9d2f8cc371aa41e5d9095abd3cb7edb@www.dscho.org>
 <5575B03C.6040008@alum.mit.edu>
 <c5720357601be135485ef546cae7ffdb@www.dscho.org>
 <20150608165643.GA6863@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20X6-00072j-73
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbbFHRIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:08:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:64224 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbbFHRIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:08:14 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LaooK-1ZUUeA2ebY-00kQ1G; Mon, 08 Jun 2015 19:08:10
 +0200
In-Reply-To: <20150608165643.GA6863@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:ueKNgtZLNCOv/kFeyiymw3sUCxTYWEKWSov3VjWZOEODizoAhtT
 bh5CR7NZZC5mV8VbzN6+R9BG7Xx9lbZCy0xdu1+jMMWNYs2SLP4w0Yyi+AdGMBoSm3O6x88
 4C8rMJF2bRZV3Z/sHQyefFwh5VCz0uNKpUbzOfels38sM62baWOYSp73F0GiQmT4RIFizWG
 RoUOmKvlVO3sIeDZrIuEQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271082>

Hi Peff,

On 2015-06-08 18:56, Jeff King wrote:
> On Mon, Jun 08, 2015 at 06:00:09PM +0200, Johannes Schindelin wrote:
> 
>> >> I like the idea, but I am a bit uncertain whether it would constitute
>> >> "too backwards-incompatible" a change to make this an error. I think
>> >> it could be argued both ways: it *is* an improvement, but it could
>> >> also possibly disrupt scripts that work pretty nicely at the moment.
>> >
>> > What kind of script are you worried about?
>>
>> I was concerned about scripts that work on repositories whose reflogs
>> become inconsistent for whatever reason (that happened a lot to me in
>> the past, IIRC it had something to do with bare repositories and/or
>> shared object databases).
> 
> I think these repositories are already broken. You cannot run `git gc`
> in such a repository, as it will barf when trying to walk the reflog
> tips during `git repack`.
> 
> We run into this exact situation at GitHub because of our shared object
> databases. Our per-fork repack code basically has to do:
> 
>   if ! git repack ...; then
>     git reflog expire --expire-unreachable=all --all &&
>     git repack ... ||
>     die "ok, it really is broken"
>   fi

Good point. So if I needed any more convincing that Michael's patch is a bug fix (as opposed to a backwards-incompatible change), this did it.

Ciao,
Dscho
