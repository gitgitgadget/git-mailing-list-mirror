From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH v2] Let mailsplit and mailinfo handle mails with CRLF
 line-endings
Date: Tue, 04 Aug 2009 16:40:57 -0500
Message-ID: <-WLgEY11_FJV7byR76pdKYY69wMV5WIIRr-HvzsgumvNMS0FNKTSfA@cipher.nrlssc.navy.mil>
References: <4A7735B0.2040703@zytor.com> <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com> <7v7hxk5b4y.fsf@alter.siamese.dyndns.org> <20090804172638.GA15136@blimp.localdomain> <20090804210327.GA23747@blimp.localdomain> <H9KDJzU0XgndJHC8J4OETn7kxYhGP3gl0YJPR0low0hfIHjZOUsoxw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:41:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYRlD-0001vV-H2
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932878AbZHDVlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 17:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbZHDVlD
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:41:03 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59260 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582AbZHDVlD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 17:41:03 -0400
Received: by mail.nrlssc.navy.mil id n74Lewre010620; Tue, 4 Aug 2009 16:40:58 -0500
In-Reply-To: <H9KDJzU0XgndJHC8J4OETn7kxYhGP3gl0YJPR0low0hfIHjZOUsoxw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 04 Aug 2009 21:40:58.0454 (UTC) FILETIME=[40EE5760:01CA154C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124819>

Brandon Casey wrote:

> Be aware that if we use the version I suggested which pushes the '\r' back
> into the input stream, I think we risk an infinite loop if size == 1.  I don't
> think that is possible from the current callers though.

I think something like this would avoid any potential infinite loop, however improbable:

        if (c == '\n') {
                if (len > 1 && buf[len - 2] == '\r')
                        buf[--len - 1] = '\n';
        } else if (c == '\r') {
                c = getc(in);
                if (c == '\n')
                        buf[len - 1] = '\n';
                else if (c != EOF)
                        ungetc(c, in);
        }

-brandon
