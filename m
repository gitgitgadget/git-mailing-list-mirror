X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 6 Dec 2006 16:27:40 +0100
Message-ID: <200612061627.40359.jnareb@gmail.com>
References: <el6c6o$oa7$1@sea.gmane.org> <200612061551.51603.jnareb@gmail.com> <4576DBA5.4080002@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 15:27:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YHVWacZfL9b1bsuttcLakRhT0Y/47NlYeEsIJfYndAA7RxATJbm6LizcLB+TQpZTiNYqeqsELT+qsUrT/NhRhdhWbJ9Imj01MWVcOIXiYUlWhMR/BNFaOvwLAtwGdDIn6hdQYHXAlEx56xAHoJZNUbUdcuuGq/+tGLYzSfSl7yU=
User-Agent: KMail/1.9.3
In-Reply-To: <4576DBA5.4080002@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33473>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gryg0-0002kw-LO for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935606AbWLFP0K (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 10:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935644AbWLFP0E
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:26:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:37580 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S935381AbWLFPZp (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 10:25:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so172411uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 07:25:44 -0800 (PST)
Received: by 10.66.232.11 with SMTP id e11mr970635ugh.1165418743459; Wed, 06
 Dec 2006 07:25:43 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id x26sm12744320ugc.2006.12.06.07.25.42; Wed, 06 Dec
 2006 07:25:42 -0800 (PST)
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:
> Jakub Narebski escreveu:
> 
>> Please add some longer commit message.
> 
> do you have any specifics you would like me to mention?

More detailed description what "Allow non-srcdir builds using cd
$builddir && $srcdir/configure" mean and why we might want to do that.

For example:

  We might want to build git from outside source directory. For this we
  need...

By the way, I think this patch is about _two_ changes. Allow to build
outside source directory, by providing srcdir AND separate change to
allow builds of separate parts of git, with separate Makefile, to
include user-generated configuration file config.mak and ./configure
generated config.mak.autogen configuration file.

Shouldn't this patch be split into two?

>>>  exec_prefix = @exec_prefix@
>>>  bindir = @bindir@
>>> -#gitexecdir = @libexecdir@/git-core/
>>> -datarootdir = @datarootdir@
>>> -template_dir = @datadir@/git-core/templates/
>>>  
>>>  mandir=@mandir@
>> 
>> Why have you removed setting datarootdir and template_dir? I would
>> have thought that you would rather change it to
>> 
>>   #gitexecdir = @libexecdir@/git-core/
>>   datarootdir = @datarootdir@
>>   GIT_datadir = @datadir@/git-core/
>>   template_dir= @datadir@/git-core/templates/
> 
> The Makefile already has this code, so adding it here is duplication
> of work and code.

Good call. Well, at least now, when ./configure script doesn't provide
means to change template_dir etc. from command line, via options.

Still I think that at least

  datarootdir = @datarootdir@

should be not removed.

> If you think putting code in the generated file is a good idea, I
> propose we just generate the entire Makefile, as is the standard usage
> for autoconf.

The stance on autoconf is that it has to be _optional_ part of
compilation. And I think it does good job of this.

>>> +## generate subdirectories and sub Makefiles. 
>>> +for d in `cd $srcdir &&  find . -type d -print | grep -v '\.git'` ;
>>> +do
>>> +  if test ! -d  $d ; then
>>> +    echo creating $d 
>>> +    mkdir $d
>>> +  fi
>>> +  
>>> +  if test -f $srcdir/$d/Makefile ; then
>>> +    
>>> +    dnl [[]] is to keep m4 happy
>>> +    depth=`echo $d/ | sed -e 's!^\./!!g' -e 's![[^/]]*/!../!g'`
>>> +    echo creating $d/Makefile
>>> +    cat << EOF> $d/Makefile
>>> +include ${depth}config.mak.autogen
>>> +here-srcdir=\$(srcdir)/$d/
>>> +VPATH=\$(here-srcdir)
>>> +include \$(here-srcdir)/Makefile
>>> +EOF
>>> +
>>> +  fi 
>>> +done
>>> +exit 1
>> 
>> What is this for? The ./configure script, generated by autoconf from
>> configure.ac (by "make configure"), generates config.mak.autogen file
>> from config.mak.in, which is included in main (top) Makefile.
> 
> in some cases, the files can also be called stand alone, eg.
> 
>   [lilydev@haring perl]$ pwd
>   /home/lilydev/vc/git/perl
> 
>   [lilydev@haring perl]$ make
>   make -f perl.mak all
>   make[1]: Entering directory `/home/lilydev/vc/git/perl'
>   make[1]: Leaving directory `/home/lilydev/vc/git/perl'
> 
> The above Makefile generation makes sure that this behavior is
> mirrored in the builddir. Also, I'm not sure if the vpath settings get
> exported automatically.
> 
> Having multiple Makefiles in the builddir is the standard behavior for
> autotool'ed packages. 

Git is not autotool'ed package. Autoconf is used only for _optional_
compile and installation configuration.

>> The variables defined in config.mak.autogen are of course visible in
>> make in subdirectories (make invoked from main makefile). Why the
>> change? What about user-generated config.mak?
> 
> good point. I'll include it too.
> 
>> This part IMHO has no sense, and has no place here.

If you want to create or modify Makefiles, do that. Not generate
"minimal" Makefiles in every and each subdirectory.

You would be able to compile git fully only from top directory. So what?
-- 
Jakub Narebski
