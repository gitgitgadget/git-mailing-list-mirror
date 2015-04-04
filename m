From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] t9814: Guarantee only one source exists in git-p4 copy
 tests
Date: Sat, 04 Apr 2015 09:31:25 +0100
Message-ID: <551FA15D.30304@diamand.org>
References: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>	<1427671914-12131-1-git-send-email-vitor.hda@gmail.com> <xmqqk2xzxk3y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 10:32:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeJUj-0006m7-9M
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 10:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbbDDIbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 04:31:52 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36277 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbDDIbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 04:31:49 -0400
Received: by wgra20 with SMTP id a20so126275508wgr.3
        for <git@vger.kernel.org>; Sat, 04 Apr 2015 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GPFxYW2zIP1XSHhJKSyDyDxc5cYDgqNKaYoPbIx6JuU=;
        b=UHjD9vQ/NTg39PeWgmzYTPi5xZAv7HyIYGWLdU1r5hCkC6Bh4HHj0VWur9zr6wFGT9
         kWvvbKM+tlJzKZ2mjIeV19QKRAJFfS2621u9+Rhr1l4YXTpCIFxwWTUX8mCvKiCZ+a8j
         mT3rd937wXfJQcIOpI5kTzY0u0+pIiKlntTjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=GPFxYW2zIP1XSHhJKSyDyDxc5cYDgqNKaYoPbIx6JuU=;
        b=N3IujWa4kVgOK5tlCxxqtSwpYqUCbqVTLRzEwXqJ8BsPXa0zH15QsqItLBfhZ+SlJc
         7ltP8xA6All032/qO7ZimJyPUPZXNEJDHjHCGlvnpP8W7p8tWzQvhWCbazZulez3g3ge
         GhnMWmpNc1qYTVMDT3BsKIZqKR8oJE/7k6ayHXT2qPAw1T6ecmB9Sgjp1sZTsmpnJXpy
         9F5OiGLL/FdFUXsJmx3sG53xUIA3ygjpOraDlgaetHVPZC3/81xl0CRbxMVef35thJzn
         L8lw4BjxCFoaHGiCn3MejMlR3MKcipnqa/U0y2PJDlwpmduOK5qqN8ynIxgxArABnpZ8
         wLWQ==
X-Gm-Message-State: ALoCoQl/K4ZUs89DodGZ3T/uz2bWS7axMFXT8yzE3MRXQKdqk104FVlR2i5T88pjqWbHHQtRsvGr
X-Received: by 10.180.206.244 with SMTP id lr20mr12709960wic.24.1428136308334;
        Sat, 04 Apr 2015 01:31:48 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id a6sm5912751wiy.17.2015.04.04.01.31.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2015 01:31:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <xmqqk2xzxk3y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266769>

On 30/03/15 04:03, Junio C Hamano wrote:
> Vitor Antunes <vitor.hda@gmail.com> writes:
>
>> * Modify source file (file2) before copying the file.
>> * Check that only file2 is the source in the output of "p4 filelog".
>> * Remove all "case" statements and replace them simple tests to check that
>>    source is "file2".
>>
>> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
>> ---
>
> I am not a Perfoce user, so I'd like to ask Pete's and Luke's
> comments on these changes.

It's much clearer now that the guessing of file source has been cleaned 
up, thanks. Ack.

Luke



