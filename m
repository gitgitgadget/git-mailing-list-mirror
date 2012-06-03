From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Sun, 03 Jun 2012 14:44:42 -0700
Message-ID: <7vfwacxe7p.fsf@alter.siamese.dyndns.org>
References: <20120427082559.GC4023@login.drsnuggles.stderr.nl>
 <20120429082341.GA32664@dcvr.yhbt.net>
 <7vvckihyqm.fsf@alter.siamese.dyndns.org>
 <7vk40yhv5q.fsf@alter.siamese.dyndns.org>
 <20120430081939.GA27715@dcvr.yhbt.net>
 <7vipghgq9a.fsf@alter.siamese.dyndns.org>
 <20120430165315.GO4023@login.drsnuggles.stderr.nl>
 <20120430190200.GA27108@dcvr.yhbt.net>
 <20120430192016.GQ4023@login.drsnuggles.stderr.nl>
 <7vy5pcd7xu.fsf@alter.siamese.dyndns.org>
 <20120603104914.GA21276@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>,
	Matthijs Kooijman <matthijs@stdin.nl>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 23:44:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbIbV-0005Ib-KZ
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 23:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab2FCVoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 17:44:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731Ab2FCVop (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 17:44:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B1108711;
	Sun,  3 Jun 2012 17:44:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zTv9Ic2LbffRqf6+Fs0ZQSxEeMA=; b=cJa0pz
	VUrDIroNPjJGrpQsiVM73usjZRGbXs7qiRx5ezZWahRd8ZgIjgam0CxcIr9dOa65
	leeAeKhzQPfSEdSaYFm2ZbQH29mi12H48fkPW9V2D09t1ffG54THW5jmL95Gh0TA
	Vo14S3X3yqj+Cmgcii+6q/14qwuFUE3b6G8TY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CwiwHMJuPRhLoMfhzTt2pmJWdZTRJR/Z
	eEkdsQ3Jd11xNJX2jP8VURzMsO4m8U0sMb+J2TgquIeerVEPFs/8Uhm/MPzhqUn8
	dxq8TPXXyz9a+U15KyaMf0DqXPB8g3rjCtrgIolwV+nAQs/frOGOwDCZVoQQhhjN
	caU4O8gq0XU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 400808710;
	Sun,  3 Jun 2012 17:44:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B78E6870E; Sun,  3 Jun 2012
 17:44:43 -0400 (EDT)
In-Reply-To: <20120603104914.GA21276@hashpling.org> (Charles Bailey's message
 of "Sun, 3 Jun 2012 11:49:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 549E8450-ADC5-11E1-A4C5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199105>

Charles Bailey <charles@hashpling.org> writes:

>> @@ -5464,7 +5481,7 @@ sub _auth_providers () {
>>  
>>  	# earlier 1.6.x versions would segfault, and <= 1.5.x didn't have
>>  	# this function
>> -	if ($SVN::Core::VERSION gt '1.6.12') {
>> +	if (compare_svn_version('1.6.12') > 0) {
>>  		my $config = SVN::Core::config_get_config($config_dir);
>>  		my ($p, @a);
>>  		# config_get_config returns all config files from
>
> I presume this patch turned into this commit:
>
> commit f760c903b8525878cd3b426fc61a7a2cf8742609
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Wed May 2 19:53:50 2012 +0000
>
>     git-svn: introduce SVN version comparison function
>
> Although it was advertised as fixing the breakage introduced by
> 082afee621aeb2d3746c8ae290af98823f981f34 it didn't fix things for me.
> Although I haven't investigate why, trial and error proved that I
> could fix it if I changed the comparison to:
>
>        if (::compare_svn_version('1.6.13') > 0) {
>
> For me:
> $ svn --version --quiet
> 1.6.13
>
> Is this the correct fix or do I have a bad svn install on my linux
> box?

The conversion from "gt '1.6.12'" to "compare() > 0" is correct, I
think, as the original wanted to make sure that you have 1.6.13 or
newer (in other words, '1.6.12' is not good enough, but '1.6.13' is).
The fix was about not doing string comparison between the version
string and '1.6.12' string, i.e.

	if ("1.6.9" gt '1.6.12') {
		use the logic for newer versions
	}

incorrectly used the logic for newer versions.  That was the only
thing f760c90 (git-svn: introduce SVN version comparison function,
2012-05-02) addressed.

It is possible that '1.6.12' is not the right cut-off point and the
logic may require a version newer than that but that is outside the
scope of f760c90.

The cut-off point comes from 082afee (git-svn: use platform specific
auth providers, 2012-04-26).

Matthijs?  Eric?
