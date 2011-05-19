From: Rafael Gieschke <rafael@gieschke.de>
Subject: Re: [PATCHv2] add Android support
Date: Thu, 19 May 2011 13:37:53 +0200
Message-ID: <2218C353-80FC-4540-A60E-608385384FB5@gieschke.de>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de> <7vaaej9pt3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 13:38:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN1Yf-00022i-SA
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 13:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab1ESLiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 07:38:20 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:27252 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696Ab1ESLiT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 07:38:19 -0400
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id 3B9701D2278;
	Thu, 19 May 2011 13:38:18 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.827
X-Spam-Level: 
X-Spam-Status: No, score=-2.827 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=0.073, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNKC5ySeb9Hg; Thu, 19 May 2011 13:38:17 +0200 (CEST)
Received: from [10.163.130.160] (unknown [89.204.137.160])
	by smtp2-587.goneo.de (Postfix) with ESMTPSA id 63EE91D1FF5;
	Thu, 19 May 2011 13:38:11 +0200 (CEST)
In-Reply-To: <7vaaej9pt3.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173951>


Am 19.05.2011 um 08:18 schrieb Junio C Hamano:

> I am still debating myself if this rather huge patch is justifiable, or an
> elaborate joke/hoax. Does anybody seriously want to run git on his phone,
> tablet or set-top box?
> 

Well, it has been promoted by the wiki since August 7, 2009 (https://git.wiki.kernel.org/index.php?title=GitFaq&diff=prev&oldid=7982). So you have to change either the wiki or the code. And of course, git is great enough that is has to be run everywhere :-). 


> I'd suggest splitting it into three patch series, and justify them
> separately.
> 
> (1) Support NO_GECOS_IN_PWENT (Makefile, ident.c);

Done + renamed to NO_GEOCS_IN_PWENT (was NO_PW_GECOS before) as I really like NO_GECOS_IN_PWENT better. Thanks.

> (2) Support NO_GETPASS (Makefile, compat/getpass.c, git-compat-util.h); and

> I wonder if you want to emply the rename trick similar to the one used for
> hstrerror/githstrerror you can see in the git-compat-util.h header file in
> the second step, though.

I've already thought about this but had concerns that gitgetpass will be very near to git_getpass, which already is in connect.c. But I think that's okay and the rename trick will bring more benefits, such as you will be able to use compat/getpass.c as a replacement for a buggy getpass and to test compat/getpass.c on platforms with predefined getpass, too. So, see new patch.


> (3) Add uname_S = Android (Makefile).
> 
> The first two would become much easier to justify if presented that
> way. At least you won't hear from anybody "we don't want that much code to
> not to run git on a phone!", as it is not entirely implausible to imagine
> environments without support for one or both of these two facilities.


So, you would prefer to leave out ANDROID and use something like "ifeq ($(uname_S),Android)", so you will have to compile using make uname_S=Android? I would be fine with that, too. But I would also be fine with having to specify the build options on the command line or using a config.mak if you want to keep Android out of the Makefile.
