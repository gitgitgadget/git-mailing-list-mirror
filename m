From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Determining commit reachability
Date: Mon, 06 Sep 2010 07:04:33 +0200
Message-ID: <4C847661.3020800@gmail.com>
References: <4C83FEC3.3040101@gmail.com> <20100906031700.GA25012@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 06 07:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsTso-0007fv-H4
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 07:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab0IFFEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 01:04:38 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55979 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab0IFFEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 01:04:37 -0400
Received: by wwj40 with SMTP id 40so5958147wwj.1
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 22:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=ODF/V2w72FY3HsFJ/Dj3UqhgHfx4VOpiejZ2BnjwJSA=;
        b=tJ3zIZ2OQeT5pmLgsDzvcvaOlazQNNKFcNYlSss5ZE9vax70OHo8x6zxqYUY+c0zt+
         ftWMNqQHzYDNbJATY7c+dKHcSGtiiuqtIKTeRqMlGH8g4UwMzi2XNusBhGr41xzOcxcE
         NPwZOJBDv1iHyucUvhr+/o4XeeN1haBdX9G2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=Rn5ZZsD4fxyNWOEavAVzwx/86XTC8gsoSEnzz21kcat6wHOgt+ge5JQX1EVodH3gNH
         MgG8/iES3o4qkVfhULKtyyaQcebLilTmjNCi+S8UKjTTreuFAipbUKcx8AKFw80sCpcZ
         1VCRv2pQTXZvqrsGOW6Rh0yyIWmqRIU7b7Wwk=
Received: by 10.227.145.20 with SMTP id b20mr870875wbv.28.1283749476039;
        Sun, 05 Sep 2010 22:04:36 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-127-121.multimo.pl [89.174.127.121])
        by mx.google.com with ESMTPS id m25sm4256091wbc.1.2010.09.05.22.04.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 22:04:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <20100906031700.GA25012@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155527>

On 09/06/10 05:17, Jeff King wrote:
> On Sun, Sep 05, 2010 at 10:34:11PM +0200, Artur Skawina wrote:
> 
>> Given commit C, refs (branches) R, S and T what would be the best way
>> to test whether 'C' is reachable from any of the heads?
>>
>> Checking if `git rev-list -n1 O ^R ^S ^T` produces any output is what
>> i came up with; is there a better (ie faster) solution?
> 
> I think that is about as fast as you will get. You could try something
> with git-merge-base, but it should be about the same speed.
> 
> Note that neither will tell you _which_ head the target was reachable
> from. For that, given the current interface you have to test each head

As i think i'll only need this to prevent leaking (private) commits that
wouldn't be reachable from the (public) heads, just  catching the
unreachable ones should be enough.

$ time git rev-list -n1 v2.6.12 ^v33 ^v35
0m2.333s user   0m0.040s system   0m2.379s elapsed   99.77% CPU
$ time git rev-list -n1 v2.6.36-rc2 ^v33 ^v35
76be97c1fc945db08aae1f1b746012662d643e97
0m0.500s user   0m0.010s system   0m0.514s elapsed   99.13% CPU

A bit expensive, but I guess should it become a problem I could cache
the result and/or blacklist the client.

Thanks,

artur
