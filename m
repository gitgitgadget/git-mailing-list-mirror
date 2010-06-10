From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/2] bash completion: Support "divergence from upstream" warnings in __git_ps1
Date: Thu, 10 Jun 2010 13:47:22 +0200
Message-ID: <cover.1276169807.git.trast@student.ethz.ch>
References: <4C0EB7F1.1030707@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Steven Michalske <smichalske@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 13:47:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMgES-0005kp-33
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 13:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab0FJLr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 07:47:27 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:16108 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091Ab0FJLr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 07:47:26 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 13:47:25 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 13:47:25 +0200
X-Mailer: git-send-email 1.7.1.553.ga798e
In-Reply-To: <4C0EB7F1.1030707@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148857>

Andrew Sayers wrote:
> +                                       case "$p" in
> +                                               \<*\>*|\>*\<* ) p="<>" ;;
> +                                               *\<*          ) p="<"  ;;
> +                                               *\>*          ) p=">"  ;;
> +                                               ""            ) p="="  ;;
> +
> +                                               # the following case shouldn't be possible
> +                                               # if you see this, please report it as a bug
> +                                               * ) p="?ERROR($p)?" ;;
> +
> +                                       esac

I didn't really like this bit, since rev-list has to format the output
only so you can match it.  I realized that I too have written code in
the past to detect which way this goes (in post-receive hooks), and/or
the number of commits as per the request

John Tapsell wrote:
> I hate to get all feature-bloat on you...
> 
> But could it state the number of commits as well please? :) :)

So here's an additional patch to provide rev-list logic that supports
this feature.  I have then tweaked your original patch to make use of
it a u+7-5 style.

I'm not too picky about the exact style that it turns out to have in
the end; I have used my own customized version ever since we started
printing a space before the (master *+) dirtiness indicator.  However,
I think we should try to be as unambiguous and short as possible.
Hence I picked the 'u' prefix to avoid ambiguity with the dirtiness
indicator.


Andrew Sayers (1):
  bash completion: Support "divergence from upstream" warnings in
    __git_ps1

Thomas Rast (1):
  rev-list: introduce --count option

 Documentation/rev-list-options.txt     |    9 +++++
 builtin/rev-list.c                     |   16 +++++++++
 contrib/completion/git-completion.bash |   57 +++++++++++++++++++++++++++++++-
 revision.c                             |    2 +
 revision.h                             |    5 +++
 t/t6007-rev-list-cherry-pick-file.sh   |   29 ++++++++++++++++
 6 files changed, 117 insertions(+), 1 deletions(-)
