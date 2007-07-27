From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: Re: index-pack died on pread
Date: Fri, 27 Jul 2007 14:33:15 +0400
Message-ID: <20070727103315.GB5047@moonlight.home>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com> <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org> <200707260115.13234.robin.rosenberg.lists@dewire.com> <alpine.LFD.0.999.0707251636490.3607@woody.linux-foundation.org> <81b0412b0707260542o58fcb73bu81ae09aa1df84c81@mail.gmail.com> <alpine.LFD.0.999.0707260911040.3442@woody.linux-foundation.org> <7vps2e5x4y.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707262231280.3442@woody.linux-foundation.org> <20070727095013.GA5047@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Michal Rokos <michal.rokos@gmail.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 12:33:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEN8P-00040q-Ei
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 12:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759263AbXG0KdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 06:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757475AbXG0KdX
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 06:33:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:1916 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbXG0KdV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 06:33:21 -0400
Received: by ug-out-1314.google.com with SMTP id j3so686992ugf
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 03:33:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=OsvOzaRGQ5UKUrNk/r7tCt4GsJQzzjKP8jzsSpQ7QCBk3BWnfZ7gFJwZO939lwrI9zPszN1QcltSiyL/e2UZQXBV24wwJK0FWLUyKBlcbG82Kpxh+LZWBJUJxK7yx+2W2Mj/5BhFXlXEjqlYtmVrgMw7wzrONcDv05OPUmQ3ngg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=IoCNTFRapwrCZeMAy8tRtz0a1WXG64+dnZB4CZZKT9H/4q2Ta6FN8SG1y4wlxd2gnZ1f/5cJyncgGz82TQzaRe860SQHpxMS6flxumMA+fS1LfWL7ALxkjEmNHRUX3FRYp+r2NbDcEv9nITWypmgeFQIqwIBRyYOCcEYn9HdEeY=
Received: by 10.86.57.9 with SMTP id f9mr1863417fga.1185532399922;
        Fri, 27 Jul 2007 03:33:19 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTPS id c14sm3317405nfi.2007.07.27.03.33.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2007 03:33:19 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id D88323A8BC;
	Fri, 27 Jul 2007 14:33:16 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l6RAXFfL016380;
	Fri, 27 Jul 2007 14:33:15 +0400
Content-Disposition: inline
In-Reply-To: <20070727095013.GA5047@moonlight.home>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53913>

On Fri, Jul 27, 2007 at 13:50:13 +0400, Tomash Brechko wrote:
> There's no dup() call, so when we mess pack_fd (that is used in
> pread() only), we also mess one more file descriptor that is used
> sequentially (output_fd in my case), and so may corrupt the pack.

I was wrong on the dup() part, since dup()'ed descriptors share the
same file position.  Anyway, if my guess is right, the fix would
probably be not to use broken pread() that messes file position,
rather than to be ready and workaround that.


-- 
   Tomash Brechko
