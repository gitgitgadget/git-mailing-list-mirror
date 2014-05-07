From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: move out of contrib
Date: Wed, 07 May 2014 14:45:17 -0500
Message-ID: <536a8d4dd798e_76ff7a52ec26@nysa.notmuch>
References: <1399077403-19678-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq38gmctzn.fsf@gitster.dls.corp.google.com>
 <536989d764672_250b14ed2ec66@nysa.notmuch>
 <536a067b3b1ca_5e8fbfd30879@nysa.notmuch>
 <xmqqppjpbicu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 21:56:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi7wt-00052d-Mg
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 21:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbaEGT4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 15:56:10 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:49001 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaEGT4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 15:56:07 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so1865830oah.21
        for <git@vger.kernel.org>; Wed, 07 May 2014 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=5QftVkeCRWLbId4p/TyoF8V4OIBNj4J+sBVlBgYvOEE=;
        b=Tiu8yf02I9BM8PRnP8gPBAtoRt1O9sH5gYc3U9XPs/lxYtgQjH4CusPGJTsfpC20MU
         uv5K/Solhp4VmM1sOAwk2LxYi7U6p65aUJlgZYdhZMhOl6uHzwR59nKLeDI+4Nsffwxu
         IkgnchW9an9JGF/Xe2BYKSjRGirDt9jBzzJBH3b0g60zd9HogptFsfftaWTGoElK8BDJ
         36ghL2/XuIfkomTUsqhghuIRnyCsE2aSGVSZSeCbg5PiDdL6Bo5pOLvCvv4Tijc6sbAf
         gq2JaJzaqbQO8L+lS6/ahYXG3hbo35BVb6zvMssLKYBCW563h9ECwYQzx0FR4se5zAx+
         PBUw==
X-Received: by 10.60.51.136 with SMTP id k8mr49231446oeo.33.1399492566901;
        Wed, 07 May 2014 12:56:06 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id nt6sm1889066obc.19.2014.05.07.12.56.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 12:56:03 -0700 (PDT)
In-Reply-To: <xmqqppjpbicu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248352>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > As an example of all the hacks needed by a real distribution package,
> > here's the stuff ArchLinux packagers have to do:
> >
> >   # bash completion
> >   mkdir -p "$pkgdir"/usr/share/bash-completion/completions/
> >   install -m644 ./contrib/completion/git-completion.bash "$pkgdir"/usr/share/bash-completion/completions/git
> >...
> >
> > And here's what debian packagers have to do:
> >
> >   # bash completion
> >   install -d -m0755 '$(GIT)'/etc/bash_completion.d
> >   install -m0644 contrib/completion/git-completion.bash \
> >     '$(GIT)'/etc/bash_completion.d/git
> >...
> >

This is what the latest debian package does:

	# bash completion
	install -d -m0755 '$(GIT)'/usr/share/bash-completion/completions
	install -m0644 contrib/completion/git-completion.bash \
	  '$(GIT)'/usr/share/bash-completion/completions/git
	ln -s git '$(GIT)'/usr/share/bash-completion/completions/gitk

> > If our build system was sane, they wouldn't need so many hacks.
> 
> I do not see how the above two examples lead to that conclusion.
> How would it help to blindly install to $(sharedir),

It is not blind, it is the location bash-completion uses *by default*,
and it's what most (all?) distributions use.

> or suggestion to use pkg-info when major distros do not even use one?

Which major distros do not ship with the pkg-config? It is part of
bash-completion (as it should be part of every decent shared softare
component), they all ship it.

Do you want me to go on a hunt and list all the distrubionts that ship
both?

  /usr/share/bash-completion/completions/git
  /usr/share/pkgconfig/bash-completion.pc

How many distributions would it take for you to accept the facts?

> I would understand if the saneness you seek were for distros to
> agree on where things should go, or at least agree on how to find
> out where things should go.

They all gree.

> I do not think we are there yet.

You are wrong.

-- 
Felipe Contreras
