From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb and unicode special characters
Date: Fri, 12 Dec 2008 11:37:57 -0800 (PST)
Message-ID: <m37i65gp6b.fsf@localhost.localdomain>
References: <3f2beab60812121033r5d41894t77acc271b7c6955c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Santhosh Thottingal" <santhosh00@gmail.com>
To: "Praveen A" <pravi.a@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:39:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBDrM-0006IU-A0
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 20:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYLLTiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 14:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbYLLTiF
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 14:38:05 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:53319 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbYLLTiA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 14:38:00 -0500
Received: by ewy10 with SMTP id 10so1939228ewy.13
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 11:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=IjSGunVPsPON4WZB0NU0I2tN6CJt6tsptNewL3ou6Ow=;
        b=UUP659mM2B+2A/4NzP+vjzv9oenL9xAPKWr2T6fPtxmN6+uKTUz4j+ytbR+SECRo2r
         LNH11kRkQpCJG44TbIk3u8ukhZSF6DH8Rk9tJHxF4SrAYBsV6NBUvJcYxbs0elYbZmmX
         /+f+R2tT75gjLlnBP/xZb6Y+l7ZVZvNQtuxWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=FbxS3k21qefT7rUOokzJBWp7WrY3SctiYhozaoYWjshkn3jScq3ya38NrUg3zS68oS
         EaJevbMGGhLQjR4v9oP6xrQJSTGtKVbfDab54IQdneiO+EmnsBeDSynz6fvnIqayC7T3
         k0VmD8nD14Ggnu62xDC8E34s4B1lcxQA4OZco=
Received: by 10.210.58.13 with SMTP id g13mr1235233eba.19.1229110678318;
        Fri, 12 Dec 2008 11:37:58 -0800 (PST)
Received: from localhost.localdomain (abvt119.neoplus.adsl.tpnet.pl [83.8.217.119])
        by mx.google.com with ESMTPS id b33sm4255843ika.17.2008.12.12.11.37.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Dec 2008 11:37:57 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBCJbtGe002401;
	Fri, 12 Dec 2008 20:37:56 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBCJbnAW002398;
	Fri, 12 Dec 2008 20:37:49 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <3f2beab60812121033r5d41894t77acc271b7c6955c@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102932>

"Praveen A" <pravi.a@gmail.com> writes:

> Git currently does not handle unicode special characters ZWJ and ZWNJ,
> both are heavily used in Malayalam and common in other languages
> needing complex text layout like Sinhala and Arabic.
> 
> An example of this is shown in the commit message here
> http://git.savannah.gnu.org/gitweb/?p=smc.git;a=commit;h=c3f368c60aabdc380c77608c614d91b0a628590a
> 
> \20014 and \20015 should have been ZWNJ and ZWJ respectively. You just
> need to handle them as any other unicode character - especially it is
> a commit message and expectation is normal pain text display.
> 
> I hope some one will fix this.

Well, I am bit stumped.  git_commit calls format_log_line_html, which
in turn calls esc_html.  esc_html looks like this:

  sub esc_html ($;%) {
  	my $str = shift;
  	my %opts = @_;
  
  **	$str = to_utf8($str);
  	$str = $cgi->escapeHTML($str);
  	if ($opts{'-nbsp'}) {
  		$str =~ s/ /&nbsp;/g;
  	}
  **	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
  	return $str;
  }

The two important lines are marked with '**'.  Not to_utf8 subroutine
is very simple wrapper:

  # decode sequences of octets in utf8 into Perl's internal form,
  # which is utf-8 with utf8 flag set if needed.  gitweb writes out
  # in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
  sub to_utf8 {
  	my $str = shift;
  	if (utf8::valid($str)) {
  		utf8::decode($str);
  		return $str;
  	} else {
  		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
  	}
  }

So it looks like Perl treats \20014 and \20015 (ZWNJ and ZWJ) as
belonging to '[:cntrl:]' class. I don't know if it is correct from the
point of view of Unicode character classes, therefore if it is a bug
in Perl, or just in gitweb.

We might need protecting similar to ($1 ne "\t"), like (ord($1) < 127)
or something... or perhaps we shouldn't use POSIX character class
[:cntrl:] but something different when dealing with Unicode,
e.g. \p{Cc} or \p{Control}, or perhaps \p{C} (other). I don't know
Perl (nor Unicode) enough to decide...


P.S. Even that might not help much, as Savannah uses git and gitwev
version 1.5.6.5, which is probably version released with some major
distribution.  As of now we are at 1.6.0.5...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
