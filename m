From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fsck: report errors if reflog entries point at
 invalid objects
Date: Mon, 08 Jun 2015 18:00:09 +0200
Organization: gmx
Message-ID: <c5720357601be135485ef546cae7ffdb@www.dscho.org>
References: <cover.1433769878.git.mhagger@alum.mit.edu>
 <2ba9ee48a062b049c8b64fed4caba32c42f03031.1433769878.git.mhagger@alum.mit.edu>
 <e9d2f8cc371aa41e5d9095abd3cb7edb@www.dscho.org>
 <5575B03C.6040008@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:00:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zTX-0002Px-PE
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbbFHQAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:00:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:63144 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259AbbFHQAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:00:30 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MCOdh-1Yssna2ECH-0098eV; Mon, 08 Jun 2015 18:00:11
 +0200
In-Reply-To: <5575B03C.6040008@alum.mit.edu>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:hsajUv+ttM7qMqAT3XfcJm49IRcO8WYEk7MZVmtceb8pJf1Dpr7
 SBkgQRHPjGUxO7C2JFcYoqoHBrD6TQFgNYbVSvuMqxkugQfMivkUZjCxJe0MnvWEKHuim/Y
 I85MsDoaBtrzKcxjGs/a66rP9eT3XCMFHxzxq1BV7O8BLKQ2B/39ePleShjTvj6jXtUabfA
 oQAGPhT3jkpIBadg73fRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fUfhiIvKAw4=:u+GdmGDYqF2uoMoMDwJHi3
 9xqKbPuW7SsNtoq7Ki146NQP5QIggvK5Oyywpx1JNQdkRFMLKRjPfjU2pdXVZRr7DbMi/jEp/
 xYFzlpWSSLhiyasI6PV65b4AVtaH3EIrJPxxOQpfGrjowivMbang22Jwn6/j8PliEaK0KiImK
 zumtQk7XetsQWa8jKXyYuv3cT4aw1uwKNFsSIrMs7nqBas8r+Kzq21HK9B7EPBMxzS04qySSK
 a/unobxdJjEZm86KwaS9XmxqQYs41tIeKHmqmuxZxbbYYZAo3IqvfpuzMudigqBrHowRIOmuN
 QR8MhlnlQOqww+PzTxh4HFFa5YDhCSayFwmQjZodY6QR2mCVj36wEAxVv0lHosVQJEc4YVcvm
 pGRC5mep5snhmtAj35APTklocqWv6SKXwCutJnHLewQ7d48i3FyiknKwoduW+Dllp0BcdnyOx
 Y1yoAMFKYz6rnoYb7QWbJV0k0/OITop+zAlUhboE7D8CTqR4lJTB50zMNoDUnuFWMk3ZARiDx
 KRAXAbgKwxV8ptI3MCgfxZQMbgnN+7ZMHQQTrjJWqRiCFXwffeXy53R7m3iN+7PJ/yuRP+Q6G
 khiX4h3VLink+anzJd8uqXLfn0xNK8+F9ssbc4xuHswHFXxSlEr2VOgjcRwEhcLKLS5zx/p3g
 QfVGVsuuFNOhvvq9n3VS+fenhQuiS3K8K0/dY1bxH2Exo5mIs3BYY+S3dDAUMS1vdmMI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271059>

Hi Michael,

On 2015-06-08 17:09, Michael Haggerty wrote:
> On 06/08/2015 04:27 PM, Johannes Schindelin wrote:
>> On 2015-06-08 08:40, Michael Haggerty wrote:
>>> Previously, if a reflog entry's old or new SHA-1 was not resolvable
>>> to an object, that SHA-1 was silently ignored. Instead, report such
>>> cases as errors.
>>
>> I like the idea, but I am a bit uncertain whether it would constitute
>> "too backwards-incompatible" a change to make this an error. I think
>> it could be argued both ways: it *is* an improvement, but it could
>> also possibly disrupt scripts that work pretty nicely at the moment.
> 
> What kind of script are you worried about?

I was concerned about scripts that work on repositories whose reflogs become inconsistent for whatever reason (that happened a lot to me in the past, IIRC it had something to do with bare repositories and/or shared object databases).

Now, if I was to run a script in, say, cron to verify that all of my repositories (possibly on a network drive, for shared team use), I could imagine that I actually want to error out if the reflogs become inconsistent. But then, I could also imagine that I care more about the script being quiet when everything is okay except for the reflogs. 

> * This change only causes fsck to output an extra line (and exit with
>   a a non-zero retcode).

It is that non-zero exit status that would make my hypothetical cron script start to fail.

> * Repair is only a
> 
>       git reflog expire --expire-unreachable=now --all
> 
>   away, I think.

True.

Plus, as I mentioned, it could be considered a bug fix that fsck now reports this problem.

The more I think about it, the more I think it is actually a bug fix.

Thanks,
Dscho
