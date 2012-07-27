From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 14:31:43 -0700
Message-ID: <7v1ujw28n4.fsf@alter.siamese.dyndns.org>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-5-git-send-email-schwern@pobox.com>
 <7vhast3hpb.fsf@alter.siamese.dyndns.org> <20120727053800.GC4685@burratino>
 <7v394d3ffc.fsf@alter.siamese.dyndns.org>
 <7vpq7h1z1q.fsf@alter.siamese.dyndns.org>
 <7vlii51xz4.fsf@alter.siamese.dyndns.org>
 <20120727200703.GA2034@dcvr.yhbt.net> <50130062.7090901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 23:31:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sus8W-0003bb-9t
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 23:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab2G0Vbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 17:31:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820Ab2G0Vbq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 17:31:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15AB69872;
	Fri, 27 Jul 2012 17:31:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e74a2+J4ZXLbpo+aSrFJDW2qw3Q=; b=CXVLnw
	3RAZ9IOXkEV+caAes6n8YdDDz0eGEJUBY/b6JrebAP7euRcTlLRihmTwyK8Z2ts8
	K29CHYXk33dS2PvuLZ/2w81elnsdpVn0xg8U6m5saS+Si6Ns6KGxuj0oOj0nSsBl
	aon63Jc8XvgjAhWIv1ahcnWLm9vAK37tfRcuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dfPZC4RoW63Dw91Wky45zK/4X26LucKV
	/bC9lHRf4y1WMOs/f1NhpNzcPxX3QkRIkKIKu+WwvWjQWMeoaahPfQhURO/dm3Mv
	DfWywfBIEOXsBjotw+8Pn+biRUk9+JSxhBN0wL3JXn4ieQ3R0s8ByMtRBPbtwS5m
	DuhA3ULVSgE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F40F09871;
	Fri, 27 Jul 2012 17:31:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7331A986E; Fri, 27 Jul 2012
 17:31:44 -0400 (EDT)
In-Reply-To: <50130062.7090901@pobox.com> (Michael G. Schwern's message of
 "Fri, 27 Jul 2012 13:56:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76746044-D832-11E1-9C36-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202377>

Michael G Schwern <schwern@pobox.com> writes:

> On 2012.7.27 1:07 PM, Eric Wong wrote:
>> While Makefile.PL now finds .pm files on its own, it does not
>> detect new files after it generates perl/perl.mak.
>
> Are you saying this doesn't work?
>
> perl Makefile.PL
> make -f perl.mak
> touch Git/Foo.pm
> perl Makefile.PL
> make -f perl.mak
>
> or this?
>
> perl Makefile.PL
> make -f perl.mak
> touch Git/Foo.pm
> make -f perl.mak

Neither of the above.  Nobody should be typing "perl Makefile.PL"
inside our source tree unless he is trying to debug our Makefiles
anyway.

What does not work is this sequence:

	make
        >perl/Git/Foo.pm
        make

Makefile at the top-level, which builds perl/perl.mak by running
"perl Makefile.PL" in perl/ subdirectory, doesn't have dependencies
[*1*], so in the above sequence, the second invocation of "make"
fails to rebuild perl/perl.mak, which causes Git/Foo.pm forgotten
from the build/installation step.

And that is what happened to Git/SVN.pm.


[Footnote]

*1* I also suspect perl/Makefile lacks this dependency even though
it has its own rule to build perl/perl.mak---don't they need to be
cleaned-up and merged???

	
