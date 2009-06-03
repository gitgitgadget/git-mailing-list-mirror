From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 4 Jun 2009 00:46:21 +0200
Message-ID: <200906040046.22383.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200906040004.18594.jnareb@gmail.com> <7vzlcp55g3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 00:41:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBz9a-00034Z-EN
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 00:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbZFCWlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 18:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754895AbZFCWll
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 18:41:41 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:33168 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbZFCWlk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 18:41:40 -0400
Received: by bwz9 with SMTP id 9so339378bwz.37
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 15:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JHV0P9flRt9/OFbKy3E3ERWYB1yBMdFAvdC2CpW+H3w=;
        b=FVlTUGau6MRVcX9lCr8cnD995AMuY5J93RkKRlTJQCiQ5f8UThukZRZGpGlRRLOfAp
         txgdlvS/9+iHQomXiuKEv5Oec/qG5f9NWcYSrUT0DTEUXepbR3/iuNY+P/vXRII3BZB/
         kmrik69oP+6nWE8fxvC1S/F7V6aok823wWN/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kC/Mq197SNVuIJ1QzvOcnMw+6qFQD1sJNF1+YasBfRP0m5GiUJPtvAYG4Ndj5Du6Yh
         TzzzSk9UnEMvGxKdJFsCVsA0wn6TeydVRSe1ug9LM0H4aIKwUs6M0e6+sdpYRxv8jSMG
         c8o9DQIJQdjy7Gv+hOsB0dYAPwByNJ/pOks1w=
Received: by 10.204.51.65 with SMTP id c1mr1381984bkg.59.1244068901240;
        Wed, 03 Jun 2009 15:41:41 -0700 (PDT)
Received: from ?192.168.1.13? (absh69.neoplus.adsl.tpnet.pl [83.8.127.69])
        by mx.google.com with ESMTPS id y15sm10768560fkd.23.2009.06.03.15.41.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 15:41:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vzlcp55g3.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120657>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > 1. Server sends space separated list of capabilities it support. It
> >    MUST NOT send capabilities it *does not* support. It MAY NOT send
> >    "include-tag" if there are no tag objects (or is it SHOULD NOT?).
> 
> I doubt RFC 2119 lingo would include MAY NOT, as it is ambiguous
> especially to non-native speakers (like me).  

You are right, RFC 2119 does not include MAY NOT.

> You meant to say "MAY omit 
> sending", perhaps, but in general capabilies are what you _can_ do at the
> protocol level, and in my opinion, you shouldn't have to check if a
> particular repository you (as a program with given set of features
> implemented) happen to be looking at has tags in order to decide what
> capabilities to advertise.

I wonder why in http://book.git-scm.com/7_transfer_protocols.html 
("Git Community Book", chapter "7. Internals and Plumbing", section
 "Transfer Protocols", subsection "Fetching Data with Upload Pack")
"include-tag" is not included ;) in advertised server capabilities.
Because github's git-daemon advertises it even if there are no
tags present

  $ echo -e -n "0039git-upload-pack /schacon/gitbook.git\0host=github.com\0" | 
    nc -v github.com 9418
  Connection to github.com 9418 port [tcp/*] succeeded!
  00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow no-progress include-tag
  00441d3fcd5ced445d1abc402225c0b8a1299641f497 refs/heads/integration
  003f7217a7c7e582c46cec22a130adf4b9d7d950fba0 refs/heads/master
  003edc9d991bc43cb04e692efc793f885eb4ff7fda98 refs/heads/pt_BR

> > 2. Client sends space separated list of capabilities it wants. It SHOULD
> >    (or perhaps it is MAY?) send subset of server capabilities, i.e do
> >    not send capabilities served does not advertise.
> 
> I'd say "the client SHOULD NOT ask for capabilities the server did not say
> it supports".

I agree that it is better formulation (phrasing).

> 
> > 3. Server MUST ignore capabilities it does not understand. Server MUST
> >    NOT ignore capabilities (or SHOULD NOT only?) that client requested
> >    and server advertised.
> 
> I know unrecognized capability requests are silently ignored, but I
> consider that as a sloppy/practical programming, and not a specification.

Well, the whole 'be strict in what you send, and accepting in what you
accept' leads unfortunately to accepting sloppy programming and coding.

Nevertheless it is I guess better to silently ignore unknown
capabilities requested by client than fail, isn't it?

-- 
Jakub Narebski
Poland
