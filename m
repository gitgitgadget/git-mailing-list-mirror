From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] reset: accept "git reset <removed file>"
Date: Mon, 18 Oct 2010 19:23:49 -0500
Message-ID: <20101019002349.GB9841@burratino>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <20101018211522.GA7655@burratino>
 <20101018224840.GA9729@burratino>
 <7viq0z2gxj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 02:27:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P803B-0004aE-Tp
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 02:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649Ab0JSA12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 20:27:28 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48383 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809Ab0JSA11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 20:27:27 -0400
Received: by qyk9 with SMTP id 9so278889qyk.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 17:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JTCPKk0lLD+t61yGxM6TlGAb+xpnc45gDT34AwvwvRA=;
        b=QkX1AAY7D4R9tqxdA3uErmNGItv7JwsJuICeuV4QV2WWtYMdZ9GdOLe492bzohsw8Y
         5/bd55RzohTLUgHs93ypM6MkAQH5W1pd3Rgo55nrIuGnzGessfBjYD0F4+xEM1Nt/2Ou
         GUwpACxQjx3jlQBRkPdhbJVO4fQK0JdgYs2RE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bE19yq1/85suDiHagkscPC//YwdnBLmNRk2rOTcc1iB7fOjgolhj+A3JPHoCNYY0dP
         15BlYLkrmyi10h/S9SvgaeNgG6QajO5CRndZ4vVwmI8eH2rcbavkqJzO88AG9EEbwynD
         iVo2o8gowCa0PYxP1QHmHKTs3l0zeWPyx20/s=
Received: by 10.229.229.194 with SMTP id jj2mr4472766qcb.269.1287448047273;
        Mon, 18 Oct 2010 17:27:27 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id t35sm11359852qco.18.2010.10.18.17.27.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 17:27:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7viq0z2gxj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159299>

Junio C Hamano wrote:

> Makes me wonder
>
>  - if we can/want to have a logic like this inside verify_filename();

Yes, I think so.  I was worried that this would be confusing for some
command that looks to the worktree, like git grep without --cached,
but I suspect that worry was unfounded.

The one case I am worried about is "git rev-parse".  What is
"git rev-parse <path>" supposed to be used for?

>  - if we need a corresponding logic in either the previous else/if cascade
>    that calls verify_non_filename(), or in verify_non_filename() itself.

Yes.

Is it safe to load the index so early?  I can imagine a person trying
"git reset" to recover from a corrupted index; are we regressing in
that respect and how would one check for it?
