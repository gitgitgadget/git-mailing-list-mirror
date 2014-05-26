From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH 00/15] Rearrange xcalloc arguments
Date: Mon, 26 May 2014 16:37:41 -0700
Message-ID: <20140526233741.GB8570@hudson.localdomain>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 01:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp4Sk-0008Gz-NU
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 01:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbaEZXhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 19:37:47 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:42888 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbaEZXhq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 19:37:46 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so8242763pbb.31
        for <git@vger.kernel.org>; Mon, 26 May 2014 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7LkGtVrTEjpzA0jHjNXB8L+282WkIUxmmLKQicTw0tY=;
        b=VE730e8pBXCP1Sg8i8aOmHzd+uYs1im3TO0odED2QUQrL8rtGaK0h6AhURS+91+a1P
         cCbDZ1rRDJVyRKt8jjdq2Y7ht1kBRBpk2EoGo7/frhtRKTQSfrxN+lxTXtvvRQUDTzfK
         HSv//tqGy2mOw8rJuWRv7Zkz9HjcNMs2ts0Ka9n01suns7LtHn/dTZApXfpseSGdCTrW
         wjlTwpmDK79Ls/gL5TZX1w0x7OrFpWOjludigXU5/YjvbBmQblHb1a2tnE5MZ98ifNl0
         auIaiRoU5+iIi4Uo/hqisV092z+Wuf1b9JWX+1StHHviep9LEFDB3BZXhhvZPb34x/Eu
         chhg==
X-Received: by 10.68.254.5 with SMTP id ae5mr31250402pbd.83.1401147466154;
        Mon, 26 May 2014 16:37:46 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ky8sm20047853pbc.64.2014.05.26.16.37.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 16:37:45 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 26 May 2014 16:37:41 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250134>

Brian,

On Tue, May 27, 2014 at 12:33:41AM +0900, Brian Gesiak wrote:
> xcalloc takes two arguments: the number of elements and their size.
> The vast majority of the Git codebase passes these arguments in the
> correct order, but there are some exceptions. This patch series
> corrects those exceptions.
> 

Let me see if I understand the issue underlying this patch set.

xcalloc works like calloc and takes two arguments, the number of
elements and the size of each element.  However, many calls specified
these arguments in the reverse order.  It didn't produce a compile
error because both arguments are the same type.  And it didn't produce
a run time error because A*B is the same as B*A.

If this behaved like dd, performance would be different depending on the
order.

  dd if=in of=out bs=1    count=1024
  dd if=in of=out bs=1024 count=1

Nonetheless, it appears to be a good fix.  Nice job!

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
