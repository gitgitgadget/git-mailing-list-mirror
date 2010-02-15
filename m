From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v3 3/3] git-push: make git push --dry-run --porcelain
 exit with status 0 even if updates will be rejected
Date: Mon, 15 Feb 2010 12:40:13 -0500
Message-ID: <20100215174013.GA12761@cthulhu>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <032264a40d15cb9f4a86885947ffa23a603bfb0e.1265661033.git.larry@elder-gods.org>
 <7vtytqyrlk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 18:40:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh4vm-0003jH-B0
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 18:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930Ab0BORkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 12:40:15 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:33717 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab0BORkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 12:40:14 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 83FC3822226; Mon, 15 Feb 2010 12:40:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vtytqyrlk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140019>

* Junio C Hamano (gitster@pobox.com) [100209 17:25]:
> Larry D'Anna <larry@elder-gods.org> writes:
> 
> > @@ -1052,7 +1053,7 @@ int transport_push(struct transport *transport,
> >  			flags & TRANSPORT_PUSH_FORCE);
> >  
> >  		ret = transport->push_refs(transport, remote_refs, flags);
> > -		err = push_had_errors(remote_refs);
> > +		err = (pretend && porcelain) ? 0 : push_had_errors(remote_refs);
> 
> Hmph, you are doing (rewritten in an easier to follow format)
> 
> 	if (--dry-run && --porcelain)
> 		err = 0;
> 	else
> 		err = push_add_errors(remote_refs);
> 
> here, which I think changes the semantics of what follows immediately
> after this hunk, namely:
> 
> 	if (!quiet || err)
> 		print_push_status(transport->url, remote_refs,
> 				verbose | porcelain, porcelain,
> 				nonfastforward);
> 
> Earlier, the logic said "even if you asked for --quiet, we would report if
> there is an error" but now you are changing the rule to "under --dry-run
> and --porcelain, --quiet means don't ever report the status, even when
> there are errors".
> 
> I don't necessarily think it is a bad change, but in any case the semantic
> change is worth documenting.

Which version of the --quiet behavior do you want for the next version of this
series?  My feeling is that "even if you asked for --quiet, we would report if
there is an error" is the best policy, even under --dry-run --porcelain.

         --larry
