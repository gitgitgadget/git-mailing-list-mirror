From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Thu, 02 Feb 2012 20:44:08 +0100
Message-ID: <op.v82g3ura0aolir@keputer>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com,
	"Ben Walton" <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Thu Feb 02 20:44:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2Zv-0003qI-JE
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396Ab2BBToP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:44:15 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33043 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab2BBToO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:44:14 -0500
Received: by eaah12 with SMTP id h12so1188476eaa.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 11:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=fjjy2vZvdHceuwf5Wz8dzzSTiFdsk3xvltr9H5JFlyE=;
        b=UVErX+/hMiDpl7VP2oAh2gcm/xCOPH6aLkZtOr7JAub8d/BFmuO9RVrj8yztK2ShNN
         YxR1KHBg+3ACCDc2bdefdBQsvFtJZi39zcFnoglQm6Y1O6reC7asNG9+yTZL532OrVm4
         EALq8/rmGFyeLCeZEX4mwhvEj5/Zf0nSB+HCA=
Received: by 10.213.12.210 with SMTP id y18mr735780eby.6.1328211851292;
        Thu, 02 Feb 2012 11:44:11 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id y12sm12588306eeb.11.2012.02.02.11.44.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 11:44:10 -0800 (PST)
In-Reply-To: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189682>

Wor_k_ around ...


On Thu, 02 Feb 2012 20:32:15 +0100, Ben Walton  
<bwalton@artsci.utoronto.ca> wrote:

> Solaris' /bin/sh was making the IFS setting permanent instead of
> temporary when using it to slurp in credentials in the generated
> 'dump' script of the 'setup helper scripts' test in t0300-credentials.
>
> The stderr file that was being compared to expected-stderr contained the
> following stray line from the credential helper run:
>
> warning: invalid credential line: username foo
>
> To avoid this bug, capture the original IFS and force it to be reset
> after its use is no longer required.  For now, this is lighter weight
> than altering which shell these scripts use as their shebang.
>
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
> ---
>  t/t0300-credentials.sh |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index 885af8f..1be3fe2 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -8,10 +8,12 @@ test_expect_success 'setup helper scripts' '
>  	cat >dump <<-\EOF &&
>  	whoami=`echo $0 | sed s/.*git-credential-//`
>  	echo >&2 "$whoami: $*"
> +	OIFS=$IFS
>  	while IFS== read key value; do
>  		echo >&2 "$whoami: $key=$value"
>  		eval "$key=$value"
>  	done
> +	IFS=$OIFS
>  	EOF
> 	cat >git-credential-useless <<-\EOF &&


-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
