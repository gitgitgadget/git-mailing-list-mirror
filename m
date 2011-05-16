From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bikeshedding advice on the ab/i18n-scripts series
Date: Mon, 16 May 2011 11:26:00 -0500
Message-ID: <20110516162600.GA25468@elie>
References: <BANLkTi==pxyy7OeZT0mn33iJHrc5R7vHBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 18:26:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM0ca-0005jO-81
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 18:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab1EPQ0L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 12:26:11 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48504 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab1EPQ0K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 12:26:10 -0400
Received: by gyd10 with SMTP id 10so1569166gyd.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XGylMIK796bgBLaAQuP63J8QbyLGE8x11Izm8SHro5E=;
        b=Wqm5Ia2bb3H7O88X8+vqfGZU75MdXxMxsMs2BD+iecNbV9JjSHApemTb1XNzSXTISW
         xd/hrFRB6o9sQ+E55mN83dKtXaqk11OmhyHdjhxpYSJR46y0RMqKjvQfTx/c4Vo0XsoE
         yl2j6Cd1uCQTnr3xZQspjTf7MTQfj7OEJwRso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kFwEwZ8BYvEDyOw0ZWXiC383fWRWL80sgCbwe9EGIdzXbAcRnUXK+qs1HjNVYCSf7s
         ILkqWNAsK4ac9u3grj+rcZI6iK5qcrV2khVnuumnRrP+MQfm/WH/KwqZdOstw/saok4b
         VisJbCj+mX0Gw5T1IZAwkOSRci1X4/2/S+N9M=
Received: by 10.150.75.10 with SMTP id x10mr3656514yba.110.1305563169480;
        Mon, 16 May 2011 09:26:09 -0700 (PDT)
Received: from elie ([69.209.63.133])
        by mx.google.com with ESMTPS id r9sm2545932yba.16.2011.05.16.09.26.07
        (version=SSLv3 cipher=OTHER);
        Mon, 16 May 2011 09:26:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi==pxyy7OeZT0mn33iJHrc5R7vHBw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173744>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Oh, and for all the convertion of:
>
>     echo >&2 "$(gettext "foobar")"
>
> I've already done:
>
>     (
>         gettext "foobar" &&
>         echo
>     ) >&2

Some day we might want to introduce a gettext_ln function or something
similar.  But that doesn't seem urgent; I wouldn't be appalled by
having to read 'gettext "foobar" && echo' in a block surrounded by
braces (or even a subshell, even though it makes shells waste a
fork()).

As for what to call the envvars, I have no strong preference there,
either.  If you don't care about compatibility with the real gettext.sh
then it should be possible to do the variable munging automatically,
using a loop:

	for var in $(git sh-i18n--envsubst --variables "$fmt")
	do
		eval "sh_i18n_$var"=3D\$var
		export "sh_i18n_$var"
	done

with an understanding that git sh-i18n--envsubst substitutes in
${sh_i18n_$var} where it sees '$var' in the format string.

But if we do want to use the real envsubst some day then that is not
possible.  I dunno.
