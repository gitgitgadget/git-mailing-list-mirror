From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] gitweb: merge boolean feature subroutines
Date: Sat, 3 Jan 2009 18:41:42 +0100
Message-ID: <9b18b3110901030941n3aa04e5ejb34c6f82c11bce4c@mail.gmail.com>
References: <1230996692-7182-1-git-send-email-kraai@ftbfs.org>
	 <9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com>
	 <20090103164024.GA4205@ftbfs.org>
	 <9b18b3110901030851t47c03d0ay75fc91b1ef2ed44b@mail.gmail.com>
	 <20090103171333.GB4205@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matt Kraai" <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Jan 03 18:43:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJAWf-0001kg-0E
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 18:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758339AbZACRlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 12:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752728AbZACRlp
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 12:41:45 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:41944 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbZACRlp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 12:41:45 -0500
Received: by qw-out-2122.google.com with SMTP id 3so5805695qwe.37
        for <git@vger.kernel.org>; Sat, 03 Jan 2009 09:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DePhSwOLaAkozVIDTrQh0bHNgjlB4Y0sDH8EElhLFEI=;
        b=jMVa7R7qhWPUU/8iitPNRs64fDzdjSjk6hnMrX1HiDONgOtKAkn8GhH+oaknPI8C4w
         4oSEP0WNbThEXd1evmKMtd6hrMN7MFrRj3UC2HSvf/+6yXHACAi9mAuN4OH7EH/xLLMx
         XnljbYD9Cms41PVeef/WcyG0NgLFSH/n+SqcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nEUVoNZabji4tGrCSPze7jxWUk2anIqLJfoBTfwmXtmvid4G6vPBODhDMSIRS9O4X3
         p6oIcC1B6I5J/fwq2t4Mx+VAu8RFraL3I4dD6HqdtiJiqxpgkv09XQu4IYdUA2h7ZKAI
         4Rj3umr0KiKU+lX2lE3SnVb9WAXQbGRJhmOmY=
Received: by 10.214.45.2 with SMTP id s2mr15637078qas.348.1231004502708;
        Sat, 03 Jan 2009 09:41:42 -0800 (PST)
Received: by 10.214.241.2 with HTTP; Sat, 3 Jan 2009 09:41:42 -0800 (PST)
In-Reply-To: <20090103171333.GB4205@ftbfs.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104476>

2009/1/3 Matt Kraai <kraai@ftbfs.org>:
> On Sat, Jan 03, 2009 at 05:51:50PM +0100, demerphq wrote:
>> 2009/1/3 Matt Kraai <kraai@ftbfs.org>:
>> > I don't think Perl has *a* false value, but rather has multiple values
>> > that are treated as false, such as undef, zero, and the empty string.
>> > Personally, I find 0 clearer than the empty string, but that's
>> > probably just my C bias sneaking in.
>>
>> Yes it definitely does have a false value, PL_sv_no, and a true value,
>> PL_sv_yes (although it is much less important).  It is these values
>> which are copied to signify true and false in the cases where the
>> internals need to, such as for boolean operators that must return
>> false, and things like negation and (in)equality checks.
>>
>> It is a so called "dual var" SvPVNV, with 0 in the NV (numeric) slot
>> and the empty string in the PV (string) slot.
>>
>> You can see one example of its behaviour in my previous mail, and can
>> see it further here:
>>
>> $ perl -MDevel::Peek -e'print Dump(shift @ARGV eq "true")'
>> SV = PVNV(0x952eb10) at 0x952b6f0
>>   REFCNT = 2147483647
>>   FLAGS = (IOK,NOK,POK,READONLY,pIOK,pNOK,pPOK)
>>   IV = 0
>>   NV = 0
>>   PV = 0x952eae8 ""\0
>>   CUR = 0
>>   LEN = 4
>>
>> Compare that to:
>>
>> perl -MDevel::Peek -e'print Dump(shift @ARGV eq "true" ? 1 : 0)'
>> SV = IV(0x94d8398) at 0x94bd678
>>   REFCNT = 1
>>   FLAGS = (PADBUSY,PADTMP,IOK,READONLY,pIOK)
>>   IV = 0
>
> Wow, I had no idea about this.  Thanks for the information.
>
> It seems like using these values would require obfuscating the code,
> though.  :(  They only seem to be exposed directly via XS.

Depend how you look at it. You have access to them via the negation
and inequality operators. In a way you can think of the 'not' (or  !)
operator as being the "inverted boolean constructor". So for instance
the kind of surprising

  my $bool= !!$val;

can be used to get a copy of the appropriate PL_sv_yes/no. But the
need to do is rare. Luckily. :-)

But yeah, they are not exposed directly at the perl level. There is no
keyword to use to generate them like there is for undef/PL_sv_undef,
although I guess it would be fairly easy to expose them in a similar
fashion via Scalar::Util.

cheers,
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
