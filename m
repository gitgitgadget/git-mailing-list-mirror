From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Tue, 6 Dec 2005 16:10:56 -0500
Message-ID: <118833cc0512061310r6398f812ia47a84d3cfad1564@mail.gmail.com>
References: <7vslt67v9o.fsf@assigned-by-dhcp.cox.net>
	 <14331.1133899163@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 22:14:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejk5f-0001CX-Rv
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 22:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbVLFVK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 16:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVLFVK6
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 16:10:58 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:21353 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965039AbVLFVK5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 16:10:57 -0500
Received: by wproxy.gmail.com with SMTP id i4so43002wra
        for <git@vger.kernel.org>; Tue, 06 Dec 2005 13:10:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rTiuoa9Vr+DgBVSrdSgxPJYM6CPYKTRM5ayyMtQy2u+8P4p/+6zgO1LQ7dnTiE4Pvsn47stYVxrfLySZnLqQ3fe6sVI9SYt6EyXQ35MeehuBvf1YVZP0sdYbD0Iq2ewSLtudyru7r3gws4Or1PQADaNrXgHievPmG0h8zDqcaQU=
Received: by 10.64.220.17 with SMTP id s17mr1000083qbg;
        Tue, 06 Dec 2005 13:10:56 -0800 (PST)
Received: by 10.65.151.1 with HTTP; Tue, 6 Dec 2005 13:10:56 -0800 (PST)
To: Jason Riedy <ejr@eecs.berkeley.edu>
In-Reply-To: <14331.1133899163@lotus.CS.Berkeley.EDU>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13289>

The code looks wrong.  It assumes that pointers are no larger than ints.
If pointers are larger than ints, the code does not necessarily compute
a consistent ordering and qsort is allowed to do whatever it wants.

Morten



static int compare_object_pointers(const void *a, const void *b)
{
	const struct object * const *pa = a;
	const struct object * const *pb = b;
	return *pa - *pb;
}
