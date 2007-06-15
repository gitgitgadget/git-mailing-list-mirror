From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-send-pack SIGSEGV..
Date: Fri, 15 Jun 2007 09:24:18 +0200
Message-ID: <81b0412b0706150024m6a3c4d0bx866e1b25e770d299@mail.gmail.com>
References: <alpine.LFD.0.98.0706142124380.14121@woody.linux-foundation.org>
	 <7vvedp935y.fsf@assigned-by-dhcp.pobox.com>
	 <7vr6od92nj.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 09:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz6AW-0003Bv-U4
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 09:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbXFOHYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 03:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbXFOHYW
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 03:24:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:29187 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbXFOHYV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 03:24:21 -0400
Received: by wr-out-0506.google.com with SMTP id 76so719842wra
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 00:24:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q8x40mjO0P2t+QKWbrZV8pwEhYLHE408FrItBFhOIbJT6bvdJuSpFF/zsx8YJOTEDnqvcVtdcqxQcPrQC9qfHR+R8VZ5t5n7XAyQACMWOK6lbhVAWdwBukVI+NrEPBfz8VpamitXWQ9B7VHdbgqBfmzeLO61ii+KTt56llDyPew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qgJwFVZmWO2fMqW+AK4Ap9eWbHwMCoEEddrceZCXEaXOFKHyTLWHbb2jHhup6pK702+A0EtI9PyxWCfaI/OboH90e9Buuyn1eL1lXVsw6/Dsyv9LQq4tODtC1lmDMtsIjaQ56eNzWH6vRFMY2Po5rurzRX1Op4zXKOHV3MSjYkg=
Received: by 10.78.193.5 with SMTP id q5mr1096388huf.1181892258859;
        Fri, 15 Jun 2007 00:24:18 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Fri, 15 Jun 2007 00:24:18 -0700 (PDT)
In-Reply-To: <7vr6od92nj.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50251>

On 6/15/07, Junio C Hamano <gitster@pobox.com> wrote:
> --- a/remote.c
> +++ b/remote.c
> @@ -252,6 +252,8 @@ static struct refspec *parse_ref_spec
>                         ep = gp;
>                 }
>                 rs[i].src = xstrndup(sp, ep - sp);
> +               if (rs[i].pattern && !rs[i].dst)
> +                       rs[i].dst = xstrdup(rs[i].src);

It may be possible to just reuse rs[i].src - there is no deallocation
of refspecs anywhere nor are src or dst detached from refspec
(which may be bad, but probably is covered in libification effort).
