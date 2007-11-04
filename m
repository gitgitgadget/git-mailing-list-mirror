From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 4 Nov 2007 21:17:58 +0800
Message-ID: <46dff0320711040517r6da5d7aaid849ff06df1b5bb6@mail.gmail.com>
References: <1194004427-26934-1-git-send-email-pkufranky@gmail.com>
	 <7vd4us1jds.fsf@gitster.siamese.dyndns.org>
	 <46dff0320711021650q4e56d025q63a961176c682a14@mail.gmail.com>
	 <7vfxzoyz7f.fsf@gitster.siamese.dyndns.org>
	 <46dff0320711040125v111c75davb49e9822537f4b19@mail.gmail.com>
	 <46dff0320711040145k1edb1fcaq1daa5469c1158e81@mail.gmail.com>
	 <7vmytus0ff.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 14:18:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IofMj-00060p-1G
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 14:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbXKDNR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 08:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755261AbXKDNR7
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 08:17:59 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:55750 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150AbXKDNR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 08:17:58 -0500
Received: by py-out-1112.google.com with SMTP id u77so2457260pyb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HlkuHY5OAe9zWiZ6LMGYxtwYm4+Aw8ChPU5gIms9QW4=;
        b=gX+x/0Y1De1cro+Q9rPKxTSKVEZgmHi6+025zzhm7mKW6i+JBXaQ4HZzW5rTEZqblflS7YfYObTRuDGqtNIo9a4Tn93k/q7bNxomtZ4lRYdyH40Q2Z34SCFXcByUCFnT7gy6OAzRe9q6td/cmWySlKrlAegWyt67rgoHmbubZIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mbzg79YFACBGgpHQof1f0amZNsIg2x0eUTh0cynC3G7fbGVpKgmCKDoHFpyAHdSE8sOvkViIk/t04H0Of0KuqZ5FkP2c12sjyCSBjmIIw/4gaAqZW/fjwEdpOpqx//VzAkVfgdSEIbqoBRClpwj3qRM8ppqJOZXdhgqefHnGpdE=
Received: by 10.35.90.1 with SMTP id s1mr4740082pyl.1194182278065;
        Sun, 04 Nov 2007 05:17:58 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 4 Nov 2007 05:17:58 -0800 (PST)
In-Reply-To: <7vmytus0ff.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63398>

On 11/4/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Yin Ping" <pkufranky@gmail.com> writes:
>
> > In both case, i think the user should be notified about the inconsistence.
> > My patch given in the first letter handles this by two warning messages as
> > follows (where $name is module name)
> >
> > +                       cd $name >&/dev/null || { echo "  Warning: fail to
> > chdir to $name" && exit; }
>
> In that situation, all he needs to know, with respect to the
> submodule, is that the submodule has been updated since his HEAD
> (and that is given by the runstatus output).  He does not _care_
> about what the individual commits in the submodule were.  It is
> not an error that the information from the submodule cannot be
> shown to him.  He _chose_ to ignore the details of that
> submodule by not checking it out to begin with.
>
> Something like this, to be totally quiet, would be more
> appropriate.
>
>        for name in $modules
>        do
>                (
>                        ... do the range, indexone, headone stuff
>                        cd "$name" 2>/dev/null || exit 0
>                        echo "* $name $headone...$indexone:"
>                        ... whatever log you show
>                ) | sed ...
>        done
>
Your point is in some cases people think the warning messages are
annoying because they don't care the change details for submodules.
However, in some cases these messages are helpful. And a third kind of
cases is that people care about only part of all submodules.

So, maybe some an switch can be used to turn this on or off (default
off)? For example
# only sm1 and sm2 are cared
git commit --submodule=sm1,sm2

# all submodules are cared
git commit --submodule='*'

> By the way, I do not know about the quoting issues with $modules
> variable in the above illustration, as I am not (yet) discussing
> about the implementation level of details.
>


-- 
franky
