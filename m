From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git commit generation numbers
Date: Fri, 22 Jul 2011 20:34:19 +0200
Message-ID: <201107222034.20510.jnareb@gmail.com>
References: <20110721202722.3765.qmail@science.horizon.com> <alpine.LFD.2.00.1107220907370.1762@xanadu.home> <alpine.DEB.2.02.1107221102180.6496@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Anthony Van de Gejuchte <anthonyvdgent@gmail.com>,
	git@vger.kernel.org, Phil Hord <hordp@cisco.com>,
	Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Jul 22 20:36:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkKaQ-0001q6-Iv
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 20:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab1GVSg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 14:36:29 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:40096 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695Ab1GVSg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 14:36:29 -0400
Received: by fxd18 with SMTP id 18so5610648fxd.11
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=EzAWl0Z4Yvi+g1ONvYTlOIBnaq9u7bcsIftb4l8WMmg=;
        b=pnrPFg5/bXzVd89Z4Y6gKhz8Utc9Wq24LD7W7C0++gjtPOaKIsTm2RnAtqY96AWk6A
         1FEQMjckCkikNxjQGRSfr0xV/zk8/zVvVv2+gpfQwSRKLb/5RE31jIyOU9z5lFCAOOSj
         3A4dFMD8QxRGVsMUVVLKB02sTySIEYA2nFCxw=
Received: by 10.223.59.17 with SMTP id j17mr2455601fah.120.1311359656750;
        Fri, 22 Jul 2011 11:34:16 -0700 (PDT)
Received: from [192.168.1.13] (abvt94.neoplus.adsl.tpnet.pl [83.8.217.94])
        by mx.google.com with ESMTPS id 12sm1698785fad.40.2011.07.22.11.34.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jul 2011 11:34:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.2.02.1107221102180.6496@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177654>

On Fri, 22 Jul 2011, David Lang <david@lang.hm> wrote:
> On Fri, 22 Jul 2011, Nicolas Pitre wrote:
> > On Fri, 22 Jul 2011, Jakub Narebski wrote:
> >
> > > BTW. with storing generation number in commit header there is a problem
> > > what would old version of git, one which does not understand said header,
> > > do during rebase.  Would it strip unknown headers, or would it copy
> > > generation number verbatim - which means that it can be incorrect?
> >
> > They would indeed be copied verbatim and become incorrect.
> 
> how would they become incorrect?

Let's assume that the following history was created with new git, one
that correcly adds generation number header to commits:


  A(1)---B(2)---C(3)---D(4)---E(5)       <-- master
          \
           \----x(3)---y(4)---z(5)       <-- foo

The numbers are generation numbers in commit object.

Let's assume that this repository is fetched into repository instance
that is managed by older git, one that doesn't understand generation
header.

Then, if we do

  [old]$ git rebase master foo

and if old git _copies_ generation number header _verbatim_, we would
get:

  A(1)---B(2)---C(3)---D(4)---E(5)                         <-- master
                               \
                                \---x'(3)--y'(4)--z'(5)    <-- foo

Those generation numbers are *incorrect*; they should be:

  A(1)---B(2)---C(3)---D(4)---E(5)                         <-- master
                               \
                                \---x'(6)--y'(7)--z'(8)    <-- foo


That is IF unknown headers are copied verbatim during rebase.  For
"encoding" header this is a good thing, for "generation" it isn't.

-- 
Jakub Narebski
Poland
