From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: BUG (v1.5.6.1): ./configure missing check for zlib.h
Date: Sat, 28 Jun 2008 01:03:18 +0200
Message-ID: <200806280103.19302.jnareb@gmail.com>
References: <4864DD65.1080402@mircea.bardac.net> <m3prq3hr6n.fsf@localhost.localdomain> <20080627150732.D88F64B4002@artemis.sr.unh.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Tom Fogal" <tfogal@alumni.unh.edu>, git@vger.kernel.org
To: Mircea Bardac <dev@mircea.bardac.net>
X-From: git-owner@vger.kernel.org Sat Jun 28 01:04:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCMzV-0007AH-Rb
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 01:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764982AbYF0XDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 19:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765400AbYF0XDa
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 19:03:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:41857 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760166AbYF0XD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 19:03:28 -0400
Received: by nf-out-0910.google.com with SMTP id d3so187563nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 16:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TkJTATawxyHAgVADCgmOTOQ9E1dWXkK1xQAgyMD4+ds=;
        b=X7uHYr6YOZ5WWLCT+JkzYTaaTmRHLsc+fgnqX+BjX3XXja1tyxTXTC48hFIj9rT4N2
         jOv0NAp4pnjUqWsQGHie5NWpeNKkvmdPp1GllRzZTmlgQ85Fy+pbxWqTcLCeUXQpx676
         fNDexPWgjMQt8yaBITJ670cbbz+WrHd67TBXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DyQ6p+QD59tOPREsPlM87wr/cKzhUTDvk281IrniWhsyB5waa8AZI7Fw+FXf/ARZgm
         4dvcs3x4MBM65XTNkSl3Sek5WfSYPXPmjcdrZ3D8guDl3WIGcPhYjypfA0ZNmFA04Wqr
         LZjiqbjWoL8w7UF6hpXzhHxxf7qg4n1SOVRtA=
Received: by 10.210.49.19 with SMTP id w19mr1668845ebw.11.1214607806070;
        Fri, 27 Jun 2008 16:03:26 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.205.161])
        by mx.google.com with ESMTPS id h7sm1455671nfh.34.2008.06.27.16.03.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 16:03:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080627150732.D88F64B4002@artemis.sr.unh.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86671>

On Fri, 27 Jun 2008, tom fogal wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Mircea Bardac <dev@mircea.bardac.net> writes:
>> 
>>> $ ./configure
>> [...]
>>> configure: CHECKS for header files
>>> In file included from daemon.c:1:
>>> cache.h:9:18: error: zlib.h: No such file or directory
>>> make: *** [daemon.o] Error 1
>>> 
>>> (installing zlib1g-dev on Ubuntu 7.10 fixed the problem)
>> 
>> What should ./configure do (what ./configure for other programs
>> or packages do)?
>> 
>> You cannot compile git without zlib!
> 
> If one can determine during configure time that a required library is
> not found, it (IMHO) is nice to give an error message and bomb out (via
> AC_MSG_ERROR).
> 
> The AC macro archive has a zlib macro which does this, as an example:
> 
>    http://autoconf-archive.cryp.to/check_zlib.html
> 
> I should note, however, that I disagree with that macro's logic in that
> it `searches' for zlib if the user does not specify it.  IMO, if the
> user does not give a --with option, and it doesn't work `out of the
> box' (without hacking FLAGS), macros should die with an error rather
> than retry with changed FLAGS.

On Fri, 27 Jun 2008, Mircea Bardac wrote:
>
> Well, as far as I know, if a program depends on any external headers, 
> they should *all* be checked, not only "those that can be skipped by 
> defining some macro" (I personally do not know which are these).

In git (not like usually in other projects) ./configure script (autoconf)
is used *only* to generate Makefile configuration.  It tries to configure
compile (build) process in such a way that building git is possible even
if some features are missing or are found not in standard place (and also
use compat version of functions if they are not in library).  It helps you
build system.

I'm not sure if checking if prerequisites exists and failing loudly
otherwise would be a good feature to have.  Git would fail anyway during
build process, so it is not some new feature.  The only advantage is that
required and unavoidable dependency would be found earlier; on the other
hand there is now disadvantage of build process (./configure process)
if it misdetects lack of needed header files, i.e. it is possible to
compile (build) git, but ./configure detects that it is not so.  This
happened once to me, and is very annoying...

But as they say, "code speaks louder than words"

-- 
Jakub Narebski
Poland
