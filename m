From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Thunderbird: fix appp.sh format problems
Date: Thu, 30 Aug 2012 10:00:52 -0700
Message-ID: <7vtxvks4aj.fsf@alter.siamese.dyndns.org>
References: <503F28CE.2090400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 19:01:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7874-0007kK-RD
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 19:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab2H3RA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 13:00:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907Ab2H3RAz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 13:00:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 755578E54;
	Thu, 30 Aug 2012 13:00:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=frBq+8mAF9visOThxH5pd8KoIZA=; b=gzm3sS
	q48ISqMQrMGp2jDkMs6mgbReKn3w9lwA1RGUr7bHCEUBNOpc9KEXAqc35v6FVL9c
	0JNoCQMq8P5vfroMXXFu2aNlYPRlS3TRxhYBgWT1xe0VwOB9ctB1Qs459kKljmml
	usNzkY/qfDfA6zaaHyheiOsL6pD48MzaHVnMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mdbe5iofRHQsTQ/UK9WVx1TsH27mGj94
	7wZnbKYhnlQYlUl/2KvcYl3OkZmFZZQPlBmxVFWe1K3i0036efSwGI+iclKVc6dT
	obpq7vvkfpXUR9Z9olA/+MZXaOE9Hoji/hBV8kG4oCQdL2QKZhV/zH4ieEy5F+wE
	mz5DMUt02j0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 607768E51;
	Thu, 30 Aug 2012 13:00:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ED4E8E50; Thu, 30 Aug 2012
 13:00:53 -0400 (EDT)
In-Reply-To: <503F28CE.2090400@gmail.com> (Marco Stornelli's message of "Thu,
 30 Aug 2012 10:48:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42322BCA-F2C4-11E1-BCE5-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204549>

Marco Stornelli <marco.stornelli@gmail.com> writes:

> The current script has got the following problems:
>
> 1) It doesn't work if the language used by Thunderbird is not English;
> 2) The field To: filled by format-patch is not evaluated;
> 3) The field Cc: is loaded only from Cc used in the commit message
> instead of using even the Cc field filled by format-patch in the email
> header.
>
> Added comments for point 1). Fixed point 2) and 3).
>
> Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
> ---
> v2: changed the commit message to reflect better the script implementation

I actually thought what the log message of the previous version
claimed to do was much more sensible.

The language used in the above 3 items describe what you perceive as
a problem, but it is unclear what the desired behaviour that is
different from the current one is.  (2) "... is not evaluated"
implies ", which is a problem, so fix it by evaluating it", but
there is no single obvious fix to (3) "loaded only from Cc in commit
and not Cc from format-patch".  Should it ignore Cc from commit log
message, or should it take Cc from both log message and e-mail
header?  I personally think it should the former, but it is not
clear which you think is the right thing to do (or perhaps you have
a third answer) if you only say "Fixed point 3".
>
>  contrib/thunderbird-patch-inline/appp.sh |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
> index 5eb4a51..e6e1b85 100755
> --- a/contrib/thunderbird-patch-inline/appp.sh
> +++ b/contrib/thunderbird-patch-inline/appp.sh
> @@ -6,6 +6,9 @@
>  
>  # ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
>  
> +# NOTE: You must change some words in this script according to the language
> +# used by Mozilla Thunderbird, as <Subject>, <To>, <Don't remove this line>.
> +
>  CONFFILE=~/.appprc
>  
>  SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
> @@ -26,17 +29,24 @@ fi
>  cd - > /dev/null
>  
>  SUBJECT=`sed -n -e '/^Subject: /p' "${PATCH}"`
> -HEADERS=`sed -e '/^'"${SEP}"'$/,$d' $1`
>  BODY=`sed -e "1,/${SEP}/d" $1`
>  CMT_MSG=`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
>  DIFF=`sed -e '1,/^---$/d' "${PATCH}"`
>  
> -CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
> -	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
> +export PATCH
> +CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCH'}; $text=<FILE>;
> +close FILE; $cc = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $cc =~ s/\n//g;
> +print $cc;'`
> +
> +TO=`perl -e 'local $/=undef; open FILE, $ENV{'PATCH'}; $text=<FILE>;
> +close FILE; $to = $1 if $text =~ /To: (.*?(,\n .*?)*)\n/s; $to =~ s/\n//g;
> +print $to;'`
>  
> +# Change <Subject> before next line according to Thunderbird language
>  echo "$SUBJECT" > $1

"before next line"???  I do not think you meant to rename the
variable $SUBJECT to $<localized string for subject>.

> +# Change <To> according to Thunderbird language

	# Change "To: " according to...

would be less confusing, as the line has to "to" on it when viewed
case insensitively.

> +echo "To: $TO" >> $1

>  echo "Cc: $CCS" >> $1
> -echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
>  echo "$SEP" >> $1
>  
>  echo "$CMT_MSG" >> $1
