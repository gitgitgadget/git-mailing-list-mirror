X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Fri, 27 Oct 2006 10:45:11 -0700 (PDT)
Message-ID: <20061027174511.8539.qmail@web31810.mail.mud.yahoo.com>
References: <7vac3igjpd.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 27 Oct 2006 18:19:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Fh7D2yWJ8mxUiD2HyN/3038/xKBBpbUvxekwUeYNyIe7P7MdOuJ06hkZviTlyvaiI59R06c9n+mUOfuBaKJQgpQEPRQ2+GpIijKHb6THwNnlAuJoMMK/g0peljalx7QpRuYlmzgkWcUJYEvZh2wz/4VZZsZZqVMp5s8yIRbJsAI=  ;
X-YMail-OSG: bHTYcmIVM1nrneFtcG34gA.2QnnFRX_Qyr7f2mKL1d9bW97ATRtIw0yuEjoXIMsKx8yi32YWLCve4sHLPvpIguLOL.BM2tLncOV8x6m2wouaZEBByo7yG9iiWORwTD9MbF1.eDXo8Ew-
In-Reply-To: <7vac3igjpd.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30339>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdVle-0002Pz-GU for gcvg-git@gmane.org; Fri, 27 Oct
 2006 19:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752304AbWJ0RpO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 13:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbWJ0RpO
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 13:45:14 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:34730 "HELO
 web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1752304AbWJ0RpM (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006
 13:45:12 -0400
Received: (qmail 8541 invoked by uid 60001); 27 Oct 2006 17:45:11 -0000
Received: from [71.80.233.118] by web31810.mail.mud.yahoo.com via HTTP; Fri,
 27 Oct 2006 10:45:11 PDT
To: Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

--- Junio C Hamano <junkio@cox.net> wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> > Alex Riesen wrote:
> >>>> >Which leads us to the always interesting, fun and exciting:
> >>>> >
> >>>> >    git ls-tree -r HEAD | git update-index --index-info
> >>>> >
> >>>> >which will undo everything except 'git add' from the index, as
> >>>> >ls-tree -r is listing everything in the last commit.
> >>>> >
> >>>>
> >>>> ... and also shows The Power of the Pipe, which Daniel@google was
> >>>> missing in recent versions of git. ;-)
> >>>>
> >>>> Btw, this is most definitely not a documented thing and requires a bit
> >>>> of core git knowledge, so perhaps the "shell-scripts were good for
> >>>> hackers to learn what to pipe where" really *is* a very important point.
> >>>
> >>> Agreed.
> >>
> >> Still, it is very impressive, it is supported (and will be
> >> supported, I assume),
> >> and as such - worth mentioning at least in these examples everyone keeps
> >> dreaming about. Until that happened, why not mention that the output
> >> of "git ls-tree" is compatible with --index-info of "update-index"?
> >
> > +1. Me likes, although I would amend the command-line that Shawn sent
> > and describe what it does. Examples > descriptions everywhere else in
> > the git docs, so it would be concise to do so.
> 
> I do not like the one that does the whole tree that much.  I
> would think "git-read-tree -m HEAD" would be simpler and more

Yep, that's what I use... "git-undo-update-index" is
      #!/bin/sh
      git-read-tree -m -i HEAD

   Luben


> efficient if you are reverting the whole tree.
> 
> On the other hand, I designed --index-info to be compatible with
> ls-tree output (it is not an accident, it was designed).  In
> 
> 	git ls-tree HEAD frotz | git update-index --index-info
> 
> "frotz" part does not have to be the exact path but can be a
> directory name.  It means "revert everything in this directory".
> 
> This is quite heavy-handed and you would probably want to run
> update-index --refresh afterwards.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
