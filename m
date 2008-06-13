From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 14:05:42 +0200
Message-ID: <237967ef0806130505p6082deb5lca15f8f06771b332@mail.gmail.com>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
	 <20080611230344.GD19474@sigill.intra.peff.net>
	 <alpine.LFD.1.10.0806111918300.23110@xanadu.home>
	 <loom.20080612T042942-698@post.gmane.org>
	 <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
	 <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>
	 <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com>
	 <7vlk1az8aa.fsf@gitster.siamese.dyndns.org>
	 <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com>
	 <alpine.DEB.1.00.0806130551200.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Eric Raible" <raible@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 13 14:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K783W-0005M3-OK
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 14:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760344AbYFMMFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 08:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbYFMMFt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 08:05:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:15400 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760344AbYFMMFn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 08:05:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2482884rvb.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hxc1Vod/0KqL4fZ4Di0bJbBmCkxYWjYwTPyk1OMz9Eo=;
        b=F2E8hoSCxcG0ti6lXnL2qPXGsitOF4bE54CNX2Sv9Ue86drsub21K6gRLB3yZ1ihOj
         EHJzyVSmmJeXLvl4HsljjbdWqHwJs/Tlf2YVMZiIa1VVXQajcHCNTAS3dc0C7eaVNNix
         85KGfhfKyKhNoY8F2ABr+0SFISRCJ4GVEBmjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=W4bPc0o0s8K1eI4JcDaifgawG0JXzRTUqvELctCuufF3KyA0oC5a+adK+eANAx+a86
         WjNMFx3hlHeuZ7mWWh/4pn2aF93sDL+kBii/ig3hoUsNYNsjGh65FlNQMYxKX7aWOqol
         RPxz3k6jzbQSWHFlXPXCKFlSd4Lc/5RyaWy8o=
Received: by 10.141.15.19 with SMTP id s19mr1777799rvi.39.1213358742997;
        Fri, 13 Jun 2008 05:05:42 -0700 (PDT)
Received: by 10.141.153.6 with HTTP; Fri, 13 Jun 2008 05:05:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806130551200.6439@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84869>

2008/6/13 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Thu, 12 Jun 2008, Eric Raible wrote:
>
>> On Thu, Jun 12, 2008 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Perhaps
>> >
>> >  http://thread.gmane.org/gmane.comp.version-control.git/84665/focus=84670
>> >
>> > The user explicitly asks to stash it for a while, where the definition of
>> > the "while" comes from reflog's retention period.
>>
>> But that doesn't answer the basic question as to why it's ok
>> to trash data that the user explicitly asked git to save?
>
> If the user really asked git to save the changes, she would have
> _committed_ them.
>
> "git stash" really is only about shelving quickly and dirtily something
> you'll need (or maybe need) in a moment.
>
> If you need something from the stash a day after stashing it, you have a
> serious problem with understanding what branches are for.

Even if everyone were to eventually agree with this, I think it's a bit rude
to teach people who stored something important in a stash for a month that
this is the case by deleting their work.

Even with the documentation update, if you're a newbie, you might not know
that git in some places automatically calls git gc when you git pull, as in
the example Brandon gave.

-- 
Mikael Magnusson
