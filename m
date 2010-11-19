From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: groff .ft command use in asciidoc
Date: Fri, 19 Nov 2010 12:22:30 -0600
Message-ID: <20101119182230.GA26187@burratino>
References: <20101117095233.GA23817@basil.fritz.box>
 <20101117101516.GA12416@burratino>
 <20101117143855.GA1987@sigill.intra.peff.net>
 <20101117154829.GE23656@basil.fritz.box>
 <20101119175424.GA13276@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 19 19:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJVcP-0005B1-HC
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 19:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab0KSSXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 13:23:24 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48674 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab0KSSXX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 13:23:23 -0500
Received: by vws13 with SMTP id 13so2564132vws.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 10:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gOcKPY4nAXiyE7Cvy3AdBU8I6Ssbb5Y5AybHTnDord0=;
        b=qEVA/J1bxwhTUfz08Tu7Dd3ZUANDGzYC7KQv38Lz4BPClmst/VIel/RLpqpeXSuRkh
         ch21F6vlJeVXi7eBqZY75ykutE7fuYECqVUvNBXjKHnsnHj+X8otsGTlXbxEBylvO8LJ
         riSEuJHmho9laclOjL3Gf1NMur02jBg3P3VL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YuLogNj2Zpd1cBZVRsiIfwB/sLFpURbCe2dIPe65a9phF12E0AL3OVL9Jlok/5OF0P
         WploBx9t1bZoE9ZxfceqqGmgvANaPNuQlk9VLyNJPtpdsMbTaUNvkmpM/eYkTZhlNgQF
         QvMUzD+FLXFjPbrPNUEJicY5LQes6dnSJYpLY=
Received: by 10.220.81.78 with SMTP id w14mr580964vck.120.1290191001065;
        Fri, 19 Nov 2010 10:23:21 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u6sm712034vby.17.2010.11.19.10.23.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 10:23:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101119175424.GA13276@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161773>

Jeff King wrote:

> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -63,35 +63,28 @@ endif
[...]
> -#	-1.68.1,	set ASCIIDOC_NO_ROFF? (based on changelog from 1.73.0)
> -#	1.69.0,		no extra settings are needed?
> +#	-1.68.1,	no extra settings are needed?
> +#	1.69.0,		set ASCIIDOC_ROFF?
>  #	1.69.1-1.71.0,	set DOCBOOK_SUPPRESS_SP?
> -#	1.71.1,		no extra settings are needed?
> +#	1.71.1,		set ASCIIDOC_ROFF?

I would like to see these question marks go away.  I believe the
initial introduction of ASCIIDOC_NO_ROFF happened conservatively:
i.e., do not change anything unless this particular toolset
requires the change.  Which is a shame, because it means it is not
obvious what ASCIIDOC_ROFF is working around.

*does some digging*

The story begins with v1.3.0-rc1~45^2 (Tweak asciidoc to work with
broken docbook-xsl, 2006-03-05).  The [listingblock] style, used
for listings like:

--------------------
$ ls
foo
bar
baz
--------------------

is meant to be rendered with the <screen> tag, but apparently DocBook
XSL 1.68.1 does not and 1.70.1 does treat <screen> as a
verbatim environment as it should.  See <http://bugs.debian.org/375503>.
The patch swapped in another verbatim environment, <literallayout>.

The result is a regression in another aspect from <screen>: namely,
<screen> uses monospace text.  v1.5.2.5~6 (Force listingblocks to be
monospaced in manpages, 2007-07-18) worked around that by introducing
some raw nroff, since this codepath is only used for manpages anyway.

The rest is history.  docbook-xsl 1.72 broke the traditional method
for passing raw roff through.  It had a hole that let you do it some
other way.  Later versions of docbook-xsl forbid passing through raw
roff escapes altogether.

Given all that, I suspect (but haven't checked) that the only knob we
would need to cover all historically supported versions of DocBook is

	DOCBOOK_MESSES_UP_SCREEN_TAG = YesUnfortunately

to be set with docbook versions in the 1.68 series.  Everyone else
can use <screen>, with the <literallayout> fixup to add some space
after it.

> However, I think it is worth it to avoid the hassle for the vast
> majority of people on modern systems.

Yes!  Your patch takes care of that, so ack.

Thanks,
Jonathan
