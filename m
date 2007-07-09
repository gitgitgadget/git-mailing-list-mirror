From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH v2] Make fetch-pack a builtin with an internal API
Date: Mon, 9 Jul 2007 16:28:12 +0100
Message-ID: <200707091628.14377.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0707090104120.6977@iabervon.org> <200707091416.39949.andyparkins@gmail.com> <20070709144030.GE16032@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 17:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7vA6-0003P8-SB
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 17:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbXGIP2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 11:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbXGIP2Z
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 11:28:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:10132 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbXGIP2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 11:28:24 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1151307ugf
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 08:28:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ryDPgtitUet/jPRVklynvQAJ+FWG/Sx2zostZ4Oh3lPy/oxvID2aAhZ+hfBwkltMnCg/stmSiFEfo5Ll2eH/mKn2jgSUpC+KZZ/h23GArRF/t7y2MLT5hpFRG5rd6gnr/fUlhIcT9gbH62yF7cIEupX7sdAiQe40hvLI0fgkL1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fRdM0/RGEhDIPMtD4vBuMWoiS5KTgr1wt92s83YFZoEGBmd43SPHB6+Ij7MHr5i4qIKk98nMDxhoQO9KHyYjxIbmHtsnRDx3ybBq8wl+nj3SpWVS7KpiH8Tg66pUhZNet1VN3wWLRXfPM/WxqSZwa9r+L1UsG3tlVh8Wmm6eutA=
Received: by 10.82.108.9 with SMTP id g9mr8410713buc.1183994899535;
        Mon, 09 Jul 2007 08:28:19 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c22sm31848692ika.2007.07.09.08.28.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 Jul 2007 08:28:18 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070709144030.GE16032@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52001>

On Monday 2007 July 09, Theodore Tso wrote:
> > "All identifiers beginning with an underscore are reserved for ordinary
> > identifiers (functions, variables, typedefs, enumeration constants) with
> > file
> > scope."

> I think the above does agree with what I said.  It says that you can
> use functions, variables, typdefs, enumeration constants (not just
> labels or structure members) WITH FILE SCOPE.  I.e., so long as it
> doesn't leak across a .o linkage.  So one .o file can use a static

I'm reading it as meaning they are reserved at file scope; not that you can 
use them at file scope.

> _my_strdup, and another .o file can use a static _my_strdup, and they
> don't have to worry about multiply defined function conflicts, since
> they are static functions with file or smaller scoping.

Erm, but we're not talking about your own .o files we're talking about 
conflicting with the library; what you say would be true for any identifier.  
We have no way of guaranteeing that _my_strdup() isn't defined by one of the 
standard library headers that have been included.  The standard header is 
entitled to use underscore identifiers because they have been reserved at 
file scope.

Reading a little further into the FAQ you posted, I found the following in the 
list of exceptions:

"You may use identifiers consisting of an underscore followed by a digit or 
lower case letter for labels and structure/union members." 
and
"You may use identifiers consisting of an underscore followed by a digit or 
lower case letter at function, block, or prototype scope."

I'm more sure now - you can't use underscore identifiers at file scope.

Regardless, we're just splitting hairs now.  We seem to both agree that it's 
easiest just to outright not use underscore-prefixed identifiers; so I'm 
happy. :-)




Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
