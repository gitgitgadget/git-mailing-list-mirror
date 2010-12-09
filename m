From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 09/18] gitweb: Revert reset_output() back to original code
Date: Thu, 09 Dec 2010 15:58:41 -0800 (PST)
Message-ID: <m3pqta1ou3.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-10-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:02:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQqR4-0007o2-Cc
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900Ab0LIX6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 18:58:44 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:57479 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800Ab0LIX6n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 18:58:43 -0500
Received: by fxm18 with SMTP id 18so3113402fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 15:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=UtoRjQ7fuekq6/TqI8FapAqe3H8Qfk36ZAWnpp8U81A=;
        b=qPB36jo19YmBrNMY6hoCWvoCWjFXQj7bIQ8gPz8gr37x6OnpF5nvzztPw9TDPycjfg
         zxObDGxmUvSTyRdoGON3hwbSpfkfXxXgwkZSMBnjFgl8nLQV3x10tjYnJ9M6v5jsnRhm
         XT6XePW32+rQjktg3lVsGFtG7TitrEzDxsMDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=VQvx50dk3vGDtnoEeaSIOKuIjOhMXkUu9EbbouQgzkG2ve++K+Z0UBCTx83Oy1gwe3
         qi36fn89lc1uFvBHgw4/JS8UVtiEz88fHj2f5KKHYNTUlLItXSpQDU67nqsMWwaRdZWY
         x15RUerBe+25UbUV6HBuyg9KhM1lUiUuOALho=
Received: by 10.223.83.133 with SMTP id f5mr72387fal.101.1291939121989;
        Thu, 09 Dec 2010 15:58:41 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id n26sm736290fam.13.2010.12.09.15.58.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 15:58:41 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB9NwDBQ020071;
	Fri, 10 Dec 2010 00:58:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB9NvuEc020067;
	Fri, 10 Dec 2010 00:57:56 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-10-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163361>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> Reverted change to reset_output as
> 
> 	open STDOUT, ">&", \*STDOUT_REAL;

For somebody not following our discussion the above would be very,
very cryptic... though I suppose this would be squashed in final
(ready to be merged in) version of the code.
 
> causes assertion failures:
> 
> 	Assertion !((((s->var)->sv_flags & (0x00004000|0x00008000)) == 0x00008000) && (((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVGV || ((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVLV)) failed: file "scalar.xs", line 49 at gitweb.cgi line 1221.

It looks like bug in Perl, because it should give some kind of Perl
error, not failed assertion from within guts of Perl C code.

Which Perl version are you using?

> if we encounter an error *BEFORE* we've ever changed the output.

And how to reproduce this error (i.e. how did you found it)?
 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1d8bc74..e8c028b 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1225,7 +1225,7 @@ sub change_output {
>  
>  sub reset_output {
>  	# This basically takes STDOUT_REAL and puts it back as STDOUT
> -	open STDOUT, ">&", \*STDOUT_REAL;
> +	open(STDOUT,">&STDOUT_REAL");

Hmmm... how to silence spurious warning then:

  gitweb.perl: Name "main::STDOUT_REAL" used only once: possible typo
  at ../gitweb/gitweb.perl line 1130.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
