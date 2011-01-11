From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 00:52:44 -0600
Message-ID: <20110111065244.GB8631@burratino>
References: <4D262D68.2050804@cfl.rr.com>
 <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com>
 <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com>
 <20110107214907.GA9194@burratino>
 <20110107220942.GB10343@sigill.intra.peff.net>
 <4D27B33C.2020907@cfl.rr.com>
 <20110111054735.GC10094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 07:53:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcY6I-00067q-Fu
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 07:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500Ab1AKGw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 01:52:58 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36804 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab1AKGw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 01:52:57 -0500
Received: by yxt3 with SMTP id 3so7828815yxt.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 22:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=63p/rJVK6uTzwoG6Hw+nHRqTyjjoz0fO5ZrJhPZ04Sw=;
        b=MPx2ifFQE/oL7oV4JvN3LKo0MmLSBl/nmR4jq/FvgjJ6B1mT4Q9SN8w69DGG3bSttv
         vexPMjzz+eoGkjAGAZw1h7QVCqAc3g1ojj1rO916JlSgeUPy42nusPPSSvRjsECnCtKm
         rlIEIjwFa4jD3+kXeQ2uw/i7wPP01h9tuSl9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=M3LBa+salWJtZ00zYhrotvMlyqKkIw1i47SnCFo6VeIFPdaxpA18p7zOJK/WK7BpBp
         oKf4TYz0/PMPFfFzoQaN6zKWK7GRC0Ys+14NWJp8cE2blu7180FPXaYBrB6u6F0bwWgo
         e0nM5WMLPwBNKlnLz+W2m7mMGY+/cblGEqeH8=
Received: by 10.90.4.22 with SMTP id 22mr7165479agd.26.1294728776595;
        Mon, 10 Jan 2011 22:52:56 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id m49sm2640301yha.2.2011.01.10.22.52.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 22:52:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110111054735.GC10094@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164914>

Jeff King wrote:
> On Fri, Jan 07, 2011 at 07:43:40PM -0500, Phillip Susi wrote:

>> What parts do not respect replacement?  More importantly, what parts
>> will be broken?
[...]
> Off the top of my head, I don't know. I suspect it would take somebody
> writing a patch to create such an incomplete repository (or making one
> manually) and seeing how badly things broke.

I have two worries:

 - first, how easily can the replacement be undone? (as you mention
   below)
 - second, what happens if the two ends of transport have different
   replacements?

That second worry is the more major in my opinion.  Shallow clones are
a different story --- they do not fundamentally change the history and
they have special support in git protocol.  It is possible to punt on
both by saying that (1) replacements _cannot_ be undone --- a second
replacement is needed --- and (2) the receiving end of a connection is
not allowed to have any replacements for objects in common that the
sending end does not have, but then does that buy you anything
significant over a filter-branch?
