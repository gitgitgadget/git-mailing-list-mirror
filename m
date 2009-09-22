From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Tue, 22 Sep 2009 10:16:44 -0500
Message-ID: <fTPSiYVR_0aJPW67ZWx3xlDqQCHFqawOhMTI1M76i0EnhLLbCjwHyw@cipher.nrlssc.navy.mil>
References: <20090921160551.GD8173@gryning.com> <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil> <7vskeguqmb.fsf@alter.siamese.dyndns.org> <20090921191943.GE8173@gryning.com> <7vocp4ulq2.fsf@alter.siamese.dyndns.org> <20090922115542.GP8173@gryning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: c@gryning.com
X-From: git-owner@vger.kernel.org Tue Sep 22 17:17:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq76y-00053v-54
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 17:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130AbZIVPQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 11:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbZIVPQu
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 11:16:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35986 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbZIVPQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 11:16:50 -0400
Received: by mail.nrlssc.navy.mil id n8MFGitw027481; Tue, 22 Sep 2009 10:16:48 -0500
In-Reply-To: <20090922115542.GP8173@gryning.com>
X-OriginalArrivalTime: 22 Sep 2009 15:16:44.0419 (UTC) FILETIME=[B1E58530:01CA3B97]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128938>

c^ wrote:
> On Mon, Sep 21, 2009 at 12:44:05PM -0700, Junio C Hamano wrote:
>> Craig Taylor <c@gryning.com> writes:
>>
>>> Exactly as you describe here, different paths but same goal.
>>> All binaries follow the DESTDIR path except the perl modules.
>>>
>>> To register this as a bug do I need to do more than send this email?
>> Do you use NO_PERL_MAKEMAKER in your build?
>>
>> If not, we need to summon an expert on ExtUtils::MakeMaker to look into
>> this issue, but if you do, perhaps you can try this patch and report how
>> well it works for you.
>>
>> ---
>>  perl/Makefile |    8 ++++----
>>  1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/perl/Makefile b/perl/Makefile
>> index e3dd1a5..4ab21d6 100644
>> --- a/perl/Makefile
>> +++ b/perl/Makefile
>> @@ -29,11 +29,11 @@ $(makfile): ../GIT-CFLAGS Makefile
>>  	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
>>  	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
>>  	echo install: >> $@
>> -	echo '	mkdir -p "$(instdir_SQ)"' >> $@
>> -	echo '	$(RM) "$(instdir_SQ)/Git.pm"; cp Git.pm "$(instdir_SQ)"' >> $@
>> -	echo '	$(RM) "$(instdir_SQ)/Error.pm"' >> $@
>> +	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)"' >> $@
>> +	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git.pm"; cp Git.pm "$$(DESTDIR)$(instdir_SQ)"' >> $@
>> +	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
>>  	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
>> -	echo '	cp private-Error.pm "$(instdir_SQ)/Error.pm"' >> $@
>> +	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
>>  	echo instlibdir: >> $@
>>  	echo '	echo $(instdir_SQ)' >> $@
>>  else
> 
> Frustratingly the last change forces the lib referenced in the perl
> scripts to include the DESTDIR.
> I will work around this for now, but would apprieciate it if someone
> more familair could fix for the future.

Craig, you're referring to _your_ last change where you hand modified the
perl.mak file so that the 'PREFIX =' line contained $(DESTDIR) right?  And
not something in the above patch?

Junio, your patch looks good and seems to work for me.

-brandon

ps.  Craig, it's best to hit 'Reply-All' when replying so that everyone is kept
     in the cc list.  People often filter their mail based on the 'To:' and 'cc:'
     fields and are more likely to notice mail that includes their address in one
     of those fields.  I added Junio back to this reply.
