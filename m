From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 01/14] Extend index to save more flags
Date: Sun, 28 Sep 2008 13:59:46 +0200
Message-ID: <200809281359.46858.jnareb@gmail.com>
References: <48d723bf90941_5de93fcd2ee870984625e@app02.zenbe.com.tmail>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 14:01:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjuy8-0001Ke-M8
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 14:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbYI1L74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 07:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbYI1L74
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 07:59:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:16988 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbYI1L7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 07:59:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1117420fgg.17
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 04:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ItB7gysCzcdTnU1KhMIk+YnN4/cJOfmSxddioCCOAZo=;
        b=HHsjeidk0w1aWn/BP2l76lJ8vStHOcJWoegyb6V05OLb6I5M2Ze2j7IwhdEvthsy4S
         1Flg67h2aq2GpQ2YaE7Y+JbYYgOQ9erl0A96cRSnNKiIpZKQYsgh+7EiaJJWbnvLXyaD
         HfZ6z9jI3H6cR6KKLfbBQh8YZVE5iqQ6+vcsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=clyNQVakPhsr+er6F0VvHeGBiwcO4cUhLgWA6+jem2dLWyCU5h6nT3KOFnQTyrN6ju
         NZCI+NEBtBpf0lZpVtJU7z3x6yHH1Xz5oFCY7ZqkxF1gNcOhxoZFocGheQh9IjFT/awv
         4dgeNt7GSQGzK08Hm/eCcGxZz/E00mZnqyxLE=
Received: by 10.181.27.7 with SMTP id e7mr1785385bkj.2.1222603193482;
        Sun, 28 Sep 2008 04:59:53 -0700 (PDT)
Received: from ?192.168.1.11? (abvg103.neoplus.adsl.tpnet.pl [83.8.204.103])
        by mx.google.com with ESMTPS id h2sm1412864fkh.11.2008.09.28.04.59.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Sep 2008 04:59:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48d723bf90941_5de93fcd2ee870984625e@app02.zenbe.com.tmail>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96958>

On Mon, 22 Sep 2008, Duy Nguyen wrote:
> On 09/22/2008 "Jakub Narebski" <jnareb@gmail.com> wrote:
>>On Sun, 21 Sep 2008, Nguyen Thai Ngoc Duy wrote:
>>> On 9/21/08, Jakub Narebski <jnareb@gmail.com> wrote:
>>>>> +
>>>>> +#define CE_EXTENDED_FLAGS (0)
>>>>> +
>>>>> +/*
>>>>> + * Safeguard to avoid saving wrong flags:
>>>>> + *  - CE_EXTENDED2 won't get saved until its semantic is known
>>>>> + *  - Bits in 0x0000FFFF have been saved in ce_flags already
>>>>> + *  - Bits in 0x003F0000 are currently in-memory flags
>>>>> + */
>>>>> +#if CE_EXTENDED_FLAGS & 0x80CFFFFF
>>>>> +#error "CE_EXTENDED_FLAGS out of range"
>>>>> +#endif
>>>>
>>>>
>>>> I don't quite understand the above fragment (especially with the fact
>>>>  that CE_EXTENDED_FLAGS is defined as (0))...
>>> 
>>> Because this patch does not introduce any new on-disk flag yet so
>>> CE_EXTENDED_FLAGS remains 0. In the next patch, CE_EXTENDED_FLAGS will
>>> be updated to have CE_NO_CHECKOUT.
>> 
>> Well, now I understand CE_EXTENDED_FLAGS being (0).
>> 
>> What I still don't understand the pattern it is protected against.  
>> As I understand it if CE_EXTENDED_FLAGS & 0x0000FFFF it is bad,
>> because ce_flags saved flags are not extended flags, and 
>> CE_EXTENDED_FLAGS & 0x003F0000 are in-memory flags.  But why
>> CE_EXTENDED_FLAGS & 0x80C00000 is bad, and why (if I understand it)
>> CE_EXTENDED_FLAGS & 0x00300000 is not bad.
> 
> Wrong bit computation, should be "#if CE_EXTENDED_FLAGS & 0x803FFFFF".
> Thanks for pointing out. 

So now there is:

Now CE_EXTENDED_FLAGS & 0x803FFFFF is bad because:
  * CE_EXTENDED_FLAGS & 0x0000FFFF are saved flags (not extended)
  * CE_EXTENDED_FLAGS & 0x003F0000 are in-memory flags
  * CE_EXTENDED_FLAGS & 0x80000000 is 'extra flags' bit
    (this is not mentioned in quoted comment; I'm not sure if
     it needs to be or not)

Is that correct?
-- 
Jakub Narebski
Poland
