From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 2/7] Change canonicalize_url() to use the SVN 1.7 API
 when available.
Date: Sat, 28 Jul 2012 13:24:42 -0700
Message-ID: <50144A8A.3040307@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-3-git-send-email-schwern@pobox.com>
 <20120728135018.GB9715@burratino> <50143700.80900@pobox.com>
 <20120728193029.GB3107@burratino> <501442D5.6080207@pobox.com>
 <20120728195733.GC3107@burratino> <20120728200047.GA4188@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 22:24:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvDZF-0005EY-M9
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 22:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111Ab2G1UYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 16:24:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087Ab2G1UYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 16:24:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CAE68B52;
	Sat, 28 Jul 2012 16:24:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=P610dGxVmC6B
	YTeaER/R0enhNzA=; b=fEcxWaDjz4xW0WfU5h3T9Rejm50d2iKnl78JRKcfDqgM
	W/i8EyNwQm5IS9236Tif/tBmmB/IdtNJmbZlWWGumaAfDDt4ufQYxTZqzdiBscq3
	dBmOZn/S7+5Vz9byzTmr9dUnKaYqqP9XQnwDIpu12aW/ZR0IvPumZC3iVyLEgO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dyO/0T
	y3+8YUq3dHpaDCgMwGUQ7N9tKWkEl33SX3rGoIUP9hJOJ3Zg+SUwYUvL6YPFCmx7
	VSb5tVrSNV+0dbRJiRdUNwCFPKzLM4VeLss/OIoLukwkQisnta2Cr/yDn+b1HaqO
	zgZX+oHcrONqT/M2lKiIMABG3P6uGVCJe5Uyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED40B8B51;
	Sat, 28 Jul 2012 16:24:44 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEFFE8B50; Sat, 28 Jul
 2012 16:24:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120728200047.GA4188@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 44A5D9D8-D8F2-11E1-B68D-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202463>

On 2012.7.28 1:02 PM, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
>> Michael G Schwern wrote:
> 
>>> I would suggest that worrying whether a few lines of code are introduced now
>>> or 10 patches later in the same branch which is all going to be merged in one
>>> go (and retesting the patches after it) is not the most important thing.
> [...]
>> In that case they should be one patch, I'd think.
>>
>> The advantage of introducing changes gradually is that (1) the changes
>> can be examined and tested one at a time, and (2) if later a change
>> proves to be problematic, it can be isolated, understood, and fixed
>> more easily.  The strategy you are suggesting would have neither of
>> those advantages.
> 
> (To avoid confusion: by "The strategy you are suggesting" I mean
> introducing dead code first and activating it later, not the path and
> url object idea.  The path and url object approach would be very
> nice. :))

If this is all a topic branch then it doesn't matter much whether a couple
lines of code is introduced at patch 8 of a branch or patch 13.  Sure, it
matters a little, but...
https://secure.wikimedia.org/wikipedia/en/wiki/Opportunity_cost

If it *isn't* going in a topic branch, if its not visible as a collected work
in history, if its going to be rebased on top of master, then yeah I can see
why you're so concerned.


-- 
Alligator sandwich, and make it snappy!
