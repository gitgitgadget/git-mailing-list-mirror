From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] revision: add --except option
Date: Fri, 30 Aug 2013 09:56:47 +0200
Message-ID: <5220503F.2080608@viscovery.net>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com> <7vhae7k7t1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 09:56:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFJZg-0008AC-Td
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 09:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab3H3H4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 03:56:53 -0400
Received: from so.liwest.at ([212.33.55.24]:44066 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165Ab3H3H4w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 03:56:52 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VFJZX-0002sv-RC; Fri, 30 Aug 2013 09:56:47 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8F4491660F;
	Fri, 30 Aug 2013 09:56:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <7vhae7k7t1.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233432>

Am 8/30/2013 8:32, schrieb Junio C Hamano:
> If you have a history where
> 
>  - branches "master" and "maint" point at commit A;
>  - branch "next" points at commit B that is a descendant of A; and
>  - there are tags X and Y pointing at commits that are ahead of B
>    or behind A
> 
> i.e.
> 
> 	----X----A----B----Y
> 
> what are the desired semantics for these?

I think the simplest were that --except trumps everything and means
"whatever else I say, do as if I did not mention the following".

>  (1) --branches --except maint

=> master next

>  (2) --all --not --branches --except maint

=> X Y --not master next

>  (3) ^master next --except maint

=> ^master next

What should the following mean? Does --not forget that --except was
earlier on the command line?

(4) Y next --except master next --not --branches

this => Y --not maint
or this => Y --not maint master next

What about this:

(5) --branches --except ^master

this => maint next
or this => maint master next ^master
or error("--except does not allow negated revisions")

-- Hannes
