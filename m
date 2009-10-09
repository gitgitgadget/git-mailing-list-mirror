From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Fri, 09 Oct 2009 12:27:35 -0700 (PDT)
Message-ID: <m3eipcgyfv.fsf@localhost.localdomain>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
	<1255065768-10428-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 21:31:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwLB9-0008De-Oc
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 21:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933728AbZJIT2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 15:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761341AbZJIT2P
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 15:28:15 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:52128 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761326AbZJIT2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 15:28:14 -0400
Received: by bwz6 with SMTP id 6so1844524bwz.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kgfFz9WHSX4/7rfREx3I3qXeRviBQFN5q16DcloZKhY=;
        b=K5Rls+kZjxj8lsvtaJ7IA3m0GG+1ZvnJuTrx1hBU8XrNoT5/RtYgCXHlopeFhWCi1x
         neU6nyOwTE5Sn2ZRxMje31C29PQqJtjI9qDz0fBilW5ksHvpOwWJ84nUSJNrJXGDLQHe
         +OiL3AY/Sz6BXaslasAyb1XDCtjnkn22Wx6Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=WCL8xwZ/xdnnM9VCCdV/qpiYNDZlAyuL59ujgIjRPucq6Sl0wgRKSrbUXDjKWp0Q9r
         0Tp8EHer1UdYHf1h1nwB9qP0jg5ccy3AGdQzdwVXe7HGTqA6DvftSHIRuiWY3mWsBL++
         e0TUx+jil/gPojI9cGH116WtpCYQb/pu4q4/o=
Received: by 10.102.211.35 with SMTP id j35mr1269744mug.35.1255116456774;
        Fri, 09 Oct 2009 12:27:36 -0700 (PDT)
Received: from localhost.localdomain (abve46.neoplus.adsl.tpnet.pl [83.8.202.46])
        by mx.google.com with ESMTPS id y6sm781561mug.10.2009.10.09.12.27.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 12:27:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n99JRXgY009026;
	Fri, 9 Oct 2009 21:27:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n99JRWSD009022;
	Fri, 9 Oct 2009 21:27:32 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1255065768-10428-2-git-send-email-spearce@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129835>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> +	empty_list     = PKT-LINE(id SP "capabilities^{}" NUL cap_list LF)
> +
> +	non_empty_list = PKT-LINE(id SP name NUL cap_list LF)
> +	                 *ref_record
> +
> +	cap_list      = *(SP capability) SP

Errr... are you sure?  Because from examples it looks like cap_list
(capabilities list) is a list of space *separated* capabilities, while
the above requires also both leading and trailing space.  Shouldn't it
be

	cap_list      = capability *(SP capability)

Also the format for capability is not defined; I guess only 
a-z, 0-9, '-' and '_' are allowed in capability name.


BTW. is it possible to not have capability list?

> +	HEX           = "0".."9" | "a".."f"

Do you plan allowing also upper case letters, while server and client
SHOULD use lowercase?  Because if you do, then RFC 5234 which defines
ABNF you seem to be using here has HEXDIG defined.

> +	NL            = <US-ASCII NUL, null (0)>

Why not NUL?

> +	LF            = <US-ASCII LF,  linefeed (10)>
> +	SP            = <US-ASCII SP,  horizontal-tab (9)>
                                       ^^^^^^^^^^^^^^-- o'rly?

Those are pre-defined in ABNF, e.g.

	SP             =  %x20

> +References
> +----------
> +
> +link:http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
> +link:http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]

You should also reference the following RFCs:
 * "RFC 5234: Augmented BNF for Syntax Specifications: ABNF"
 * "RFC 2119: Key words for use in RFCs to Indicate Requirement Levels"

-- 
Jakub Narebski
Poland
ShadeHawk on #git
