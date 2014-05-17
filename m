From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2] format-patch --signature-file <file>
Date: Sat, 17 May 2014 08:39:43 -0700
Message-ID: <20140517153943.GB31912@hudson.localdomain>
References: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
 <1400203881-2794-2-git-send-email-jmmahler@gmail.com>
 <20140516081445.GA21468@sigill.intra.peff.net>
 <20140517072548.GA18239@hudson.localdomain>
 <20140517074224.GA16697@sigill.intra.peff.net>
 <20140517085911.GA18862@hudson.localdomain>
 <20140517100013.GA18087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 17 17:39:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlgiG-00060f-LR
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 17:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757518AbaEQPjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 11:39:48 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64757 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757315AbaEQPjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 11:39:48 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so3840455pab.15
        for <git@vger.kernel.org>; Sat, 17 May 2014 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DBM88SWXn+KQY9UWczKN4i+dFf8hqI8HhAnBrNLqEno=;
        b=FJdtGJKNxA/35hN0cWSB/aCQJGgYhhHovRDOhYXBDMKlgSVS6ITQI+krxwB/+aFh5l
         880pmbm7u8suDolC2Mz0P3dzDhCw01vxX3SE8GQUo2hTAJzQTg1ZhJS5GfAE5ZntL/7P
         AoCQcPXCelcCDaXpKryOVPGNa5Rb37Ddhf+4zlBC7wgtmoi/zwf7wZNPj1FQNSrjFUQX
         JB+D4uXrQlQ4//oHHyRKqUtwUkszMCduy2WHhyPUMN4xLbzbVg5o/lk3mZas+hVpu+uf
         T+x6M38/lnjsprXGmKdmxs8ulRKXUqbruDxUL1QLK5ZTI5bSJmgtHHw1TYR+dDCAbMKc
         7Xew==
X-Received: by 10.66.141.109 with SMTP id rn13mr30008266pab.117.1400341187466;
        Sat, 17 May 2014 08:39:47 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id xc1sm49343950pab.39.2014.05.17.08.39.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 17 May 2014 08:39:46 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sat, 17 May 2014 08:39:43 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140517100013.GA18087@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249474>

On Sat, May 17, 2014 at 06:00:14AM -0400, Jeff King wrote:
> On Sat, May 17, 2014 at 01:59:11AM -0700, Jeremiah Mahler wrote:
> 
> > >   if (signature) {
> > > 	if (signature_file)
> > > 		die("you cannot specify both a signature and a signature-file");
> > > 	/* otherwise, we already have the value */
> > >   } else if (signature_file) {
> > > 	struct strbuf buf = STRBUF_INIT;
> > > 	strbuf_read(&buf, signature_file, 128);
> > > 	signature = strbuf_detach(&buf);
> > >   } else
> > > 	signature = git_version_string;
> > > 
> > 
> > Before, --no-signature would clear the &signature.
> > With this code it sees it as not being set and assigns
> > the default version string.
> 
> Ah, you're right. Thanks for catching it.
> 
> If you wanted to know whether it was set, I guess you'd have to compare
> it to the default, like:
> 
>   if (signature_file) {
> 	if (signature && signature != git_version_string)
> 		die("you cannot specify both a signature and a signature-file");
> 	... read signature file ...
>   }
> 

That works until someone changes the default value.
But if they did that then some tests should fail.

I like the address comparision which avoids a string comparision.

> though it's a bit ugly that this code has to know what the default is.
> Having signature-file take precedence is OK with me, but it feels
> somewhat arbitrary to me from the user's perspective.
> 
> -Peff

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
