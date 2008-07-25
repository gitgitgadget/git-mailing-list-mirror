From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9 v2] Allow the built-in exec path to be relative to
 the command invocation path
Date: Thu, 24 Jul 2008 21:50:40 -0700
Message-ID: <7v3aly5zz3.fsf@gitster.siamese.dyndns.org>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <200807232112.18352.johannes.sixt@telecom.at>
 <7vd4l37vz7.fsf@gitster.siamese.dyndns.org>
 <200807242124.14583.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Jul 25 06:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMFHR-0002Wf-I9
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 06:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbYGYEur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 00:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbYGYEur
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 00:50:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbYGYEuq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 00:50:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B5B7942BF0;
	Fri, 25 Jul 2008 00:50:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CABB942BEF; Fri, 25 Jul 2008 00:50:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3E4967AA-5A05-11DD-A388-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89999>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Donnerstag, 24. Juli 2008, Junio C Hamano wrote:
>> Johannes Sixt <johannes.sixt@telecom.at> writes:
>> > It also fixes 'make install' of git-gui as well (sigh!) by not exporting
>> > gitexecdir - assuming that Shawn applies the git-gui patch.
>>
>> Yeah, this seems to break the install quite badly without git-gui patch.
>
> If you squash this in, we don't need the git-gui patch.

Thanks.

I think this patch makes _more_ sense than the git-gui patch, actually.

Within the context of git.git project, we would want to force the
installation directory of git-gui portion to be consistent with the main
project.

> diff --git a/Makefile b/Makefile
> index aab23a2..904150e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1344,7 +1344,7 @@ install: all
>  	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
>  ifndef NO_TCLTK
>  	$(MAKE) -C gitk-git install
> -	$(MAKE) -C git-gui install
> +	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
>  endif
>  ifneq (,$X)
>  	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), 
> $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)

However, I have to wonder if it is the right thing to do, like your patch
does, for "git --exec-path" to return "../libexec/git-core/" in a relative
form, without saying what it is relative to.  Shouldn't we be showing the
full path after resolving that relative path to git executable?
