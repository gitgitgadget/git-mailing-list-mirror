From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Wed, 16 Apr 2008 21:44:39 -0400
Message-ID: <32541b130804161844g9c7b321u70bbd36a01494185@mail.gmail.com>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
	 <20080416200107.GG3133@dpotapov.dyndns.org>
	 <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com>
	 <20080416203923.GH3133@dpotapov.dyndns.org>
	 <320075ff0804161447u25dfbb2bmcd36ea507224d835@mail.gmail.com>
	 <20080416223739.GJ3133@dpotapov.dyndns.org>
	 <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com>
	 <20080417004645.GK3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nigel Magnay" <nigel.magnay@gmail.com>, git <git@vger.kernel.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 03:45:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmJBs-0001Fa-Qr
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 03:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbYDQBom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 21:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbYDQBom
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 21:44:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:60732 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYDQBol (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 21:44:41 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2641072fgb.17
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=amhE1TZlLcyrNMKGxLKcAL7UjuZ4HE3CHyKoAwsrRts=;
        b=pqJT4Op1s9hqB0Z/sOa1Jsjv5vk55p4jNQaNvzIU/EX6r3nnWa8Z/3qC0k7gAD4q+PNmT/keXdw+t5Nhfko87BHjPmoQnNk/8/k1rvIB3ZAsEQBO46KgYR/zwUN2VQAq2WzfI7Ur11TZUFRqdnkgwJ8Yksmecm5L1iFW1T8SasE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B3TznpmsqzLJLyX90T8zzvok5cAXfrRvaiwC999Jg+F03viooD+GUBUpevuWOn3z1xX3AX9apDKN+7Fun73w0M1Ch9GK0ItFV0r7D+hqtodqlLM1fu8dS413AzypgKk93ZAf0tWm5ENquVFND+k8CJtYxOkH8KoHlIaE2eicdtY=
Received: by 10.82.153.5 with SMTP id a5mr1200333bue.5.1208396679864;
        Wed, 16 Apr 2008 18:44:39 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 16 Apr 2008 18:44:39 -0700 (PDT)
In-Reply-To: <20080417004645.GK3133@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79764>

On 4/16/08, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Thu, Apr 17, 2008 at 12:07:27AM +0100, Nigel Magnay wrote:
>  > Okay - at the very least this behaviour is really, really confusing.
>  > And I think there's actually a bug (it should *always* report that the
>  > file is different), not magically after it's been touched.
>
> I don't think there is a simple way to correct that without penalizing
>  normal use cases. Usually, people do not change autocrlf during their
>  normal work. Besides, you can have your own input filters and they may
>  cause the same effect. So, Git works in the assumption that input filters
>  always produce the same results...

However, it doesn't check that before it marks the file as unmodified
right after checkout.  That is, the problem is hidden until the file's
mtime changes.

Is there a way to quickly check that every file in the repo is "sane",
ie. the input filter is the proper inverse of the output filter and
will put each file back in the repo?  This is pretty important for
anyone designing any kind of input filter, or bugs will go undetected
until some later time when they're confusing.

> If you imported correctly in Git, it should not have CRLF for text
>  files. So, there is no conversion that a user does expliciltly.

Can you give a set of steps for how to import "correctly" using git-svn?

Remember that a given svn repository might have long ago been
configured to store CRLF (actually, to store files without changing
their line endings), since that is the svn default.  Also remember
that the svn:eol-style flag may be set differently on various files in
svn, and may have changed in different svn revisions over time.

Thanks,

Avery
