From: Tim Schumacher <schumact@gmail.com>
Subject: Re: Building GIT on older systems.
Date: Wed, 29 Feb 2012 15:17:24 -0700
Message-ID: <4F4EA3F4.7040501@gmail.com>
References: <CAFqtsHfrk89qHexg8VwMZnKwgWDqbseJNNKFSUkwDtVKX_t=5g@mail.gmail.com> <CAFqtsHd=b=Ey8j1zTCC4-fut7rno3daQ2Q3HMs3k2SHFvE4dSQ@mail.gmail.com> <20120229205510.GA628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 29 23:18:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2rqT-00021s-MO
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 23:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab2B2WR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 17:17:28 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47407 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab2B2WR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 17:17:27 -0500
Received: by yhmm54 with SMTP id m54so1912418yhm.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 14:17:26 -0800 (PST)
Received-SPF: pass (google.com: domain of schumact@gmail.com designates 10.236.201.232 as permitted sender) client-ip=10.236.201.232;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of schumact@gmail.com designates 10.236.201.232 as permitted sender) smtp.mail=schumact@gmail.com; dkim=pass header.i=schumact@gmail.com
Received: from mr.google.com ([10.236.201.232])
        by 10.236.201.232 with SMTP id b68mr3296582yho.129.1330553846891 (num_hops = 1);
        Wed, 29 Feb 2012 14:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=atCfUbyFBXy4Yx/QJ3d78iixE1SWXcjDQpV8ghrCh5o=;
        b=xzt/qbZZsDdOgjE8EateuTSF5ijgaI9KqtNQ/NMr+FbZg0wbG/CSIJg9L6P8eqqA9o
         wgdLApOPjQ2m9aKxO1ghl9HoRtnmw2bfRdaksrwfQaycAWmLJji8vOVfP4Djud4W48s/
         wwDBBvdj9fToye83rPBgXkmt+a8IejRrlSlMg=
Received: by 10.236.201.232 with SMTP id b68mr2602911yho.129.1330553846832;
        Wed, 29 Feb 2012 14:17:26 -0800 (PST)
Received: from [192.168.100.110] ([69.15.86.83])
        by mx.google.com with ESMTPS id g21sm32176416ani.13.2012.02.29.14.17.25
        (version=SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 14:17:26 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120229205510.GA628@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191860>

Hi Peff, thanks!

Comments in-line below.

-Tim

On 2/29/2012 1:55 PM, Jeff King wrote:
> On Wed, Feb 29, 2012 at 01:22:21PM -0700, Tim Schumacher wrote:
>
>> After a long battle trying to get git to compile on my dev boxes I am
>> seeking help from the gurus...  I have an old system, redhat linux
>> 7.3, with a 2.4.18 kernel with gcc 2.96 toolchain.  Unfortuneatly,
>> upgrading is not currently an option.
> That's pretty old, but I would think git should be build-able on it with
> the right Makefile flags set. We build on even older versions of
> Solaris.
>
>> I have figured out so far that I can run the command
>>
>> make NO_NSEC=true
>>
>> to get past the time struct compile error.
> As an aside, you can put definitions like this into config.mak, which is
> read automatically by the Makefile. Then you don't have to specify them
> on the command line for each 'make' invocation.
>
>> After that, I was able to hand edit the Makefile to set
>>
>> BASIC_LDFLAGS = -ldl
>>
>> so linking the git-imap-send program succeeds (was failing to link
>> against this library for some reason...).
> What was the link error? I don't know why imap-send would need to link
> against -ldl. However, you should be able to just put -ldl into the
> LDFLAGS on the command-line or in config.mak.

The actual link errors were unresolved references to the dl* family of 
functions: dlopen, dlsym, etc.

>> I tried to run configure with these options, but it did not seem to
>> take, only setting NO_NSEC=true to the make command line seems to
>> work.
> Was NO_NSEC set in the resulting config.mak.autogen?
Not sure.  I set up the config.mak though so it is sticking with that.
>
>> Anyway, now I get to the point in the build where it goes into the
>> perl subdir and fails with:
>>
>>     SUBDIR perl
>> /bin/sh: -c: line 3: syntax error near unexpected token
>> `"s<\Q++LOCALEDIR++\E></'
>> /bin/sh: -c: line 3: `        -e "pm_to_blib({qw{Git/I18N.pm
>> blib/lib/Git/I18N.pm private-Error.pm blib/lib/Error.pm Git.pm
>> blib/lib/Git.pm}},'blib/lib/auto','/usr/bin/perl -pe
>> "s<\Q++LOCALEDIR++\E></usr/local/git-1.7.9.2/share/locale>"')"'
>> make[2]: *** [pm_to_blib] Error 2
>> make[1]: *** [all] Error 2
>> make: *** [all] Error 2
> I haven't seen that before. The snippet mentioned in the error message
> is actually written to the Makefile by Makefile.PL. Can you show us the
> relevant part of the Makefile (i.e., the command that contains
> "++LOCALEDIR++") so we can see if it's broken? My suspicion is that
> there is an error in the generation of the Makefile by Makefile.PL.

Around line 108 in my GIT_HOME/perl/perl.mak I have this:  (line numbers 
are from VI)

     108 PM_FILTER = $(PERL) -pe 
"s<\Q++LOCALEDIR++\E></home/tschumacher/share/locale>"

and later PM_FILTER is used as:

     713
     714 # --- MakeMaker pm_to_blib section:
     715
     716 pm_to_blib: $(TO_INST_PM)
     717     @$(PERL) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)" \
     718     "-I$(PERL_ARCHLIB)" "-I$(PERL_LIB)" -MExtUtils::Install \
     719         -e 
"pm_to_blib({qw{$(PM_TO_BLIB)}},'$(INST_LIB)/auto','$(PM_FILTER)')"
     720     @$(TOUCH) $@
     721


> Although your perl is so old the first step may be either to turn off
> perl or upgrade to a newer version (see below).
>
>> A couple questions I have so far:
>> (1)  how can I make make output the actual command it is executing so
>> I can try to debug things more quickly?
> Doing "make V=1" will be more verbose. You can also use "make -d" to get
> more output about which rules and commands are being followed, but its
> output can be a bit overwhelming (and I don't think you have a make
> problem, exactly).
>
>> (2)  how can I configure the Makefile to automatically set -ldl as
>> well as the NO_NSEC flag?
> Put it in LDFLAGS.
>
>> (3)  My perl -v output: This is perl, v5.6.1 built for i386-linux.  Is
>> this sufficient?
> These days we require at least 5.8, mostly because no developers are using 5.6
> and support for it is bit-rotting. If your perl is that old, probably
> setting NO_PERL is the best option. You will lose a few perl features
> like interactive patch selection ("git add -p") and git-svn.
>
> -Peff

I am trying to install a newer version of perl on this box and will 
retry the configure adding --with-perl option and see how it goes.
