From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: StGIT cannot import properly from stdin
Date: Thu, 22 Sep 2005 13:08:21 +0200
Message-ID: <433290A5.5070008@drzeus.cx>
References: <433107C7.60901@drzeus.cx> <b0943d9e05092101033dd5d366@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 13:09:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIOwU-0005mq-3u
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 13:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVIVLIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 07:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbVIVLIV
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 07:08:21 -0400
Received: from [85.8.12.41] ([85.8.12.41]:9859 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1030255AbVIVLIV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 07:08:21 -0400
Received: from [192.168.128.82] (alcatraz.cendio.se [::ffff:193.12.253.67])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Thu, 22 Sep 2005 13:08:19 +0200
  id 00062716.433290A3.00002068
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
To: catalin.marinas@gmail.com
In-Reply-To: <b0943d9e05092101033dd5d366@mail.gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9107>

Catalin Marinas wrote:

>
>It works for me with the latest snapshot. What might happen in your
>case is a missing "---" line after the patch description. The import
>command reads the sys.stdin file descriptor until the first "---"
>line. After that, the git.apply() function will read the rest of the
>lines and pass them to git-apply. You can put some prints in the
>git.apply() function to check where it starts reading from.
>
>  
>

Hmm... it seems you're kind of right. It doesn't need the patch twice.
But it needs EOF more than once. The for-loop in __parse_patch() doesn't
start until the EOF is recieved. And the second for-loop in _input()
requires a new EOF.

>Patches without description cannot be read from stdin at the moment.
>Maybe I could add another option to prevent it from reading the
>description.
>
>  
>

If you would cache the input to a file (or memory) you would remove both
of these problems.

Rgds
Pierre
