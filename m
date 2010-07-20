From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH 2/2] Add test for git clean -e.
Date: Tue, 20 Jul 2010 19:35:54 -0400
Message-ID: <20100720233554.GA2141@localhost.localdomain>
References: <cover.1279654370.git.jaredhance@gmail.com>
 <b8f95cd841124e24b9774c301ac63e803da325de.1279654370.git.jaredhance@gmail.com>
 <7vmxtllwoi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 01:36:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObMM2-0007qO-DE
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 01:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889Ab0GTXgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 19:36:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65229 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932872Ab0GTXf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 19:35:59 -0400
Received: by vws14 with SMTP id 14so902227vws.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 16:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DTyCZzPi6GktFMQlx7P79k7UrNv9JbHMpyn8N+l6qOE=;
        b=hIgYQ2nNwBX4FGsagFYOKQzcVmMxRKQGxKqj2FSn9iGdkAE6e0XKIj5GLb4akvwuJv
         WRxpT6g1GEvJzOmot9Xocmvgjrt2HkWjMW+LAX17+nPt3Y/FFOTU2C/FJxUzG5z++6Ju
         yic1oDffYmx4d/rnzpp5rqxcAsbBfgST/SiBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RJCYXTkawfi1A9lyLL5aCtK2kRYRbAUGlti/G3xXQ1ppgKfWSdPtFwRq9T5/gOow1p
         597r32Yb26t4xw1Pgigf6g3UhR1fID0NEZSjsKuHm1Xt4IE39Ht5ch+C8mvxBDP3tGai
         9+RjRr1mLMk67Vq7al00C/kEQzkyVJkX0rPxQ=
Received: by 10.224.80.210 with SMTP id u18mr644976qak.325.1279668958448;
        Tue, 20 Jul 2010 16:35:58 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id i26sm28601209qcm.31.2010.07.20.16.35.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 16:35:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmxtllwoi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151375>

On Tue, Jul 20, 2010 at 01:34:21PM -0700, Junio C Hamano wrote:
> This is a good start but it doesn't seem to test possible interactions
> with entries in .gitignore file(s) in the working tree.  Do we care?

Honestly, I'm not sure that we do care.

> 
> What should happen when a path "path":
> 
>  (1) is marked to be ignored in .gitignore and -e "path" is also given;

It is excluded.

>  (2) is marked not to be ignored (i.e. "!path") in .gitignore but -e
>     "path" is given;

I think it would be good for "!path" to cause -e path to have no
effect because of globbing issues.

Currently, -e works as normal.

>  (3) is marked to be ignored in .gitignore but -e "!path" is given;

Again, I'm not sure and am definately open to debate here. Personally,
I think that -e "!path" is completely abusing the use of -e, because
it is using -e to NOT exclude something.

Currently, -e has no effect.

>  (4) is marked not to be ignored in .gitignore and -e "!path" is also
>      given;

No effect happens. Again, this is abuse of -e in my opinion, as its
goal to allow one to do a clean and save one or two files.

>  (5) perhaps other combinations like "!path" in a/.gitignore, and -e "a/path"
>      from the command line.

Judging by (2), -e will work as normal.
