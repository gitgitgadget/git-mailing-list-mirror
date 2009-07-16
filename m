From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v5] git-am: allow e-mail file(s) as input
Date: Thu, 16 Jul 2009 00:09:31 -0700
Message-ID: <4A5ED22B.6050101@gmail.com>
References: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org> <eb6317e39369adc8d2594c35ee351b49aaadcc24.1247721562.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 16 09:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRL6A-000714-Nv
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 09:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbZGPHJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 03:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbZGPHJf
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 03:09:35 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:62400 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZGPHJf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 03:09:35 -0400
Received: by wa-out-1112.google.com with SMTP id j5so744218wah.21
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 00:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=1ksN91r4G7OxD8JXPegGFOhhw/GIEv3cQppHKeViGEQ=;
        b=H22Q8js8rSGUGjp5cAXyGxmv/5o0rn+Ldh0yVO2Jx2O5bJtJu4onTrzmpItdSnJGqs
         tvK/hoHsm07WhIBE67OnsROISsv8e+rthLh9b7q8qdPdgEUkke08S26FHHhQwKAqcgp3
         hDeMTSV1qC2mCU732iZPxJ4Z+oRq45UjKmql4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=XAXgCg4JtyD3HmZuovIfXaKiISCrqtPGGKtPqr8VMaXzoxr19OXXReRR18uoZK0UuN
         4BybdY4iktLe9suw3g7rKMUNMy/kLbRAjecf6devWufs+7YqMJHOb1ftazJC6DgBygP6
         lRCqPyh8khVFlg8qLDiHNXaJyReP9jOzR9P3U=
Received: by 10.115.108.2 with SMTP id k2mr3591084wam.131.1247728173973;
        Thu, 16 Jul 2009 00:09:33 -0700 (PDT)
Received: from ?10.10.0.3? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id m28sm15262398waf.37.2009.07.16.00.09.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Jul 2009 00:09:33 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <eb6317e39369adc8d2594c35ee351b49aaadcc24.1247721562.git.nicolas.s.dev@gmx.fr>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123372>

Nicolas Sebrecht wrote:
> diff --git a/git-am.sh b/git-am.sh
> index d64d997..2b55ddc 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -162,6 +162,17 @@ check_patch_format () {
>  		return 0
>  	fi
>  
> +	# Then, accept what really looks like (series of) email(s).
> +	# the first sed select headers but the folded ones
> +	sed -e '/^$/q' -e '/^[[:blank:]]/d' "$1" |
> +	# this one is necessary for the next 'grep -v'
> +	sed -e '/^$/d' |
> +	grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' ||
> +	{
> +		patch_format=mbox
> +		return 0
> +	}
> +
>  	# otherwise, check the first few lines of the first patch to try
>  	# to detect its format
>  	{

This fails t4150-am.sh #10 (am -3 -q is quiet). You should redirect the
output of the sed and grep to /dev/null like Junio did in his "how about
this" patch.

Also, writing some tests would be helpful.
