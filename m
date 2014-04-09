From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The fetch command should "always" honor remote.<name>.fetch
Date: Wed, 09 Apr 2014 11:40:21 -0700
Message-ID: <xmqqioqi1h4a.fsf@gitster.dls.corp.google.com>
References: <5340871D.8070503@lewisdiamond.com>
	<xmqqioqlm21y.fsf@gitster.dls.corp.google.com>
	<CAHwd=G=zV97H7eEK5dJ0XrfbF0bpZD6-YOvk0O8nVuqMGSz=jw@mail.gmail.com>
	<7v61mjnumu.fsf@alter.siamese.dyndns.org>
	<CAHwd=GnRHM9Nk7SzCL46cLTrxgGYH+F9O7KBOxnJmAQQRvKhSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lewis Diamond <git@lewisdiamond.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 20:40:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXxQN-0002ue-2i
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 20:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbaDISk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 14:40:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933323AbaDISkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 14:40:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73B6D7A3DF;
	Wed,  9 Apr 2014 14:40:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+AbonD+kwQ7kLPfA85RRNcTa0+0=; b=HBemST
	tTa5MM5GYi7rnzqbmA1Z+fIXOEeiDSZ1ekR92ZKBmAs3BMZhGnBjmNJmKyzbJolA
	J5VpDgM0Rrh+RkhCKeRdXnuqBpTVFS/xehbMITUoRYkT1ojblDCPZnNcLuPANB45
	Nmv/SOGsyKQDtDi0H1Xf6XSRQu9OCxcEqICF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oRSCQn3ZulyE2GmVdnc8P8QDTQ89FtCQ
	1zLrFUrkpQ6UrAJBW0s09WLp+5xB8NSTp+xt3T4++YHqo6U+F35fbcumaoB3/+ze
	tTzcIK2GjwtxbL+V1BPmwD46w9FKZISMvQDbaLI8NiQppdbJAA1oMximJtnpJdNq
	N3UpOcGGgTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60AAF7A3DE;
	Wed,  9 Apr 2014 14:40:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4703B7A3CF;
	Wed,  9 Apr 2014 14:40:23 -0400 (EDT)
In-Reply-To: <CAHwd=GnRHM9Nk7SzCL46cLTrxgGYH+F9O7KBOxnJmAQQRvKhSA@mail.gmail.com>
	(Lewis Diamond's message of "Wed, 9 Apr 2014 11:57:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 68E65234-C016-11E3-99F2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245986>

Lewis Diamond <git@lewisdiamond.com> writes:

> ... Yes, I agree that the abbreviation expansion works as designed
> (using the rev_parse_rules), 

I am not fundamentally opposed if you want to add a new command line
option to "git fetch" so that the shortened "what to fetch" are
dwimmed differently, but changing how "git fetch there master"
without any such option behaves will not fly well.  It will break
those who have already learned Git who expect that that is the way
to explicitly ask to fetch the master branch regardless of what
configuration the repository might have.

It is true that "git fetch there 'master'" cannot possibly mean the
'master' branch we locally have, so there is no fundamental reason
why we should use the same rev-parse dwim rules to grok them.

In fact we used to have different dwim rules for local (rev-parse
dwim rules) and for remote access --- I do not offhand recall if we
had rules for push and fetch separately, but I wouldn't be surprised
if we did.  The underlying mechanism certainly allowed us to use
separate rules for them back then.

Over time, however, having separate rules for remote and local was
found confusing by users, and that is why we changed the code to use
the same rule everywhere when dwimming the abbreviated refname on
the command line these days.
