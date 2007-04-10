From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 18:50:00 +0200
Message-ID: <81b0412b0704100950s32645423r439d04197ee8cd78@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
	 <200704101828.37453.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 02:37:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbJXx-0001ju-GV
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 18:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031126AbXDJQuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 12:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031128AbXDJQuE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 12:50:04 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:13134 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031126AbXDJQuC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 12:50:02 -0400
Received: by an-out-0708.google.com with SMTP id b33so2017729ana
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 09:50:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PE9YnZfQB/fawHlfHw3FtTDDvO2Zbc9lKMYJN+yRp7eQoo4ncovcAeqMBKr2vPOaT65Q8X6Ae40Fw+k3WZQcWJBN//dGyZv2nUXZJv0jA/Xg0AbnTA7S0YSDRRnhAj7kxLL2JptkSMruLxLffth5N4d9wFwUAmRiA46kLCqpF14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NkJ05ySxpo4e63cGGuqrHrpnpo6nctHrOWtkGukn3TlFOil2jD+CLmEQ14KlCLTW0K3CPCCqSK3tVg4ZQX1++z9sxIqeuGyag3ixQSCPwRMhc4PyhqqH8pyaS8aEbcHk2wfEzweM8+J8beMuGOqmgP+aQYD3tza8OmupMIXyyAk=
Received: by 10.100.130.8 with SMTP id c8mr5034347and.1176223801126;
        Tue, 10 Apr 2007 09:50:01 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Tue, 10 Apr 2007 09:50:00 -0700 (PDT)
In-Reply-To: <200704101828.37453.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44156>

On 4/10/07, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Tuesday 10 April 2007, Linus Torvalds wrote:
> > ...
> > +     if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
> > +             return 0;
> > +     return hashcmp(sha1, ce->sha1);
>
> So this does mean that the SHA1 of a gitlink entry corresponds
> to the commit in the subproject?

Right.

> I wonder if it is not useful to be able to add some attribute(s)
> to a gitlink, i.e. first reference a gitlink object in the superproject,
> which then references the submodule commit, and also holds some
> further attributes. These attributes can not be put into the subproject,
> as it should be independent.

These attributes can be put into a file in superproject tree and
checked in at the same as the gitlink. No real need for introducing
another object type (right now there is no gitlink object type, just
an entry in tree with special mode).
