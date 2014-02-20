From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Fri, 21 Feb 2014 06:35:06 +0700
Message-ID: <CACsJy8AeZWPz=39ySQr9MrSUiLyJDQbs02sumS9VjbbGWzP9pw@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
 <xmqqzjlocf28.fsf@gitster.dls.corp.google.com> <CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
 <xmqq4n3warni.fsf@gitster.dls.corp.google.com> <CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
 <CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com> <xmqqd2ij9be1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 00:35:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGd9Z-0004uO-Sy
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 00:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbaBTXfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 18:35:38 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:60158 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbaBTXfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 18:35:37 -0500
Received: by mail-yh0-f46.google.com with SMTP id v1so1546073yhn.33
        for <git@vger.kernel.org>; Thu, 20 Feb 2014 15:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KOuN/vzkDbn6kZKUfEVFN8WUtJEUy4v2c2V9UufBbcU=;
        b=yLSMypRshugK8prSeiJ00QNyiAtsIEyND66CBA2whx52QyA8m79v7UMeMCTFgIFWkB
         y4Z/W5Dg6jlLTOx5pEcOWh0jEGZN3rQcaWxtKtPsIdDzF0vxxGXd6PbPKqKSEk69bjz4
         Kq2u4Ahxcw8iX5TPjYA8gFQQjU2MuX80CXwQgCoXG4yihKGZeGsp1m1hB05an8rU3SXS
         N656AzCQCF4wOyfGDnwh17AwZqXiKHVGfTZ7C46RYE5y/W33EzsKlr6GcmTdz9ev8JAW
         ABYXIvUTL3gH/4zGw3R9ECbjGr9jsnCTR5fmKXiefgPfqqPO3QSBQIVI+O7oFiGdgP7U
         HNOQ==
X-Received: by 10.236.61.136 with SMTP id w8mr7292663yhc.14.1392939336820;
 Thu, 20 Feb 2014 15:35:36 -0800 (PST)
Received: by 10.170.115.65 with HTTP; Thu, 20 Feb 2014 15:35:06 -0800 (PST)
In-Reply-To: <xmqqd2ij9be1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242451>

On Thu, Feb 20, 2014 at 1:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Philippe Vaucher <philippe.vaucher@gmail.com> writes:
>
>>> fwiw this is the thread that added --depth=250
>>>
>>> http://thread.gmane.org/gmane.comp.gcc.devel/94565/focus=94626
>>
>> This post is quite interesting:
>> http://article.gmane.org/gmane.comp.gcc.devel/94637
>
> Yes, it most clearly says that --depth=250 was *not* a
> recommendation, with technical background to explain why such a long
> delta chain is a bad idea.

On the other hand, the size reduction is really nice (320MB vs 500MB).
I don't know if we can do this, but does it make sense to apply
--depth=250 for old commits only and shallow depth for recent commits?

For old projects, commits older than 1-2 years is probably less often
accessed and could use some aggressive packing. This still hits
git-blame badly. We could even make sure all objects "on the blame
surface" have short delta chain. But that may be pushing pack-objects
too much.
-- 
Duy
