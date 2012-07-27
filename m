From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 15:52:43 -0700
Message-ID: <7vwr1oyfyc.fsf@alter.siamese.dyndns.org>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-5-git-send-email-schwern@pobox.com>
 <7vhast3hpb.fsf@alter.siamese.dyndns.org> <20120727053800.GC4685@burratino>
 <7v394d3ffc.fsf@alter.siamese.dyndns.org>
 <7vpq7h1z1q.fsf@alter.siamese.dyndns.org>
 <7vlii51xz4.fsf@alter.siamese.dyndns.org>
 <20120727200703.GA2034@dcvr.yhbt.net>
 <7vsjcczxgu.fsf@alter.siamese.dyndns.org>
 <20120727220753.GA7378@dcvr.yhbt.net> <20120727221924.GA8700@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jul 28 00:52:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SutOu-0004zK-PA
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 00:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab2G0Wwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 18:52:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61753 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019Ab2G0Wwq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 18:52:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C25B68A0B;
	Fri, 27 Jul 2012 18:52:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQNPK7ISbM5CjJhIa7cpVc5YdjQ=; b=sF0kP+
	q4TraqO18vjOw3WtJJIgRLx0zAbRHbrjgwvXFm9UV6DQ72RHwFFKYmakj/nfDG9X
	P9TpLuoPFwAp5e+0/fwOJo9Z8qsBYDbiPmNwgIrd250gA26bpHdX2xRg6/sn505/
	cBxF3CgsqEN2pjyBi7JVn0x9LEvqfyg1qxZEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cAw09eDOxxSjiHbKKIXul/DzrfB7Cf3Q
	HkIrXODmyzBH2QbJ/+d/yiZ4jxeTUeMxH/CI3tSiWsKVhJYgfsvgkRFVQli3aTgx
	2NVoE+59I/UneVQLpMrqgjeyvbNQbD4+opkqZbJ94c5HvlrN3heZt3QvDtTzPy6m
	MdB3jSG2Kbo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B00FD8A09;
	Fri, 27 Jul 2012 18:52:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30AD58A08; Fri, 27 Jul 2012
 18:52:45 -0400 (EDT)
In-Reply-To: <20120727221924.GA8700@dcvr.yhbt.net> (Eric Wong's message of
 "Fri, 27 Jul 2012 22:19:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7AAE888-D83D-11E1-83DD-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202390>

Eric Wong <normalperson@yhbt.net> writes:

> Eric Wong <normalperson@yhbt.net> wrote:
>> So I'll hold off until we can fix the build regressions (working on it
>> now)
>
> OK, all fixed, all I needed was this (squashed in):
>
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -22,6 +22,8 @@ clean:
>  	$(RM) $(makfile).old
>  	$(RM) PM.stamp
>  
> +$(makfile): PM.stamp
> +
>  ifdef NO_PERL_MAKEMAKER
>  instdir_SQ = $(subst ','\'',$(prefix)/lib)

Another thing I noticed but didn't say was that the top-level
Makefile seems to think without NO_PERL the way to regenerate
perl/perl.mak is to run perl/Makefile.PL, which is not true if the
build is done with NO_PERL_MAKEMAKER.

I do not offhand know why we even need to have dependency on
perl/perl.mak in the toplevel Makefile (other than "otherwise nobody
descends into perl/ and run make in it", which is a bogus
reason---there should be a rule to run "$(MAKE) -C perl/ $@" when
doing "make all" at the top-level if that is the case), but I think
at least the duplicated rule in the toplevel Makefile should read
something like:

	perl/perl.mak: ... (the dependencies) ...
		$(QUIET_SUBDIR0)perl ... (make variables) ... perl.mak

so that the real knowledge of how to rebuild it (with or without
NO_PERL_MAKEMAKER) should be in perl/Makefile.
