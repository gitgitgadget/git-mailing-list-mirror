From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 18:51:11 +0200
Message-ID: <200906031851.12160.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200906031121.38616.jnareb@gmail.com> <20090603144837.GE3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 18:51:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBtgR-0007Ci-PJ
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 18:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbZFCQvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 12:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbZFCQvN
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 12:51:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:11324 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbZFCQvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 12:51:12 -0400
Received: by fg-out-1718.google.com with SMTP id 16so45056fgg.17
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Jio7Lq/rSiY1Luhnrt1r+2yhsMbbt8Vme/N52sq0bUk=;
        b=eXZ+uP7nLM0gRivDZcyRJrbnv9kmb/x2vbgyfCjMjq/vpi9Het4jwavC+P9+F3cvBN
         kC7uFzb0aOOHzKMXzfevnjuhENHRKh1Q6yhO6MDx7S6kct1vv4gnsf3/L7cZK8+7Z6Gs
         FBLkDca+Y6jZ6pCHVJCq++21wcdSRsrbzhgF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=blK+/+WFofuqVxiex0Fqs9V+aCfULp/foIdgMHG3doFEvioe4GN/3N4YJx8CppYmji
         9bhLlJY2yHEr6Jb+mrH+OS8pBF2XTOjtK48TaeTKR1bGgn7I1CRNxBd7PZ/VJlaGxChk
         1/Q5NLf5XFIG7xYew5ahZwilF92WbEZYZLlv4=
Received: by 10.86.95.8 with SMTP id s8mr1486716fgb.2.1244047873226;
        Wed, 03 Jun 2009 09:51:13 -0700 (PDT)
Received: from ?192.168.1.13? (abws210.neoplus.adsl.tpnet.pl [83.8.242.210])
        by mx.google.com with ESMTPS id 4sm239742fge.18.2009.06.03.09.51.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 09:51:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090603144837.GE3355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120620>

On Wed, 3 Jun 2009, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

[..]
>>>> It is a bit pity that git protocol was not created with
>>>> extendability (like capabilities) in mind...
>>> 
>>> Yes, no doubt.  There are many things I would have done differently,
>>> given that I now have 20/20 hindsight vision into the past's future.
>>> 
>>> :-)
>>> 
>>> The protocol (mostly) works fine as-is.  Its widely distributed in
>>> terms of clients using it on a daily basis.  Its likely to continue
>>> to serve our needs well into the future.  So, it is what it is.
>> 
>> I do wonder if existing Internet Standard (in the meaning of RFC) 
>> protocols also have such kludges and hacks...

I wonder if there are some BCP (Best Common Practices) RFC for designing
protocols (and BCP documents for designing file formats). And which one
of RFC 2360, RFC 2424,... are applicable here.

> 
> I'm sure they have some... oddities.  But perhaps not as bad as git.
> 
> We have a history of not leaving ourselves room for future expansion,
> and then needing to find a backdoor in the canonical implementation
> parser in order to make it work.
> 
> In the protocol suite, its been the strlen() < pktlen trick which
> has generally worked.  Oh, and also sticking stuff after a fixed
> length record, where we didn't care.

Magic number (magic sequence) identifying protocol / format plus
version number.  But it is good that we have capabilities now
(which is better than version number in this case, IMHO).

> 
> Oh, and send-pack/receive-pack protocol now has ".have" refs, which
> work for C Git because the send-pack client was always calling
> check_ref_format() on each thing sent by the server, and ".have"
> isn't a valid ref name.  Why the hell the send-pack client was doing
> that, I have no idea.  But, when the ref failed it was a silent
> failure, so we were able to use ".have" for some new capability.
> 
> It also broke JGit, which wasn't doing this seemingly pointless
> check_ref_format() and silently fail business.  Oh, and IIRC,
> GitHub may have been burned around the same time somehow.

What are those ".have" refs? They are not described in current version
of "Transfer Protocols" (sub)section in "The Community Book". I remember
that they were discussed on git mailing list, but I don't remember what
they were about...

> 
> In packed-refs, Junio had a hard time adding the "peeled-refs"
> support, because the first version of the parser was so strict.
> But again, somehow he managed to find a backdoor in the old parser,
> and that backdoor is why that file looks the way it does today.

I don't remember what that was about... Nevertheless now we have
kind of 'capabilities' section in .git/packed-refs

> 
> In the loose object format, when we added new-style loose objects
> we found a backdoor in the way libz deflate formats the first 2
> bytes of the file... and encoded something that shouldn't appear
> there to signal it was a new "pack style" loose object.
> 
> Pack index v2 uses a hole where old clients would barf on the
> '\377t0c' followed by the version '2' not being monotonically
> increasing.

Interesting... even more so that this problem of designing without
extendability in mind (magic number + version) is so persistent :-(

>> P.S. By the way, is pkt-line format original invention, or was it 
>> 'borrowed' from some other standard or protocol?
> 
> No clue.  I find it f'king odd that the length is in hex.  There
> isn't much value to the protocol being human readable.  The PACK
> part of the stream sure as hell ain't.  You aren't going to type
> out a sequence of "have" lines against the remote, like you could
> with say an HTTP GET.  *shrug*

Well... in theory you could... ;-)

-- 
Jakub Narebski
Poland
