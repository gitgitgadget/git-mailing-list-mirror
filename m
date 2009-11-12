From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3/RFC 4/5] gitweb: Create links leading to 'blame_incremental' using JavaScript
Date: Thu, 12 Nov 2009 10:22:39 +0100
Message-ID: <200911121022.40893.jnareb@gmail.com>
References: <1251805160-5303-1-git-send-email-jnareb@gmail.com> <200911061905.52285.jnareb@gmail.com> <7vtyx0f9rd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 10:22:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Vsr-0004hb-5t
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 10:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbZKLJWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 04:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbZKLJWL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 04:22:11 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43997 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbZKLJWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 04:22:09 -0500
Received: by bwz27 with SMTP id 27so1963497bwz.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 01:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PY2DAbNTxKpKkPZn6BkyPdfydDQW5fqChtpD+XJ814w=;
        b=Nw9C1xPCzcz7f8WFxBuGZ82vShd4HQFcB8IFfL+pOP8wKnqVWmfkpqLnar/a4JI/nY
         5oPlq9W0IK0/SapoH5pIdIRd9cPp0zam50BAw85+xrFJ+Y3pPKnyEQ8r9H9pVDSBVgze
         867zf+LYzHqEgq5qT5WV1tNlJoretMM4WsReg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RVq+o80IhOSfq6DlfZlPf6CbHX8i5FczCD11HRG1rKurtg8FUX4Y0MJpo1XjtVpUrj
         ULK5aKqXBtcy2yVG0Do1dKXCyoaMyOznniH8yfFdT0OjR5P2MGdGq4b540nN4OeBbA4/
         eYjIYdFVe/hw/KBo0x/ivXGIWXCsouRRGH4us=
Received: by 10.204.148.88 with SMTP id o24mr2732241bkv.182.1258017733622;
        Thu, 12 Nov 2009 01:22:13 -0800 (PST)
Received: from ?192.168.1.13? (abwa45.neoplus.adsl.tpnet.pl [83.8.224.45])
        by mx.google.com with ESMTPS id 13sm784693bwz.14.2009.11.12.01.22.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 01:22:12 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vtyx0f9rd.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132750>

On Thu, 12 Nov 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > But even if incremental blame turns out to be slower than incremental
> > blame it still has the advantage of being _incremental_.  You have at 
> > least some result soon.
> 
> It wasn't it was slow that bothered me, but early implementations of
> incremental blame I tried didn't _appear_ as incremental.  That was the
> dissapointing part.
> 
> At the protocol and implementation level it certainly was feeding data
> incrementally to the browser, but the end user experience on the screen
> was "click....wait...wait...wait...voila the whole blame appears", not
> "click...trickle...trickle...trickle...ah everything is filled".  The
> latter obviously is what an incremental one should be aiming for.
> 
> No I haven't tried your latest code.  Probably I should.

The problem with earliest versions of incremental blame _in some browsers_
was that 'onreadystatechange' event was not fired as soon as new part of
blame data was available (truth to be said the definition of this event
is a bit underspecified).  That is why newer versions of interactive blame
use timer (alarm) to check every 1 second if there is something new.

Perhaps interactive blame should use 'onprogress' event instead, which is
well defined... but is in _draft_ of standard (XHR 2.0), and not yet in
established standard.

-- 
Jakub Narebski
Poland
