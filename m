From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 02/43] refs: make repack_without_refs and is_branch
 public
Date: Mon, 05 Oct 2015 16:26:43 -0400
Organization: Twitter
Message-ID: <1444076803.5158.13.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-3-git-send-email-dturner@twopensource.com>
	 <5611FDD9.1050405@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:26:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCLS-0004wL-9H
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbbJEU0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:26:46 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34640 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbbJEU0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:26:45 -0400
Received: by qgez77 with SMTP id z77so160953890qge.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 13:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=5dUvUmyrmu00gxxeLqkLkKbfXwqLKZizarcyMF5/QGo=;
        b=NBfCt0NMj38OBU0wNPGLEdqvkSCAG1Z7MYGRmNYphIF0ehak3xoEn1u+ruFJ050JvR
         VXtZRtf429VTS3zId1D11Mi0+Ob7CnzbYwag9tx+kpLgjR6TYswzL6s1l9ZtMGT0zCXt
         lNdhDPxR17H6G6ecut8gzluysRxsz/7yjiAChv6Y0nJix0tQZHZX6cG9BGoaUFvag9Nu
         V5E3J2QCWVOuD/7fPOOTJZBsj1/RuEueORKMFAYBgrEMxsQer8rsYXL0sYzxMu84rmo3
         rcohZObrm7k61da7kAG+g6BTK0UIUyP5SAtm4BFs7RDstU3vIYNAdP/+vgUf/6/wOqeg
         rb4A==
X-Gm-Message-State: ALoCoQlL7eTdzed0HiiZzMKakBHXGLOSuRG/bBkcWIe/zp0bD/G0kqCfJNmN6IS61EGT0EUjIC5W
X-Received: by 10.140.98.54 with SMTP id n51mr42096177qge.75.1444076805153;
        Mon, 05 Oct 2015 13:26:45 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id 138sm4193541qhw.27.2015.10.05.13.26.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 13:26:44 -0700 (PDT)
In-Reply-To: <5611FDD9.1050405@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279079>

On Mon, 2015-10-05 at 06:34 +0200, Michael Haggerty wrote:
> On 09/29/2015 12:01 AM, David Turner wrote:
> > Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  refs.c |  9 +--------
> >  refs.h | 13 +++++++++++++
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> > 
> > diff --git a/refs.c b/refs.c
> > index ce551e9..2741cc5 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2826,14 +2826,7 @@ int pack_refs(unsigned int flags)
> >  	return 0;
> >  }
> >  
> > -/*
> > - * Rewrite the packed-refs file, omitting any refs listed in
> > - * 'refnames'. On error, leave packed-refs unchanged, write an error
> > - * message to 'err', and return a nonzero value.
> > - *
> > - * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
> > - */
> > -static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
> > +int repack_without_refs(struct string_list *refnames, struct strbuf *err)
> 
> I looked for the corresponding change to remove `static` from
> is_branch(). Apparently that function already had external linkage, even
> though it was not listed in the header file. As a convenience to readers
> you might note that peculiarity in the commit message.

Will fix, thnaks.
