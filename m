From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 07 May 2014 19:18:13 -0500
Message-ID: <536acd4578ac_3caaa612ec76@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
 <rmiha51dd99.fsf@fnord.ir.bbn.com>
 <536a8f6cd81e9_76ff7a52ec60@nysa.notmuch>
 <rmizjit6txa.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 02:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiCEg-0002QS-6G
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 02:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbaEHA3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 20:29:01 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:39817 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbaEHA3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 20:29:00 -0400
Received: by mail-yk0-f179.google.com with SMTP id 19so1532400ykq.38
        for <git@vger.kernel.org>; Wed, 07 May 2014 17:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=X39JhKA174u6QdWrhiUttNXzIBNKZAGnkzfSYX22pb0=;
        b=D4VcqBRVdwMyG8H/4nH3nno+wFBqpCS4or73+/KRmy3mFVb7rIn2KWNd/OxrTS9S8y
         zZm3VFDyY/wC1BN7aJG33xr5qp/XanSd4GhCwiL26z3ZaRxQCibg2R9l4ovlQ3pSfLyA
         wbhi5J4Vw6du+AIJjEaQZCz/4fXSVyTB2DvcM0Q0Qt5pdJot9UFr2sTIPnY/pRbugCMP
         uPK2kzt1oRQ47lbvHEe4rpZ8Q0+uCbKVV5M+IT5zsz5xe0WashCIdDX2Md3Ivs7AbVSY
         zW9dc2zCjnO382vCF2etveV9jeQFsizMExcQ/cP8nhC/vHdPhiTyxuVjMjXn3SlTT2DX
         b/sw==
X-Received: by 10.236.102.70 with SMTP id c46mr507221yhg.40.1399508939875;
        Wed, 07 May 2014 17:28:59 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d44sm29513553yhf.21.2014.05.07.17.28.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 17:28:58 -0700 (PDT)
In-Reply-To: <rmizjit6txa.fsf@fnord.ir.bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248393>

Greg Troxel wrote:
> 
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Greg Troxel wrote:
> >> In a packaging system, dependencies are much more troublesome.
> >> Dependencies have to be declared, and the build limited to use only
> >> those declared dependencies, in order to get repeatable builds and
> >> binary packages that can be used on other systems.  Dependencies that
> >> really are required are fine.  But optional dependencies are a
> >> problem, because e.g. one doesn't want to require the presence of qt
> >> to build something (that isn't already enormous).   So if git needs
> >> mercurial and subversion installed, plus perhaps 5 other things for
> >> less popular remote helpers, that starts to be a real burden.
> >
> > It doesn't *need* them to build. The Mercurial/Bazaar dependencies are
> > optional, both at build-time and at run-time. Most distributions would
> > want to test the functionality they are distributing, and for testing
> > they do need these dependencies.
> 
> My point is that a packaging of git needs to either decide to forego
> these optional parts, or to include them, in the default case.

That is currently the case. They would be included by default, but not
usable unless the *optional* dependencies are installed.

> So I'm merely trying to suggest that it's better to have a core
> package with a restrained set of dependencies, and then a way to build
> the other things independently (perhaps assuming the core is
> built/installed), each with their own dependencies.

I'm all in favor of 'make install' installing only the core of Git, and
different targets for all the other parts.

However, if you take a look at any distribution's packaing of Git you
would see why that wouldn't be desirable (they are full of hacks and
fixes). If the build system is eventually fixed so one package can do
'make install', another 'make install-p4', another 'make install-hg' and
so on, that would be great. But we are pretty far from that.

-- 
Felipe Contreras
