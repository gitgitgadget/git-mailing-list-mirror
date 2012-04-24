From: Andreas Ericsson <ae@op5.se>
Subject: Re: Build without BUILT_INS
Date: Tue, 24 Apr 2012 10:32:14 +0200
Message-ID: <4F96650E.7040900@op5.se>
References: <CAAXzdLVbqp-_9A+BwcOuiHi3A39gAJb7_NqANfhAfuK9-+iZ0g@mail.gmail.com> <xmqqmx61hmtu.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 10:32:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMbAh-00079l-Cs
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697Ab2DXIcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:32:20 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49787 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab2DXIcR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:32:17 -0400
Received: by lbbgf7 with SMTP id gf7so379233lbb.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 01:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=UOR+gqqEh58ExUp7dN2TBIb/voZocoi9oYElJBkCvAU=;
        b=oF37GeYJSSfj7TP4Ejj2EgNN/xmf5JO4Tmx1/JAAD7jthvBI6nA3OLQGvA++A1q5H5
         8nUNA8FvIKV8yfp62NSIV9w64X10pDETOKdGLqrqXB9p+5zm8pFdEz4fnfZ/TbEy34jS
         O1QZMeshU/X7nTFAGofSKV43DNsd3GSpK9N4arza2gOn48FZtYQj3gRB5k3axjwm3xLZ
         8PiYdRxU8FpxoTL1UW0056tmh5GT/SdMp2Flb+asCGX57M7cTft7KmW0pwoKvI4hQZbd
         y5PucrsjkAKjdNAaKo/zOjp8a4rkjfzmaTAF4ws0qETTSJWBzXN0HAmXS+jiLQac2R/G
         Z1sQ==
Received: by 10.112.100.8 with SMTP id eu8mr9393768lbb.16.1335256336390;
        Tue, 24 Apr 2012 01:32:16 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id os6sm12636128lab.6.2012.04.24.01.32.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 01:32:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <xmqqmx61hmtu.fsf@junio.mtv.corp.google.com>
X-Gm-Message-State: ALoCoQmlmqaKKrWicSEVqlFKzxHAoOhY4GfZcd9m8cRJ7jTtFdgkWAJ20VdH1E7CRZoQsT27vEkB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196209>

On 04/24/2012 04:42 AM, Junio C Hamano wrote:
> Steven Penny<svnpenn@gmail.com>  writes:
> 
>> I would like to build Git for Windows without the hard links in libexec/git-core
>>
>> I tried doing
>>
>> make install prefix=/c/git BUILT_INS=
>>
>> and I get this error
> 
> Unsurprising.
> 
> What are you trying to do?  Are you trying to build a git that does not
> know any of the built-in commands like "checkout", "commit", etc?  Or do
> you still want a full-featured git, but because you know the code to
> perform "git foo" for any builtin command "foo" is contained in git
> executable itself, you want to "rm -f git-foo" from the filesystem?
> 
> The latter is a bad idea to begin with, as it will break older scripts
> that trust the promise that by having git --exec-path early on the $PATH
> older forms "git-foo" will always work.
> 
> If you really want to do so, the right way is not by mucking BUILT_INS
> to empty.  I do not know how GfW is built, but if it uses our usual
> Makefile, find the place where it installs the git-foo forms of links
> after it installs the main git executable, and comment it out.
> 
> And no, it will *not* be a compilation option, as the resulting
> installation will break the age-old promise we made to script writers.
> 

Otoh, we did warn that we were going to deprecate the 'git-foo' form back
in 2005 when the git wrapper was rewritten in C, so perhaps we should
consider marking it as deprecated now so we can get rid of them altogether
altogether in another seven years. ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
