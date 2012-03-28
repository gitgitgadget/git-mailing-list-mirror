From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v7 3/3] gitweb: add If-Modified-Since handling to git_snapshot().
Date: Wed, 28 Mar 2012 22:28:08 +0100
Message-ID: <201203282328.08876.jnareb@gmail.com>
References: <20120328164513.GA4389@odin.tremily.us> <201203282011.32148.jnareb@gmail.com> <20120328183712.GA5992@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD0Pk-0004wL-G0
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 23:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050Ab2C1V2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 17:28:15 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41301 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932969Ab2C1V2O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 17:28:14 -0400
Received: by wgbdr13 with SMTP id dr13so1371092wgb.1
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=C98H0d36hTsGIlfD1LvlvZEboSZ3bMHKWy3WIMl20ew=;
        b=b0SK8yO8KOOFtf1kzIIWQU7KReE7btaRQHMBMlHkkCWgXQm/oyr6Nw/W6JNJE1TLGU
         vLNRU8wkm6ZVrhzfnHvC0tsvPdSHJaQzPRXj2MtdMfgU7ZD+n0Vj33xnzKwih+XDvq/7
         o1VWiR1CBNNogWOxMfkgEl55IFDrHMT8ejfisaqXToYFQl91+NP6HuI4LJ3Q3y1KzaMR
         K43rdcbGs2fFoa8bIXB3Y0dPgv4Whd6qOftydCq/Km1qhy1ONeUwCagjPAg9Gij56X7S
         ZH5+tqWib4KPb56vPBktVR1ywwhQpgqgOFEsXHqQ3RFiELC9eZBjijX/BCKVnw4nI3i0
         cnIQ==
Received: by 10.180.101.231 with SMTP id fj7mr1509240wib.15.1332970093549;
        Wed, 28 Mar 2012 14:28:13 -0700 (PDT)
Received: from [192.168.1.13] (euy254.neoplus.adsl.tpnet.pl. [83.20.196.254])
        by mx.google.com with ESMTPS id k6sm61119403wie.9.2012.03.28.14.28.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 14:28:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120328183712.GA5992@odin.tremily.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194201>

On Wed, 28 Mar 2012, W. Trevor King wrote:
> On Wed, Mar 28, 2012 at 07:11:31PM +0100, Jakub Narebski wrote:

[...]
> > And it was not caught by test because CGI.pm can output the last modified
> > header as "Last-modified" (RFC 2616, sec 4.2 states "Field names are
> > case-insensitive"), so the last check should be
> > 
> >   +	! grep -i "Last-Modified" gitweb.output
> > 
> > Hmmm... why we use gitweb.output and not gitweb.headers?  Is it consistency
> > with earlier tests?
> 
> Yes, but I can switch to `gitweb.headers` if you'd like.  Should I
> adjust all the header tests in t9501 to use `gitweb.headers` and `grep
> -i`?  It should probably be a separate patch for the tests that
> existed before my i-m-s additions.

Eh, don't worry about this.  First, I think we can assume that HTTP
headers from CGI.pm will all start with capital letter.

Second, for positive match being overly strict is safe - if assumption
doesn't hold we would get false failure.  The problem is for negative
match - being overly strict means that we won't catch the breakage.

I think that the gitweb.output vs gitweb.headers (and gitweb.body) is
because those tests predate gitweb_run producing gitweb.headers file.
Be consistent if you want, or use new feature in new test; you don't
need to modernize t9501.

-- 
Jakub Narebski
Poland
