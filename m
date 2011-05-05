From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Thu, 05 May 2011 07:58:24 +0200
Message-ID: <4DC23C80.6020401@viscovery.net>
References: <20110428022922.GC4833@camk.edu.pl> <7v62py5nbp.fsf@alter.siamese.dyndns.org> <20110428192751.GE4833@camk.edu.pl> <4DBFA3C6.8060209@viscovery.net> <7vzkn3itb5.fsf@alter.siamese.dyndns.org> <4DC0E99E.6090402@viscovery.net> <20110504135827.GC18585@camk.edu.pl> <4DC1653A.7000000@viscovery.net> <7v4o5afht7.fsf@alter.siamese.dyndns.org> <7vwri5c27e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kacper Kornet <kornet@camk.edu.pl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 07:58:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHra7-00025B-3I
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 07:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473Ab1EEF6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 01:58:30 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28312 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751436Ab1EEF6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 01:58:30 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QHrZw-0006g8-UZ; Thu, 05 May 2011 07:58:25 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A2FDB1660F;
	Thu,  5 May 2011 07:58:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vwri5c27e.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: 0.5 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172800>

Am 5/5/2011 4:26, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> So I think it would probably be a less-impact and useful solution to keep
>> sysconfdir and add "sysconfdir = @sysconfdir@" to config.mak.in as well.
>>
>> Is Kacper's latest patch with an obvious one-liner to config.mak.in
>> sufficient to achieve that?
>>
>>   From: Kacper Kornet <kornet@camk.edu.pl>
>>   Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defin...
>>   Date: Wed, 4 May 2011 16:29:21 +0200
>>   Message-ID: <20110504142921.GE18585@camk.edu.pl>
> 
> In other words, this one on top of the above (which defaults sysconfdir
> to /etc when $(prefix) is /usr and then sets git_etcdir to $(sysconfdir)).
> 
> -- >8 --
> Subject: [PATCH] config.mak.in: allow "configure --sysconfdir=/else/where"
> 
> We do allow vanilla Makefile users to say make sysconfdir=/else/where
> and config.mak can also be tweaked manually for the same effect. Give
> the same configurablity to ./configure users as well.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.mak.in |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/config.mak.in b/config.mak.in
> index 9614973..dd8f274 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -18,6 +18,7 @@ bindir = @bindir@
>  gitexecdir = @libexecdir@/git-core
>  datarootdir = @datarootdir@
>  template_dir = @datadir@/git-core/templates
> +sysconfdir = @sysconfdir@
>  
>  mandir=@mandir@
>  

No, that's not sufficient. Notice that $(sysconfdir) is used for ETC_GIT*
variables *only* if $(prefix) == /usr (both before and after Kacper's
patch). Therefore, you won't gain a lot of configurability via sysconfdir;
you have to change ETC_GIT* variables directly.

I'm not opposed to keep sysconfdir at all if it gains a useful purpose
like with the oneliner above. But extra work is needed in Makefile; if
this doesn't materialize, I suggest you back out Kacper's patch from 'next'.

-- Hannes
