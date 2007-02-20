From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] disable t4016-diff-quote.sh on some filesystems
Date: Tue, 20 Feb 2007 11:47:07 -0800
Message-ID: <7vk5ycvcg4.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0702200127m231425d6p67d2d67e6d7d9b04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 20:47:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJaxm-0006ok-63
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 20:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbXBTTrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 14:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbXBTTrK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 14:47:10 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46054 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030377AbXBTTrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 14:47:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220194709.RSUV21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 14:47:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rvn81W0031kojtg0000000; Tue, 20 Feb 2007 14:47:08 -0500
In-Reply-To: <81b0412b0702200127m231425d6p67d2d67e6d7d9b04@mail.gmail.com>
	(Alex Riesen's message of "Tue, 20 Feb 2007 10:27:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40256>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> because the filesystems (most typically FAT and NTFS) do not support
> HT nor LF in filenames.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>
> ---
> God help me...
> 
>  t/t4016-diff-quote.sh |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)

Buddha help me.

You are still lacking the "good stuff" in what I'd end up saving
in a separate file and applying, which is the attachment part...

> From 0edbc6df977e7d954032eaf72720c93b86ab4c0f Mon Sep 17 00:00:00 2001
> From: Alex Riesen <raa.lkml@gmail.com>
> Date: Tue, 20 Feb 2007 10:04:32 +0100
> Subject: [PATCH] disable t4016-diff-quote.sh on some filesystems
>
> ---
>  t/t4016-diff-quote.sh |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

... but that is a minor detail.  I can survive.

> +if ! test : 2>/dev/null >"$P1" ; then
> +	echo >&2 'Filesystem does not support tabs in names'
> +	test_done
> +fi

I do not understand what this test-colon is doing?  Did you mean

	if ! : >"$P1" 2>&1
        then
		...
	fi

I would have written it like this, to check if it really
succeeded creating and also we can remove it.

	: >"$P1" 2>&1 && test -f "$P1" && rm -f "$P1" || {
		...
	}
