From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: parse-options: ambiguous LASTARG_DEFAULT and OPTARG
Date: Sat, 06 Jun 2009 13:14:42 -0700
Message-ID: <4A2ACE32.8080504@gmail.com>
References: <4A28B072.8030006@gmail.com> <4A2A4534.80604@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@madism.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jun 06 22:15:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD2IR-0001Kw-9J
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 22:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbZFFUOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 16:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbZFFUOo
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 16:14:44 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:38459 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbZFFUOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 16:14:43 -0400
Received: by gxk10 with SMTP id 10so84323gxk.13
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=lmsGerW4gpx5PvDUcazKFbjMPA7n6AZlNHLzzQWehqY=;
        b=qTKRixWGa3v7dpey3adnGTlyYcbUcHZ0/dg7ySNNZAu6KrHoiGtjMUQi0GaVYRrI8u
         O7Hd/lQvunxbjIo/GTDdhuTE3DPluY2XKY1NZREkyQXcu9SiQuiS/FiQbqZSpz4My60r
         aKI/MwMEJppZj+0rxZcL7r0D1W/h7+9zhPv/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=yDkNATqTzoWd3fKQKuJVMd7k+2djO0mS7saesejzSW5j75uByNSC240uv7n/s5lZmK
         D5beniAeb9jGg0inY9n9cd33fTEnB1fP1lv91ScZ5aOeBvGSUIfSvj3n0cOVtFlgTyRG
         ObMQAe8N4R44IVnDsEQYgNWssnSX6P8y0QVYg=
Received: by 10.90.72.3 with SMTP id u3mr4165332aga.82.1244319285133;
        Sat, 06 Jun 2009 13:14:45 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id 1sm3377936agb.48.2009.06.06.13.14.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 13:14:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <4A2A4534.80604@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120932>

Ren=E9 Scharfe wrote:
> PARSE_OPT_OPTARG overrides PARSE_OPT_LASTARG_DEFAULT, as Pierre noted=
 in
> commit 1cc6985c, which introduced the latter, so the two should not b=
e
> used together.

Ok, thanks. This means I used it wrong when I switched over show-branch
:-/ I'll have to send a follow-up patch for that.

> PARSE_OPT_LASTARG_DEFAULT uses the default value if the option is the
> last one on the command line and requires an explicit argument if it'=
s
> not the last, as you found out above.  That's also what the code says
> and its name implies; the comment in parse-options.h (by yours truly)
> is probably misleading because it doesn't mention this condition.

I was mislead. When I read it I thought I had to use the flag to say
that the default value will be used in the case when no argument is
given. I completely ignored the LASTARG part (I thought it was
referencing the default arg). I think just adding what you said here to
parse-options.h will help others to avoid this.

> I don't remember any other program having options with such a
> behaviour; I'm not sure how to stress that --merged needs to be the
> last option, as implied by the help message.

"git tag --contains" is the same. Figuring out a way to say that the
syntax changes when it's the last option versus in the middle is not
obvious to me either.
