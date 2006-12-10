X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remove "[PATCH]" prefix from shortlog output
Date: Mon, 11 Dec 2006 00:35:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612110031480.1348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0612091954010.2630@xanadu.home>
 <Pine.LNX.4.63.0612102337090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <eli3vr$j6v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 23:35:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <eli3vr$j6v$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33962>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtYCu-0000Ss-UO for gcvg-git@gmane.org; Mon, 11 Dec
 2006 00:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762464AbWLJXfk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 18:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762538AbWLJXfk
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 18:35:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:37990 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1762464AbWLJXfk
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 18:35:40 -0500
Received: (qmail invoked by alias); 10 Dec 2006 23:35:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp020) with SMTP; 11 Dec 2006 00:35:38 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 11 Dec 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Sat, 9 Dec 2006, Nicolas Pitre wrote:
> > 
> >> This doesn't convey much information in the shortlog context.
> >> And the perl version did strip it as well.
> > 
> > From the current builtin-shortlog.c:128ff:
> > 
> >         if (!strncmp(oneline, "[PATCH", 6)) {
> >                 char *eob = strchr(oneline, ']');
> > 
> >                 if (eob) {
> >                         while (isspace(eob[1]) && eob[1] != '\n')
> >                                 eob++;
> >                         if (eob - oneline < onelinelen) {
> >                                 onelinelen -= eob - oneline;
> >                                 oneline = eob;
> >                         }
> >                 }
> >         }
> > 
> > It tries not only to strip "[PATCH]", but also "[PATCH 0/n]" and basically 
> > every prefix beginning with "[PATCH" and ending in "]". I do not remember 
> > if I really tested that code, but it should work.
> 
> What happens if you have "[PATCH" without closing "]"? Does it work (and
> doesn't crash)? Does it strip anything?

Use the source, Luke!

If "[PATCH" is there, but "]" is not, then eob will be NULL, and nothing 
happens.

Well, actually it is not completely true: the code searches for "]" in the 
_complete_ commit message (which _is_ terminated by '\0'). But only if it 
is found, _and_ it is in the first line, the substring is trimmed away.

Hth,
Dscho
