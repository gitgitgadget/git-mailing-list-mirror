From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 12:07:40 -0600
Message-ID: <0OMCWm31DRbUGCfPIS6SSJn59HQIM9AKtSDgVSNdiSR99clfmJ3D-Q@cipher.nrlssc.navy.mil>
References: <20091130075221.GA5421@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 19:07:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFAfC-000404-Sq
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 19:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbZK3SHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 13:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbZK3SHl
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 13:07:41 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47646 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbZK3SHk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 13:07:40 -0500
Received: by mail.nrlssc.navy.mil id nAUI7fH0019147; Mon, 30 Nov 2009 12:07:41 -0600
In-Reply-To: <20091130075221.GA5421@coredump.intra.peff.net>
X-OriginalArrivalTime: 30 Nov 2009 18:07:41.0310 (UTC) FILETIME=[01FBA1E0:01CA71E8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134124>

Jeff King wrote:
> Without this, test-lib checks that the git_remote_helpers
> directory has been built. However, if we are building
> without python, we will not have done anything at all in
> that directory, and test-lib's sanity check will fail.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> On top of sr/vcs-helper.
> 
> This feels a little funny for NO_PYTHON to mean "no remote helpers at
> all". But that is the way the Makefile is set up, since we seem to have
> only python helpers.
> 
>  Makefile      |    1 +
>  t/test-lib.sh |    2 +-
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 42744a4..443565e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1743,6 +1743,7 @@ GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
>  	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
>  	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
>  	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
> +	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
>  
>  ### Detect Tck/Tk interpreter path changes
>  ifndef NO_TCLTK
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 4a40520..ca0839c 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -638,7 +638,7 @@ test -d ../templates/blt || {
>  	error "You haven't built things yet, have you?"
>  }
>  
> -if test -z "$GIT_TEST_INSTALLED"
> +if test -z "$GIT_TEST_INSTALLED" && test -z "$NO_PYTHON"
>  then
>  	GITPYTHONLIB="$(pwd)/../git_remote_helpers/build/lib"
>  	export GITPYTHONLIB

Shouldn't this section be moved down below the sourcing of ../GIT-BUILD-OPTIONS
on line 656 so that the value of NO_PYTHON will be available when running the
test scripts directly?

-brandon

ps. There's something eerily familiar about this patch.
