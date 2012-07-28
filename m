From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 2/7] Change canonicalize_url() to use the SVN 1.7 API
 when available.
Date: Sat, 28 Jul 2012 12:51:49 -0700
Message-ID: <501442D5.6080207@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-3-git-send-email-schwern@pobox.com>
 <20120728135018.GB9715@burratino> <50143700.80900@pobox.com>
 <20120728193029.GB3107@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:52:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvD41-0000xS-Q3
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 21:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073Ab2G1Tvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 15:51:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032Ab2G1Tvv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 15:51:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE1B08615;
	Sat, 28 Jul 2012 15:51:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=my/uWiBjtqpO
	wn5H4EcY2eg1AeI=; b=adlE3xQO1zVcOr7hdXRsGk8bEHVU8L+r82Ii8Uy1DFwn
	35jJdCr4LiAKp7Jl0iBttOVaJhLOzTDjpI3rwnzV491AtdP+6ktsfT4WIZoF+MfK
	rCKXiuJfpvUR46AXYpm6tPjps1+T9lDOQN7laCP3kxTsEdhfHCPyqbJjBQVj5QM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FLnww2
	VwsSyeeSpSqbfX9xAdVcR/SRdooujX4+aqEMocKrHToEeKr5TV5Zwt72afZ/lqFi
	Lo6EKJ5yj9Nu0zXOmJMnmtYGmDrQ00FaukgmT5VcelqvIzH7cbYEqQWhsDGrSZCq
	TDLdnanmaKGOYPVF1F/Bt+xj6kSTVK2FRWnBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8DDF8614;
	Sat, 28 Jul 2012 15:51:50 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3CE08613; Sat, 28 Jul
 2012 15:51:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120728193029.GB3107@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: AC199A46-D8ED-11E1-9D8D-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202460>

On 2012.7.28 12:30 PM, Jonathan Nieder wrote:
>> I didn't know about that.  I don't know what your SVN backwards compat
>> requirements are, but if that behavior goes back far enough in SVN to satisfy
>> you folks, then canonicalize_url() should fall back to
>> SVN::_Core::svn_path_canonicalize().
> 
> svn_path_canonicalize() has been usable for this kind of thing since
> SVN 1.1, possibly earlier.

Great!  Then _canonicalize_url_ourselves() can probably be replaced with that.
 Just take my advice and do it after 1.7 is working and the code is ready for
canonicalization.


>>                                      But try it at the end of the patch
>> series.  The code has to be prepared for canonicalization first.  Then how it
>> actually does it can be improved.
> 
> Since this part of the series is not tested with SVN 1.7, this is
> basically adding dead code, right?  That could be avoided by
> reordering the changes to keep "canonicalize_url" as-is until later in
> the series when the switchover is safe.

I would suggest that worrying whether a few lines of code are introduced now
or 10 patches later in the same branch which is all going to be merged in one
go (and retesting the patches after it) is not the most important thing.  The
code needs humans looking over it and deciding if canonicalizations were
missed or applied inappropriately.  Or hey, work on that path and url object
idea that makes a lot of real code mess go away.


-- 
ROCKS FALL! EVERYONE DIES!
	http://www.somethingpositive.net/sp05032002.shtml
