From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: [PATCH v2] Thunderbird: fix appp.sh format problems
Date: Fri, 31 Aug 2012 09:09:28 +0200
Message-ID: <50406328.60003@gmail.com>
References: <503F28CE.2090400@gmail.com> <7vtxvks4aj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 09:16:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7LSh-0007h1-Cq
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 09:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab2HaHQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 03:16:08 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52700 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab2HaHQG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 03:16:06 -0400
Received: by wgbdr13 with SMTP id dr13so2253056wgb.1
        for <git@vger.kernel.org>; Fri, 31 Aug 2012 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=T+bkF5AngfcAskTUpBoXMQoLGtRbXGmyUy9oL+fQf3A=;
        b=bBuEb5R7Sbv1aYGGUHGmhDwTXnJJlWp8nbeJGgLY+yRfgCXFRa0tehzPKTzFQG65G9
         dJjYcPvd8dskMgFdCP4HDgz86EQ+wgErDjPEq4rjwYcBzjgHsM8qY3UDZpjQV3Qx1vC3
         gkShI6eVuNLCWT6yRfv7lWs4FwAng6o79GjNToYhgBPenYH/bDBJIu+WmhdZLmpTzt4u
         a0PxW3H+grjUTJ9IOzGQaQt2ABfAFesvQTRVw0hTSWq5fc7t+Oo+94oSe+eGSRnLMy4c
         0DoPuTfoqFodeB85QoBgb1d2QsStzxA2551XVm3cx0MVmd6P4RUfM5J2aHDl8KzR9u2R
         0PTQ==
Received: by 10.180.74.33 with SMTP id q1mr2586627wiv.4.1346397364578;
        Fri, 31 Aug 2012 00:16:04 -0700 (PDT)
Received: from [82.49.192.78] (host78-192-dynamic.49-82-r.retail.telecomitalia.it. [82.49.192.78])
        by mx.google.com with ESMTPS id b7sm7450889wiz.9.2012.08.31.00.16.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2012 00:16:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <7vtxvks4aj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204580>

Il 30/08/2012 19:00, Junio C Hamano ha scritto:
> Marco Stornelli <marco.stornelli@gmail.com> writes:
>
>> The current script has got the following problems:
>>
>> 1) It doesn't work if the language used by Thunderbird is not English;
>> 2) The field To: filled by format-patch is not evaluated;
>> 3) The field Cc: is loaded only from Cc used in the commit message
>> instead of using even the Cc field filled by format-patch in the email
>> header.
>>
>> Added comments for point 1). Fixed point 2) and 3).
>>
>> Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
>> ---
>> v2: changed the commit message to reflect better the script implementation
>
> I actually thought what the log message of the previous version
> claimed to do was much more sensible.
>
> The language used in the above 3 items describe what you perceive as
> a problem, but it is unclear what the desired behaviour that is
> different from the current one is.  (2) "... is not evaluated"
> implies ", which is a problem, so fix it by evaluating it", but
> there is no single obvious fix to (3) "loaded only from Cc in commit
> and not Cc from format-patch".  Should it ignore Cc from commit log
> message, or should it take Cc from both log message and e-mail
> header?  I personally think it should the former, but it is not
> clear which you think is the right thing to do (or perhaps you have
> a third answer) if you only say "Fixed point 3".

Ok, I can change the commit. Actually with the new implementation Cc: is 
evaluated in both cases.

>>
>>   contrib/thunderbird-patch-inline/appp.sh |   18 ++++++++++++++----
>>   1 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
>> index 5eb4a51..e6e1b85 100755
>> --- a/contrib/thunderbird-patch-inline/appp.sh
>> +++ b/contrib/thunderbird-patch-inline/appp.sh
>> @@ -6,6 +6,9 @@
>>
>>   # ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
>>
>> +# NOTE: You must change some words in this script according to the language
>> +# used by Mozilla Thunderbird, as <Subject>, <To>, <Don't remove this line>.
>> +
>>   CONFFILE=~/.appprc
>>
>>   SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
>> @@ -26,17 +29,24 @@ fi
>>   cd - > /dev/null
>>
>>   SUBJECT=`sed -n -e '/^Subject: /p' "${PATCH}"`
>> -HEADERS=`sed -e '/^'"${SEP}"'$/,$d' $1`
>>   BODY=`sed -e "1,/${SEP}/d" $1`
>>   CMT_MSG=`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
>>   DIFF=`sed -e '1,/^---$/d' "${PATCH}"`
>>
>> -CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
>> -	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
>> +export PATCH
>> +CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCH'}; $text=<FILE>;
>> +close FILE; $cc = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $cc =~ s/\n//g;
>> +print $cc;'`
>> +
>> +TO=`perl -e 'local $/=undef; open FILE, $ENV{'PATCH'}; $text=<FILE>;
>> +close FILE; $to = $1 if $text =~ /To: (.*?(,\n .*?)*)\n/s; $to =~ s/\n//g;
>> +print $to;'`
>>
>> +# Change <Subject> before next line according to Thunderbird language
>>   echo "$SUBJECT" > $1
>
> "before next line"???  I do not think you meant to rename the
> variable $SUBJECT to $<localized string for subject>.

In my case I add a line before in this way:

....
SUBJECT=`echo $SUBJECT | sed 's/Subject/Oggetto/g'`
echo "$SUBJECT" > $1
....

>
>> +# Change <To> according to Thunderbird language
>
> 	# Change "To: " according to...

Ok.

>
> would be less confusing, as the line has to "to" on it when viewed
> case insensitively.
>
>> +echo "To: $TO" >> $1
>
>>   echo "Cc: $CCS" >> $1
>> -echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
>>   echo "$SEP" >> $1
>>
>>   echo "$CMT_MSG" >> $1
>
