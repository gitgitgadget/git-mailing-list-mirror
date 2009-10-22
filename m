From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git-merge: imply --no-ff when --no-commit is given
Date: Thu, 22 Oct 2009 08:35:02 +0200
Message-ID: <20091022063502.GA8311@localhost>
References: <200910201947.50423.trast@student.ethz.ch> <alpine.LNX.2.00.0910201912390.14365@iabervon.org> <20091021030608.GA18997@atjola.homenet> <7vk4ypb71j.fsf@alter.siamese.dyndns.org> <20091021172123.GB27495@localhost> <7v3a5c2zrr.fsf@alter.siamese.dyndns.org> <7viqe81ktx.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 08:35:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0rGS-000814-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 08:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbZJVGfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 02:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbZJVGfA
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 02:35:00 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:46676 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbZJVGfA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 02:35:00 -0400
Received: by fxm18 with SMTP id 18so8750459fxm.37
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 23:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=nCZUgtLeR7GRdKq65HwSZBaG038aoQcKnt931MnVw6E=;
        b=hCJVqoaoz73sqxIdbQL3IRBiyx1ubl+GOtioSNbCROKTCd6wOrdI8W1TC0SdLnQ+3j
         S6ZqkL+8aiIt8I1+0CC1IBSgJrhAOVHMUTimLSk7IFJTr4PqFRD59eX/hCdXi+2m1mqU
         1JFe6mi+CdyNJ0cYiY/T+dJrhoe/F5XHVxphc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=W1m6BEXH+B5VTUjjdcXv9XDBs1iBLlwYPTNfuy0KuhPkTZh0F7MryGtiVNTmgsitG4
         jqKz8A5Gwx8bL04o2v+RLzngHqw+REJSuN3y5jQzoCUF52fRM36SmOKoYNQVUZbUY13Q
         1Us73nj3T1PqrqmlT/CGY5ETtokfgw1L29Z4s=
Received: by 10.102.235.20 with SMTP id i20mr3802498muh.38.1256193303888;
        Wed, 21 Oct 2009 23:35:03 -0700 (PDT)
Received: from darc.lan (p549A3470.dip.t-dialin.net [84.154.52.112])
        by mx.google.com with ESMTPS id j10sm2060503mue.6.2009.10.21.23.35.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 23:35:02 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N0rGI-0002Vx-M3; Thu, 22 Oct 2009 08:35:02 +0200
Content-Disposition: inline
In-Reply-To: <7viqe81ktx.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130996>

On Wed, Oct 21, 2009 at 02:46:50PM -0700, Junio C Hamano wrote:

> Make --no-commit imply --no-ff; --no-commit is a request by the user to
> tweak the resulting merge and it is clear indication that the user wants
> to have a merge, even if it is an extra one, to futz with.

I think --no-commit makes sense in case of a real merge, because a 3-way
diff can help fix any semantic errors. Apart from that, one can simply do a
regular merge and --amend it later.

In case of a fast-forward merge, there is not going to be a 3-way diff
anyways. So it's pointless to use --no-commit in this case.

I'm therefore in favor of your other proposal, even though it may be
confusing to users who don't understand the difference between n-way and
fast-forward merge. But that's something they will have to learn.

And --no-ff can always be used explicitly.

Clemens
