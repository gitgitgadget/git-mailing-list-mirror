From: Michael G Schwern <schwern@pobox.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 18:00:32 -0700
Message-ID: <500F4530.7030207@pobox.com>
References: <500F17A3.60307@pobox.com> <20120724220207.GA15969@burratino>
 <500F26BF.7090501@pobox.com> <20120724233128.GD16333@burratino>
 <7va9yoenb2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 03:00:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stpxx-0002UV-0t
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 03:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593Ab2GYBAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 21:00:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47636 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409Ab2GYBAe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 21:00:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FC929BEF;
	Tue, 24 Jul 2012 21:00:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=qQ5QgFWOsKIq
	yOWkzz806WYc49o=; b=w5ilr5pcbU8T5h7Mx57j7EWx1FCx7+dmb4IdMXCj2H5Z
	6dG/jqv8HKoGgRpDUNkjB9Lx3k7qmQW6/ZRUlGTLIKROXUR6Q2fbZP53wmWI1dVs
	92+sZ2LuGUPv65fjXsF6+GnmTo3dC41esZDpHkTFp5Zci/71TNBUf848edOkgKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nuR5Xd
	kFjoI2BW7gzR1vuP80FzoA+z/99+WPBxMmzARUBMKPOvZvSc5506lAZ8Tzopl7sd
	qlMeEUBSvn7Z+e89/+ltFJIA6KKNZ2RfJnp1FktM8R8Dt9Bshp6ulaWNSkBxeqfv
	lExABfMTO1pFrEOGunwzsgl9epDRlo5iAKaso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D83B9BEE;
	Tue, 24 Jul 2012 21:00:34 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 056BC9BED; Tue, 24 Jul
 2012 21:00:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7va9yoenb2.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 232B15D0-D5F4-11E1-8745-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202089>

On 2012.7.24 4:45 PM, Junio C Hamano wrote:
>>>   git log -p schwern/git-svn/extract-classes..schwern/git-svn/fix-canonical
>>>
>>> That should give you the information you need...
>>
>> I guess so.  May we have your sign-off on these changes?  (A simple
>> reply of "yes" is enough, no need to resend patches to do this.)
>>
>> Here it is in patch form for reviewers.  If I understand correctly,
>> the idea is to replace accesses to $gs->{path} with calls to a
>> $gs->path function that canonicalizes (and likewise for s/path/url/).
>>
>> There are probably other subtleties, but that seems to be the gist.
> 
> The impression I am getting is that the updated code wants to handle
> URL and paths without any funny encoding, but it is unclear from my
> cursory read (e.g. what goes on with escape_url?).

No, now it's just canonicalizing as early as possible.  Preferably within the
object accessor rather than at the point of use.  So in the code below,
$full_url is already escaped/canonicalized.

In general this blob patch isn't going to make a lot of overall sense.  I'm
working with Jonathan to get it submitted in manageable pieces.


>>  	if ($old_url =~ m#^svn(\+ssh)?://# ||
>>  	    ($full_url =~ m#^https?://# &&
>> -	     escape_url($full_url) ne $full_url)) {
>> +	     $full_url ne $full_url)) {
> 
> How can the latter part of this conditional be true?

Good point.  More importantly, what was it trying to accomplish before and
does it need to be preserved?

"If the URL is svn OR its http and needs to be escaped... do something
special".  I don't really understand what the special stuff in the following
block is.  Anything that undef's the invocant (ie. $self) is probably broken.

a51cdb0c0420ee3bef26bbd1a9aa75e1d464e5b7 and
2a679c7a3148978a3f58f1c12100383638e744c5 shed some light.  2a679 looks like it
specifically holds off on escaping $full_url.  It would be very nice if that
was not necessary.  It would be helpful if the bug mentioned in 2a679 could be
reproduced to see if it still applies or can be dealt with in another way.


-- 
185. My name is not a killing word.
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
