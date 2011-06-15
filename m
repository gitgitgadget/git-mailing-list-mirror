From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gc getting called on each git command ... what's wrong?
Date: Wed, 15 Jun 2011 17:35:06 +0200
Message-ID: <201106151735.07137.jnareb@gmail.com>
References: <BANLkTi=oUARfwvNFNj-_FvZdwxQgibqPOg@mail.gmail.com> <m3pqmodzee.fsf@localhost.localdomain> <BANLkTi=w10KQ3MSd5YuYR+S=eMgywNTY-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 17:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWs7n-00010U-RO
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 17:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab1FOPfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 11:35:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38065 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab1FOPfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 11:35:17 -0400
Received: by fxm17 with SMTP id 17so490505fxm.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=GDFjmB8qajU1L//rVASBiZ8FbDp0OioMhNgqyhq1xvk=;
        b=gThtUb87kw7LqttAFiQNhVFu2aIRsasFAA+so/mAlr1idBqOhWa3XxaEuDAJ45G8bL
         PSCekkBRhBz4EO11qJJf/TEs9AM7xwq4ndd3FkSll7rA8tegT5hl3xE10X7SokVuqd5E
         +QIzZPu8SIzLMrgm2PinvZjIMODk2sBD1wngs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VP9CW6jB0d1qySdV34LkrNz6EohUxjKaVwQE/nLd3D9NUELA/KUqb1HOLj4gV7+hyQ
         cCrJkWyypgFzcva9QUDCqM/lEnTxdL7PcDUC1gA74I7Cqz+I3cHFc1rZM9YD5WC3jt09
         SkcanpZ4ye/QKITBjW3knAPDHO47DtuXPPFcw=
Received: by 10.223.54.148 with SMTP id q20mr759860fag.84.1308152114355;
        Wed, 15 Jun 2011 08:35:14 -0700 (PDT)
Received: from [192.168.1.15] (abwp5.neoplus.adsl.tpnet.pl [83.8.239.5])
        by mx.google.com with ESMTPS id a18sm288677fak.5.2011.06.15.08.35.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 08:35:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTi=w10KQ3MSd5YuYR+S=eMgywNTY-A@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175838>

On Wed, 15 Jun 2011, Geoff Russell wrote:
> On Thu, Jun 9, 2011 at 2:39 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> > Peter Harris <git@peter.is-a-geek.org> writes:
> > > On Tue, Jun 7, 2011 at 9:33 PM, Geoff Russell wrote:
> > > >
> > > > As of today, almost every time I do a git command, gc is getting
> > > > invoked.
> > >
> > > >   There are 96 pack files.
> > >
> > > That's why. See gc.autopacklimit in "git help config" -- by default,
> > > git will gc if there are more than 50 pack files.
> >
> > Actually it looks like it is combination of this and packSizeLimit set
> > to 30M.  Git notices that it has too many packfiles, and tries to
> > repack them, but packlimit forces Git to split it into small
> > packfiles... and end up with more packfiles than limit anyway.
> 
> Thanks to everybody. This is exactly what was happening and the problems
> went away when I set the packSizeLimit higher ... 3000M
 
Why did you set packSizeLimit at all?

 
> >
> > Perhaps git should notice that it has nonsensical combination of
> > options...
> 
> That would be nice. It should be reasonably easy to work out that the
> packSizeLimit will guarantee too many pack files after the gc.
> Disobeying a users wishes shouldn't be undertaken lightly, but sometimes
> we stuff up :) 

Well, git can simply notice that each except perhaps on file has
size greater or equal to gc.packSizeLimit, and then ignore gc.autopacklimit
hint, because repacking would not reduce number of packs, and not lower
it below gc.autopacklimit.

If `git gc` is called interactively, we can warn user about this situation...

-- 
Jakub Narebski
Poland
