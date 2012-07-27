From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 15:59:59 -0700
Message-ID: <7vobn0yfm8.fsf@alter.siamese.dyndns.org>
References: <7vhast3hpb.fsf@alter.siamese.dyndns.org>
 <20120727053800.GC4685@burratino> <7v394d3ffc.fsf@alter.siamese.dyndns.org>
 <7vpq7h1z1q.fsf@alter.siamese.dyndns.org>
 <7vlii51xz4.fsf@alter.siamese.dyndns.org>
 <20120727200703.GA2034@dcvr.yhbt.net>
 <7vsjcczxgu.fsf@alter.siamese.dyndns.org>
 <20120727220753.GA7378@dcvr.yhbt.net> <20120727221924.GA8700@dcvr.yhbt.net>
 <7vboj0zv7t.fsf@alter.siamese.dyndns.org>
 <20120727224554.GA30385@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jul 28 01:00:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SutW6-0001Ho-M0
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 01:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab2G0XAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 19:00:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab2G0XAG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 19:00:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAF2B8BA7;
	Fri, 27 Jul 2012 19:00:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OIVY57phdNZXSdh77LhPsTmCqNI=; b=D/RViF
	bG6gXThnX7gLXqb5mpHIJ4edsmNpefXAg+vWJ4QMF8leImwuhqyVYtbXnEpD7HKF
	qj+XUNxdZJbsQkih4xtLewjUrJn4N1HvWEqiOMvPDQEa9L6ZB09F9MZi+ylEM6Rx
	jnVIp1J4N00lGNiO/Pltw80Lq+axmF69nHnL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Aat/IJtncaaUh+kVId9WjR4u5xWYvpbQ
	RjSffk2Cvp3cy5nVuBU7ODhFJulX2ntO4f3+Yb7fjvmrv2SdO/9hyZvV2xnU2g7C
	wE62UvqPqEMddVhLTIm3ciSWnSKFP2NDjFnBzP+tYZWAnapDKoWP4LceEdzGuM+k
	2YlTr5iVU8U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AB698BA2;
	Fri, 27 Jul 2012 19:00:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A3488B9C; Fri, 27 Jul 2012
 19:00:00 -0400 (EDT)
In-Reply-To: <20120727224554.GA30385@dcvr.yhbt.net> (Eric Wong's message of
 "Fri, 27 Jul 2012 15:45:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB315D42-D83E-11E1-947E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202392>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <normalperson@yhbt.net> writes:
>> > The redundant dependencies are biting us :<  I agree there presence in
>> > the top-level Makefile needs to be reviewed.
>> 
>> Do you feel confident enough that we can leave that question hanging
>> around and still merge this before 1.7.12 safely?
>
> Yes.
>
>> I do not think it is a regression at the Makefile level per-se---we
>> didn't have right dependencies to keep perl.mak up to date, which
>> was the root cause of what we observed.
>> 
>> But the lack of dependencies did not matter before this series
>> because the list of *.pm files never changed, so in that sense the
>> series is what introduced the build regression, and I do not have a
>> solid feeling that we squashed it.
>
> Right, I agree the original dependencies are not good and it's not
> a recent regression in the Makefile level.
>
> I do feel our patch deals with the problem for now.  I've been going
> between commits in Michael's 3rd series and haven't noticed new issues
> when running the tests.

Ok, please don't forget to add necessary .gitignore rule for the new
stamp file.
