From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Submodules and merge conflicts
Date: Thu, 21 May 2009 16:31:39 -0400
Message-ID: <32541b130905211331u47be06afrcff2e01f0c666680@mail.gmail.com>
References: <1242912120853-2951928.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 22:32:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Evx-0004vi-MR
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 22:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbZEUUcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754667AbZEUUb7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 16:31:59 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:59712 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbZEUUb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 16:31:59 -0400
Received: by yx-out-2324.google.com with SMTP id 3so801116yxj.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 13:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8sSqUOide50BaRfAoNZpTDDG9kOhDNHj2aGqXUIiQQ0=;
        b=CgRgueJjSdkHWrAo7wWy6zGP3ap42sXSCLtwfZJrrPCYkpPGDBHBJhIyDD8dtu4zfq
         UnK4wVg8N9R67hOQ506E5q61b3VKRdqR+Zw/HZZldmqSQ3gVvwV0a8DLbihdaAPgyvrz
         1ha1s1CW4OaTI3f7ShhDmgK63XFUB2IfPSvvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=j3obZlKFUIiwFyjHnnXK249vZ0LSfbaTkUcxdFqAGbdsSPy6aOqF/OqYXoLll1k42+
         SmsV+rqGqvLgtlLLDlzuikMy1zelN9ULRqPSg6TP7PENoiTHm8hOoyLU7VWJHX9QS6XK
         DI4vpXwM8h+7C6myhgroWhBN0/Pf1fNZP1xiU=
Received: by 10.150.136.15 with SMTP id j15mr5871586ybd.260.1242937919099; 
	Thu, 21 May 2009 13:31:59 -0700 (PDT)
In-Reply-To: <1242912120853-2951928.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119706>

On Thu, May 21, 2009 at 9:22 AM, Henk <henk_westhuis@hotmail.com> wrote:
> Instead of using the sha1 of a specific revision in the submodule, I would
> find it more logical to use a branch-name or tag. This way you can commit on
> the submodule without having to commit the new submodule revision to the
> main repository also.
>
> I would like to hear your thoughts on this. Maybe we are using submodules
> wrong, or maybe this is already possible.

The primary advantage of the git submodule code is the ability to lock
to a specific sha1.  If you don't want to do that, you're not going to
get much benefit from using submodules.

One option here is to simply skip the 'git submodule' altogether and
just have a script that checks out the other git repositories into
subdirs.  Then you have total control over which branches, etc are
included, the changes to the script (eg. to change which branch you
want to use) can be merged just like changes to anything else.

We do something in between on our internal projects: we use git
submodules to lock in the sha-1 (it's really valuable to know
*exactly* which version of everything was used in a particular
release), but we have scripts to auto-update the sha-1 for each
submodule to the tip of the right branches.

For some other projects, we also use the git-subtree tool I developed
(http://alumnit.ca/~apenwarr/log/?m=200904#30) but given that your
submodules are huge things like the Linux kernel, it's probably not
appropriate in your case.  You might want to look at it anyway in case
I'm wrong.

Have fun,

Avery
