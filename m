From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] convert filter: supply path to external driver
Date: Tue, 21 Dec 2010 13:24:15 -0800
Message-ID: <7vzkry7rb4.fsf@alter.siamese.dyndns.org>
References: <20101218223822.GA18902@arf.padd.com>
 <20101219212925.GA7393@arf.padd.com>
 <7vzks1e84p.fsf@alter.siamese.dyndns.org>
 <20101220160911.GA32136@honk.padd.com>
 <7v8vzkcol8.fsf@alter.siamese.dyndns.org>
 <20101221134403.GA10401@honk.padd.com> <20101221181924.GB25812@burratino>
 <20101221203322.GA13868@honk.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 22:24:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV9hG-0005zm-8p
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 22:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab0LUVYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 16:24:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab0LUVYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 16:24:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6344936C3;
	Tue, 21 Dec 2010 16:24:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F+q+xCiuvWCBCFTYLsKk1dT6sQY=; b=wAxXoN
	cRDFhafb1P4C/QDvoAy7lO5gc2OtI109zAm193ffFxPWFAKwU6CL4WXX1HDw8tqJ
	M+leyu1Q7MyNHTjkNWOXqSN15cafPFnUEEfwfa7GgS570A8Shmtg6kbSKVY1jAA9
	zQ6C57LbJoOAD+pk7/tivzF6Wqc0Ve3DGiOPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aKCwak8i488X7mLCbZyy10hJH3KckF4b
	lNWKCHuW/TfXPKUW2J00YHd0i0wLAzWRTRF84G3UpSUKKW+RV4b8BVF9o6Mt1Z67
	GTTwEp+akPh8+mpk4CYeI+idBw5sIwkHhbW+CNfNiHozkaPK80SZXfCAX60+GCir
	13EdCW+9hxY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DE4B36BF;
	Tue, 21 Dec 2010 16:24:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0568D36B9; Tue, 21 Dec 2010
 16:24:45 -0500 (EST)
In-Reply-To: <20101221203322.GA13868@honk.padd.com> (Pete Wyckoff's message
 of "Tue\, 21 Dec 2010 12\:33\:22 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BFF1257E-0D48-11E0-A4B3-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164059>

Pete Wyckoff <pw@padd.com> writes:

> Filtering to support keyword expansion may need the name of
> the file being filtered.  In particular, to support p4 keywords
> like
>
>     $File: //depot/product/dir/script.sh $
>
> the smudge filter needs to know the name of the file it is
> smudging.
>
> Add a "%f" conversion specifier to the gitattribute for filter.
> It will be expanded with the path name to the file when invoking
> the external filter command.  The path name is quoted and
> special characters are escaped to prevent the shell from splitting
> incorrectly.

You do not specify the filter in attributes file, and this is not just
about splitting incorrectly (think $var substitutions).  I rephrased the
last paragraph when I tentatively queued v3 (and then I had to discard it
after seeing this round) like this:

    Allow "%f" in the custom filter command line specified in the
    configuration.  This will be substituted by the filename inside a
    single-quote pair to be passed to the shell.

> I couldn't quite bring myself to delete the nice spaces in
> redirections like "> test".  Rest of the usage in t/ seems
> to be about 1/3 for space, 2/3 against.

While existing mistakes by others do not make a good excuse to throw
unnecessary code-churn patches at me, it is not an excuse to introduce
more mistakes of the same kind in new code.

>  Documentation/gitattributes.txt |   12 +++++++++
>  convert.c                       |   22 +++++++++++++++++-
>  t/t0021-conversion.sh           |   48 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 564586b..1afcf01 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -317,6 +317,18 @@ command is "cat").
>  	smudge = cat
>  ------------------------
>  
> +If your filter needs the path of the file it is working on,
> +you can use the "%f" conversion specification.  It will be
> +replaced with the relative path to the file.  This is important
> +for keyword substitution that depends on the name of the
> +file.  Like this:

Maybe "important" to you, but not really.  Just let the reader decide the
importance.  I rephrased this when I tentatively queued v3 (and then I had
to discard it after seeing this round) like this:

    Sequence "%f" on the filter command line is replaced with the name of
    the file the filter is working on (a filter can use this in keyword
    substitution, for example):

> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 828e35b..69c22a6 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -93,4 +93,52 @@ test_expect_success expanded_in_repo '
>  	cmp expanded-keywords expected-output
>  '
>  
> +test_expect_success 'filter shell-escaped filenames setup' '
> +	cat >argc.sh <<-EOF &&
> +	#!$SHELL_PATH
> +	echo argc: \$# "\$@"
> +	EOF
> +	chmod +x argc.sh
> +'
>
> +# The use of %f in a filter definition is expanded to the path to
> +# the filename being smudged or cleaned.  It must be shell escaped.
> +# First, set up some interesting file names and pet them in
> +# .gitattributes.
> +test_expect_success 'filter shell-escaped filenames test' '
> +	norm=name-no-magic &&
> +	spec=$(echo name:sgl\"dbl\ spc!bang | tr : \\047) &&

I think this is going overboard.  The correctness of sq_quote_buf() is not
what we are really testing with this test; we are primarily interested in
testing that '%f' is substituted here.  You can and should drop at least
dq from the funny pathname, so that this can be run on Windows as well.
Perhaps (note two SPs between "name" and "with"):

	special="name  with '\''sq'\'' and \$x" &&

Do not over-abbreviate variable names unnecessarily; it will only confuse
the readers.  "spec" typically stands for "specification", but you don't
mean that here.

Also if you define the filter as "sh ./argc.sh %f", you should be able to
stop worrying about the "chmod +x" failing, no?

> +	echo some test text > test &&
> +	cat test > $norm &&
> +	cat test > "$spec" &&

Quote both for consistency.

	cat test >"$norm"
        cat test >"$spec"

> +	git add $norm &&
> +	git add "$spec" &&

Why add them separately?

> +	echo "name* filter=argc" > .gitattributes &&
> +
> +	# delete the files and check them out again, using a smudge filter
> +	# that will count the args and echo the command-line back to us
> +	git config filter.argc.smudge "./argc.sh %f" &&
> +	rm $norm "$spec" &&
> +	git checkout -- $norm "$spec" &&
> +
> +	# make sure argc.sh counted the right number of args
> +	echo "argc: 1 $norm" > res &&

Perhaps "res" stands for "result", but both are misleading as it is
unclear if that is an expected result or an actual result.

	echo "argc: 1 $norm" >expect &&

Thanks.
