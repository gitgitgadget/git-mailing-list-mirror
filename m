From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Makefile: Improve compiler header dependency check
Date: Mon, 29 Aug 2011 23:05:15 -0500
Message-ID: <20110830040515.GC6647@elie.gateway.2wire.net>
References: <20110827162645.GA10476@elie.gateway.2wire.net>
 <1314478844-55379-1-git-send-email-davvid@gmail.com>
 <CALx8hKTx3r=ow+=jsCyvZGRJ6Yr+w9TT7=Uyi4y4+beOou45AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 06:05:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyFZl-0003Bm-OE
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 06:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781Ab1H3EFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 00:05:21 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:48488 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab1H3EFU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2011 00:05:20 -0400
Received: by yie30 with SMTP id 30so4094141yie.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 21:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ajc0x0z5NcvsABEaju91We2hpOXuYazEoSAsY3fmW7Y=;
        b=utkBHSBFX/MsbfFfVD7Gh0pNHvl3e1MpdR9VEdoJcJGV56XMy8tA3F7+0GzdoiFljq
         pK8V9Ma3Vd3sCFWdJzt3EKr5EcVz8qAV4PFLNDuO57HLwzzMSb1eYhsvU77JW55fvz+j
         Zz8drpSoFiPpkKlF+AICLBg8mB/zYD2iSZb80=
Received: by 10.150.50.10 with SMTP id x10mr1777023ybx.326.1314677119896;
        Mon, 29 Aug 2011 21:05:19 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-62-70.dsl.chcgil.sbcglobal.net [69.209.62.70])
        by mx.google.com with ESMTPS id p63sm643533yhl.39.2011.08.29.21.05.17
        (version=SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 21:05:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALx8hKTx3r=ow+=jsCyvZGRJ6Yr+w9TT7=Uyi4y4+beOou45AA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180390>

Hi,

=46redrik Kuivinen wrote:
> On Sat, Aug 27, 2011 at 23:00, David Aguilar <davvid@gmail.com> wrote=
:

>> I'm not sure if "sh -c" is necessary but I did notice that other
>> parts of the Makefile use $(SHELL_PATH). =C2=A0The check was adjuste=
d
>> to use that as well.
>
> I'm not sure either. I just used what I saw at other places in the Ma=
kefile.

It is not needed, and imho it makes it harder to read.  I believe the
current uses of "sh -c" near the top of the Makefile are to emphasize
that a POSIX shell has not been determined yet (so POSIXy constructs
cannot be used at that point on platforms like Solaris).

Aside from that, this seems good, though.  While at it, the log
message could be simplified to something closer to the original
version:

	The Makefile enables CHECK_HEADER_DEPENDENCIES when the
	compiler supports generating header dependencies.
	Make the check use the same flags as the invocation
	to avoid a false positive when user-configured compiler
	flags contain incompatible options.

	For example, without this patch, trying to build universal
	binaries on a Mac using CFLAGS=3D'-arch i386 -arch x86_64'
	produces

		gcc-4.2: -E, -S, -save-temps and -M options are
		not allowed with multiple -arch flags

	While at it, remove "sh -c" in the command passed to $(shell);
	at this point in the Makefile, SHELL has already been set to
	a sensible shell and it is better not to override that.

Thanks again and sorry for the fuss.

Cheers,
Jonathan
