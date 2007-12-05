From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Try harder in parse_tag; perhaps it was given ambiguous name
Date: Wed, 5 Dec 2007 11:13:39 +0100
Message-ID: <200712051113.40654.jnareb@gmail.com>
References: <200712010245.29204.jnareb@gmail.com> <200712010247.25107.jnareb@gmail.com> <7v3auh1v75.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Guillaume Seguin <guillaume@segu.in>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 11:14:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzrGc-0002MA-9Y
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 11:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbXLEKNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 05:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbXLEKNu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 05:13:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:62607 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbXLEKNt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 05:13:49 -0500
Received: by nf-out-0910.google.com with SMTP id g13so3106263nfb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 02:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=xXWkf4XIb0sjqdqgZ93Ky2LbMEvaU4MNiBnKC7xRcUs=;
        b=UImZl7KyVBQCfbUPDzjf2BuP4A2H9tVouJJLYLrXzETqEHCQuZucjn4e7aol2QtyFVOFu3Rjj95WmL52Eicvw5GRmQfi9R6/HZ7ZGCoyKIJ6XRBoHtRb1ThX4B/IQrhLrWVju4D9w8I3CeZfIK7InN3fWkfqZIugaxNIsP7O/eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qF56Qd/ik5qL7eEKEfLmPs7Ze/TKE+DEZy9KA6/yRvF3cHHQzT+QcWLKBuoHcb37SHji9miZM1hNgThfqpH1h/lDkdX0mjOP05OF5/nL5W4dzSucSIbjed9z5RjNp0eYln3NKCPPOnm+pfnKGVl8rwcgsIgpeQ2PuODxnYuG5gU=
Received: by 10.86.74.15 with SMTP id w15mr316383fga.1196849627576;
        Wed, 05 Dec 2007 02:13:47 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.215.161])
        by mx.google.com with ESMTPS id l12sm7234942fgb.2007.12.05.02.13.43
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 02:13:45 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v3auh1v75.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67131>

On Wed, 5 Dec 2007, Junio C Hamano wrote:

> I have these two patches still in my mailbox, unapplied:
> 
> [PATCH] gitweb: disambiguate heads and tags withs the same name
> [PATCH] gitweb: Try harder in parse_tag; perhaps it was given ambiguous name

Actually second should be [PATCH/RFC] as it penalizes the "not found"
case (extra check 'if really not found').

First patch, which is modified version of Guillaume Seguin patch solves
problem that links in gitweb does lead to correct 'tag' view, while the
second one solves the problem from the other side: instead of ensuring
that links in gitweb are unambiguous it tries to resolve ambiguity.


The problem is caused by the fact that git _always_ prefer heads (head
refs) to tags (tag refs), even when it is clear
  $ git cat-file tags ambiguous-ref
that we want a tag. So alternate solution would be to correct
git-cat-file.
 

> I am wondering if they should be part of 1.5.4.  They look Ok but it is
> not very easy to pick up what the real breakage it is trying to fix from
> Perl gibberish.
> 
> Can we have tests (not just "we do not spit out anything to stderr") for
> gitweb so that each patch can demonstrate the existing breakage, to make
> judging easier?

True, current way of testing gitweb does not allow for test which would
detect breakage noticed by Guillaume.

It would be quite easy I think to add checking if gitweb returns
expected HTTP return code (HTTP status). So what is the portable way
to check if first line of some output matches given regexp (given fixed
string)?

-- 
Jakub Narebski
Poland
