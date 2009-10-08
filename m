From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] perl/Makefile.PL: detect MakeMaker versions incompatible
 with DESTDIR
Date: Thu, 08 Oct 2009 15:21:48 +0200
Message-ID: <4ACDE76C.4040307@viscovery.net>
References: <7wQSYSBJPoVtvyGI0lqsDW37w4byCpgpMaHiDKALwW_oJ9nHXddX9OBMnqXGZBVAo2U7Tc1BMxg@cipher.nrlssc.navy.mil> <FE_WTi0YAHrCrSdGFemlb7ALatFkdSu5V7Yfb5CUgyoxfv3ZFXdFABKbT1boP7aeGWli-gJPcBA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, c@gryning.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 08 15:24:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvsyp-0001Pb-Dp
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 15:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758256AbZJHNWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 09:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758253AbZJHNWp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 09:22:45 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65348 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412AbZJHNWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 09:22:43 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MvswH-0001qj-6m; Thu, 08 Oct 2009 15:21:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B97D74E9; Thu,  8 Oct 2009 15:21:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <FE_WTi0YAHrCrSdGFemlb7ALatFkdSu5V7Yfb5CUgyoxfv3ZFXdFABKbT1boP7aeGWli-gJPcBA@cipher.nrlssc.navy.mil>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129690>

Brandon Casey schrieb:
> From: Brandon Casey <drafnel@gmail.com>
> 
> It appears that ExtUtils::MakeMaker versions older than 6.11 do not
> implement the DESTDIR mechanism.  So add a test to the generated perl.mak
> to detect when DESTDIR is used along with a too old ExtUtils::MakeMaker and
> abort with a message suggesting the use of NO_PERL_MAKEMAKER.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> 
> 
> This just reverses the logic in the test on $(MM_VERSION) so that the test
> will also fail if MM_VERSION is unset.  Who knows if ancient versions set
> it.  Sorry for the quick v2.
> 
> -brandon
> 
> 
>  perl/Makefile.PL |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/perl/Makefile.PL b/perl/Makefile.PL
> index 320253e..0b9deca 100644
> --- a/perl/Makefile.PL
> +++ b/perl/Makefile.PL
> @@ -5,6 +5,14 @@ sub MY::postamble {
>  instlibdir:
>  	@echo '$(INSTALLSITELIB)'
>  
> +ifneq (,$(DESTDIR))
> +ifeq (0,$(shell expr '$(MM_VERSION)' '>' 6.10))

I don't think the test works as intended, because 6.2 *is* greater than
6.10 (aka 6.1).

(Found while staring at git diff v1.6.5-rc2..v1.6.5-rc3 in a spare minute.)

> +$(error ExtUtils::MakeMaker version "$(MM_VERSION)" is older than 6.11 and so \
> +	is likely incompatible with the DESTDIR mechanism.  Try setting \
> +	NO_PERL_MAKEMAKER=1 instead)
> +endif
> +endif
> +
>  MAKE_FRAG
>  }

-- Hannes
