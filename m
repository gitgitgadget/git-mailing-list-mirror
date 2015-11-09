From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 12:47:38 -0500
Message-ID: <20151109174738.GA29468@sigill.intra.peff.net>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
 <20151104064021.GB16605@sigill.intra.peff.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
 <20151109155538.GC27224@sigill.intra.peff.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA17@mail.accesssoftek.com>
 <20151109165343.GA29179@sigill.intra.peff.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA18@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:47:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvqXi-0006kM-C6
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbbKIRrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:47:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:55067 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751587AbbKIRrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 12:47:41 -0500
Received: (qmail 10164 invoked by uid 102); 9 Nov 2015 17:47:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 11:47:41 -0600
Received: (qmail 18087 invoked by uid 107); 9 Nov 2015 17:48:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 12:48:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Nov 2015 12:47:38 -0500
Content-Disposition: inline
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA18@mail.accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281069>

On Mon, Nov 09, 2015 at 09:28:12AM -0800, Victor Leschuk wrote:

> Maybe use the simplest version (and keep num_numbers == 0 also as flag for all other checks in code like if(num_flags) .... ):
> 
> if (list.nr || cached )
>   num_threads = 0; // do not use threads
> else if (num_threads == 0)
>   num_threads = online_cpus() <= 1 ? 0 : GREP_NUM_THREADS_DEFAULT;

That's OK.

> else if (num_threads < 0)
>   die(...)

Do we really want to die here? I think "threads < 0" works the same as
"threads==0" in other git programs. It's also a weird place to die. It
would make:

  git grep --cached --threads=-1

silently work, while:

  git grep --threads=-1

would die.

If we do accept it, it may make sense to normalize it to 0 so that you
can just check "!num_threads" elsewhere in the code.

-Peff
