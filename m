From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] fetch: Get submodule paths from index and not from .gitmodules
Date: Fri, 17 Sep 2010 17:29:58 -0700
Message-ID: <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <jens.lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 18 02:30:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwlJs-0004mu-0l
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 02:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab0IRAaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 20:30:03 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59191 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0IRAaC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 20:30:02 -0400
Received: by pvg2 with SMTP id 2so723658pvg.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 17:30:01 -0700 (PDT)
Received: by 10.142.255.9 with SMTP id c9mr4848035wfi.134.1284769801866;
        Fri, 17 Sep 2010 17:30:01 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id y36sm2463634wfd.6.2010.09.17.17.30.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Sep 2010 17:30:00 -0700 (PDT)
In-Reply-To: <4C935D77.3080008@web.de>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156420>

On Sep 17, 2010, at 5:22 AM, Jens Lehmann wrote:
>> As far as stderr of the child is concerned, if you only want to re-use the
>> standard error of the parent, then not assigning anything to cp.err is
>> correct (it was set to 0 in the memset before this hunk). But perhaps you
>> want to achieve something else?
> 
> Nope. You are right, setting both to 0 (via the memset) to inherit the
> channel from the parent is just what is needed here.
> 
> So the correct fix should look like this:
> 
> 
> diff --git a/submodule.c b/submodule.c
> index e2c3bae..209efa4 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -260,7 +260,6 @@ int fetch_populated_submodules(int forced)
>        cp.env = local_repo_env;
>        cp.git_cmd = 1;
>        cp.no_stdin = 1;
> -       cp.out = -1;
> 
>        for (i = 0; i < active_nr; i++) {
>                struct strbuf submodule_path = STRBUF_INIT;

Yep, this patch fixes the output issue. Now all submodules are reported. However, they're still not prefixed with the previous layers, so it appears like all submodules are rooted in the current directory, which is obviously not true. And of course the performance issue is still relevant.

-Kevin Ballard