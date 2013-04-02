From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] merge: a random object may not necssarily be a commit
Date: Tue, 2 Apr 2013 11:03:44 -0400
Message-ID: <20130402150343.GA18642@sigill.intra.peff.net>
References: <7v7gl3jmx0.fsf_-_@alter.siamese.dyndns.org>
 <1364846239-8802-1-git-send-email-gitster@pobox.com>
 <1364846239-8802-2-git-send-email-gitster@pobox.com>
 <20130402053004.GC22089@sigill.intra.peff.net>
 <7vk3olgemi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Yann Droneaud <ydroneaud@opteya.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 17:04:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN2l5-0002dS-Du
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 17:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589Ab3DBPDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 11:03:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52199 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932122Ab3DBPDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 11:03:48 -0400
Received: (qmail 10207 invoked by uid 107); 2 Apr 2013 15:05:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 11:05:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 11:03:44 -0400
Content-Disposition: inline
In-Reply-To: <7vk3olgemi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219781>

On Tue, Apr 02, 2013 at 08:02:13AM -0700, Junio C Hamano wrote:

> >> +	if (remote_head->util) {
> >> +		struct merge_remote_desc *desc;
> >> +		desc = merge_remote_util(remote_head);
> >> +		if (desc && desc->obj && desc->obj->type == OBJ_TAG) {
> >> +			strbuf_addf(msg, "%s\t\t%s '%s'\n",
> >> +				    sha1_to_hex(desc->obj->sha1),
> >> +				    typename(desc->obj->type),
> >> +				    remote);
> >> +			goto cleanup;
> >> +		}
> >> +	}
> >> +
> >>  	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
> >>  		sha1_to_hex(remote_head->object.sha1), remote);
> >
> > I guess there is no other object type besides OBJ_TAG and OBJ_COMMIT
> > that would yield something we could merge, but it feels weird that you
> > check only for OBJ_TAG here, and otherwise still say "commit". Would the
> > intent be more clear if it just said:
> >
> >   if (desc && desc->obj && desc->obj->type != OBJ_COMMIT) {
> >           ...
> >
> > ?
> 
> I suspect not.
> 
> The point of the added code is that it knows we want to special case
> merging a tag object, and it wants to keep any other case behaving
> the same as before.

Ah. I read it as "if we have a random object, we do not want to just say
"commit X", because it is not a commit.

-Peff
