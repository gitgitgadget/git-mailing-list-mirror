From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-config: replaces ~/.gitconfig symlink with real file
Date: Mon, 16 Jul 2007 15:46:17 -0700
Message-ID: <7vps2s2chy.fsf@assigned-by-dhcp.cox.net>
References: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
	<dbfc82860707160237v6772b5b8o541f2045ccd824d5@mail.gmail.com>
	<f158199e0707160433v27fe7073w9c550712c41c32e8@mail.gmail.com>
	<f158199e0707160626j1025ab2cp3339ca6ab91d9af0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nikolai Weibull" <now@bitwi.se>, git@vger.kernel.org
To: "Bradford Smith" <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 00:46:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAZKo-0002t6-K0
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 00:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbXGPWqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 18:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbXGPWqT
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 18:46:19 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61950 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbXGPWqS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 18:46:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716224618.JKOQ1358.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Jul 2007 18:46:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QNmH1X00B1kojtg0000000; Mon, 16 Jul 2007 18:46:17 -0400
In-Reply-To: <f158199e0707160626j1025ab2cp3339ca6ab91d9af0@mail.gmail.com>
	(Bradford Smith's message of "Mon, 16 Jul 2007 09:26:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52731>

"Bradford Smith" <bradford.carl.smith@gmail.com> writes:

> ...  So, I guess I need to add a GIT_CONFIG_HOME
> environment variable.

I suspect that is going down a wrong path.

We use the sequence:

	fd = creat("temporary location");
        write(fd, ...);
        close(fd);
        rename("temporary location", "final location");

in quite a lot of codepaths.  I think they can be factored out,
to take the "final location" (and perhaps a suggested temporary
directory) as an parameter, and that code can check that "final
location" is a symlink to somewhere else and create the
temporary next to the target file.
