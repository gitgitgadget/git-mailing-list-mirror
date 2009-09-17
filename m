From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and 
	MSVC
Date: Thu, 17 Sep 2009 12:39:22 +0400
Message-ID: <e2480c70909170139x9580bb4pcc1ad8e1b93aef17@mail.gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>
	 <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>
	 <4AB10F01.9010703@viscovery.net>
	 <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com>
	 <4AB1E118.70504@viscovery.net> <4AB1E4C5.80102@gmail.com>
	 <4AB1E6E4.1040100@viscovery.net> <4AB1EB02.2090308@gmail.com>
	 <4AB1EF0E.5010600@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 10:39:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoCWY-0000S7-K1
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 10:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbZIQIjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 04:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbZIQIjV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 04:39:21 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:36489 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbZIQIjU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 04:39:20 -0400
Received: by bwz19 with SMTP id 19so137863bwz.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=h/Luk/Ik/vLSjQlBxxm/MHwhF9++GrGDFEkDA+6whVY=;
        b=LP5aqzkSqgXVDRD90w2ykDNSg+hBF0kyidJgzGHoY4O5XtGSu0G2DzZ8jCTEtS4e8Y
         AZOVdnKiTBwMW7rDIGVKEP3dDMVcjdykRGMAme+XBucyuwcDpEWn5rdAwg7+1YJc8OH6
         fHTKdvWlOkcprgAMqFjrmh/JTbli/wZW9ua0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GM2oooe6Au+5eRC3CRMwBmCunLzmldFW9Mk96F5dW2rSKPSmhvVlhhMCgcj7uGmYIJ
         SdzWuWvKdyhUKBZI35yYX4WnupSBcMb+R+wu9JSCo2Or2dRM77IkDj6IZnCgr/x2ByzD
         Jmhvtq6R4OWwm7VXLbVSTTWzfVlsBLs6rZq0k=
Received: by 10.223.4.144 with SMTP id 16mr3459862far.36.1253176762223; Thu, 
	17 Sep 2009 01:39:22 -0700 (PDT)
In-Reply-To: <4AB1EF0E.5010600@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128733>

On Thu, Sep 17, 2009 at 12:10 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Marius Storm-Olsen schrieb:
>> BTW, I ran all the tests (make /k test) before and after the
>> whole series, with msysgit 'devel' branch + plain git.git 'next',
>> and it turns out that 2 more tests pass after this series :)
> Sorry to disappoint you: these 2 tests only passed by chance. For a
> work-around see e95a73ef in mingw.git (it papers over an undetected
> racily-clean index).

Maybe we should just implement nsec for mingw? The code is already almost there:

Converter filetime_to_timespec is available in cygwin.c
Definition of struct timespec and struct stat that uses it can be
borrowed from cygwin's cygwin/stat.h and cygwin/types.h, we could call
it struct mingw_timespec and struct mingw_stat. Then #define timespec
mingw_timespec and #define stat mingw_stat, as well as #define
st_atime (st_atim.tv_sec) and similarly others, just like
cygwin/stat.h does.
Since we already reimplement stat/lstat/fstat it should be relatively
simple and we don't care about usage of mingw's stat.
Do you want me to cook up a patch?
