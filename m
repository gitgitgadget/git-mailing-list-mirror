From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Re*: [PATCH] t1503: Fix arithmetic expansion syntax error when using dash
Date: Thu, 23 Sep 2010 07:38:24 +1000
Message-ID: <AFB91AEE-2D2C-4864-A6CD-79780B68C2E9@gmail.com>
References: <4C98EF25.4070700@ramsay1.demon.co.uk> <7viq1xsi7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (iPhone Mail 8B117)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 23:39:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyX1k-00017h-LM
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 23:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183Ab0IVViv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 17:38:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40671 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0IVViu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 17:38:50 -0400
Received: by iwn5 with SMTP id 5so820029iwn.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-transfer-encoding:content-type:message-id:cc
         :x-mailer:from:subject:date:to;
        bh=fwu/s3evKIqtTIZ3XfNX3pIm6GAUvz2cYU0tofnjddA=;
        b=bxUUv3kPRaeZTfMqKdHfSOqcneIP476hyzzxR5juWA/lbiM1el7/OsQIgM6IoSHoFR
         yqiZxJR2GZVBQEtUzZMelEPxZoocm2sLTW7eLi8I9FgyG4y2NOXAblR8ODeskWWaM2Jv
         oHdd+X5V2HgW1pDExxSeMz+k5xMnnXhHxKl78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        b=ruhvGcU6rLiVbRq9umgXi1MAfiZj1bdeSj8nYpaTGm7gIMStRKAsQxH9WRhoEMITOy
         NADgmaQV1CmXdnBTDUbiRKtXR26WGvBiHl4uEPz9OwvsbN7kAsAjenchPOjNzZca+oAT
         Uc7XM77aGIRXfHKOc2ZL7pRBCNbymMM5uwJFM=
Received: by 10.231.151.198 with SMTP id d6mr680165ibw.86.1285191529311;
        Wed, 22 Sep 2010 14:38:49 -0700 (PDT)
Received: from [10.0.1.2] (124-169-3-134.dyn.iinet.net.au [124.169.3.134])
        by mx.google.com with ESMTPS id h8sm13556ibk.15.2010.09.22.14.38.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 14:38:47 -0700 (PDT)
In-Reply-To: <7viq1xsi7a.fsf@alter.siamese.dyndns.org>
X-Mailer: iPhone Mail (8B117)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156836>

Ack. Thanks for the info and corrections.

jon.

On 23/09/2010, at 5:15, Junio C Hamano <gitster@pobox.com> wrote:

> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> On systems which have dash as /bin/sh, such as Ubuntu, the final
>> test (master@{n} for various n) fails with a syntax error while
>> processing an arithmetic expansion. The syntax error is caused by
>> using a bare name ('N') as a variable reference in the expression.
>> 
>> In order to avoid the syntax error, we spell the variable reference
>> as '$N' rather than simply 'N'.
>> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> 
> Thanks.
> 
> POSIX wants shells to support both "N" and "$N" and requires them to yield
> the same answer to $((N)) and $(($N)), but we should aim for portability
> in a case like this, especially when the price we pay to do so is so
> small, i.e. a few extra dollars.
> 
> By the way, on my box, I get this:
> 
>    $ ls l /bin/dash
>    -rwxr-xr-x 1 root root 104024 2008-08-26 02:36 /bin/dash*
>    $ dpkg -l dash | grep '^ii'
>    ii  dash              0.5.4-12          POSIX-compliant shell
>    $ /bin/dash -c 'N=20 ; echo $(( N + 3 ))'
>    23
> 
> I just left it vague by saying "e.g. older dash" in below, but we may want
> to be more precise in the documentation.
> 
> -- >8 --
> CodingGuidelines: spell Arithmetic Expansion with $(($var))
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Documentation/CodingGuidelines |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index b8bf618..2cdd76f 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -43,6 +43,10 @@ For shell scripts specifically (not exhaustive):
> 
>  - We use Arithmetic Expansion $(( ... )).
> 
> + - Inside Arithmetic Expansion, spell shell variables with $ in front
> +   of them, as some shells do not grok $((x)) while accepting $(($x))
> +   just fine (e.g. older dash).
> +
>  - No "Substring Expansion" ${parameter:offset:length}.
> 
>  - No shell arrays.
