From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [Census] So who uses git?
Date: Sun, 29 Jan 2006 09:19:23 -0500
Message-ID: <118833cc0601290619k1e9c6bb8gc63937f1a2d2b31e@mail.gmail.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	 <1138446030.9919.112.camel@evo.keithp.com>
	 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	 <118833cc0601281814i503bf934ge32b12e7b090c44@mail.gmail.com>
	 <7v7j8jpu48.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 15:19:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3DP2-0002oa-Qw
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 15:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWA2OTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 09:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWA2OTZ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 09:19:25 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:27987 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751002AbWA2OTY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 09:19:24 -0500
Received: by pproxy.gmail.com with SMTP id o67so89419pye
        for <git@vger.kernel.org>; Sun, 29 Jan 2006 06:19:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l3LoJspW6Go/Q+bi0nSUVKHYZXsNyUQ5eQNHixvJow19nWPlCUsHuLoLohXfoZkE2JJ6OtD5d+Esh6HfgnYspF9j4BBKiO2aPS+nazviQZoKQE4pciYXoyskHqtcjFhSvfk2yjNuDrD4LJR5XNQtcteaxO9/c+0RR8mO9CQSAo0=
Received: by 10.35.60.15 with SMTP id n15mr21501pyk;
        Sun, 29 Jan 2006 06:19:23 -0800 (PST)
Received: by 10.35.39.13 with HTTP; Sun, 29 Jan 2006 06:19:23 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j8jpu48.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15220>

> I think that 40% sounds about right.  My understanding of the
> underlying format CVS uses, RCS, is that it stores an full copy
> of the tip of trunk uncompressed, and other versions of the file
> are represented as incremental delta from that.  The packed git
> format does not favor particular version based on the distance
> from the tip, and stores either a compressed full copy, or a
> delta from some other revision (which may not necessarily be
> represented as a full copy).  When we store something as a delta
> from something else, we limit the length of the delta chain to a
> full copy to 10 (by default), so that you can get to a specific
> object with at most 10 applications of delta on top of a full
> copy.

If I understand this right, that means that for a log file (in this
case a ChangeLog file) that is appended to linearly as a
function of revision number, we have...

cvs: O(n) archive size
git: O(n*n) archive size

At least that is what we get if revision N is always deltad over
revision N-1.  A good deal could be saved if instead of dumping
a full copy every 10 revisions, that revision would instead be
deltad off an earlier revision, but I think it'll still be O(n*n).

(/me prepares for Linus chiming in and telling me I should not
keep ChangeLog files, :-)

M.
