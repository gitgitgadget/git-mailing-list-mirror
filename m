From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] reset: accept "git reset HEAD <path>" from unborn
 branch
Date: Tue, 19 Oct 2010 18:26:47 -0500
Message-ID: <20101019232647.GA6198@burratino>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes>
 <20101019182845.GE25139@burratino>
 <7vhbgiyoo9.fsf@alter.siamese.dyndns.org>
 <20101019221005.GC32029@burratino>
 <20101019221415.GG32029@burratino>
 <7vzku9ye5k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 01:31:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8LeO-00072w-62
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 01:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077Ab0JSXag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 19:30:36 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39820 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0JSXaf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 19:30:35 -0400
Received: by qwa26 with SMTP id 26so1756601qwa.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7HiA8fgPZoEYVLTUEgzxKUgUsmsKu+91G0HajLiXRMg=;
        b=U+WJebJn/h1HEguyogPuCUmub/+szg+JcSB3QLFE8mz+opfQyVHV5Q7SGpFjYwmEOS
         AKVqUhZ0ptYG/Fmn9VJw+SPvwSTraXezAeUJ7Tz8/cyECi2Bw/bzPA5kR5pbx5t78TML
         XXhN+R3B/6MZfI2ekLj9/YLUB+94HX9a/ZrqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ozEAi8meEOIKCHg4GV8zPiLAZoQLXZ+gzw0Kzy2y101i2ZfcIKGiLGH57bb1q+kRqs
         21sci3/RrQfDEA+Dh9rtr4ebpkBOI78s20SETSnWpJcWjR7XGt5Y47Oqeiej84qrBEtb
         jcreFWb3R7cq19vxNrQNJKKiNU/esdbqErSAk=
Received: by 10.224.37.14 with SMTP id v14mr4593505qad.223.1287531034389;
        Tue, 19 Oct 2010 16:30:34 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t35sm12525752qco.42.2010.10.19.16.30.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 16:30:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzku9ye5k.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159379>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> 	git add .
>> 	rm <path1>; # bad file!
>> 	git reset <path1>
>>
>> git will respond by informing me that this use of <path1> is
>> ambiguous.
>
> Which is fixed by 3/4.

No, I didn't fix that.

What 3/4 allows is

	git reset -- <path1>

The explicit "--" is required in the case where that file is not
present on disk.

>> ...  So I might try to disambiguate:
>>
>> 	git reset HEAD <path1>
>
> I however do not think this is sane, as you are _explicitly_ referring to
> HEAD, saying "I want to pull this out of the commit pointed by the HEAD",
> while there is _no such commit_.  Sounds somewhat insane.

Yes, makes sense.  I started out thinking of HEAD as a sort of
abstract symbol (like the occasionally-proposed INDEX) but it probably
is better to get used to it just being a reference early on.

> But why is path1 ambiguous in the first place?  It is because it is not
> considered to be a pathname, and it is not a valid refname either, right?
>
> Didn't we discuss a separate topic to teach verify_filename/non_filename
> to optionally look into the index?  If we did that, perhaps we do not even
> need 3/4, no?

That would eliminate the need for 4/4, I think.  Thanks for the pointers.
