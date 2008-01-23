From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Wed, 23 Jan 2008 16:42:41 +0000
Message-ID: <b0943d9e0801230842w250ab963t16a1ab3c8024487e@mail.gmail.com>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
	 <200801162147.33448.kumbayo84@arcor.de>
	 <200801162158.26450.kumbayo84@arcor.de>
	 <20080117074559.GB25213@diana.vm.bytemark.co.uk>
	 <20080118042447.GA13178@diana.vm.bytemark.co.uk>
	 <b0943d9e0801230335m4a2d1855uf465d0d134f3ef39@mail.gmail.com>
	 <20080123161014.GA5850@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Peter Oberndorfer" <kumbayo84@arcor.de>, git@vger.kernel.org,
	"Pavel Roskin" <proski@gnu.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 17:43:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHih1-0001zS-I8
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 17:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbYAWQmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2008 11:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbYAWQmo
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 11:42:44 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:8307 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbYAWQmn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 11:42:43 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1796813nze.1
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 08:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=I6erW8udAli+QcxiUyxVim85hSIUFM+NHZnybji7nFk=;
        b=ur0FNj8d+0lMpbbkqLmoUZcFg0qsq0mrJW7uHXLHO+XZ/QGIFNMFeTSfYFN2LT7HEysm3nwm6OoEhCTULQAbugKokBrvL7nDfMPuJmlmFx+CX2U4PWNHindRt/SM5CIuk/xPN6cEx8SuxUP3UgzX4vHMzazW042KAyFoaRl12/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lLhFq4kAbF2w3Cgyiz/G48vqnQLXqXWwn8MFmImZsBBSA6YbrPcChtYAl58jfXGm/pP3J74V1evMWfmsg9k1q+YYq3HuwgwZ5897KvFtk6Ar/m6PsJKrk+FQzIilTjQqChdb5nAezvSQ6tZR6Cz4whuQsG0IApOTNJCljiOFTAA=
Received: by 10.141.171.6 with SMTP id y6mr6486042rvo.84.1201106561756;
        Wed, 23 Jan 2008 08:42:41 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Wed, 23 Jan 2008 08:42:41 -0800 (PST)
In-Reply-To: <20080123161014.GA5850@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71554>

On 23/01/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-01-23 11:35:03 +0000, Catalin Marinas wrote:
> > The 'goto' checks the local status before pushing but doesn't repor=
t
> > this (and my machine is slow and it might wait even 20 seconds or
> > more, it is useful to get some messages).
>
> No, it doesn't anymore, so it should be faster than before. Instead o=
f
> checking the entire tree for cleanliness, it just relies on
> git-read-tree -u -m to abort without changes if any of the files that
> need updating are dirty.

Ah, OK. BTW, even if the tree was clean, a 'goto' failed on my Linux
tree earlier today with the following message:

$ stg goto realview-eb-header
Popped realview-pb1176 -- realview-ioaddress
fatal: Entry 'arch/arm/mach-realview/realview_pb11mp.c' not uptodate.
Cannot merge.
stg goto: Command aborted (all changes rolled back)

It worked fine after running 'stg status' once (and not showing any
changes). In the old GIT interface, we use to call refresh_index (i.e.
'git update-index -q --unmerged --refresh'). Does this still happen?

The message above also shows what I meant with messages not being very
clear. It reports "Popped" but actually failed. Showing "Popping ...
done" would be better.

--=20
Catalin
