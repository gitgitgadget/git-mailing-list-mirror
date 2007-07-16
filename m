From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 15:45:29 +0200
Message-ID: <20070716134529.GC26675@cip.informatik.uni-erlangen.de>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <gitster@pobox.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 15:45:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAQtK-00064i-FW
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 15:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759873AbXGPNpb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 09:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758829AbXGPNpb
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 09:45:31 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:60980 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755404AbXGPNpa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 09:45:30 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id CC9583F42E; Mon, 16 Jul 2007 15:45:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52677>

Hello,

entry.c line 17:

        static void create_directories(const char *path, const struct checkout *state)
        {
        ...
                        if (mkdir(buf, 0777)) {
=>                              if (errno == EEXIST) {
                                        struct stat st;
=>                                      if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
                                                continue;
                                        if (!stat(buf, &st) && S_ISDIR(st.st_mode))
                                                continue; /* ok */
                                }
                                die("cannot create directory at %s", buf);
                        }
        ...

I think here is the problem. I don't understand what the code should do
actually. Or why the directory is deleted and re-created (maybe something todo
with permissions)?

        Thomas
