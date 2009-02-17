From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] rev-list: estimate number of bisection step left
Date: Tue, 17 Feb 2009 15:36:03 +0000
Message-ID: <43d8ce650902170736h6316f987qc783edeebf488b40@mail.gmail.com>
References: <20090217060944.488184b0.chriscool@tuxfamily.org>
	 <alpine.DEB.1.00.0902171542490.6185@intel-tinevez-2-302>
	 <43d8ce650902170711r1edb1e40udfacce4b9123b0a5@mail.gmail.com>
	 <alpine.DEB.1.00.0902171630130.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 16:37:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZS0u-0000QH-62
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 16:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbZBQPgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 10:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbZBQPgH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 10:36:07 -0500
Received: from el-out-1112.google.com ([209.85.162.180]:54918 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZBQPgG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 10:36:06 -0500
Received: by el-out-1112.google.com with SMTP id b25so1414914elf.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 07:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZsAf6OfD0pDZFP7LY0YRHjAjtkX/5M6lNxvFuVRedfQ=;
        b=AYW3vMyxYbCV2whQDBxglLOz94/gkdsQqL65SYOzjJkrVz4kTyODgpPd0WmGT+kSyJ
         ADR/gh4BghjotupiGHk+aAjYZyJBt9YRt+SMbcDBKe1FTkfZJjcovvTY3d2c9+EeYuhp
         5S1KYwlFsgtd0ZzAfqbCdsQiM5EW5ofu05EsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jmUMfXGmSXvV4CLzJtN2gdZYqy6DfA0A+y0ZJ8GREWWKyANBcNoBgyIfv5w9cSE688
         TQCptoR6Wm/hmSduh8TUGFu6BUJ2wGgILYlsqg+iK5oxLKrDWJzENjcuto42rPrlHJzW
         fC3ONhDZRD/r+GSD6g7yGrlwlI/mfJSrPJm48=
Received: by 10.151.39.21 with SMTP id r21mr6158478ybj.210.1234884963313; Tue, 
	17 Feb 2009 07:36:03 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902171630130.6185@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110402>

2009/2/17 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Tue, 17 Feb 2009, John Tapsell wrote:
>
>> 2009/2/17 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>
>> > On Tue, 17 Feb 2009, Christian Couder wrote:
>> >
>> >> +static int estimate_bisect_steps(int all)
>> >> +{
>> >> +     int log2 = 0;
>> >> +     int left = (all >> 1) - 1;
>> >> +
>> >> +     if (left <= 0)
>> >> +             return 0;
>> >> +
>> >> +     do {
>> >> +             left = left >> 1;
>> >> +             log2++;
>> >> +     } while (left);
>> >> +
>> >> +     return log2;
>> >> +}
>> >
>> > How about this instead, calling it from cmd_rev_list directly?
>> >
>> >        static int log2(int n)
>> >        {
>> >                int log2;
>> >
>> >                for (log2 = 0; n > 1; log2++)
>> >                        n >>= 1;
>> >
>> >                return log2;
>> >        }
>>
>> This would work, if you want a non-iterative solution
>>
>> unsigned int log2_integer_approximate(unsigned int n){
>> *((float*)&n) = (float)n;
>> return ((n & (~((1<<23) - 1))) >> 23) - 127;
>> }
>
> That assumes that your floats are IEEE floats, right?

Yeah.  Is it a bad assumption? Does git run on any system in which they aren't?

>
> Ciao,
> Dscho
>
