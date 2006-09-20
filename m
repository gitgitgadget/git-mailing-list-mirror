From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Wed, 20 Sep 2006 19:45:48 -0400
Message-ID: <20060920234548.GA20461@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de> <7vfyemf9ah.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 21 01:46:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQBlK-00081j-Dk
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 01:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWITXpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 19:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWITXpv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 19:45:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:5028 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750740AbWITXpu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 19:45:50 -0400
Received: (qmail 21802 invoked from network); 20 Sep 2006 19:44:58 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 20 Sep 2006 19:44:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2006 19:45:48 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27436>

On Thu, Sep 21, 2006 at 01:07:54AM +0200, Johannes Schindelin wrote:

> +	if (deny_non_fast_forwards && !is_null_sha1(old_sha1)) {
> +		struct commit *old_commit, *new_commit;
> +		struct commit_list *bases;
> +
> +		old_commit = (struct commit *)parse_object(old_sha1);
> +		new_commit = (struct commit *)parse_object(new_sha1);
> +		for (bases = get_merge_bases(old_commit, new_commit, 1);
> +				bases; bases = bases->next)
> +			if (!hashcmp(old_sha1, bases->item->object.sha1))
> +				break;
> +		if (!bases)
> +			return error("denying non-fast forward;"
> +					" you should pull first");
> +	}

Memory leak on 'bases'. It shouldn't matter much because the program is
short-lived, but I couldn't remember if we have a policy on such things
with increasing lib-ification.

-Peff
