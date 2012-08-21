From: Tim Chase <git@tim.thechases.com>
Subject: misleading diff-hunk header
Date: Tue, 21 Aug 2012 08:21:04 -0500
Message-ID: <50338B40.9050606@tim.thechases.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 15:19:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3oNA-00055I-Fu
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 15:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab2HUNTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 09:19:51 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:60064 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753631Ab2HUNTt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2012 09:19:49 -0400
X-Greylist: delayed 1392 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2012 09:19:49 EDT
Received: from ppp-70-251-69-251.dsl.rcsntx.swbell.net ([70.251.69.251] helo=[192.168.1.12])
	by boston.accountservergroup.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tim.thechases.com>)
	id 1T3oN3-0008H2-Ct
	for git@vger.kernel.org; Tue, 21 Aug 2012 08:19:49 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111120 Icedove/3.1.16
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203964>

[posted originally to git-users@ but advised this would be a better
forum]

diff.{type}.xfuncname seems to start searching backwards in
from the beginning of the hunk, not the first differing line.

To reproduce:

  $ mkdir tmp
  $ cd tmp
  $ git init
  $ cat > foo.c <<EOF
  int call_me(int maybe)
  {
  }

  int main()
  {
  }
  EOF
  $ git add foo.c
  $ git commit -m "Initial checkin"
  $ ed foo.c
  # main() should return 0
  $i
    return 0;
  .
  wq
  $ git diff

The diff returns a header line of

  @@ -4,4 +4,5 @@ int call_me(int maybe)

   int main()
   {
  +  return 0;
   }

misleadingly suggesting that the change occurred in the call_me()
function, rather than in main()

I'm running 1.7.2.5 from Debian Stable if that makes a difference.

Is this expected/proper behavior?

-tkc

FWIW, I stumbled across this tinkering with
diff.{typename}.xfuncname detailed in gitattributes(5)
