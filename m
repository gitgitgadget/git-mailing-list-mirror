From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Fri, 05 Dec 2008 16:46:37 -0800
Message-ID: <7vabbaxh8y.fsf@gitster.siamese.dyndns.org>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
 <200812060134.22959.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 01:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8lL3-0006X6-GQ
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 01:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbYLFAqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 19:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754924AbYLFAqs
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 19:46:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbYLFAqs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 19:46:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E232384AC0;
	Fri,  5 Dec 2008 19:46:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BC6EC84ABF; Fri,
  5 Dec 2008 19:46:39 -0500 (EST)
In-Reply-To: <200812060134.22959.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat, 6 Dec 2008 01:34:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C39983C-C32F-11DD-A0E3-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102426>

Jakub Narebski <jnareb@gmail.com> writes:

>> +	# The maximum number of patches in a patchset generated in patch
>> +	# view. Set this to 0 or undef to disable patch view, or to a
>> +	# negative number to remove any limit.
>> +	'patches' => {
>> +		'override' => 1,
>> +		'default' => [16]},
>>  );
>
> You need to set "'sub' => \&feature_patches" for feature to be 
> override-able at all.  Also features are usually not overridable
> by default, which reduces load a tiny bit (by _possibly_ not reading
> config, although that shouldn't matter much now with reading whole
> commit using single call to git-config, and not one call per variable).
> And I think the default might be set larger: 'log' view generates
> as big if not bigger load, and it is split into 100 commits long
> pages.

I do not think defaulting to 'no' for overridability nor defaulting a new
feature to 'disabled' have much to do with the load, but they are more
about the principle of least surprise.  Somebody who runs gitweb in the
playpen he was given on the server shouldn't be getting a phone call from
his users late at night complaining that the page his gitweb serves look
different and has one extra link per each line, only because the sysadmin
of the server decided to update git to 1.6.1 without telling him.

Once a new version capable of serving a new feature is introduced, he can
plan, announce and deploy by switching the feature on in his gitweb
configuration file.

Some things, like sitewide default css changes, cannot be made disabled
by default.  But a new feature can easily be kept disabled by default not
to cause needless surprises.