>
>>   t/t9814-git-p4-rename.sh |   46 +++++++++++++++++++++++++++++++---------------
>>   1 file changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
>> index 8b9c295..d8fb22d 100755
>> --- a/t/t9814-git-p4-rename.sh
>> +++ b/t/t9814-git-p4-rename.sh
>> @@ -132,6 +132,9 @@ test_expect_success 'detect copies' '
>>   		cd "$git" &&
>>   		git config git-p4.skipSubmitEdit true &&
>>
>> +		echo "file8" >> file2 &&
>
> Style: please lose SP between redirection and its target, i.e.
>
> 	echo file8 >>file2 &&
>
> The same comment applies to everywhere else.
>
>> +		git commit -a -m "Differentiate file2" &&
>> +		git p4 submit &&
>>   		cp file2 file8 &&
>>   		git add file8 &&
>>   		git commit -a -m "Copy file2 to file8" &&
>> @@ -140,6 +143,10 @@ test_expect_success 'detect copies' '
>>   		p4 filelog //depot/file8 &&
>>   		p4 filelog //depot/file8 | test_must_fail grep -q "branch from" &&
>>
>> +		echo "file9" >> file2 &&
>> +		git commit -a -m "Differentiate file2" &&
>> +		git p4 submit &&
>> +
>>   		cp file2 file9 &&
>>   		git add file9 &&
>>   		git commit -a -m "Copy file2 to file9" &&
>> @@ -149,28 +156,39 @@ test_expect_success 'detect copies' '
>>   		p4 filelog //depot/file9 &&
>>   		p4 filelog //depot/file9 | test_must_fail grep -q "branch from" &&
>>
>> +		echo "file10" >> file2 &&
>> +		git commit -a -m "Differentiate file2" &&
>> +		git p4 submit &&
>> +
>>   		echo "file2" >>file2 &&
>>   		cp file2 file10 &&
>>   		git add file2 file10 &&
>>   		git commit -a -m "Modify and copy file2 to file10" &&
>>   		git diff-tree -r -C HEAD &&
>> +		src=$(git diff-tree -r -C HEAD | sed 1d | sed 2d | cut -f2) &&
>> +		test "$src" = file2 &&
>>   		git p4 submit &&
>>   		p4 filelog //depot/file10 &&
>> -		p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
>> +		p4 filelog //depot/file10 | grep -q "branch from //depot/file2" &&
>> +
>> +		echo "file11" >> file2 &&
>> +		git commit -a -m "Differentiate file2" &&
>> +		git p4 submit &&
>>
>>   		cp file2 file11 &&
>>   		git add file11 &&
>>   		git commit -a -m "Copy file2 to file11" &&
>>   		git diff-tree -r -C --find-copies-harder HEAD &&
>>   		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
>> -		case "$src" in
>> -		file2 | file10) : ;; # happy
>> -		*) false ;; # not
>> -		esac &&
>> +		test "$src" = file2 &&
>>   		git config git-p4.detectCopiesHarder true &&
>>   		git p4 submit &&
>>   		p4 filelog //depot/file11 &&
>> -		p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
>> +		p4 filelog //depot/file11 | grep -q "branch from //depot/file2" &&
>> +
>> +		echo "file12" >> file2 &&
>> +		git commit -a -m "Differentiate file2" &&
>> +		git p4 submit &&
>>
>>   		cp file2 file12 &&
>>   		echo "some text" >>file12 &&
>> @@ -180,15 +198,16 @@ test_expect_success 'detect copies' '
>>   		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>>   		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
>>   		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
>> -		case "$src" in
>> -		file10 | file11) : ;; # happy
>> -		*) false ;; # not
>> -		esac &&
>> +		test "$src" = file2 &&
>>   		git config git-p4.detectCopies $(($level + 2)) &&
>>   		git p4 submit &&
>>   		p4 filelog //depot/file12 &&
>>   		p4 filelog //depot/file12 | test_must_fail grep -q "branch from" &&
>>
>> +		echo "file13" >> file2 &&
>> +		git commit -a -m "Differentiate file2" &&
>> +		git p4 submit &&
>> +
>>   		cp file2 file13 &&
>>   		echo "different text" >>file13 &&
>>   		git add file13 &&
>> @@ -197,14 +216,11 @@ test_expect_success 'detect copies' '
>>   		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>>   		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
>>   		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
>> -		case "$src" in
>> -		file10 | file11 | file12) : ;; # happy
>> -		*) false ;; # not
>> -		esac &&
>> +		test "$src" = file2 &&
>>   		git config git-p4.detectCopies $(($level - 2)) &&
>>   		git p4 submit &&
>>   		p4 filelog //depot/file13 &&
>> -		p4 filelog //depot/file13 | grep -q "branch from //depot/file"
>> +		p4 filelog //depot/file13 | grep -q "branch from //depot/file2"
>>   	)
>>   '
