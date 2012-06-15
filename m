From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl/Makefile: move "mkdir -p" to module installation
 loop for maintainability
Date: Fri, 15 Jun 2012 16:10:39 -0700
Message-ID: <7vhauc893k.fsf@alter.siamese.dyndns.org>
References: <1339781427-10568-1-git-send-email-adam@roben.org>
 <20120615180505.GH10752@burratino> <7vwr388dyp.fsf@alter.siamese.dyndns.org>
 <20120615230234.GA3547@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <adam@roben.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 16 01:10:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfffB-0000eH-V0
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jun 2012 01:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758489Ab2FOXKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 19:10:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45446 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757981Ab2FOXKl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 19:10:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7642083A0;
	Fri, 15 Jun 2012 19:10:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KTYPh5NnnSvbZ8Jzgq3q80FhKZw=; b=BHk9O8
	LNZrndC8bHXippaJZpBp64vWoD0YOXtDS6CvikbO8HcSQdLRc/3P2DUZzCQ8lqdP
	I1aJDDZEHD/eIn6+TJDd3vE+jtFF8X5xl8fYi+q1uzt2s10tgdEQ+mqLLA5WGUBo
	e+6xYWXrNpIQojHhuf7WLHT5yPggu4Y6pcUw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yp7FXqSKld3aRNCCDgwGI1nEul6NxwDk
	yngCO9h4SWkmfd2CwtcXOOwFHRmEScc8oUQ9I7YrQ7QMzRdWpIoFdbrrgROsakPe
	WZH5JPv9bQVT+9O2kuVMpjqffZhlQ4j/EfOynJBCL590Ki5vy7RUr4rj07TecR1H
	TvzOr2S3vg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D0B3839F;
	Fri, 15 Jun 2012 19:10:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D78CC839E; Fri, 15 Jun 2012
 19:10:40 -0400 (EDT)
In-Reply-To: <20120615230234.GA3547@burratino> (Jonathan Nieder's message of
 "Fri, 15 Jun 2012 18:02:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5376E5BC-B73F-11E1-9E09-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200107>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In the NO_PERL_MAKEMAKER=YesPlease fallback case, make the
> directory that will contain each module when installing it
> (simulating "install -D") instead of hardcoding "Git/SVN/Memoize
> is the deepest level".  This should make this codepath which is
> not used often on development machines a little easier to
> maintain.
>
> Requested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Jun 15, 2012 at 02:25:34PM -0700, Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> +	echo '	mkdir -p blib/lib/Git/SVN/Memoize' >> $@
>>
>> Wouldn't it be much less error prone to maintain if you did not
>> hardcode the "blib/lib/Git/SVN/Memoize is the deepest level" here,
>> and run the "mkdir -p blib/lib/$$(basename $$i)" or something in the
>> loop instead?
>
> Yes, I think so.
>
> Wasn't sure if "install -D" or "dirname" is portable, so this
> patch avoids them.

OK.  I suspect others may come up with a cleaner solution, so I'm
tempted to hold this in 'pu' for now and use the original one, which
was _not wrong_ in any way, for the 1.7.11 final.

Thanks.

>  perl/Makefile |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/perl/Makefile b/perl/Makefile
> index fe7a4864..2e8f9804 100644
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -34,22 +34,34 @@ modules += Git/SVN/Ra
>  
>  $(makfile): ../GIT-CFLAGS Makefile
>  	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
> -	echo '	mkdir -p blib/lib/Git/SVN/Memoize' >> $@
>  	set -e; \
>  	for i in $(modules); \
>  	do \
> +		if test $$i = $${i%/*}; \
> +		then \
> +			subdir=; \
> +		else \
> +			subdir=/$${i%/*}; \
> +		fi; \
>  		echo '	$(RM) blib/lib/'$$i'.pm' >> $@; \
> +		echo '	mkdir -p blib/lib'$$subdir >> $@; \
>  		echo '	cp '$$i'.pm blib/lib/'$$i'.pm' >> $@; \
>  	done
>  	echo '	$(RM) blib/lib/Error.pm' >> $@
>  	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
>  	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
>  	echo install: >> $@
> -	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)/Git/SVN/Memoize"' >> $@
>  	set -e; \
>  	for i in $(modules); \
>  	do \
> +		if test $$i = $${i%/*}; \
> +		then \
> +			subdir=; \
> +		else \
> +			subdir=/$${i%/*}; \
> +		fi; \
>  		echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
> +		echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)'$$subdir >> $@; \
>  		echo '	cp '$$i'.pm "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
>  	done
>  	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
