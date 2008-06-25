From: Christian Holtje <docwhat@gmail.com>
Subject: Re: [PATCH v2] pre-commit hook should ignore carriage returns at EOL
Date: Wed, 25 Jun 2008 14:47:58 -0400
Message-ID: <5B163827-204D-4F76-88C9-8F0C93E60AF3@gmail.com>
References: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com> <20080625181422.GC4039@steel.home>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 20:49:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBa3A-0006Qs-Mr
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 20:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbYFYSsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 14:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbYFYSsD
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 14:48:03 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:65506 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbYFYSsB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 14:48:01 -0400
Received: by yx-out-2324.google.com with SMTP id 31so696506yxl.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=bxgpjr4xPqhGjV5mHkR/LKxD1GobBAnbLNgcjj+SQis=;
        b=rXAgfcOWW+U/8pklyzbMuhoJCtNU2r0OFNSAGbRYIzw/8M+B1UwAJl4W4T+txbjIEn
         w3PKmWVgeOlgtltvmzG1Kqk2Dgn+4KVmaIUXLPF7cdp7bz7qQMCLatl6RHe0YCKrBNvj
         YnZ6n7pPaMht0nmPUpl+c/NLqSgh+7Reo1m+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=QakH8f9hl67NkFl9RJwoDcyxVfM+rnEN3s5aOBMI6TMTVcE5hJPigF7wGu1lR3dsDC
         fwkvXlOblhIDQWzB2CQFU8iQr1aKq1wlREaIfJtE3RUqONswPlkWoOrTJV562emy/zt9
         OnaF/ILsSyiQESky/ObCVaA26nQu07skrfcSA=
Received: by 10.150.54.1 with SMTP id c1mr210099yba.64.1214419679869;
        Wed, 25 Jun 2008 11:47:59 -0700 (PDT)
Received: from ?192.168.0.161? ( [206.210.75.84])
        by mx.google.com with ESMTPS id n44sm5122782pyh.44.2008.06.25.11.47.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 11:47:59 -0700 (PDT)
In-Reply-To: <20080625181422.GC4039@steel.home>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86317>

On Jun 25, 2008, at 2:14 PM, Alex Riesen wrote:
> Christian Holtje, Tue, Jun 24, 2008 21:21:22 +0200:
>> diff --git a/t/t7503-template-hook--pre-commit.sh b/t/t7503-template-
>> hook--pre-commit.sh
>
> Your patch has long lines wrapped.
>
>> diff --git a/templates/hooks--pre-commit b/templates/hooks--pre- 
>> commit
>> index b25dce6..335ca09 100644
>> --- a/templates/hooks--pre-commit
>> +++ b/templates/hooks--pre-commit
>> @@ -55,8 +55,14 @@ perl -e '
>> 	if (s/^\+//) {
>> 	    $lineno++;
>> 	    chomp;
>> -	    if (/\s$/) {
>> -		bad_line("trailing whitespace", $_);
>> +	    if (/\r$/) {
>> +		if (/\s\r$/) {
>> +		    bad_line("trailing whitespace", $_);
>> +		}
>> +	    } else {
>> +		if (/\s$/) {
>> +		    bad_line("trailing whitespace", $_);
>> +		}
>
> You coud just strip the trailing (cr)lf, instead of chomp:
>
>  	if (s/^\+//) {
>  	    $lineno++;
> - 	    chomp;
> +	    s/\r?\n$//so;
> 	    if (/\s$/) {
> 		bad_line("trailing whitespace", $_);
>
> Makes for a shorter patch and less code.

That's a good idea!  However, this patch is not going anyplace, I  
think.  Junio submitted a different patch to disable the pre-commit  
example.

Junio, do you want me to make this change anyway?  It does make  
sense.  The unittests for the pre-commit hook may or may not still be  
useful.

Ciao!
