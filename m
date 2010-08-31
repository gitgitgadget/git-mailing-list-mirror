From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP
 files.
Date: Tue, 31 Aug 2010 16:50:47 -0700
Message-ID: <7vk4n68hpk.fsf@alter.siamese.dyndns.org>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
 <4C7B8E1E.6050708@drmicha.warpmail.net>
 <AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
 <20100830141602.GF2315@burratino>
 <AANLkTim+S87KjFBstBineR02hQHzG=X2VDqgiGNbPQGS@mail.gmail.com>
 <20100830163302.GA13336@burratino>
 <AANLkTi=VPf9CWNJcce6d20HQChi0mHgTG1F=jakzNT-O@mail.gmail.com>
 <4C7C020C.6090907@drmicha.warpmail.net>
 <AANLkTimiSBjifxtDoFXAEAEpYM8bJ18SwJ5Fj8zqh_G6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 01:51:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqabd-0001Ar-A0
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 01:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755Ab0HaXvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 19:51:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0HaXvC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 19:51:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6810D2080;
	Tue, 31 Aug 2010 19:50:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xJs59eHolOKn69giqp7vp4Tf8jQ=; b=uiqjh3
	DOYiBrJPkpb9AX6tBLW4lVS4vh7T7IYbfy3TZpCIB1z/t5QxgJ5sZNcRMooli9Jv
	ADynZD9TSSqvyr6asMatM7OlL/BnbHHaUo4Cey7l84NN2/A0crQXODg2EPPKPw1a
	S0fhMjJuRCHon9Zl/ddWpDBHMkoMxjFR/Dz0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l++bf+M/uCbgfPVseGeYVrj/7kCfi6rz
	fMKdUH/GDxwr3FFxcNTmzIHbsHVBdnf6OhNgFYxVbS0h0OMYkUs5qsVwXk9bu/HO
	cYvbSaRjhYeQqWITuCBiRDFR+ZL8WWKXon9GKHGRhlOxyJQdGHMn6NwwQpr99EkB
	kw1aDfBFi8E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB526D207F;
	Tue, 31 Aug 2010 19:50:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A06F1D207A; Tue, 31 Aug
 2010 19:50:49 -0400 (EDT)
In-Reply-To: <AANLkTimiSBjifxtDoFXAEAEpYM8bJ18SwJ5Fj8zqh_G6@mail.gmail.com>
 (Chris Patti's message of "Tue\, 31 Aug 2010 17\:06\:50 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 981A1ED4-B55A-11DF-BD7C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154997>

Chris Patti <cpatti@gmail.com> writes:

> function parseCommit($old_sha1,$new_sha1) {
>         # if this is the first commit on a new branch, $old_sha1 will
> be a bunch of zeroes, and so
>         # git diff --raw will fail, since there's no old ref to
> compare against.  So, we parse the
>         # results of git diff-tree -root=$new_sha1 instead to get the
> blob and filename we'll need.
>         if (detectNewBranch($old_sha1,$new_sha1)) {
>                 $diffcmd="git diff-tree --root $new_sha1";

This somehow feels wrong.  If the tree of the new commit is flat without
subdirectory, the above would do, but don't you need "diff-tree -r" here?

>                 $regex="/\:\w+ \w+ \w+ (\w+) \w (.+)/";
>         }
>         else {
>                 $diffcmd="git diff --raw $old_sha1 $new_sha1";

And you are better off using "diff-tree -r" here instead of "diff --raw"
here as well, to keep the input to your parser for both cases uniform.
The parser would be easier that way, no?

>                 $regex="/\:\d+ \d+ \w+... (\w+)... \w\t(.+)/";
>         }
