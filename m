From: demerphq <demerphq@gmail.com>
Subject: Re: Checking for a valid email address
Date: Fri, 27 Feb 2009 10:20:33 +0100
Message-ID: <9b18b3110902270120t15babbc0oe2975c086297e1e0@mail.gmail.com>
References: <799406d60902261928q2c691112yf24d01b92a3dad6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 10:22:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcyuz-0000Nt-S6
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 10:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbZB0JUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 04:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbZB0JUh
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 04:20:37 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:23225 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbZB0JUg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 04:20:36 -0500
Received: by yw-out-2324.google.com with SMTP id 5so745716ywh.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 01:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=04Yo9wCzho2F3ki7sYropmwsqQnl9yL1py5p0OCysko=;
        b=n9A3oyybat2pQgODupBmuVYsJ3rjxC/zXCd2uExsbVIrnniUUklkzg9gJgAlgD2fZI
         TiwsJFqHhG/+H3GsKwv0K2V0SnAV+acJHKns2rgGN2i3YtPrbJBtrcomlb/Lgym76FM7
         OfbeHN5oMiiLsoyBtifduTf6berffaxDADOJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TIxiNdCCVm+nslrY0HSED2T4K1DutdGGzwH4yZb1sjRbGtgv9etx5N363zWRfKEPNE
         BJG3eoEys9GoZYkPM4h7xooa/ig24KgPj3+FC8nMhKotbmIwTkl+U+6MxHIMZqUOEgPB
         8TUxppBT2nplxuU9kfnejfJmuYym4krnwt+wM=
Received: by 10.231.10.68 with SMTP id o4mr2283058ibo.33.1235726433299; Fri, 
	27 Feb 2009 01:20:33 -0800 (PST)
In-Reply-To: <799406d60902261928q2c691112yf24d01b92a3dad6c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111652>

2009/2/27 Adam Mercer <ramercer@gmail.com>:
> Hi
>
> We are in the process of migrating some of our repositories from CVS
> to Git in a two step process, first to a centralised Git setup then
> (hopefully) onto a more distributed development model. In the testing
> we have been doing so far the only problem we have run into is
> developers not setting their email addresses correctly so the
> changelogs are filled with spurious address. Does anyone know of a
> pre-commit hook that could check for a valid email address prior to
> allowing a commit? Or another way that this can be acheived?

If you are using Perl 5.10 or later then you can use the following regex:

my $email = qr {
    (?(DEFINE)
      (?<address>         (?&mailbox) | (?&group))
      (?<mailbox>         (?&name_addr) | (?&addr_spec))
      (?<name_addr>       (?&display_name)? (?&angle_addr))
      (?<angle_addr>      (?&CFWS)? < (?&addr_spec) > (?&CFWS)?)
      (?<group>           (?&display_name) : (?:(?&mailbox_list) | (?&CFWS))? ;
                                             (?&CFWS)?)
      (?<display_name>    (?&phrase))
      (?<mailbox_list>    (?&mailbox) (?: , (?&mailbox))*)

      (?<addr_spec>       (?&local_part) \@ (?&domain))
      (?<local_part>      (?&dot_atom) | (?&quoted_string))
      (?<domain>          (?&dot_atom) | (?&domain_literal))
      (?<domain_literal>  (?&CFWS)? \[ (?: (?&FWS)? (?&dcontent))* (?&FWS)?
                                    \] (?&CFWS)?)
      (?<dcontent>        (?&dtext) | (?&quoted_pair))
      (?<dtext>           (?&NO_WS_CTL) | [\x21-\x5a\x5e-\x7e])

      (?<atext>           (?&ALPHA) | (?&DIGIT) | [!#\$%&'*+-/=?^_`{|}~])
      (?<atom>            (?&CFWS)? (?&atext)+ (?&CFWS)?)
      (?<dot_atom>        (?&CFWS)? (?&dot_atom_text) (?&CFWS)?)
      (?<dot_atom_text>   (?&atext)+ (?: \. (?&atext)+)*)

      (?<text>            [\x01-\x09\x0b\x0c\x0e-\x7f])
      (?<quoted_pair>     \\ (?&text))

      (?<qtext>           (?&NO_WS_CTL) | [\x21\x23-\x5b\x5d-\x7e])
      (?<qcontent>        (?&qtext) | (?&quoted_pair))
      (?<quoted_string>   (?&CFWS)? (?&DQUOTE) (?:(?&FWS)? (?&qcontent))*
                           (?&FWS)? (?&DQUOTE) (?&CFWS)?)

      (?<word>            (?&atom) | (?&quoted_string))
      (?<phrase>          (?&word)+)

      # Folding white space
      (?<FWS>             (?: (?&WSP)* (?&CRLF))? (?&WSP)+)
      (?<ctext>           (?&NO_WS_CTL) | [\x21-\x27\x2a-\x5b\x5d-\x7e])
      (?<ccontent>        (?&ctext) | (?&quoted_pair) | (?&comment))
      (?<comment>         \( (?: (?&FWS)? (?&ccontent))* (?&FWS)? \) )
      (?<CFWS>            (?: (?&FWS)? (?&comment))*
                          (?: (?:(?&FWS)? (?&comment)) | (?&FWS)))

      # No whitespace control
      (?<NO_WS_CTL>       [\x01-\x08\x0b\x0c\x0e-\x1f\x7f])

      (?<ALPHA>           [A-Za-z])
      (?<DIGIT>           [0-9])
      (?<CRLF>            \x0d \x0a)
      (?<DQUOTE>          ")
      (?<WSP>             [\x20\x09])
    )

    (?&address)
}x;

which is a fully RFC compliant perl regex for validating any email address.

Have fun, and if you use it credit Abigail of the Perl community for
writing it.

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
