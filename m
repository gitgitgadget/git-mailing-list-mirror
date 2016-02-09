From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Tue, 09 Feb 2016 14:25:11 -0800
Message-ID: <xmqqr3gl1pyw.fsf@gitster.mtv.corp.google.com>
References: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
	<xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>,
	Dickson Wong <dicksonwong@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 23:25:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTGir-0007LY-DB
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 23:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259AbcBIWZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 17:25:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933096AbcBIWZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 17:25:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24E5D423BF;
	Tue,  9 Feb 2016 17:25:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fwwka4fIJWUUxEzApfHIR+wrV30=; b=SBRzOK
	79+neSNckIk81yXhdwy9ab8ksIPr7JGpRB76ZxguBEYUOB0Z9cUtb3mxo9rVVVgw
	erSkyQapDd/uoarq7O4zthNAOCML7hGSuDmsMIxEYD8HDO8yssEpBx2i0igEZAAw
	8Rz6MYl57h9SOLKEZsLpTB8QFANfXM2Apkjgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wdf9c8yaCW21abfmUMLQpKKC/WszN4d5
	T8BiCoTbG5/2v50xiOK1lZ6s7qEiX9A5k/oGTLld9HFAW+nUo2xqIQOpvzol0Rib
	D6NOvplMb9arEscFL42hiAk0QGM9uJC04xIt27KM35vzu+fzbwryQXHbii2WmLYA
	wii7VNxXm3Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BBC4423BE;
	Tue,  9 Feb 2016 17:25:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 677F2423BC;
	Tue,  9 Feb 2016 17:25:12 -0500 (EST)
In-Reply-To: <xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 Jan 2016 10:45:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FC3BE334-CF7B-11E5-89B4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285877>

Junio C Hamano <gitster@pobox.com> writes:

> Dickson Wong <dicksonwong@gmail.com> writes:
>
>> When invoking default (g)vimdiff three-way merge, the merged file is
>> loaded as the first buffer but moved to the bottom as the fourth window.
>> This causes a disconnect between vim commands that operate on window
>> positions (e.g. CTRL-W_w) and those that operate on buffer index (e.g.
>> do/dp).
>>
>> This change reorders the buffers to have the same index as windows while
>> keeping the cursor default to the merged result as the bottom window.
>>
>> Signed-off-by: Dickson Wong <dicksonwong@gmail.com>
>> ---
>
> David, I unfortunately do not use 'mergetools' myself and certainly
> not vimdiff.
>
> Opinions?

Second call for help.  Any comments on this from anybody other than
the author that I missed to support this change?

>
>>  mergetools/vimdiff | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
>> index 1ddfbfc..74ea6d5 100644
>> --- a/mergetools/vimdiff
>> +++ b/mergetools/vimdiff
>> @@ -2,22 +2,22 @@ diff_cmd () {
>>  	"$merge_tool_path" -R -f -d \
>>  		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
>>  }
>>  
>>  merge_cmd () {
>>  	touch "$BACKUP"
>>  	case "$1" in
>>  	gvimdiff|vimdiff)
>>  		if $base_present
>>  		then
>> -			"$merge_tool_path" -f -d -c 'wincmd J' \
>> -				"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
>> +			"$merge_tool_path" -f -d -c '4wincmd w | wincmd J' \
>> +				"$LOCAL" "$BASE" "$REMOTE" "$MERGED"
>>  		else
>>  			"$merge_tool_path" -f -d -c 'wincmd l' \
>>  				"$LOCAL" "$MERGED" "$REMOTE"
>>  		fi
>>  		;;
>>  	gvimdiff2|vimdiff2)
>>  		"$merge_tool_path" -f -d -c 'wincmd l' \
>>  			"$LOCAL" "$MERGED" "$REMOTE"
>>  		;;
>>  	gvimdiff3|vimdiff3)
