From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] rev-list: estimate number of bisection step left
Date: Tue, 17 Feb 2009 15:11:18 +0000
Message-ID: <43d8ce650902170711r1edb1e40udfacce4b9123b0a5@mail.gmail.com>
References: <20090217060944.488184b0.chriscool@tuxfamily.org>
	 <alpine.DEB.1.00.0902171542490.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 16:13:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZRdJ-0007Vi-Uc
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 16:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbZBQPLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 10:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753025AbZBQPLV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 10:11:21 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:35914 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbZBQPLT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 10:11:19 -0500
Received: by gxk22 with SMTP id 22so4142956gxk.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 07:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FL2ABqSn8CzgKocexik4cTv95AtWNqSoIamqqJwrRAs=;
        b=wmalp/3DQ97Op5T6kIEpnO77LmlK9YKBfUTub68ERmeXNAEGL/WxCtPvMmobgNs6ke
         zazyuvbls8rbnAp/G7qZy43H+cIqs8k1hcSV80zmcnGoY3GGK+aL4e6eNeA2MmWZ26tL
         TBUP7dZa3wyEr9QUIHmH2FQtSuqFy/73ZDAow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dAicn2vK3v0muULBM185g1886IAcsuFbBnlCUKoJiPuMBJKvlM6qMkijFyR+go93ds
         v92HiicynyVXq/LHtb4JgFh43VC6OMUaFxU6SZCSk/rc6BjZGUrp6086muyQGC8bfcxC
         NFxyhxHY4NhhsqDzdlQkRH4nCV4IjQt0oL860=
Received: by 10.151.11.19 with SMTP id o19mr55983ybi.119.1234883478259; Tue, 
	17 Feb 2009 07:11:18 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902171542490.6185@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110395>

2009/2/17 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Tue, 17 Feb 2009, Christian Couder wrote:
>
>> +static int estimate_bisect_steps(int all)
>> +{
>> +     int log2 = 0;
>> +     int left = (all >> 1) - 1;
>> +
>> +     if (left <= 0)
>> +             return 0;
>> +
>> +     do {
>> +             left = left >> 1;
>> +             log2++;
>> +     } while (left);
>> +
>> +     return log2;
>> +}
>
> How about this instead, calling it from cmd_rev_list directly?
>
>        static int log2(int n)
>        {
>                int log2;
>
>                for (log2 = 0; n > 1; log2++)
>                        n >>= 1;
>
>                return log2;
>        }

This would work, if you want a non-iterative solution

unsigned int log2_integer_approximate(unsigned int n){
*((float*)&n) = (float)n;
return ((n & (~((1<<23) - 1))) >> 23) - 127;
}

(It's correct up to 2^25, then it's off by 1 for a few.)


> Ciao,
> Dscho
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
