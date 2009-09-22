From: c^ <c@gryning.com>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Tue, 22 Sep 2009 12:55:42 +0100
Message-ID: <20090922115542.GP8173@gryning.com>
References: <20090921160551.GD8173@gryning.com> <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil> <7vskeguqmb.fsf@alter.siamese.dyndns.org> <20090921191943.GE8173@gryning.com> <7vocp4ulq2.fsf@alter.siamese.dyndns.org>
Reply-To: c@gryning.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 13:56:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq3yR-0003rc-Q9
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 13:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227AbZIVLzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 07:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756197AbZIVLzu
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 07:55:50 -0400
Received: from 87-194-167-47.bethere.co.uk ([87.194.167.47]:50159 "EHLO
	jolt.ukmail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191AbZIVLzt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 07:55:49 -0400
Received: from craigt by jolt.ukmail.org with local (Exim 4.63)
	(envelope-from <c@gryning.com>)
	id 1Mq3yA-0008Tl-Mn
	for git@vger.kernel.org; Tue, 22 Sep 2009 12:55:42 +0100
Content-Disposition: inline
In-Reply-To: <7vocp4ulq2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128933>

On Mon, Sep 21, 2009 at 12:44:05PM -0700, Junio C Hamano wrote:
> Craig Taylor <c@gryning.com> writes:
> 
> > Exactly as you describe here, different paths but same goal.
> > All binaries follow the DESTDIR path except the perl modules.
> >
> > To register this as a bug do I need to do more than send this email?
> 
> Do you use NO_PERL_MAKEMAKER in your build?
> 
> If not, we need to summon an expert on ExtUtils::MakeMaker to look into
> this issue, but if you do, perhaps you can try this patch and report how
> well it works for you.
> 
> ---
>  perl/Makefile |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/perl/Makefile b/perl/Makefile
> index e3dd1a5..4ab21d6 100644
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -29,11 +29,11 @@ $(makfile): ../GIT-CFLAGS Makefile
>  	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
>  	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
>  	echo install: >> $@
> -	echo '	mkdir -p "$(instdir_SQ)"' >> $@
> -	echo '	$(RM) "$(instdir_SQ)/Git.pm"; cp Git.pm "$(instdir_SQ)"' >> $@
> -	echo '	$(RM) "$(instdir_SQ)/Error.pm"' >> $@
> +	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)"' >> $@
> +	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git.pm"; cp Git.pm "$$(DESTDIR)$(instdir_SQ)"' >> $@
> +	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
>  	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
> -	echo '	cp private-Error.pm "$(instdir_SQ)/Error.pm"' >> $@
> +	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
>  	echo instlibdir: >> $@
>  	echo '	echo $(instdir_SQ)' >> $@
>  else

Frustratingly the last change forces the lib referenced in the perl
scripts to include the DESTDIR.
I will work around this for now, but would apprieciate it if someone
more familair could fix for the future.

CraigT

-- 

c^ [c%5e]

Failure is natural.
