From: xiaozhu <xiaozhu@gmail.com>
Subject: Re: a bug about format-patch of multibyte characters comment
Date: Sun, 13 Feb 2011 19:14:20 +0900
Message-ID: <4D57AEFC.10608@gmail.com>
References: <4D565D3B.7060808@gmail.com> <20110213075337.GA12112@sigill.intra.peff.net> <20110213083137.GB12112@sigill.intra.peff.net> <4D579A35.1000007@gmail.com> <20110213085236.GA2251@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 13 11:14:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoYyO-0003r0-Hk
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 11:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab1BMKO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 05:14:27 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36529 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab1BMKO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 05:14:26 -0500
Received: by pzk35 with SMTP id 35so679935pzk.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 02:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=IssqJqpupIKSGHcjS9cFyCvIV/fPMVRZWMZB0klOWwY=;
        b=lt/tP/lKq7kX7PT0ZPjY5Oicpoov5wm23Bv1slHKtln2tOJTuRoPiSEQUGoDLQdh5j
         GY/OFo/7n91mH38PeRGbf8780ZKOO8u0+r73m/z8O9eR/BHUYh9ftgIBDvuX7ZCJe6cQ
         kAeG3/blvW9x6Z+eTh4nqoF0v4MFGIGknxHb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xmirlcHrhZgE/GLwPQrN93NMSFSsS2To92Wn4uC9NFYDj9bw4861/azrDf7RA6ICGw
         XwxozR+yfb3CYu0PpFpMgLkLBTtYqiOAfmNWGUsjFwCp5fw9KwWEnE5E8eY61WTAYTlM
         T0To0EDkScFmVMB8jqFhcQefJ5XF+u1GmRmWM=
Received: by 10.142.204.4 with SMTP id b4mr2067109wfg.298.1297592065550;
        Sun, 13 Feb 2011 02:14:25 -0800 (PST)
Received: from [192.168.11.57] (softbank126036243176.bbtec.net [126.36.243.176])
        by mx.google.com with ESMTPS id w22sm2304762wfd.7.2011.02.13.02.14.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Feb 2011 02:14:24 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110213085236.GA2251@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166656>



On 2011/02/13 17:52, Jeff King wrote:
> On Sun, Feb 13, 2011 at 05:45:41PM +0900, xiaozhu wrote:
>
>>> Shouldn't we still be generating "one two three", encoding it via
>>> rfc2047 if necessary, and _then_ deciding if folding is required? Yes,
>>> individual lines in a multi-line subject are good candidates for
>>> folding, but don't we need to be checking for and folding long lines
>>> anyway?
>>
>> It seems that by rfc2047 there is no multi-line subject spec. A subject
>> with multi-line will be always conflated to one single line.
>
> Sorry, I don't quite parse what you're saying. If the header takes up
> multiple lines, then yes, that gets decoded as a single line by rfc822
> header folding. I would then expect that result to be rfc2047-decoded if
> necessary, and in theory it could contain encoded newlines.

I am not similar with mail format. I read the rfc2047 again, but I didn't
see any description about line separator encoding. Perhaps a base64 encoded-word
will contain the line separator involuntarily? I also found a sample in
rfc2047 it show us a line broken subject mail, but it didn't say any thing
about line separator encoding.

>> And also that if we just generate the subject within multi-line just
>> like the current implemention, yes, we can modify the git-am to decode
>> it correctly, but most of the mail client will can not show it
>> correctly.
>
> Again, I don't quite understand what you're saying. The output generated
> by format-patch now is _not_ valid according to rfc2822. Changing git-am
> to parse its bogus output won't help that.
>
>> So it seems that there is only one way that combining the whole first
>> paragraph to a single line? But it will be a nightmare for some long comment.
>
> It's not the only way, but it is how we treat multi-line subjects in all
> other parts of git, so it is at least consistent (and that behavior was
> agreed upon after seeing what is worse: truncating to a single line, or
> merging lines).
>
> -Peff

A sample of rfc2047 show us a legal line broken subject mail, like following:
------------------------------------------------------------------
  Subject: =?ISO-8859-1?B?SWYgeW91IGNhbiByZWFkIHRoaXMgeW8=?=
     =?ISO-8859-2?B?dSB1bmRlcnN0YW5kIHRoZSBleGFtcGxlLg==?=
------------------------------------------------------------------

I understand that the current format-patch is not not valid to rfc2822/rfc2047,
but even a valid one just like above, most of the mail client will can not show it
correctly, they show the first line only, I think that's a problem of user
friendliness.

-xzer
