From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Add svnrdump
Date: Thu, 15 Jul 2010 14:01:43 +0200
Message-ID: <20100715120143.GE22574@debian>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
 <20100714153206.GH25630@jack.stsp.name>
 <20100714160149.GA7561@debian>
 <20100714172429.GC25861@ted.stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael B
X-From: git-owner@vger.kernel.org Thu Jul 15 14:00:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZN6j-0006el-T5
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 14:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095Ab0GOL77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 07:59:59 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51236 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758420Ab0GOL76 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 07:59:58 -0400
Received: by eya25 with SMTP id 25so133970eya.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8vOjPc8WPbnMyJU1InwGC8adg44gs9UDj73AXlpSBFo=;
        b=v2N4YxuwG3oyPN5sWxSTD+E8+hgvU+72+F4rK+YKHL//aqERVFxc+dPwuP5PREq8e6
         SLDmlyucBYXm9gvZZFqbkGR83gtccrj50+5ayRRWe86eltGN6z+qRvo4nN1dUJVSIe4F
         Ziz8pXyKREJf/PXqvBJJ3JVL2fJlmZhO6Wfzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FGDCCUlsXve0bATLsH+E7HZytgsEuhOm53E/i0H7RqudTJqC2xucG2RGXmL8mStjZl
         pmHss4RCF8yag2YXr5YpvE39mSOvTk0qQZGhLtkK5Gm/60Mnyge8ucFIRe5ogxhNU9Y3
         EoU681hOjdRSe93qqiSaI9Tr2ookiNV3WYcHc=
Received: by 10.213.29.8 with SMTP id o8mr13838339ebc.84.1279195196529;
        Thu, 15 Jul 2010 04:59:56 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id a48sm7558931eei.12.2010.07.15.04.59.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 04:59:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100714172429.GC25861@ted.stsp.name>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151076>

Hi Stefan,

Stefan Sperling writes:
> > This isn't in the dump-load-format spec document (atleast afaik), and
> > it's very hard to get this right (yes, I tried). Moreover, it's very
> > ungratifying to have a few extra newlines (reverse engineered from
> > `svnadmin dump`) printed at the end of 10+ hrs of work; yes, that's
> > what I estimate it'll take to fix this.
> 
> Well, it would be really nice to have.
> Details like this are time sinks, I know. But it pays off.
> You don't have to do it right away. We can file an issue so we don't
> forget about fixing it before 1.7 release.
> If necessary, feel free to adjust the output of svnadmin dump a little
> if that makes it easier for svnrdump to produce matching output.

I think the latter is certainly an option. We definitely need to fix
the dump-load-format spec to show everything.

> > gawk '$0 !~ "Prop-delta: true|Text-delta-base-|sha1|Text-copy-source-|^-$" && $0 ~ "^+|^-" { print; }'
> 
> Fine for testing. But I still think the end-result should look just
> like svnadmin dump, if possible. That would make testing even easier.

Right. We can use the same test suite and maintenance would become
infinitely easier.

> > > Please get rid of all global variables in svnrdump.c:
> > Will do. I'm waiting for commit access, because I don't want to make
> > un-versioned edits to the file that I cannot track or revert in
> > future.
> 
> What about using git until then? It does not matter which state you
> initially import into the Subversion repository. But well, whatever
> works for you is best.

Oh, I didn't think it would take this long for my account to get
activated. I'll consider using Git to stage for now because I don't
want to delay the response to your review.

-- Ram
