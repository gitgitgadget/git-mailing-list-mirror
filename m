From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make test script annotate-tests.sh handle missing authors
Date: Sat, 16 Oct 2010 00:34:58 -0700 (PDT)
Message-ID: <m3sk06617a.fsf@localhost.localdomain>
References: <1287208215-91901-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 09:42:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P71PM-0004J1-TI
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 09:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab0JPHmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 03:42:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52470 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab0JPHmS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 03:42:18 -0400
Received: by bwz15 with SMTP id 15so1538578bwz.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=DeXupVpqwuvb5IWZz22eGSOdOF2ViaK3KqmfzfTBm8w=;
        b=fJ8q0EAL8zCCQcN/iGgJXgzMZN60WdRaLjliLIWd+JlgmLIXStXSufM9utFhLQlg0t
         q0ow66nZikGx6FRfopVeGJ6s1pBX/AJQnRhrsaxP7K9C5c2wqq3CCYH1bNYSJQlsxoxm
         zGTYWI2qNdL6SDJaifPeP7VfYIz8tmt4UeRj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=yFDOr1/3XulLbeXefCRbSY6C5/K7+QWrZxQBeq4nkMEbxDlPG2ZJyB5ztWXehFbH6e
         QwFYgc4dwh7LMA/Giawnpn9Ar/jhDvyPGZoL9R7MEsQS5e3wPVlHa8z/90lI1CNF/2La
         YeafmNC7Qup6gS6Iu+5TAi/GQpODlzzmeKh18=
Received: by 10.204.72.207 with SMTP id n15mr1521073bkj.208.1287214499110;
        Sat, 16 Oct 2010 00:34:59 -0700 (PDT)
Received: from localhost.localdomain (abvv67.neoplus.adsl.tpnet.pl [83.8.219.67])
        by mx.google.com with ESMTPS id y19sm13837348bkw.6.2010.10.16.00.34.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 00:34:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9G7YHpc014970;
	Sat, 16 Oct 2010 09:34:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9G7Y1W8014831;
	Sat, 16 Oct 2010 09:34:01 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1287208215-91901-1-git-send-email-kevin@sb.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159156>

Kevin Ballard <kevin@sb.org> writes:

> Also, I'm not a Perl programmer, so it's possible there's a better idiom
> for this sort of thing.
> 
>  t/annotate-tests.sh |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index 396b965..4e37a66 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -9,6 +9,9 @@ check_count () {
>  	cat .result | perl -e '
>  		my %expect = (@ARGV);
>  		my %count = ();
> +		while (my ($author, $count) = each %expect) {
> +			$count{$author} = 0;
> +		}


First, it is a very bad practice to have variables of different type
named the same way, here %count (hash) and $count (scalar, unused).

Perl idiom way would be

  -		my %count = ();
  +		my %count = map { $_ => 0 } keys %expect;

>  		while (<STDIN>) {
>  			if (/^[0-9a-f]+\t\(([^\t]+)\t/) {
>  				my $author = $1;
> -- 
> 1.7.3.1.186.gc0af9.dirty
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
