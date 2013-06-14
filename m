From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/3] sh-setup: add new peel_committish() helper
Date: Fri, 14 Jun 2013 17:05:03 +0100
Organization: OPDS
Message-ID: <59954A85BB7C4B279B61C46CC1D81CCA@PhilipOakley>
References: <1371215872-9796-1-git-send-email-artagnon@gmail.com> <1371215872-9796-3-git-send-email-artagnon@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 18:04:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnWUQ-0005Bv-Ac
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 18:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab3FNQEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 12:04:34 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:41237 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752232Ab3FNQEd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jun 2013 12:04:33 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArkNACM+u1FZ8YhC/2dsb2JhbABbgwkwiQe2EgQBAwGBCRd0gh4FAQEEAQgBAS4eAQEhBQYCAwUCAQMOBwELJRQBBAgSBgcXBgESCAIBAgMBh2sDCQqxYA2IUoxjgXtqgwZhA4hohgaGbIwDggKFJIMQOw
X-IronPort-AV: E=Sophos;i="4.87,867,1363132800"; 
   d="scan'208";a="578739815"
Received: from host-89-241-136-66.as13285.net (HELO PhilipOakley) ([89.241.136.66])
  by out1.ip06ir2.opaltelecom.net with SMTP; 14 Jun 2013 17:04:31 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227891>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
Sent: Friday, June 14, 2013 2:17 PM
> The normal way to check whether a certain revision resolves to a valid
> commit is:
>
>  $ git rev-parse --verify $REV^0
>
> Unfortunately, this does not work when $REV is of the type :/quuxery.

Is there a proper name for this style of revision specification? I've 
been letting this 'style' wash over me in the hope that I'd understand 
eventually, but it hasn't.

Loking at git-rev-parse I now see that it might be the 'Commit Message 
Regex' rev specifier.

If re-rolled, can this elucidation be included in the commit message?

> Write a helper to work around this limitation.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
> git-sh-setup.sh | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 2f78359..7a964ad 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -313,3 +313,15 @@ then
>  }
>  : ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
> fi
> +
> +peel_committish () {
> + case "$1" in
> + :/*)
> + peeltmp=$(git rev-parse --verify "$1") &&
> + git rev-parse --verify "${peeltmp}^0"
> + ;;
> + *)
> + git rev-parse --verify "${1}^0"
> + ;;
> + esac
> +}
> -- 
> 1.8.3.1.381.g12ca056.dirty
>
> --
Philip 
