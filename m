From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t6022: Use -eq not = to test output of wc -l
Date: Tue, 16 Nov 2010 13:23:18 -0600
Message-ID: <20101116192318.GA15828@burratino>
References: <1289251766-48316-1-git-send-email-brian@gernhardtsoftware.com>
 <7vaalajkiq.fsf@alter.siamese.dyndns.org>
 <4CE22EC2.7040603@viscovery.net>
 <20101116171031.GB13398@burratino>
 <7vtyjhgk3z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 20:24:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIR8a-0004oU-9t
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 20:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418Ab0KPTYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 14:24:05 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39838 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab0KPTYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 14:24:03 -0500
Received: by vws13 with SMTP id 13so523627vws.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 11:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/k0VXmDhcfZgDPlUzCNWKLpTQJcoVMNeuAHc0fWmqv4=;
        b=rxz+p7PPhQNAo3lpx69G352D/VKL/jv0pNCxK3lhs8r5gduPZXupv1VLpV7Kb3w+l4
         YuFtu3+TVLDps66u3RZ+7pmCu/ZGXukdALC3FE54gWNTeVUAWAKIQTynukPNtCPB8maj
         O2liT2LLBhwLpuGA4v3WShGL9Y1j5/nIyeFp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jRMNEpk/STMz7BvgIW6tGFmc6QysX4Anm0QNAMYJUyxuxA72P15N2USdw/SFQYC4Xr
         QqO7iFPKwmeEqqMDbG1kH+CfpxyO1n5mIQmVW/rMdJ9MF63gGSKO0R0MfcWZFhm/SVtK
         0JPw4LveTuT9RkYCOfBMVxukWDMeWzV1AOQgA=
Received: by 10.229.82.10 with SMTP id z10mr6692706qck.98.1289935442781;
        Tue, 16 Nov 2010 11:24:02 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm962891qck.25.2010.11.16.11.23.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 11:23:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vtyjhgk3z.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161579>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +	if test "$3" = -
>> +	then
>> +		line_count_tmp=test_line_count.output
>> +		cat >"$line_count_tmp"
>> +		set -- "$1" "$2" "$line_count_tmp"
>> +	fi
>> +	if ! test $(wc -l <"$3") "$1" "$2"
>>  	then
>>  		echo "test_line_count: line count for $3 !$1 $2"
>>  		cat "$3"
>>  		return 1
>
> You forgot to clean the temporary file here.

The idea was to leave it around to help in diagnosis.  But you are
right, it is more useful to not break later tests:

		rm -f "$line_count_tmp"
		return 1

> Also if the file is huge, do we really want to cat the whole thing?

I think so.  (Maybe not if it is binary, though.)
