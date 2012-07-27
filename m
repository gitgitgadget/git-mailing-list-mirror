From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 01:41:23 -0700
Message-ID: <50125433.1000702@pobox.com>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-5-git-send-email-schwern@pobox.com>
 <7vhast3hpb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 10:42:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sug7g-00046E-JW
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 10:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab2G0Il1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 04:41:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab2G0IlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 04:41:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3DAD5B6B;
	Fri, 27 Jul 2012 04:41:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=8A94oqMWB43q
	Myjls70DHcHqQJ8=; b=Y0yrwCC3+8HjiRH/EBaVoOWjnl7GbO9nKTWbBX0Gpoa0
	tXiePg34EDXsfHcWFpe0b+MDw2QY+fEP652tiko1gA2BFdQOvrAl1JzWkSFRRkmQ
	zkcmGbEQ1RQASBwBbweOaiY0QGFUWzNNAN+l7TbHjpn6dAVaV/exZGbW0NkMkDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YFTo4H
	oXhW6e8oSHdAeJTsHfQqUGZTu/g7ixIJp0td9NUqDGEdfpPjJwKUYjjANCRzkVVH
	Wba0aLtCZTBm5B7UQnLobSAPp8JiUsJrqkB/Uk+eMvGDHneMRjsv+Wnyxc+3oxeo
	KUzLzXNr664U6RfTe0ynjSHM2+v1zVy+SVblQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0D935B6A;
	Fri, 27 Jul 2012 04:41:24 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD42D5B68; Fri, 27 Jul
 2012 04:41:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vhast3hpb.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: D91F2F60-D7C6-11E1-BCF9-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202346>

On 2012.7.26 10:18 PM, Junio C Hamano wrote:
> If you swap the order of steps 3/4 and 4/4 by creating Git/SVN.pm
> that only has these variable definitions (i.e. "our $X" and "use
> vars $X") and make git-svn.perl use them from Git::SVN in the first
> step, and then do the bulk-moving (equivalent of your 3/4) in the
> second step, would it free you from having to say "it's doubtful it
> will compile by itself"?

If it wasn't clear, all tests pass with every patch using SVN 1.6.

"Compile on its own" wasn't entirely clear.  I meant that Git::SVN doesn't
depend on git-svn to set its defaults.  Git::SVN still depends on it for A LOT
of other things, and will likely remain that way for a long time, so it's
kinda splitting hairs to worry about it.

4/4 was done last to ensure the phase of git-svn when the Git::SVN globals are
initialized remains basically the same.  If they were moved into Git::SVN
before it was split out they'd be getting initialized *after* the git-svn
command has been executed.  I didn't want to expend the energy or risk the
bugs to get around that.


> In short:
> 
>  - I didn't see anything questionable in 1/4;
> 
>  - Calling up ::opt_prefix() from module in 2/4 looked ugly to me
>    but I suspect it should be easy to fix;

Originally I tried to refactor new().  It rapidly turned into a lot of work on
undocumented code with no unit tests for no use to the SVN 1.7 issue for one
variable.  This is a very cheap way to let far more important work move
forward and it has a very narrow effect.  It could be made a Git::SVN global
that git-svn grabs at, but that's not really any better.  I'd rather leave it be.


-- 
91. I am not authorized to initiate Jihad.
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
