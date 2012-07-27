From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 2/4] Prepare Git::SVN for extraction into its own file.
Date: Fri, 27 Jul 2012 01:16:49 -0700
Message-ID: <50124E71.2010302@pobox.com>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-3-git-send-email-schwern@pobox.com>
 <7vvch93hpy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 10:17:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SufjJ-00012D-HK
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 10:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab2G0IQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 04:16:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab2G0IQw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 04:16:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79BE256FB;
	Fri, 27 Jul 2012 04:16:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=kGbRaBRnFOpO
	jJ+4VDZurWOj91k=; b=oE+of6veaeGaFGdo6MkkJ2DwVLE7LVMphwhy9Ss3cg8b
	B5/zB9UVfQIbWcLQFkSAqViAVTTHTLPP4Xd0JAEuRAihhonz6w9l9rDUE5GGKWmO
	UOzm6454Mc2aDzgjX+FD0QSvkTyAB+ppzEGUmTVoJ13rqq76q5A7PtcMbpjUSVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CGK9H5
	pb4vEEn/nkrr1XjR6dvDv/eV2CAoTTvcqJJx2QyYpYjDeaXq/xlSkhhcNbWhpeeX
	xkoUMDwVYPlUpYNCeJCmssQXsfgZbpLR4jTN9uHQWT8iDFwgkPcgtknFP31/Ak64
	Sr6NlxWZ+pLp2jv7GBAvnztCROqA5dme1trg4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67E3556FA;
	Fri, 27 Jul 2012 04:16:51 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85F4956F9; Fri, 27 Jul
 2012 04:16:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vvch93hpy.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 6AF59B94-D7C3-11E1-B4E3-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202344>

On 2012.7.26 10:18 PM, Junio C Hamano wrote:
> Forgot to sign-off, or are you still unsure about this step?

I just never think to do it.  It's just a line in the commit message, right?
There's no crypto involved like tag -s.  Is it a blocker?  I guess I can write
a msg-filter if it's important.


> Again, I agree with you that passing $prefix as one of the arguments
> to ->new is the right thing to do in the final state after applying
> the whole series.  I don't know if later steps in your patch series
> will do so, but it _might_ make more sense to update ->new and its
> callers to do so without doing anything else first, so that you do
> not have to call out to the ::opt_prefix() when you split things
> out.

I don't personally plan on doing any more about it, no.  It isn't needed for
SVN 1.7, there's very little real code change (which you could see by looking
at my remote instead of waiting to be fed patches...) and its a very, very
minor problem in the grand scheme.

How git-svn structures its switches needs a ton of work, and there are far
deeper problems with Git::SVN.  For one, it's completely undocumented.  For
another, Git::SVN can't instantiate an object without git-svn being loaded and
so is very difficult to unit test.  I wouldn't want to change the constructor
interface until I could construct an object.

The first step toward that would be to change git-svn so it can be loaded as a
library using the standard "main() unless caller" trick.  Then Git::SVN unit
tests can require git-svn as a library without executing it and get some tests
written with a minimum of Git::SVN code change.

Step zero would be to allow Perl unit tests to either use or emulate the work
done in lib-git-svn.sh.  The major problem being how to communicate the
location of the trash directory, currently done by environment variables.  A
simple trick would be for the Perl tests to execute a shell wrapper that
outputs the relevant information.

None of which I plan to get into just now.


-- 
emacs -- THAT'S NO EDITOR... IT'S AN OPERATING SYSTEM!
