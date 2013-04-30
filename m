From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 18:19:46 -0500
Message-ID: <CAMP44s3QT5z1iWsm0cvQDfmZBp_kWbXatQKGaj8H3kzgdK=QFw@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<7vhaindcuk.fsf@alter.siamese.dyndns.org>
	<CAMP44s2S4AtZUfH4NWCLt=p49QXeYSZKELYbahpBUgDofaFMsw@mail.gmail.com>
	<7vsj27ac2a.fsf@alter.siamese.dyndns.org>
	<CAMP44s3=frHWUh8rQ5kTooUJqwAtkEG37MaeY3Ho6G7-kwZQ_w@mail.gmail.com>
	<7vbo8vabet.fsf@alter.siamese.dyndns.org>
	<CAMP44s02QkL7QAuHHm_uT6B4QCzk9Mur0_w_D8t2A2u1go2F8A@mail.gmail.com>
	<CAMP44s3L6X=iWK7S-JFqp42PmNx4xbh-GnPJpAgur4FGoZYNbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 01:19:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJpx-00022G-B1
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 01:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933910Ab3D3XTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 19:19:50 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:35463 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933898Ab3D3XTt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 19:19:49 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so915365lab.8
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 16:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=y73lbmcY3ncOmcZZ6Fz2sIYJGTQVQRw2anWxGYImWds=;
        b=CqkYWk/TGMMWnpE/LnkpDeSPG0XE1Huq3QbFo4Bcw8v688Ff0E+XEUAOFpfnYwd/Yr
         R7kHlTWjoa/79dRONaAEIYFWRQWb8vRDDFLwbO3DLx2BgV/orr6lCZp7dNNndW6w1SSY
         QY+UTuLTubegyO/OWhiaL1J3sX7Lml8b20MbF4tuiWIkP9yoYM991RV9Pi1kQ9Kol7eL
         gcK6gwZ90OkfuC0hXwBQ8ydXm/xsyoCm2JnCxoFANtJMOpTQWHCURDPeAC6lo1mWlZwq
         R9g/MrY26mR9L1ie4tR//8y+qmbM1DVTwh6jiF0oS9Xa53yEA43X3IVnLUfeefoC+jf2
         sW5w==
X-Received: by 10.112.166.101 with SMTP id zf5mr370129lbb.59.1367363987464;
 Tue, 30 Apr 2013 16:19:47 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 16:19:46 -0700 (PDT)
In-Reply-To: <CAMP44s3L6X=iWK7S-JFqp42PmNx4xbh-GnPJpAgur4FGoZYNbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223042>

On Tue, Apr 30, 2013 at 6:00 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> +static int interpret_empty_at(const char *name, int namelen, int len,
> struct strbuf *buf)
> +{
> +       if (namelen - len < 1 || name[len + 1] == '{')
> +               return -1;
> +
> +       strbuf_reset(buf);
> +       if (len == 0) {
> +               strbuf_add(buf, "HEAD", 4);
> +               return 1;
> +       } else {
> +               strbuf_add(buf, name, len);
> +               return len + 1;
> +       }
> +}

Hmm, it's not correct, and besides, if we don't parse 'master@', it's
much simpler:

/* parse @something syntax, when 'something' is not {.*} */
static int interpret_empty_at(const char *name, int namelen, int len,
struct strbuf *buf)
{
	if (len || (namelen > 1 && name[1] == '{'))
		return -1;

	strbuf_reset(buf);
	strbuf_add(buf, "HEAD", 4);
	return 1;
}

-- 
Felipe Contreras
