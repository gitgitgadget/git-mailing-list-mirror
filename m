From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] fix parallel make problem
Date: Fri, 31 Aug 2007 11:06:51 +0300
Message-ID: <20070831080651.GA17637@mellanox.co.il>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 10:07:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR1XB-0006d3-Rh
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 10:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462AbXHaIHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 04:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbXHaIHM
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 04:07:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:44603 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbXHaIHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 04:07:08 -0400
Received: by nf-out-0910.google.com with SMTP id f5so653903nfh
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 01:07:06 -0700 (PDT)
Received: by 10.78.146.11 with SMTP id t11mr1009296hud.1188547625331;
        Fri, 31 Aug 2007 01:07:05 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.35.163])
        by mx.google.com with ESMTPS id q1sm2822130uge.2007.08.31.01.06.57
        (version=SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 01:06:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmyw85uml.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57128>

> Quoting Junio C Hamano <gitster@pobox.com>:
> Subject: Re: [PATCH] fix parallel make problem
> 
> How about this as a replacement?  I notice that after a
> successful build all the test-*.o files are removed by make, and
> somehow make seems to believe it is Ok not to recreate them.

Yea. this works for me.

> ---
>  Makefile |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 4eb4637..51af531 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -969,6 +969,8 @@ test-date$X: date.o ctype.o
>  
>  test-delta$X: diff-delta.o patch-delta.o
>  
> +.PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
> +
>  test-%$X: test-%.o $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)

Add a comment here?
	
> Warning: 1 path touched but unmodified. Consider running git-status.

BTW, shouldn't the warning go to standard error?

-- 
MST
