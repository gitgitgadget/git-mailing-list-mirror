From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 09:27:04 -0800
Message-ID: <7vvdgrordj.fsf@alter.siamese.dyndns.org>
References: <20091130075221.GA5421@coredump.intra.peff.net>
 <7vr5rgv1lr.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911300156l7f8dbe55p7da26540b0360773@mail.gmail.com>
 <200911301159.23383.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 18:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFA22-0006Kg-Fb
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 18:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZK3R1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 12:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbZK3R1O
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 12:27:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbZK3R1N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 12:27:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5011AA21D6;
	Mon, 30 Nov 2009 12:27:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ttlNo7UnaYxCzg1rI+7nyChsJWA=; b=NfjbAc
	HRPeBUSfvj+SkIj7I1qo6JDzjUgoRKRRm/4VRKImthgx9MwdSH3i/ytUDMrOx6p3
	a8Uwe2ttGRiDTCPkOA/m4djRJ4HXVS2uaRVdI5VdN4endKVrrH2MrvhuiulcVSfD
	YW+9VEeu9i4sJmz/WEVOkVFYC7J/pXfoxegKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IvFRoZbaQjl2IgjkbARmajsrISPwNRV1
	eqtiVhLeZL/J/rCx26L8b8J4Tv8QNkx7qeWu2P3qFyo0srVugxY1sC0gJXIPT2dL
	BVixTAaRpzgO6OFj22ltd926RVUa7Ymu617PawI9eZJ3KKqXy5ESUMo6kimdr6Bx
	9h7uHRD9foY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0481CA21D5;
	Mon, 30 Nov 2009 12:27:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 14D40A21D0; Mon, 30 Nov 2009
 12:27:05 -0500 (EST)
In-Reply-To: <200911301159.23383.johan@herland.net> (Johan Herland's message
 of "Mon\, 30 Nov 2009 11\:59\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 98D7C2AC-DDD5-11DE-ACA2-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134121>

Johan Herland <johan@herland.net> writes:

> ... Hence, this subdir is 
> meant to contain the support scripts for remote helper written in Python, 
> both common support scripts, and support scripts specific to each remote 
> helper. So far, only the common code is there, but we expect the Hg and CVS 
> helpers to add scripts to the "hg" and "cvs" subsubdirs, respectively.

Ahh, Ok, that clarifies it.  The packager (not me) can package what is
(in|built from) remote_helpers directory into one package, and declare
that as a dependency to each of the individual remote helper packages that
uses the common stuff found in there, if the distro wants to have "one
end-user feature per package" granularity.

Just to make sure you didn't misunderstand me, I wasn't complaining that
the directory was not further split for each helper.  I wanted to know the
reason behind wanting to have _one_ directory that is common across
multiple helpers that are supposed to be independent.  "A common library"
is a good reason to have that organization.

> We _could_ split up the "git_remote_helpers" package into a "git-remote-hg"-
> specific package, and a "git-remote-cvs"-specific package, but that would 
> mean either having two copies of the current support code. Alternately, we 
> could create a _third_ package containing the common support code, that each 
> of our hg/cvs support packages would in turn depend on. I don't think we 
> want to go there, at least not yet.

I think that is typically done by the distros; in the longer term it would
be nicer to them if we did so in our build structure, but I do not think
we are there yet.

> Also, to prevent this misunderstanding, we could create a "python" subdir in 
> git.git, and move the "git_remote_helpers" into there.

If (and this is a big if, as we are not migrating to Python) the use of
Python proliferates over time, a single "python" subdir to hold "a common
library" to create the third package will not make sense in the longer
term, as different services written in Python will have different set of
common supporting code, so there will be multiple common libraries and you
would need multiple third packages.  You would probably need multiple
directories there, perhaps as subdirectories of that single toplevel
directory you called "python", so that scripts written in Python would say
"import pythonGit.remoteHelper" or something like that.
