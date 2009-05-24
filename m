From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/18] http*: add helper methods for fetching packs
Date: Sun, 24 May 2009 13:44:03 -0700
Message-ID: <7v7i06teng.fsf@alter.siamese.dyndns.org>
References: <20090524222006.cd71f8dc.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 22:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8KYN-0002b3-C3
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 22:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbZEXUoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 16:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753350AbZEXUoE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 16:44:04 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38397 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868AbZEXUoC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 16:44:02 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524204404.MXEA20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Sun, 24 May 2009 16:44:04 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id vYk31b00D4aMwMQ04Yk3ZM; Sun, 24 May 2009 16:44:04 -0400
X-Authority-Analysis: v=1.0 c=1 a=l6C0ey3IMRMA:10 a=CYmAowFhlkkA:10
 a=pGLkceISAAAA:8 a=8I7qvBULHheKW2qMy3AA:9 a=4GLYPLhVQtDO0B5s54MA:7
 a=H3s67DOPLrhBrTdXiCyJxfehMEwA:4 a=MSl-tDqOz04A:10 a=gL_Cd0aKKSpnZdhT:21
 a=gT14A9zaNABl4i9J:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119858>

Tay Ray Chuan <rctay89@gmail.com> writes:

> The code handling the fetching of packs in http-push.c and
> http-walker.c have been refactored into new methods and a new struct
> (http_pack_request) in http.c. They are not meant to be invoked
> elsewhere.
>
> The new methods in http.c are
>  *new_http_pack_request
>  *finish_http_pack_request
>  *release_http_pack_request
> and the new struct is http_pack_request.

Please do not use '*' not followed by any whitespace for enumerations; use
of '*' when you talk about code is confusing (e.g "is he talking about a
pointer?").

> ***http-push.c***
> The local_stream member of the transfer_request has been removed, as
> the packfile pointer will be managed in the struct http_pack_request.
>
> The code moved out from start_fetch_packed to new_http_pack_request
> deals with filenames, file and curl options, and does not change
> its behaviour.

Sorry, I cannot parse these.  Do you mean

	Refactor code from start_fetch_packed() to a new function,
	new_http_pack_request(); this deals with filenames, file and curl
	options.

I am a bit puzzled about the description split along the filename boundary
of the source files.  You also describe the new_http_pack_request()
function below, where you talk about changes to http-walker.c.  It would
be much easier to review if you don't split them, e.g.

	Add a function, new_http_pack_request(), that deals with the
	details of coming up with the filename to store the retrieved
	packfile, resuming a previously aborted request, and making a new
	curl request.  Update start_fetch_packed() in http-push.c and
	fetch_pack() in http-walker.c to use this.
