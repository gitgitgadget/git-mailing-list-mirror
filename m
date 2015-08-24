From: =?UTF-8?Q?J=C4=81nis_Ruk=C5=A1=C4=81ns?= <janis.ruksans@gmail.com>
Subject: Re: Submodule, subtree, or something else?
Date: Mon, 24 Aug 2015 20:12:38 +0300
Message-ID: <1440436358.32140.72.camel@gmail.com>
References: <1440197262.23145.191.camel@gmail.com>
	 <CAGZ79kbUXwEYnpDWgKqnUab2xP4m9m7FMskaK2u8WcqnLSSoog@mail.gmail.com>
	 <1440339066.32140.17.camel@gmail.com>
	 <CAK6hiNiBD+DUdNq0c2DY9LWg2PCgE56SpbBip8BNNmHTsEttuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Cox, Michael" <mhcox@bluezoosoftware.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 19:12:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTvId-0007Qy-70
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 19:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbbHXRMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 13:12:42 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35481 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbbHXRMm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 13:12:42 -0400
Received: by lbcbn3 with SMTP id bn3so83858941lbc.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=dFGYsQaaR5hItHuOX1Jl3a8WlvXUBx/4E2NJ2zaRtm0=;
        b=ZFWezljwX/aWRdlphEM+ctgRGE25VdxFzUCalS2ccZkiRrQSXad4Ca0XCt/q9r94Z/
         HUQbH0pAYmq51r+jdnh95uTytR1mlhIgXldA8quOIHBojQtcgVa1LDtiU16zJim9Jioo
         WOIbUjJ/7C8CtfyD5MxLftDYH+AS7NSpP1dDBqjCa9O48Rm+mizAp2DJCa+Dzse6LLZP
         yPZ2PXjH+Ad5waHFyQQpOacHd5PPx+Z/o3l/qI5ICxSogd24xGjhGmJJD7M6kddD46aA
         quMnEL/7bUDY9DC0uPrpCLDcpAqZ8Ldrlstg8NplZe1KR4D6cGk64d7Yw2KpOCaDxACG
         xx3Q==
X-Received: by 10.112.163.72 with SMTP id yg8mr21114831lbb.82.1440436360460;
        Mon, 24 Aug 2015 10:12:40 -0700 (PDT)
Received: from ganja (two.vendomar.lv. [195.244.143.5])
        by smtp.googlemail.com with ESMTPSA id kt10sm5222849lac.39.2015.08.24.10.12.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2015 10:12:39 -0700 (PDT)
In-Reply-To: <CAK6hiNiBD+DUdNq0c2DY9LWg2PCgE56SpbBip8BNNmHTsEttuQ@mail.gmail.com>
X-Mailer: Evolution 3.12.11 (3.12.11-1.fc21) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276466>

On Sv, 2015-08-23 at 17:13 -0600, Cox, Michael wrote:
> You might want to take a look at how the Boost (boost.org) project
> uses submodules.  They use submodules for each library.  I know they
> use relative paths in their .gitmodules file to avoid the problem
> you're referring to regarding "git clone --recurse-submodules".

Thanks!  I had a look at their setup, and they are using ../libx.git for
submodules, which unfortunately breaks when cloning from another
"working copy":

$ git clone --recursive file:///tmp/gittest/repo.a/main.git main.work
Cloning into 'main.work'...
<snip>
Submodule 'liba' (file:///tmp/gittest/repo.a/liba.git) registered for path 'liba'
Cloning into 'liba'...
<snip>
Submodule path 'liba': checked out '6a0ef37c03a7068328956dcb8a08bc39f280edfc'

$ git clone --recursive file://($pwd)/main.work main.home
Cloning into 'main.home'...
<snip>
Submodule 'liba' (file:///tmp/gittest/work/liba.git) registered for path 'liba'
Cloning into 'liba'...
fatal: '/tmp/gittest/work/liba.git' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
Clone of 'file:///tmp/gittest/work/liba.git' into submodule path 'liba' failed


After some trial and error I managed to get what I wanted to achieve by
using ./liba as the submodule URL (no .git suffix!), and creating a file
named liba in /tmp/gittest/repo.a/main.git (ie. the bare "origin" repo)
with a single line in it:

gitdir: ../liba.git

However, I'm not sure it is the right thing, or even advisable to do so.
