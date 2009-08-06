From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: push: point to 'git pull' and 'git push --force' in
	case of non-fast forward
Date: Thu, 6 Aug 2009 23:16:10 +0200
Message-ID: <20090806211610.GB12924@vidovic>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr> <7v7hxgk8c9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 23:16:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZAJz-0003VO-Ax
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 23:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbZHFVQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 17:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756094AbZHFVQO
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 17:16:14 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:46659 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027AbZHFVQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 17:16:14 -0400
Received: by ewy10 with SMTP id 10so1126069ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=cBsfux/k3TMDLjXVuG4bThxMNIf1pAmLZafD+2ixvSM=;
        b=TSKfjbdMUb+SlARWRyEdA7s7wfgYUfjn+2gq3X7DhBFEMIaHQTZuKRdgJS+ENHjD1Y
         zgmOKvnrkZRAMfGMaaxZXY2ewKBk714O2m446dua71gFHlxI5/HN/G2sC8CuLevs36Ol
         wqnBBRJi/AFeTHJzbWRu55rzHSRVu6Xt0leds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XhA4XXVsK0cdnQ+z8gUqEKhT2WXfzNXoX/1CU0cfwYhbxhNEEmC5giNAIcqruVrHRO
         Ps1GvgMF7xOLLI9xKjIoe90R1wQukGnvjOVT2IghDE8uEwOSTy06f5YA44oP+nixI9mH
         Tmzyd+r75axx7XoCO+o+9us8F8i8RkT/WygO0=
Received: by 10.211.199.11 with SMTP id b11mr395562ebq.68.1249593373571;
        Thu, 06 Aug 2009 14:16:13 -0700 (PDT)
Received: from @ (91-164-149-117.rev.libertysurf.net [91.164.149.117])
        by mx.google.com with ESMTPS id 28sm1038012eyg.32.2009.08.06.14.16.11
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 14:16:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7hxgk8c9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125126>

The 06/08/09, Junio C Hamano wrote:

>  Documentation/git-push.txt |   75 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 75 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 2653388..c1ae82d 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -195,6 +195,81 @@ reason::
>  	refs, no explanation is needed. For a failed ref, the reason for
>  	failure is described.
>  
> +Note about fast-forwards
> +------------------------
> +
> +When an update changes a branch (or more in general, a ref) that used to
> +point at commit A to point at another commit B, it is called a
> +fast-forward update if and only if B is a descendant of A.
> +
> +In a fast-forward update from A to B, the set of commits that the original
> +commit A built on top of is a subset of the commits the new commit B
> +builds on top of.  Hence, it does not lose any history.
> +
> +In contrast, a non-fast-forward update will lose history.

I believe that this sentence a bit too much scaring for the beginner.
There are two kinds of update (push and pull). We loose history only
when pushing. I know this applies to Documentation/git-push.txt but out
of this context (and because we talk about pull near from here), I think
it would be clearer to say something like:

	In contrast, a non-fast-forward push will loose history.

>                                                             For example,
> +suppose you and somebody else started at the same commit X, and you built
> +a history leading to commit B while the other person built a history
> +leading to commit A.  The history looks like this:
> +
> +----------------
> +
> +      B
> +     /
> + ---X---A
> +
> +----------------

<...>

> +Alternatively, you can rebase your change between X and B on top of A,
> +with "git pull --rebase", and push the result back.  The rebase will
> +create a new commit D that builds the change between X and B on top of
> +A.
> +
> +----------------
> +
> +      B   D
> +     /   /
> + ---X---A
> +
> +----------------

Wouldn't "git pull --rebase" loose B? Shouldn't we have this

  ----------------
  
            D
           /
   ---X---A
  
  ----------------

instead?

-- 
Nicolas Sebrecht
