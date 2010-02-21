From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Configuring git to for forget removed files
Date: Sat, 20 Feb 2010 20:47:46 -0600
Message-ID: <20100221024746.GA9628@progeny.tock>
References: <4B7FBB73.70004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrew Benton <b3nton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:21:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj1r8-0003cS-Hm
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 03:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab0BUCrY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Feb 2010 21:47:24 -0500
Received: from mail-yx0-f193.google.com ([209.85.210.193]:57855 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0BUCrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 21:47:22 -0500
Received: by yxe31 with SMTP id 31so96261yxe.21
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 18:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MOSqb8j8iLFywKebrr2CWFMcZt24AiKBCoElKhZapDc=;
        b=RQJfJNIyJFTC2+7TgUhPdZWKgedxtdrGmAl8u1eLv85IJqSBqH8Pp6Z77xINlJusqf
         /apcFhhS+EfmWFE8f2D6M5iSuBbdrYRCLontAtClFBHUsmKAitoOPbsw7uTyXnNFDs7h
         QViPNcvkprUI6oN/wNcoBUB/PILUNMOP26JYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IO44EwqXYUvSJMYkz7MGZdeJ05unoThWU7RhNw2U2yAKg8seYOna82CSZD/ovo6/Ks
         Q7DZr4h10Zf3GSL61YO8B38oUNrbFXxJO7T1sJ2cIJRmQhnYERbyHm75vt0405H5tDqm
         Gzxr6OMTfI9tjYeId0R/KGtmrulwlkt9L/j2I=
Received: by 10.101.199.34 with SMTP id b34mr5707823anq.148.1266720440522;
        Sat, 20 Feb 2010 18:47:20 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm1676414gxk.7.2010.02.20.18.47.19
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 18:47:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B7FBB73.70004@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140580>

Hi Andy,

Andrew Benton wrote:

> I have a project that I store in a git repository. It's a bunch of
> source tarballs and some bash scripts to compile it all. Git makes
> it easy to distribute any changes I make across the computers I run.

This is not really what git is intended to do.

 - git generally works better with files that are easy to diff; see
   the =E2=80=9Cfilter=E2=80=9D attribute in gitattributes(5) for one w=
ay this is
   sometimes achieved with meaningful binary files (e.g., the
   compressed files OpenOffice produces)

 - Though git can cope with large projects, it generally works best
   when track the smallest meaningful unit that can be tested alone.
   Submodules can be used to stitch them together.

Thus if it is important to you to track the history of this project, I
would suggest giving each source tree its own repository and stitching
them together with a =E2=80=9Csupermodule=E2=80=9D that tracks your scr=
ipts and
includes references to the appropriate versions of each source
package.

See http://who-t.blogspot.com/2009/04/big-fat-xorg-supermodule.html
for an example of this kind of thing.

On the other hand, I don=E2=80=99t get the impression it is so importan=
t here
to track the history from the beginning, so:

> The problem I have is that over time the repository gets ever
> larger. When I update to a newer version of something I git rm the
> old tarball but git still keeps a copy and the folder grows ever
> larger. At the moment the only solution I have is to periodically rm
> -rf .git and start again. This works but is less than ideal because
> I lose all the history for my build scripts.

Maybe you could keep the build scripts in a git repository and
synchronizing the tarballs out of line with some other tool, such as
rsync or unison.

> Is it possible to make git delete its
> backup copies of removed files?

git is not intended to be a backup tool; as you=E2=80=99ve noticed, the=
 older
versions gradually accumulate and it becomes apparent over time that
it would be really nice for older commits to expire.

I am guessing, but it sounds to me like what you are looking for is
something that is distributed like git but is a backup system.  Or in
other words, a way to record a few snapshots like LVM or btrfs, but
such that new snapshots can be easily transfered to another computer.
At least I would be glad to learn of such a tool. ;-)

Hope that helps,
Jonathan
