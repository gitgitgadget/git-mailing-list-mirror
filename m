From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 14/19] fsck: Allow upgrading fsck warnings to errors
Date: Fri, 19 Jun 2015 23:10:33 +0200
Organization: gmx
Message-ID: <b003ad9a31c790dd0dafea8d81839322@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <49189b5b9e8ad194c6408b30db6f493c53595021.1434720655.git.johannes.schindelin@gmx.de>
 <xmqq616j78ik.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:10:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63Yl-0005QU-FH
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 23:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912AbbFSVKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 17:10:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:51739 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932849AbbFSVKj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 17:10:39 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MVui8-1ZdBPV18xM-00X8Ft; Fri, 19 Jun 2015 23:10:33
 +0200
In-Reply-To: <xmqq616j78ik.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:mPR5bfYr4hlwKc65QBxsmx4Jawj81cbkQk63B6vKk8nk98pSt+6
 9yX1HKKeNZA7Gg1Zrov6NC6Dd0uXAz3A0pbIeovaTjbePVwJLv6qmAWyL94Cg7QvneYs50t
 GHrqFNBSP8E2M4gY98FZJ/urwq3iQhNAuAq0l8j+6DDfzGQmTl3ZgX1w1oVxGxKCjZj44Q/
 wpjKb7eiU/RAytjGyGjWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aRptnVeLq9w=:LohICeX80ppa/auklqu9Mz
 r+NzbdI0xz3Gc1nIIMN6Pol5iEv/KZyACrcjupkazQeCL1VDOI/tXkK8RVxjn0k6luOwWPzuV
 IjHpcq4J0/5O+4+PNd8VX7EjNpCoXaoMhKUwPPcg3PlWOGC3gT8WeBUFexn6xGsxcLzHG0DoP
 AqxmufCzXhOK1rN389lRsQSNiSbHt1k8jZ8HPmuK+eZqwnEil1KETdNLOMSzxqIvrvOCOqcia
 tW1zXmWRMRHuAoC7QNRDbYUaHrynFzhHZQ0UWFzQPzPh6FaNpvLOLO3q/xEeembrMACaCmGh9
 q78lj/Wfjqbfe7mCM0SBVP2+SAzmGkYhzzZ1cXHzTD4dNETI9C5psG7XiaNTci4YDiUmzQ8IR
 uSZM0OcM3ERr9ytbubomzWnp6CqQppCikbtS5gQn+FKrk7l8QVLaWucEYmP0YlTVHm35uk2sL
 KfUd5dpwHXOhF7NIbpFydg8mppxLROUg36TI0/6QdVjIE2LQTfMeRjsZU3FTnE/B2q+2eqXb8
 QegZ4jKjQhTWz1WImLN2TqA+Db8m6WkeW7Y3qVpqWZ5x3sb2V48qcoE2OvF2++Hp55GC6FrVC
 A4dlz9CR1I60qDV5wnINC5m5gwCnaLa/J0IJ42j0K1juABNWXV5EQF+O4eMR452I8vZlMczlO
 zMgcUslVRoOYt0HZuhS9aZKsqkQvXzUrRDEobpmRcn6hiTIxqOc+IpHciDGHP3u3y/YU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272211>

Hi Junio,

On 2015-06-19 22:22, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>>  #define FSCK_FATAL -1
>> +#define FSCK_INFO -2
>>
>>  #define FOREACH_MSG_ID(FUNC) \
>>  	/* fatal errors */ \
>> @@ -50,15 +51,16 @@
>>  	FUNC(ZERO_PADDED_DATE, ERROR) \
>>  	/* warnings */ \
>>  	FUNC(BAD_FILEMODE, WARN) \
>> -	FUNC(BAD_TAG_NAME, WARN) \
>>  	FUNC(EMPTY_NAME, WARN) \
>>  	FUNC(FULL_PATHNAME, WARN) \
>>  	FUNC(HAS_DOT, WARN) \
>>  	FUNC(HAS_DOTDOT, WARN) \
>>  	FUNC(HAS_DOTGIT, WARN) \
>> -	FUNC(MISSING_TAGGER_ENTRY, WARN) \
>>  	FUNC(NULL_SHA1, WARN) \
>> -	FUNC(ZERO_PADDED_FILEMODE, WARN)
>> +	FUNC(ZERO_PADDED_FILEMODE, WARN) \
>> +	/* infos (reported as warnings, but ignored by default) */ \
>> +	FUNC(BAD_TAG_NAME, INFO) \
>> +	FUNC(MISSING_TAGGER_ENTRY, INFO)
> 
> Exactly the same comment as 12/19 applies to this change; not only
> complaints but also "result makes sense" part.

And my explanation is the same ;-) At 02/19 time, it would just puzzle me, as a reader, to see special treatment without any good reason.

Ciao,
Dscho
