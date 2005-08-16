From: Junio C Hamano <junkio@cox.net>
Subject: Re: [patch] possible memory leak in diff.c::diff_free_filepair()
Date: Mon, 15 Aug 2005 21:32:12 -0700
Message-ID: <7v3bpapkmr.fsf@assigned-by-dhcp.cox.net>
References: <87y876gl1r.wl@mail2.atmark-techno.com>
	<7viry9my6k.fsf@assigned-by-dhcp.cox.net>
	<877jepo87m.wl@mail2.atmark-techno.com>
	<7viry9le0g.fsf@assigned-by-dhcp.cox.net>
	<8764u6ponn.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 06:33:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4t7e-0008FC-MT
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 06:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVHPEcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 00:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVHPEcR
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 00:32:17 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:28404 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932601AbVHPEcR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 00:32:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816043214.NZGU17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 00:32:14 -0400
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <8764u6ponn.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Tue, 16 Aug 2005 12:05:16 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> parepare_temp_file() and diff_populate_filespec() has a lot in
> similarity. so it'd be nice to refactor some. and re-introduce
> diff_free_filespec_data() and call right after prep_temp_blob() in
> prepare_temp_file().

Another thing that may (or may not) help would be to move that
prepare_temp_file() and stuff to happen in the forked child
process instead of the parent, so that we do not have to worry
about freeing the buffer; it has been some time since I worked
on that part of the code so this may not be an option to make
things easier.

> Junio, did you also mean to clean-up these functions when you said in
> the thread of "Re: gitweb - option to disable rename detection"?

No.  I was talking about cleaning up the similar option parsing
code, and the call into diffcore_std() which takes more
arguments every time a new option is added to the family.
