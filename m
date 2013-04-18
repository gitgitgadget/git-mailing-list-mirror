From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/6] transport-helper: clarify pushing without refspecs
Date: Thu, 18 Apr 2013 19:35:40 +0100
Message-ID: <20130418183540.GB2278@serenity.lan>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
 <1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
 <20130418101133.GW2278@serenity.lan>
 <7v38un7nnp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 20:36:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UStgf-00085O-0W
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 20:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936364Ab3DRSf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 14:35:56 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:39900 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab3DRSfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 14:35:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 008F360650A;
	Thu, 18 Apr 2013 19:35:55 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2PjzMJOkAB1y; Thu, 18 Apr 2013 19:35:54 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 6078D6064CA;
	Thu, 18 Apr 2013 19:35:54 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 50A12161E413;
	Thu, 18 Apr 2013 19:35:54 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YF6Yw+p01Zq9; Thu, 18 Apr 2013 19:35:53 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id EC528161E405;
	Thu, 18 Apr 2013 19:35:42 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v38un7nnp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221681>

On Thu, Apr 18, 2013 at 10:29:30AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> >> diff --git a/transport-helper.c b/transport-helper.c
> >> index cea787c..4d98567 100644
> >> --- a/transport-helper.c
> >> +++ b/transport-helper.c
> >> @@ -785,6 +785,9 @@ static int push_refs_with_export(struct transport *transport,
> >>  	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
> >>  	struct strbuf buf = STRBUF_INIT;
> >>  
> >> +	if (!data->refspecs)
> >> +		die("remote-helper doesn't support push; refspec needed");
> >
> > I think the "refspec needed" text is likely to be confusing if an
> > end-user ever sees this message.  I'm not sure how we can provide useful
> > feedback for both remote helper authors and end-users though.
> 
> This "refspecs" only come via the helper and not directly from the
> end user, no?
> 
> If that is the case, I do not think "confusing" is much of an issue.
> Not _("localizing") is also the right thing to do.  We may want to
> say "BUG: " at front to clarify it is not the end-user's fault, but
> a problem they may want to report.  If we at this point know what
> helper attempted export without giving refspecs, it may help to show
> it here, so that developers will know with what helper the user
> had problems with.

I like this idea.  Perhaps we should say "Bug in remote helper; refspec
needed with export", so that it clearly indicates to both end-users and
remote helper authors that the error is in the remote helper.
