From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related subroutines
Date: Sat, 12 Jul 2008 16:31:50 +0200
Message-ID: <200807121631.51406.jnareb@gmail.com>
References: <200807031824.55958.jnareb@gmail.com> <200807121435.49151.jnareb@gmail.com> <20080712134553.GC10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 12 16:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHg9p-000134-Dc
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 16:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbYGLOcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 10:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbYGLOcG
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 10:32:06 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:18234 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbYGLOcE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 10:32:04 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1936531ika.5
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4aQvaXsU+V6shWm8LVlARQP+4gqJ9/oOSbv2VCJFdTg=;
        b=L/Y2yUR8nz0h3OmSg6/hi/F2XHQNx5aJydIRuGtop4xoERdwUrHqDW5Bp0Wo9UKd1e
         9fBlN2ZhKmJcj00hrXYmglLxi2YWn/GSYVthy5GdpjdLJFpECTrTkJjEiE0BAstYSvZ/
         YN870ky+2bq50wvZhDuH/YIJJ7eZanCnAiz0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=C4II5BKVXdSuQTBG4ihhgPm6SUZ19YmoLqMt/n/OaOce5wRjQdq75+B3xv9/IMPvE0
         CR/pTPhPaAgzqNy5oFV2nRQKt0VUamr1JNsCwRTg11WGukX086NM+Hg33sj5Ab5SIQsd
         3aiIw56JItv0sAQHcTiPmT5KGUrIzUKXenR68=
Received: by 10.210.56.7 with SMTP id e7mr7466479eba.123.1215873120990;
        Sat, 12 Jul 2008 07:32:00 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.204.111])
        by mx.google.com with ESMTPS id z37sm3083686ikz.6.2008.07.12.07.31.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jul 2008 07:31:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080712134553.GC10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88241>

On Sat, Jul 12, 2008, Petr Baudis wrote:
> On Sat, Jul 12, 2008 at 02:35:48PM +0200, Jakub Narebski wrote:
>> On Sat, Jul 12, 2008, Petr Baudis wrote:
 
>> On the other hand if one uses (assuming now Git::Config object API)
>> 
>>   $conf = $repo->get_config('section');
>> 
>> one could access configuration variable values _without_ prefixing
>> them with subsection name, i.e.
>> 
>>   $conf->get('variable');
>> 
>> and not
>> 
>>   $conf->get('section.variable');
>> 
>> 
>> I'm not sure if it is much of an improvement.
> 
> I would propose not to go with this feature yet and add it only when
> justified by accompanied cleanups of real code using this.

O.K.
 
>> The former plays better with
>> 
>>   $r->get_config()->bool('gitweb.blame');
>> 
>> but this is nevertheless not recommended workflow; you can use
>> 
>>   $r->config_bool('gitweb.blame');
>> 
>> and it would be faster (unless some Perl/OO trickery with singletons
>> and the like).
>> 
>>  Recommended workflow (code) is
>> 
>>   $c = $r->get_config();
>>   ...
>>   $c->get_bool('gitweb.blame');
>> 
>> or something like that.
> 
> I thought that the get_config() method would be reusing existing
> Git::Config instances no-matter-what? (Otherwise, you can get into
> rather tricky issues like one part of the code modifying the config and
> the other not noticing the change, etc. And I can se no benefit. If you
> want to reload the config, we might have method like reload(), but I
> don't think that would be very useful except perhaps in some kind of
> mod_perl'd gitweb scenario.)

Somehow I forgot that $repo can remember existing Git::Config, generate
it only once (and remember it) on demand but fully, and then serve it.
It probably is some OO "pattern" like SingletonFactory or sth...

It would probably play better with Git::Repo object interface, but can
I think work as well with Git->repository(...) instance.


As to changing config: I wasn't even thinking about that... and I don't
think that any command written in Perl which uses or can use either
Git or Git::Repo API needs writing config files.


> But we're arguing about nothing, really, except the exact amount of
> coolness of the Git::Config approach. :-)

True.  For me the fact that one can write $c->value('diff.renameLimit')
or $c->value('diff.renamelimit'); is teh winner ;-)

-- 
Jakub Narebski
Poland
