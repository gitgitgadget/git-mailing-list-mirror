From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: [PATCH 3/3] Hook up the result aggregation in the test makefile.
Date: Mon, 12 May 2008 17:03:29 +0200
Message-ID: <19f34abd0805120803h6a976d1fvcc49a43c192fe517@mail.gmail.com>
References: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
	 <1210584832-16402-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, dsymonds@gmail.com
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 17:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvZZc-0004bi-Ln
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 17:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbYELPDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 11:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYELPDb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 11:03:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:39820 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbYELPDa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 11:03:30 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2701837rvb.1
        for <git@vger.kernel.org>; Mon, 12 May 2008 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KONcbEQbjywS0h5s1jWfahdv2LJ20DcJ50dEoj6oHhI=;
        b=pMNp4V/TrzrbXSxQb8Gf8KcAVOgp5fJLQF7r1PxVjXNupCcDF9vVaY9eq/UFH+8sirBeu/I0QFovC0x6FfeeFm+pGRWhHx/RWaeo6gDv0bf/PfB1zOMA6jPR65uePNYMfFd/pe1lDGPwaBWxKEx3SdnDRiQPl1q8fFH18qinZG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Iy0K8RVf+Sop0LuM9nLvJ8IiXuCN2GKsZcD375i5td0rF9fHmAMmcj8zv/rsu5ItcsnXEWKgbT/Y7wlxU6tuzey27PxQvC8dfrYDQae4QTpFcVahwiL52UWqQoPTAW/KFQdSzu6nAesFTbgN4XadbctdNDUPNLFdLPW7EcPPXlQ=
Received: by 10.141.89.13 with SMTP id r13mr3734691rvl.88.1210604609394;
        Mon, 12 May 2008 08:03:29 -0700 (PDT)
Received: by 10.141.185.13 with HTTP; Mon, 12 May 2008 08:03:29 -0700 (PDT)
In-Reply-To: <1210584832-16402-4-git-send-email-srabbelier@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81870>

Hi,

On Mon, May 12, 2008 at 11:33 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> This patch makes 'make' output the aggregated results at the end of each build.
>  The 'git-test-result' file is removed both before and after each build.
>
>  Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
>  ---
>   t/Makefile |    9 ++++++++-
>   1 files changed, 8 insertions(+), 1 deletions(-)
>
>  diff --git a/t/Makefile b/t/Makefile
>  index 72d7884..3955ee8 100644
>  --- a/t/Makefile
>  +++ b/t/Makefile
>  @@ -14,13 +14,20 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
>   T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
>   TSVN = $(wildcard t91[0-9][0-9]-*.sh)
>
>  -all: $(T) clean
>  +all: pre-clean $(T) aggregate-results clean
>
>   $(T):
>         @echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
>
>  +pre-clean:
>  +       $(RM) -f /tmp/git-test-results
>  +
>   clean:
>         $(RM) -r trash
>  +       $(RM) -f /tmp/git-test-results
>  +
>  +aggregate-results:
>  +       ./key_value_parser.py
>
>   # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
>   full-svn-test:
>  --
>  1.5.5.1.178.g1f811

I am not really familiar with the git makefile in particular, but
usually it's a good idea to put

.PHONY: pre-clean aggregate-results

as well if these targets are not output files. (Rationale can be found
in section 4.6 "Phony Targets" of the GNU make manual.)


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
