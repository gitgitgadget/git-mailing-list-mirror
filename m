From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-svn in non-MakeMaker builds
Date: Fri, 15 Jun 2012 14:25:34 -0700
Message-ID: <7vwr388dyp.fsf@alter.siamese.dyndns.org>
References: <1339781427-10568-1-git-send-email-adam@roben.org>
 <20120615180505.GH10752@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <adam@roben.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 23:25:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfe1V-0001nh-LL
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 23:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336Ab2FOVZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 17:25:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36746 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757223Ab2FOVZh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 17:25:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C63DE92C2;
	Fri, 15 Jun 2012 17:25:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n7gCAJdriyarwcx2HjUbn4JaHw0=; b=D1wFow
	L8P0feJUIWxu31+NI3m3ibyPWI9RSdDSdU1ssf2pbNlylCQX+Bp2OtIC6tvoxreg
	mEPM/1YM5Be49Gb0kiv/tERyaEY+HqUMlV17FQkEa/5JNH9Q61PRy8KTsFBAFaYX
	9Ha01bmaYnkA2AVz+fk4pQoBZ+HQmHCMOLsZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xjWWIuzunluWbKXrdFdif8PQ0sK+xma+
	BT1WmhFQqOKwL0LjdEx7hmsfbZWqJbhh9MkQTQuKAMRkz5gnRxKeU0IPlMSb5d86
	84ljKMCWQ/NxK/DASJBKpy2Rl4BAm5rKGooLH68LZyBKGVwa92X0IRnYIFFcdSmI
	s6zItNHrnwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB57A92C1;
	Fri, 15 Jun 2012 17:25:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 260D992C0; Fri, 15 Jun 2012
 17:25:36 -0400 (EDT)
In-Reply-To: <20120615180505.GH10752@burratino> (Jonathan Nieder's message of
 "Fri, 15 Jun 2012 13:05:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A58DD694-B730-11E1-8052-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200101>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Adam Roben wrote:
>
>> c102f4cf729a65b3520dbb17b52aa0c4fe4d4b29 and
>> a6180325e885e2226d68144000e8bb18a906a2a6 split some git-svn code into
>> separate modules, but forgot to inform the non-MakeMaker build about
>> those new modules.
>
> Good catch.  How about this patch against master (untested)?
>
> -- >8 --
> Subject: perl/Makefile: install Git::SVN::* when NO_PERL_MAKEMAKER=yes, too
>
> v1.7.11-rc1~12^2~2 (2012-05-27) and friends split some git-svn code
> into separate modules but did not update the fallback rules to install
> them when NO_PERL_MAKEMAKER is set.  Add the appropriate rules so
> users without MakeMaker can use git-svn again.
>
> Affected modules: Git::SVN::Prompt, Git::SVN::Fetcher,
> Git::SVN::Editor, Git::SVN::Ra, Git::SVN::Memoize::YAML.
>
> Reported-by: Adam Roben <adam@roben.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmali.com>
> ---
> Sensible?
>
> In principle this should be two patches --- one to introduce the loop,
> another to add Git::SVN::* to that loop.  Let me know if you think
> this would be easier to read that way and I can try it.

>  perl/Makefile |   31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/perl/Makefile b/perl/Makefile
> index 3e21766d..fe7a4864 100644
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for perl support modules and routine
>  #
>  makfile:=perl.mak
> +modules =
>  
>  PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
>  prefix_SQ = $(subst ','\'',$(prefix))
> @@ -22,19 +23,35 @@ clean:
>  
>  ifdef NO_PERL_MAKEMAKER
>  instdir_SQ = $(subst ','\'',$(prefix)/lib)
> +
> +modules += Git
> +modules += Git/I18N
> +modules += Git/SVN/Memoize/YAML
> +modules += Git/SVN/Fetcher
> +modules += Git/SVN/Editor
> +modules += Git/SVN/Prompt
> +modules += Git/SVN/Ra
> +
>  $(makfile): ../GIT-CFLAGS Makefile
>  	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
> -	echo '	mkdir -p blib/lib/Git' >> $@
> -	echo '	$(RM) blib/lib/Git.pm; cp Git.pm blib/lib/' >> $@
> -	echo '	$(RM) blib/lib/Git/I18N.pm; cp Git/I18N.pm blib/lib/Git/' >> $@
> +	echo '	mkdir -p blib/lib/Git/SVN/Memoize' >> $@

Wouldn't it be much less error prone to maintain if you did not
hardcode the "blib/lib/Git/SVN/Memoize is the deepest level" here,
and run the "mkdir -p blib/lib/$$(basename $$i)" or something in the
loop instead?

> +	set -e; \
> +	for i in $(modules); \
> +	do \
> +		echo '	$(RM) blib/lib/'$$i'.pm' >> $@; \
> +		echo '	cp '$$i'.pm blib/lib/'$$i'.pm' >> $@; \
> +	done
>  	echo '	$(RM) blib/lib/Error.pm' >> $@
>  	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
>  	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
>  	echo install: >> $@
> -	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)"' >> $@
> -	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)/Git"' >> $@
> -	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git.pm"; cp Git.pm "$$(DESTDIR)$(instdir_SQ)"' >> $@
> -	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git/I18N.pm"; cp Git/I18N.pm "$$(DESTDIR)$(instdir_SQ)/Git"' >> $@
> +	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)/Git/SVN/Memoize"' >> $@

Likewise.

> +	set -e; \
> +	for i in $(modules); \
> +	do \
> +		echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
> +		echo '	cp '$$i'.pm "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
> +	done
>  	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
>  	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
>  	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
