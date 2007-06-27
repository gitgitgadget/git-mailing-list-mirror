From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] detect dup failure
Date: Wed, 27 Jun 2007 14:48:52 +0200
Message-ID: <81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com>
References: <87wsxpobf0.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jim Meyering" <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 14:48:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Wx6-0006AY-51
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 14:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797AbXF0Msy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 08:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbXF0Msy
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 08:48:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:62769 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757892AbXF0Msy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 08:48:54 -0400
Received: by ug-out-1314.google.com with SMTP id j3so313009ugf
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 05:48:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WeeNeMkcTkKWffW2sTk5vtJPBx/rl8HmSLGOeGVzFutNCrtIauhfxogKKRUCrbz9nonA3aS+KeJEUoG10t4J+rUeTg1dPCSx/gqVlFBGLTlT0eabryU8nE6tLNTpVSJdu7XSvofSsXW+Tzgr7i6aTaEJFsCJOv8AsSEEsHGX2AA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YBN9zj5g7tUr3AX8RyIpRKCSMAseEy7x1VCNx2yQNzJTaLfZ5ZFA0L5iKj9hAJsGoWgU3PCi+bp2zBD3EFRdnXA81HtN7JFeR+gBcNv60N/H4QcwPvxqNowhPi3UcsFODsJLuMuHjd1pX4w+DopyLxzi53Jq0/SiQYBxJrnHDUo=
Received: by 10.78.160.2 with SMTP id i2mr239484hue.1182948532400;
        Wed, 27 Jun 2007 05:48:52 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 27 Jun 2007 05:48:52 -0700 (PDT)
In-Reply-To: <87wsxpobf0.fsf@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51036>

On 6/27/07, Jim Meyering <jim@meyering.net> wrote:
> Without this, if you ever run out of file descriptors, dup will
> fail (silently), fdopen will return NULL, and fprintf will
> try to dereference NULL (i.e., usually segfault).

But if you check the result of fdopen for NULL instead
you'll cover the dup failure _and_ out-of-memory in one
go. You'll loose the errno (probably), but you don't seem
to use it here anyway.
