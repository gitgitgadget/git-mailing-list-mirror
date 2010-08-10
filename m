From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: fix test broken by
 jn/commit-no-change-wo-status
Date: Tue, 10 Aug 2010 18:56:12 -0500
Message-ID: <20100810235612.GC2099@burratino>
References: <1281447519-25862-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 01:57:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiyhb-0004sG-Pv
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 01:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758040Ab0HJX5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 19:57:47 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:56889 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab0HJX5q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 19:57:46 -0400
Received: by qyk7 with SMTP id 7so3832592qyk.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 16:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZmttPvCwhqUCXC0wcgjQf8Q4hU0rxGTl/Qclued5274=;
        b=MYpJjRMX5LvMqLt0OS4ROHJ7CdF/nvt29QJrQlRy8WtDL9CBcQS4fPY2W3pCEmAka9
         kcM1dM3I/1xXic8uKxa5FNPYn+0yF/j9IosZ6avCzeqHsdhZgjd+OKHnd+be7dLQvJ0E
         ruiie9LNKwJ2JgKmXRJ8wCm6fV0xh4WWGNWPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qd1Bi6Ogla6VMAmynH93oLZFhXxxkDqUhCLDpS0ceyh+7Nrs9x+dgrcrXpAdLwBNmo
         yzo4Ip1M6U/hmu4mCF0dRLo551cUt56DiPVaFtb4lg+PYCSlNzd1kxiXzRDRvwk1opBk
         FhkDbWlKaJIDzZzwE2umz+RHFNFC/Rq8YRpQc=
Received: by 10.224.69.162 with SMTP id z34mr10169993qai.38.1281484665240;
        Tue, 10 Aug 2010 16:57:45 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n6sm63974qcu.7.2010.08.10.16.57.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 16:57:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281447519-25862-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153175>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> +++ b/t/t6040-tracking-info.sh
> @@ -70,8 +70,9 @@ test_expect_success 'status' '
>  		git checkout b1 >/dev/null &&
>  		# reports nothing to commit
>  		test_must_fail git commit --dry-run
> -	) >actual &&
> -	grep "have 1 and 1 different" actual
> +	) >actual 2>actual-err &&
> +	grep "nothing to commit" actual &&
> +	grep "Already on" actual-err

Hmm, this looks rather like a bug in the series: it looks
like as an unpleasant side-effect it eliminates the

 # Not currently on any branch.

-like output.
