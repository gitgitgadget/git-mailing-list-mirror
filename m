From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 15:37:42 -0700
Message-ID: <7vboj0zv7t.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Sat Jul 28 00:37:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SutAR-0003cg-QJ
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 00:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab2G0Whq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 18:37:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55895 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747Ab2G0Whp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 18:37:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0C7386FF;
	Fri, 27 Jul 2012 18:37:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jDDeYxZnuXmAbbEcuOpTujoSQIY=; b=pQT01g
	sv4WnzK2/9pGL3H71+fD9y4YXp+totPKByZHQFciCrIh5JKIDF0bM1cDgaaV+Qg9
	bNs+1XvO/I+78qj22ZftUaF7BwjORJ5/5R3KgHqbv16oDwmmmGGOSig5YMHuFigK
	bAiw/uI9Z40E5aBXVrPjWXYHoPRx4/vq7U8Js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NRnXtskbnJALGmwKDwdOyIWGiToZkgnw
	5U9/LKb3jAd+hVsuoaPug82S3vdtedZ3gmJDQU8VwqDHikW3XLu3W6nIej33PZuz
	47pvCdePyf+vJZ+CGdW14h5sZIWv7mNtMPqLCDQEYOmON9Vl8XoGHPtAI5rKx6Ea
	QqaspagqJAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC99486FE;
	Fri, 27 Jul 2012 18:37:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DA9586FC; Fri, 27 Jul 2012
 18:37:43 -0400 (EDT)
In-Reply-To: <20120727221924.GA8700@dcvr.yhbt.net> (Eric Wong's message of
 "Fri, 27 Jul 2012 22:19:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE882F5C-D83B-11E1-B0AC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202386>

Eric Wong <normalperson@yhbt.net> writes:

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
>
> -------------
> The redundant dependencies are biting us :<  I agree there presence in
> the top-level Makefile needs to be reviewed.

Do you feel confident enough that we can leave that question hanging
around and still merge this before 1.7.12 safely?

I do not think it is a regression at the Makefile level per-se---we
didn't have right dependencies to keep perl.mak up to date, which
was the root cause of what we observed.

But the lack of dependencies did not matter before this series
because the list of *.pm files never changed, so in that sense the
series is what introduced the build regression, and I do not have a
solid feeling that we squashed it.

> Anyways, you can pull this now from my master:
>
> The following changes since commit cdd159b2f56c9e69e37bbb8f5af301abd93e5407:
>
>   Merge branch 'jc/test-lib-source-build-options-early' (2012-07-25 15:47:08 -0700)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn master
>
> for you to fetch changes up to 5c71028fced46d03bf81b8625680d9ac87c8f4f0:
>
>   Move initialization of Git::SVN variables into Git::SVN. (2012-07-27 22:14:54 +0000)
>
> ----------------------------------------------------------------
> Junio C Hamano (1):
>       perl: detect new files in MakeMaker builds
>
> Michael G. Schwern (7):
>       Quiet warning if Makefile.PL is run with -w and no --localedir
>       Don't lose Error.pm if $@ gets clobbered.
>       The Makefile.PL will now find .pm files itself.
>       Extract some utilities from git-svn to allow extracting Git::SVN.
>       Prepare Git::SVN for extraction into its own file.
>       Extract Git::SVN from git-svn into its own .pm file.
>       Move initialization of Git::SVN variables into Git::SVN.
>
>  Makefile                       |    7 +
>  git-svn.perl                   | 2340 +---------------------------------------
>  perl/.gitignore                |    1 +
>  perl/Git/SVN.pm                | 2324 +++++++++++++++++++++++++++++++++++++++
>  perl/Git/SVN/Utils.pm          |   59 +
>  perl/Makefile                  |    5 +
>  perl/Makefile.PL               |   35 +-
>  t/Git-SVN/00compile.t          |    9 +
>  t/Git-SVN/Utils/can_compress.t |   11 +
>  t/Git-SVN/Utils/fatal.t        |   34 +
>  10 files changed, 2487 insertions(+), 2338 deletions(-)
>  create mode 100644 perl/Git/SVN.pm
>  create mode 100644 perl/Git/SVN/Utils.pm
>  create mode 100644 t/Git-SVN/00compile.t
>  create mode 100644 t/Git-SVN/Utils/can_compress.t
>  create mode 100644 t/Git-SVN/Utils/fatal.t
