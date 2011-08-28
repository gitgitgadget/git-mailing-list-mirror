From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* git clean --exclude broken?
Date: Sat, 27 Aug 2011 23:27:38 -0700
Message-ID: <7v62li9hk5.fsf@alter.siamese.dyndns.org>
References: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net>
 <7vliuio65w.fsf@alter.siamese.dyndns.org>
 <7vfwkqmfsh.fsf@alter.siamese.dyndns.org>
 <7vpqjtl4yi.fsf_-_@alter.siamese.dyndns.org>
 <20110827235458.GA8124@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Todd Rinaldo <toddr@cpanel.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 08:27:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxYqQ-0006DH-SS
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 08:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075Ab1H1G1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 02:27:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab1H1G1k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 02:27:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 105BF22AC;
	Sun, 28 Aug 2011 02:27:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0+TXWk0ofPkMy/xU3iEVCOErhys=; b=nn91Nn
	Mxew6pxd1TqAS+qj/FR8mDa5PBJQP5T/ddmRRfeDj//hcHbfjZsInTV4w86Bdscc
	IrMm0SjTPxGf5PO1pLJB31+20BZT8E8FjAuNZwSk/fex6rmdbhu0IjqlmPjFwnxt
	K8zz6pvTzU/sEexVch8VFARIBhJq4raGPs/yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X2mDfqO/Zp+/pfnYZG0mcKyKJsI8vqbz
	2CREgPfgk/amNxIX8QZrSolorKqGKukuI59Y+0YqGKZOYvtLVP/i2eitRnTDnJyr
	32+MPa1MImdiuA1HhtTYN2STunEyNyUxZWrzc1fSoFT0Y5mgjDrCUJZEo3BS63Bf
	2/D6/NIMXMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 085D222AB;
	Sun, 28 Aug 2011 02:27:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 738BD22AA; Sun, 28 Aug 2011
 02:27:39 -0400 (EDT)
In-Reply-To: <20110827235458.GA8124@arf.padd.com> (Pete Wyckoff's message of
 "Sat, 27 Aug 2011 19:54:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3ED6ADC-D13E-11E0-84FB-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180258>

Pete Wyckoff <pw@padd.com> writes:

>> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
>> index 974e04e..a7a18e3 100644
>> --- a/Documentation/git-clean.txt
>> +++ b/Documentation/git-clean.txt
>> @@ -47,9 +47,9 @@ OPTIONS
>>  
>>  -e <pattern>::
>>  --exclude=<pattern>::
>> -	Specify special exceptions to not be cleaned.  Each <pattern> is
>> -	the same form as in $GIT_DIR/info/excludes and this option can be
>> -	given multiple times.
>> +	In addition to what are found in .gitignore (per directory) and
>> +	$GIT_DIR/info/exclude, also consider these patterns to be in the
>> +	set of the ignore rules in effect.
>>  
>>  -x::
>>  	Don't use the ignore rules.  This allows removing all untracked
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index 75697f7..3782718 100644
>> --- a/builtin/clean.c
>> +++ b/builtin/clean.c
>> @@ -76,6 +76,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>  
>>  	if (ignored && ignored_only)
>>  		die(_("-x and -X cannot be used together"));
>> +	if (ignored && exclude_list.nr)
>> +		die(_("adding exclude with -e and ignoring it with -x is crazy"));
>
> This breaks one of my use cases for git clean.

The description of '-x' needs to be also updated to reflect what it does.

How about this on top?

 Documentation/git-clean.txt |    4 +++-
 builtin/clean.c             |    2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index b49674f..79fb984 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -52,7 +52,9 @@ OPTIONS
 	set of the ignore rules in effect.
 
 -x::
-	Don't use the ignore rules.  This allows removing all untracked
+	Don't use the standard ignore rules read from .gitignore (per
+	directory) and $GIT_DIR/info/exclude, but do still use the ignore
+	rules given with `-e` options.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
 	conjunction with 'git reset') to create a pristine
 	working directory to test a clean build.
diff --git a/builtin/clean.c b/builtin/clean.c
index 7fcbf87..0c7b3d0 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -76,8 +76,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
-	if (ignored && exclude_list.nr)
-		die(_("adding exclude with -e and ignoring it with -x is crazy"));
 
 	if (!show_only && !force) {
 		if (config_set)
