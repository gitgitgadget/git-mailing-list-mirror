From: Eric Raible <raible@nextest.com>
Subject: Re: Poor status output during conflicted merge
Date: Thu, 1 Jul 2010 18:51:37 -0700
Message-ID: <4C2D4629.1090600@nextest.com>
References: <loom.20100701T195742-266@post.gmane.org> <7v1vbm3g8j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 03:58:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUVW2-0008Os-IE
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 03:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949Ab0GBB44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 21:56:56 -0400
Received: from mail.nextest.com ([12.96.234.114]:12825 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755017Ab0GBB4z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 21:56:55 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2010 21:56:55 EDT
Received: from [131.101.151.222] (131.101.151.222) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Thu, 1 Jul 2010 18:51:50 -0700
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <7v1vbm3g8j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150100>

Junio C Hamano wrote:
> 
> It might be just a simple matter of ...
> 

I don't think it's that simple.  Consider the case of an integrator who
initially picks the wrong branch.  Wouldn't it seem that:
	git checkout --ours file
	git add file
	git status

should result in the same output as:
	git checkout --theirs file
	git add file
	git status
	# oops
	git checkout --ours file
	git add file
	git status

I can accept an answer is "no".  After all, 'git add' says
that you are happy.  But it makes me wonder whether the empty
"if (s->in_merge)" clause in wt_status_print_cached_header()
wouldn't be the right place to handle this case.

Aside from that, wouldn't the message "merge result will be the
same as HEAD commit" be incorrect if that there are other files
which were already merged successfully?
