From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [PATCH] checkout -f: do not leave untracked working tree files.
Date: Tue, 20 Jun 2006 13:01:50 +0200
Message-ID: <8764iw5bvl.fsf@gmail.com>
References: <449557B6.1080907@garzik.org>
	<7vbqsqdru0.fsf@assigned-by-dhcp.cox.net> <4495DB3B.10403@garzik.org>
	<7v4pyhdel5.fsf@assigned-by-dhcp.cox.net>
	<4497B39E.2050205@garzik.org>
	<7vr71kb257.fsf@assigned-by-dhcp.cox.net>
	<7vfyi0b1gv.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jeff@garzik.org>, git@vger.kernel.org,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Tue Jun 20 13:02:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsdze-00030g-0T
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 13:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWFTLB7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 07:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWFTLB7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 07:01:59 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:2771 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S932594AbWFTLB6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 07:01:58 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k5KA0q920183;
	Tue, 20 Jun 2006 12:00:52 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyi0b1gv.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 20 Jun 2006 02:50:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Earlier we did not consider untracked working tree files
> "precious", but we have always considered them fair game to
> clobber.  These days, branch switching by read-tree is more
> careful and tries to protect untracked working tree files.  This
> caused the following workflow to stop working:
>
> 	git checkout one-branch-with-file-F
> 	git checkout -f another-without-file-F
> 	git pull . one-branch-with-file-F
>
> Because the second checkout leaves F from the previous state as
> untracked file in the working tree, the merge would fail, trying
> to protect F from being clobbered.
>
> This changes "git checkout -f" to remove working tree files that
> are known to git in the switched-from state but do not exist in
> the switched-to state, borrowing the same logic from "reset --hard".
>

I agree with this patch (without testing).

Another thing to take into account is that, for this particular
case/sequence, the untracked file-F is exactly the same as the one from
the pull, so you are not overwritting that file and it could succeed.

    Santi
