From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH RFC 1/2] gitweb: Fix warnings with override permitted but 
	no repo override
Date: Wed, 18 Feb 2009 08:41:54 +0100
Message-ID: <cb7bb73a0902172341x2265e9d4r24a16ef2913bcda6@mail.gmail.com>
References: <499AD871.8000808@oak.homeunix.org>
	 <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com, fg@one2team.net,
	pasky@suse.cz
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 08:43:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZh5s-0006RF-IZ
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 08:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbZBRHl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 02:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbZBRHl4
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 02:41:56 -0500
Received: from mail-ew0-f31.google.com ([209.85.219.31]:45084 "EHLO
	mail-ew0-f31.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbZBRHl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 02:41:56 -0500
Received: by ewy12 with SMTP id 12so1165270ewy.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 23:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zuzXEcB6jworFsygxSpvFRzQklN7AD0ylLIDVJTg4bE=;
        b=FEcWxnEI5z61UmAdvSPQbEde92TCh3ffsaDm2Hw5icsGDfHMH181DH2+D1469StxwE
         BlUIuflW+GsYVpI56VTI9dpLSMokLOlcHBpXYw6eonR3aNT2JrvwOVOaV+Aii9tB6yGD
         Gs+VDEOnWbGJV+6fb4QIPQilnpERKTrR+Ec+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EdiFpw/nT27Pc8GsZYUbR5J7yZuG6YQioimh+4j19xlWDLykptb3pNYRaRqzoSTP0i
         1qAO3XWFSs2RGsQUrO8aylULaVWM4gzkXMZflLJhnqbjUC/zzL8EoiozqCkeWRYD3nqD
         3u3SvSevzCTJ4AJrvdfn5XyKzPn6QO5PIAa4M=
Received: by 10.210.71.13 with SMTP id t13mr3031808eba.90.1234942914046; Tue, 
	17 Feb 2009 23:41:54 -0800 (PST)
In-Reply-To: <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110511>

On Wed, Feb 18, 2009 at 4:00 AM, Marcel M. Cary <marcel@oak.homeunix.org> wrote:
> When a feature like "blame" is permitted to be overridden in the
> repository configuration but it is not actually set in the
> repository, a warning is emitted due to the undefined value
> of the repository configuration, even though it's a perfectly
> normal condition.
>
> The warning is grounds for test failure in the gitweb test script,
> so it causes some new feature tests of mine to fail.
>
> This patch prevents warning and adds a test case to exercise it.
>
> Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
> ---
>
> Here's a small patch I put together while tinkering with bug hyperlinking.
> Does this look reasonable?

My only perplexity is about this:

> @@ -1978,6 +1978,8 @@ sub git_get_project_config {
>                $config_file = "$git_dir/config";
>        }
>
> +       return undef if (!defined $config{"gitweb.$key"});
> +

I'm no Perl expert, so I have no idea: how do non-bool config checks
(which expect arrays) cope with an undef? Also, you may want to add a
non-bool override test in the test suite.

-- 
Giuseppe "Oblomov" Bilotta
