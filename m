From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH v3] ls-remote: fall-back to default remotes when no
 remote specified
Date: Fri, 9 Apr 2010 10:49:13 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC7448206860D@xmail3.se.axis.com>
References: <1270710427-6680-1-git-send-email-rctay89@gmail.com>
 <1270747273-1504-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 10:50:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O09v3-0008F3-MG
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 10:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772Ab0DIIuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 04:50:25 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:50282 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923Ab0DIIuX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 04:50:23 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o398nFeV014797;
	Fri, 9 Apr 2010 10:49:15 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Fri, 9 Apr 2010 10:49:14 +0200
Thread-Topic: [PATCH v3] ls-remote: fall-back to default remotes when no
 remote specified
Thread-Index: AcrXQJHrje31/oszQ2mJpTJjlSfmIwAgG2rw
In-Reply-To: <1270747273-1504-1-git-send-email-rctay89@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144419>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Tay Ray Chuan
> Sent: den 8 april 2010 19:21
> To: Git Mailing List
> Cc: Junio C Hamano; Jeff King
> Subject: [PATCH v3] ls-remote: fall-back to default remotes when no
> remote specified
> 
> Instead of breaking execution when no remote (as specified in the
> variable dest) is specified when git-ls-remote is invoked, continue on
> and let remote_get() handle it.
> 
> This way, we are able to use the default remotes (eg. "origin",
> branch.<name>.remote), as git-fetch, git-push, and other users of
> remote_get(), do.
> 
> If no suitable remote is found, exit with a message describing the
> issue, instead of just the usage text, as we do previously.
> 
> Add several tests to check that git-ls-remote handles the
> no-remote-specified situation.
> 
> Also add a test that "git ls-remote <pattern>" does not work; we are
> unable to guess the remote in that situation, as are git-fetch and
> git-push.
> 
> In that test, we are testing for messages coming from two separate
> processes, but we should be OK, because the second message is triggered
> by closing the fd which must happen after the first message is printed.
> (analysis by Jeff King.)
> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  builtin/ls-remote.c  |   11 ++++++---
>  t/t5512-ls-remote.sh |   58
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 70f5622..6c738c9 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -4,7 +4,8 @@
>  #include "remote.h"
> 
>  static const char ls_remote_usage[] =
> -"git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>] <repository> <refs>...";
> +       "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\n"
> +"                     [<repository> [<refs>...]]";

That should be:

static const char ls_remote_usage[] =
	"git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\n"
	"              [<repository> [<refs>...]]";

or the second line of the usage will not be indented as intended.

//Peter
