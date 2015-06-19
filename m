From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 09/19] fsck: Handle multiple authors in commits
 specially
Date: Fri, 19 Jun 2015 23:04:17 +0200
Organization: gmx
Message-ID: <fdcad96a0b8509eba316c79d2ce8be45@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <eb82bbfc658e8af1db03f7197b38aaaec33fd4ad.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqioaj78tl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:08:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63W8-0002xB-8s
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 23:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933415AbbFSVEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 17:04:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:54306 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808AbbFSVE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 17:04:26 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LjqLx-1YZCY720Iz-00boum; Fri, 19 Jun 2015 23:04:18
 +0200
In-Reply-To: <xmqqioaj78tl.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:OKFrGoJt/lwBeQcHMVJGS675lKVLEUtJDiah3VNA/UKa5TIe2Ef
 cAVv5voxeTFOXEufkQQfJaF7iVc8oVYVeu+8eyl/drX5QPtT4cFzVZfb5qIp5QvxpBEnM+9
 bYsFYJJv8yFgRkquPIYeog67KEV/gbWL02RcjVu8dFn75CfvrtXD46l6iIOZ0xCaQL1wNqH
 kUKfEnzhvxy8Kkkd1uZxQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272209>

Hi Junio,

On 2015-06-19 22:16, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>>  	err = fsck_ident(&buffer, &commit->object, options);
>>  	if (err)
>>  		return err;
>> +	while (skip_prefix(buffer, "author ", &buffer)) {
>> +		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
>> +		if (err)
>> +			return err;
>> +		err = fsck_ident(&buffer, &commit->object, options);
>> +		if (err)
>> +			return err;
>> +	}
> 
> Hmph, naively I would have expected that you wouldn't need an
> extra call to fsck_ident() here, and instead would see something
> like this:
> 
> 	author_count = 0;
> 	while (skip_prefix("author ")) {
>         	author_count++;
>                 ... do the existing check as-is ...
> 	}
>         if (author_count < 1)
>         	err |= report(missing author);
> 	else if (author_count > 1)
>         	err |= report(multiple authors);

Good idea! I fixed this in my branch and it will be part of v7.

Ciao,
Dscho
