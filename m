From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Migrating away from SHA-1?
Date: Tue, 12 Apr 2016 16:06:53 -0700
Message-ID: <570D7F8D.9050406@zytor.com>
References: <570D78CC.9030807@zytor.com>
 <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:07:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7Ot-0004Zr-8x
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965944AbcDLXHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:07:09 -0400
Received: from terminus.zytor.com ([198.137.202.10]:44084 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932523AbcDLXHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:07:08 -0400
Received: from carbon-x1.hos.anvin.org ([67.51.76.21])
	(authenticated bits=0)
	by mail.zytor.com (8.15.2/8.14.5) with ESMTPSA id u3CN6w1u020223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Tue, 12 Apr 2016 16:07:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291317>

On 04/12/16 16:00, Stefan Beller wrote:
> On Tue, Apr 12, 2016 at 3:38 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> OK, I'm going to open this can of worms...
>>
>> At what point do we migrate from SHA-1?  At this point the cryptoanalysis of
>> SHA-1 is most likely a matter of time.
>
> And I thought the cryptographic properties of SHA1 did not matter for
> Gits use case.
> We could employ broken md5 or such as well.
> ( see http://stackoverflow.com/questions/28792784/why-does-git-use-a-cryptographic-hash-function
> )
> That is because security goes on top via gpg signing of tags/commits.
>
> I am not sure if anyone came up with
> a counter argument to Linus reasoning there?
>

Not true, because what we are signing is a chain of SHA-1s; the 
signature is meaningless unless the integrity of the hash chain is 
inviolate.

>>
>> For existing repositories we will need to have a migration mechanism. Since
>> we can't modify objects without completely invalidating the cryptographic
>> properties, what I would suggest is that we leave the existing objects as
>> is, with a persistent lookup table from SHA-1 to <new hash>, and have that
>> lookup table signed (e.g. GPG) by the person responsible for converting the
>> repository.  This freezes the cryptographic status of the existing SHA-1
>> objects at the time the conversion happens.  This is a very good reason to
>> do this before SHA-1 is actually broken  In contrast. SHA-2 has been
>> surprisingly resistant to cryptoanalysis, to the point that SHA-3 was
>> motivated by performance and the desire to have a well-tested function based
>> on entirely different principles should a generic attack against the common
>> structure of MD5/SHA-1/SHA-2 would ever be found.
>
> When the kernel moved from BitKeeper to Git, all history was thrown away,
> and started from scratch. The old history could be grafted into the
> repo, if you cared
> though.
>
> I'd propose to go that route again and use a sha1 graft history which
> you can get optionally
> put into your new history for convenience.
>

That was done more for legal reasons than anything else, as far as I 
understand.  The userbase of git today is also much, much larger than 
the userbase for BK ever was.

	-hpa
