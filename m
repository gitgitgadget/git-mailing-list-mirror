From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] Remove i18n legos in notifying new branch tracking
 setup
Date: Thu, 31 May 2012 09:00:24 -0500
Message-ID: <20120531140024.GC10523@burratino>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com>
 <1338469482-30936-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 16:00:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa5vc-0001E7-TJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758195Ab2EaOAh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 10:00:37 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34800 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496Ab2EaOAg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 10:00:36 -0400
Received: by gglu4 with SMTP id u4so806163ggl.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZjbNVE5SA6iTkAdOh9i9Dw6esEpQB1ekfaEMZkacKY4=;
        b=FVXfPf3nzmBOvs0nGiYANrYxcvW6M4sq7BEZBFZF1Oxm2WPxnk+BaGiLI/1q/MEYPU
         dLjVjiB3ybb0U5izWUXKg/mEN3LISdKU2bUYb4aSeIqGu4JoSm954pomG21HlG69wiM6
         tkcNHe1ovtqumB6zKUBHJOmzz8KhRnF8Fr36XUJqjVCcHUuTN/u9WujxKvw+PfyjXsas
         h4f+K0cFw+VK5y4JlNdpukAnQVqbvU9WjMLgRKN+SbHuRg9+xUQuvkoBYcaJXnnmXYKW
         raDzgf9zc5iRhDQPNa09eb22yS3/K7CWCWecay08PVXQEDJ3e1WN0KF+Pvjtl11UKebq
         bPEA==
Received: by 10.50.212.70 with SMTP id ni6mr13726765igc.30.1338472835447;
        Thu, 31 May 2012 07:00:35 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z7sm1542334igb.3.2012.05.31.07.00.32
        (version=SSLv3 cipher=OTHER);
        Thu, 31 May 2012 07:00:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1338469482-30936-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198902>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Not sure if it's the right way to fix these though. For example, whil=
e
> 1/1 looks very good from i18n perspective, code-wise it's quite ugly.
> Grouping format strings in array also prevents gcc from checking
> correct parameters, I think.
[...]
> --- a/branch.c
> +++ b/branch.c
> @@ -74,25 +74,43 @@ void install_branch_config(int flag, const char *=
local, const char *origin, cons
[...]
> -		strbuf_addstr(&key, origin ? "remote" : "local");
> -
> -		/* Are we tracking a proper "branch"? */
> -		if (remote_is_branch) {
> -			strbuf_addf(&key, " branch %s", shortname);
> -			if (origin)
> -				strbuf_addf(&key, " from %s", origin);
> +		if (rebasing) {
> +			if (remote_is_branch) {
> +				if (origin)
> +					printf("Branch %s set up to track remote branch %s from %s by r=
ebasing.\n",
> +					       local, shortname, origin);
> +				else
[...]
> +			} else {
> +				if (origin)
[...]
> +			}
> +		} else {
> +			if (remote_is_branch) {
[...]

I think a table-driven version of this switchboard would be much
easier to read, even if it would hurt gcc's -Wformat checking.  If the
-Wformat safety is too precious to lose, would something like the
following work?

	switch (tracking_msg_flags) {
	case REBASING | REMOTE_IS_BRANCH | ORIGIN:
		printf(_("Branch %s set up to track remote branch %s ..."),
			...
		break;
	case REBASING | REMOTE_IS_BRANCH:
		printf(_(...
