From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Tue, 19 Mar 2013 12:37:59 +0700
Message-ID: <CACsJy8AjqwGVRRiQGMG0AN5qqtvxLk8FHKfUzCZB-7BykrHfjg@mail.gmail.com>
References: <20130313040845.GA5057@sigill.intra.peff.net> <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin> <20130319034822.GL5062@elie.Belkin> <7vli9kkoci.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 06:39:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHpGK-0002cB-LI
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 06:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515Ab3CSFib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 01:38:31 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:60410 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670Ab3CSFia (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 01:38:30 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so75245obb.37
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 22:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=YzeQpQU/jrZfm0CUraD6jAuNeAYI1oCAxodtTI4/440=;
        b=E3jawCtakCTtZJMuP4G2oEXbkedRGI/2OIOv/AY8T+P+jROEv0rHMPso/LkFiMJmPi
         UhWORQZ9EqNYoab8VMQULnp64B7C5AChqy9GB0H03VYrzp8joyCRNAn5DpUgYjRNvsiO
         P9rl6ZuVuxipLgNJVV8xaXci2c8bMKj3nTomnWm7jAezuI7lKcElMxKceWqjDvRQAA5v
         /CxahYkZwsNA6D1YqWHjZwOiJaNh3rMUwmW83JF7Wck7SWsIBq16N+O7i1Mb0izYjTFr
         DIZfA/Jg7am9SAuOqaRtbenXdvtUzdSLFBO6xMGViu5S+5mShsTYGBFPjl6sv2m3mtF/
         dJIA==
X-Received: by 10.60.171.230 with SMTP id ax6mr444419oec.25.1363671510220;
 Mon, 18 Mar 2013 22:38:30 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Mon, 18 Mar 2013 22:37:59 -0700 (PDT)
In-Reply-To: <7vli9kkoci.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218484>

On Tue, Mar 19, 2013 at 11:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I am wondering if we can special case the no-pathspec case to have
> add_files_to_cache() call underlying run_diff_files() without any
> pathspec, inspect the paths that are modified and/or deleted in the
> update_callback, add ones that are under the $prefix while noticing
> the ones outside as warning worthy events.

My concern is run full-tree diff can be expensive on large repos (one
of the reasons the user may choose to work from within a
subdirectory). We can exit as soon as we find a difference outside
$prefix. But in case we find nothing, we need to diff the whole
worktree.
-- 
Duy
