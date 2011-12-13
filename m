From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: Git blame only current branch
Date: Tue, 13 Dec 2011 07:37:22 +0530
Message-ID: <8739cpteat.fsf@gmail.com>
References: <e9e35956-a091-4143-8fd4-3516b54263a6@mail>
	<d615954f-bed8-482d-a2e3-e1e741d6dd23@mail>
	<20111212165542.GA4802@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Bash <bash@genarts.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 13 03:07:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaHmR-0006Z0-BW
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 03:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab1LMCH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 21:07:28 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32834 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab1LMCH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 21:07:27 -0500
Received: by iaeh11 with SMTP id h11so4023580iae.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 18:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LLi4EGhh2Vdt+joNApMdDKnuXsOt3T2pBN06Q9lwERw=;
        b=LE2CGR8RNCP4R9fgKUit5QmTOk/aKcRJm2zrlBCY5Bfcx2yrFjlmMI7oTBI5Wn6Z3g
         7W/X7ixYTZ+ZL+I+i2Cl1jO5cDHCPKU0ezt6dLRyrzXguSQnVLdDi0LlVh7LKKOKdp/a
         E+aonyuhcNf3e9eQ6VrAAXGnGHvUPar0W2umk=
Received: by 10.50.182.199 with SMTP id eg7mr17152344igc.57.1323742046968;
        Mon, 12 Dec 2011 18:07:26 -0800 (PST)
Received: from BALROG ([59.92.69.51])
        by mx.google.com with ESMTPS id 36sm57854076ibc.6.2011.12.12.18.07.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 18:07:26 -0800 (PST)
In-Reply-To: <20111212165542.GA4802@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 12 Dec 2011 11:55:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186996>

Jeff King <peff@peff.net> writes:

[snip]

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 80febbe..c19a8cd 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1191,6 +1191,8 @@ static int num_scapegoats(struct rev_info *revs, struct commit *commit)
>  {
>  	int cnt;
>  	struct commit_list *l = first_scapegoat(revs, commit);
> +	if (revs->first_parent_only)
> +		return l ? 1 : 0;
>  	for (cnt = 0; l; l = l->next)
>  		cnt++;
>  	return cnt;

I just spent 30s staring at this wondering why you needed to do 

    return 1 ? 1 : 0;

which always returns 1 anyway before I realized it was a lowercase L.

The code reads fine when there's no numeral 1 around but now it doesn't
read well.  I think refactoring

    struct commit_list *l

to 

    struct commit_list *lst

is justified.  Thoughts?

> -Peff

-- 
Cheers
~vijay

Gnus should be more complicated.
