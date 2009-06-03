From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 4 Jun 2009 00:04:09 +0200
Message-ID: <200906040004.18594.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200906032220.00238.jnareb@gmail.com> <20090603202429.GO3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:59:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MByUz-0000XL-3B
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 23:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbZFCV7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 17:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbZFCV7l
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 17:59:41 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:34250 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbZFCV7k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 17:59:40 -0400
Received: by fxm9 with SMTP id 9so326059fxm.37
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qDaV5Ad4QOTx9T1CTbNS5kbgwx+WCUpezcwv8ToX8Lg=;
        b=awZolDM3zz+6KU8e1jGuhWMw9ly6WROocDFJPLCVHlu6e9ci7k3uY1FFGuwEc5sLsx
         aax1L5d0ehdeuOdwiSUeOggkVChQUjCY0Xd/51pKM+61Q8MwAPV8sukjoZ7RuEok96rA
         CGkZNRwX9cmstc+YZEWV60xlcZD3OEz3ktKPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kKlDrsuSasISUBZMnL+4kTHAyWfChOFBTfAX/vDVYFXSbjDqO5V25DCr9dSDkQfv+E
         SRKflBCl+7i/b9/mwroSfVBAjkXjVu6tk0dTLUd2Ms9RVrOfMPzrOu18Z5bHxQyfDChN
         dkTnBdeqTBeQHuUtkL6Q+yZpzVNLDoXOqlCx8=
Received: by 10.204.54.4 with SMTP id o4mr1349501bkg.10.1244066381381;
        Wed, 03 Jun 2009 14:59:41 -0700 (PDT)
Received: from ?192.168.1.13? (absh69.neoplus.adsl.tpnet.pl [83.8.127.69])
        by mx.google.com with ESMTPS id 21sm10736534fkx.14.2009.06.03.14.59.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 14:59:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090603202429.GO3355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120651>

On Wed, 3 Jun 2009, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

> > BTW. do "include-tag" capability MUST NOT (REQUIRED) be send if there
> > are not tags (tag objects?), or just SHOULD NOT (RECOMMENDED), or even
> > MAY NOT (OPTIONAL).  GitHub server doesn't send it if there are no 
> > tags...
> 
> Clients MAY always send include-tag, hardcoding it into a request.
> The decision for a client to request include-tag only has to do
> with the client's desires for tag data, whether or not a server
> had advertised objects in the refs/tags/* namespace.
> 
> Clients SHOULD NOT send include-tag if remote.name.tagopt was set
> to --no-tags, as the client doesn't want tag data.
> 
> Servers MUST accept include-tag without error or warning, even if the
> server does not understand or support the option.
> 
> Servers SHOULD pack the tags if their referrant is packed and the
> client has requested include-tag.
> 
> Clients MUST be prepared for the case where a server has ignored
> include-tag and has not actually sent tags in the pack.  In such
> cases the client SHOULD issue a subsequent fetch to acquire the
> tags that include-tag would have otherwise given the client.

So do I understand correctly that capabilities are governed by the
following generic rules:

1. Server sends space separated list of capabilities it support. It
   MUST NOT send capabilities it *does not* support. It MAY NOT send
   "include-tag" if there are no tag objects (or is it SHOULD NOT?).
2. Client sends space separated list of capabilities it wants. It SHOULD
   (or perhaps it is MAY?) send subset of server capabilities, i.e do
   not send capabilities served does not advertise.
3. Server MUST ignore capabilities it does not understand. Server MUST
   NOT ignore capabilities (or SHOULD NOT only?) that client requested
   and server advertised.

I know that client MUST send only maximum of one of "side-band" and 
"side-band-64k", but how should server reacts if client sends both?
Should it use "side-band-64k"?

-- 
Jakub Narebski
Poland
