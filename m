From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] build: be clearer about order-only prerequisites
Date: Sun, 26 May 2013 14:50:39 -0700
Message-ID: <7v1u8t76mo.fsf@alter.siamese.dyndns.org>
References: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
	<1369449666-18879-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 26 23:51:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgiqA-0004NK-5s
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 23:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab3EZVuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 17:50:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161Ab3EZVun (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 17:50:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89B9422556;
	Sun, 26 May 2013 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Ris1HXbpp2F1u8a1hyQhJjUNtC4=; b=RUhCAN8KA8ZZdFMU+mUt
	YMCJHYetTQ0AuR7D/usg9uGE9cUhhYlyUQ5ic6UxwKLMYT5Mlv7Ysyu36Z7K4mVC
	sbuaaGMbyk15BrMSOvIG0XzmS9dpiLF0ItdsEXYzSzvJrDeG5gIwcCcdBl9Hhn4/
	37Qab+BU9lF/5EtxisB84F4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=FkOJjpxnFlKu/ZgqvqNdWpSCEavoMTcGKNN2bb2Rplc1no
	eEN0xHPtV4j+75jNcd1gBtj4EX0iCVPKzYtHrBsGY9c1fUrfVBQtvkio35qS48m8
	da9FigOOrduM1xdKvKNZtCfL8Cak6TgHpTmvR0ykiqPWl6meePlYaOvTbw7Yo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EC0D22555;
	Sun, 26 May 2013 21:50:42 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C884E22554;
	Sun, 26 May 2013 21:50:41 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F842158-C64E-11E2-ACC5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225573>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

This patch is wrong, I think.

The canonical example of order-only is something like

  http://www.kolpackov.net/pipermail/notes/2004-January/000001.html

where you want to make sure an output directory already exists, but
you do not want to list that as prerequiste _input_ to produce
output from the source.  G-V-F has real information that is used to
affect the output, which is quite a different animal.

Try applying this 6-patch series, "make clean; make git.spec", and
then "git checkout HEAD~2" to come back to the commit for this
patch.  And then try running "make git.spec".  I think Version line
will not change and still claim you are building a version with the
6-patch series fully applied.

After a quick scan of the other 5 patches in the series, they looked
all sensible, and I do not think any of them depends on the change
in this patch, so I think we can safely drop this one.

Administrivia: as I said in the whats cooking message, I'll be
taking things slow til the beginning of next month, so if your (not
limited to Felipe) messages are not answered by me, it merely means
they were not yet read by me (as opposed to dismissed as not worth
reading without responding).

>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 28b6117..97ff848 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1787,7 +1787,7 @@ perl/PM.stamp: FORCE
>  perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
>  	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
>  
> -$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
> +$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl | GIT-VERSION-FILE
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>  	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
>  	sed -e '1{' \
> @@ -1850,7 +1850,7 @@ CONFIGURE_RECIPE = $(RM) configure configure.ac+ && \
>  		   autoconf -o configure configure.ac+ && \
>  		   $(RM) configure.ac+
>  
> -configure: configure.ac GIT-VERSION-FILE
> +configure: configure.ac | GIT-VERSION-FILE
>  	$(QUIET_GEN)$(CONFIGURE_RECIPE)
>  
>  ifdef AUTOCONFIGURED
> @@ -2415,7 +2415,7 @@ quick-install-html:
>  
>  ### Maintainer's dist rules
>  
> -git.spec: git.spec.in GIT-VERSION-FILE
> +git.spec: git.spec.in | GIT-VERSION-FILE
>  	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@+
>  	mv $@+ $@
