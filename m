From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix chop_str not to cut in middle of utf8 multibyte chars.
Date: Tue, 20 May 2008 15:19:01 -0700 (PDT)
Message-ID: <m3lk244o16.fsf@localhost.localdomain>
References: <g0vdse$rj6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Waldenborg <anders@0x63.nu>
X-From: git-owner@vger.kernel.org Wed May 21 00:20:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyaBd-0005Kc-0Q
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 00:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761582AbYETWTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 18:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761043AbYETWTI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 18:19:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:15112 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760997AbYETWTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 18:19:05 -0400
Received: by ug-out-1314.google.com with SMTP id h2so24508ugf.16
        for <git@vger.kernel.org>; Tue, 20 May 2008 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=yL8/YvdIZJWxdoxXukTu6O56PU1W72Q2td+rNBmwLqM=;
        b=UrZN3a2JQ54BSv5FNsFlgG7iD8+kCv38vnub1QRWtsoqpQO8HIoD6TwmTBgyDQIG+my82vnQytpctLSLQMK7t9AZsisi2DpvhuBTSfWFqDF3zN90xa7LSzlQ+DfwxX5Wp/QOTeoaSfEni3/vcl5wqvYiPwbRxYdvlU534v5lIPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=tATAShGBNn5ZzhdojsK86Ock0qJbyn9yTXM1fVo3MQKUDB2I5/YXdhMbQaRXgesy+GGEV3LlIocqkO+cKLp6cS3dOfErtffkUiNKfdxwZro61MlbORIDmy1xRmhIjcUgbz0ur26LnmMnQEAukOGHrECVQjQysUx1YZt8Unzu2NI=
Received: by 10.67.25.9 with SMTP id c9mr106023ugj.46.1211321943641;
        Tue, 20 May 2008 15:19:03 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.224.111])
        by mx.google.com with ESMTPS id m5sm1559916gve.3.2008.05.20.15.18.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 May 2008 15:19:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4KMJ59X011988;
	Wed, 21 May 2008 00:19:06 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4KMJ1Td011985;
	Wed, 21 May 2008 00:19:01 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <g0vdse$rj6$1@ger.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82511>

Anders Waldenborg <anders@0x63.nu> writes:

> Without this fix at least author name in short log may cut in middle of a
> multibyte char. When the result comes to esc_html to_utf8 is called again,
> which doesn't find valid utf8 and decodes using $fallback_encoding making
> it even worse.

Thanks a lot.  This is certainly a good thing, although I think that
the proper solution (but which would need much more work) would be to
ensure that all information is stored in Perl internal form, and not
only ensured on output.

I would change title of this commit to be more descriptive what this
commit does; or rather make current subject the first sentence of
commit summary, have something like the following for commit message:

gitweb: Convert string to Perl internal form before chopping in chop_str

Fix chop_str not to cut in middle of utf8 multibyte chars.  Without
this fix at least author name in short log may cut in middle of a
multibyte char. When the result comes to esc_html to_utf8 is called
again, which doesn't find valid utf8 and decodes using
$fallback_encoding making it even worse.
 
> Signed-off-by: Anders Waldenborg <anders@0x63.nu>
> ---
>   gitweb/gitweb.perl |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 2facf2d..8308e22 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -866,6 +866,10 @@ sub chop_str {
>          my $add_len = shift || 10;
>          my $where = shift || 'right'; # 'left' | 'center' | 'right'
> 
> +       # Make sure perl knows it is utf8 encoded so we don't
> +       # cut in the middle of a utf8 multibyte char.
> +       $str = to_utf8($str);
> +

I like the comment here. It explains the whys of code.

>          # allow only $len chars, but don't cut a word if it would fit in $add_len
>          # if it doesn't fit, cut it if it's still longer than the dots we would add
>          # remove chopped character entities entirely
> 

This patch is whitespace damaged, by the way.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
