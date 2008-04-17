From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Thu, 17 Apr 2008 11:09:12 +0100
Message-ID: <320075ff0804170309h4232463fk984f362e6cf0a259@mail.gmail.com>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
	 <20080416200107.GG3133@dpotapov.dyndns.org>
	 <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com>
	 <20080416203923.GH3133@dpotapov.dyndns.org>
	 <320075ff0804161447u25dfbb2bmcd36ea507224d835@mail.gmail.com>
	 <20080416223739.GJ3133@dpotapov.dyndns.org>
	 <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com>
	 <20080417004645.GK3133@dpotapov.dyndns.org>
	 <320075ff0804170007k5171eb72n68882679f62fa238@mail.gmail.com>
	 <20080417094342.GM3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 12:11:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmR4F-0006Ul-6j
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 12:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088AbYDQKJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 06:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935292AbYDQKJS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 06:09:18 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:21019 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934055AbYDQKJO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 06:09:14 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3678fkr.5
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+pt8mi/sN1vUmzv1kFpGgh2EtfNucCChvXgAQQ1728o=;
        b=AEM1QQtnlm8tPw1unNf1iZ3Sr1rUoZRq02lPXP2mEq+H6WpUPSoDNE8XIr3NvoKNCkj3+UZ8HcQoMPYW71peH1xLuNwXxdkmEuT4zIIlNRwgWm7iEyYGzJXDb7e1sMLtizOY+FExS82peHQADoFhsu/U7bRVK4BmU7K8Rpfc1E0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hlmfGsn4hTeQEV37w4gcU8qgIhotlMgsxPKdmH6N8O+hxXzr0qj1LPbzfsptE7hhMyYfIqeXzTL+f1XMpgq6CMrL/TXhH/zdU9BNrT9OxvW6rzP56GdxqHfhh2xalc0lde+ujwdwpFcGTaUsM2eURZm41XHYDBl1UOUDgB4alg0=
Received: by 10.82.158.12 with SMTP id g12mr1953338bue.50.1208426952235;
        Thu, 17 Apr 2008 03:09:12 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Thu, 17 Apr 2008 03:09:12 -0700 (PDT)
In-Reply-To: <20080417094342.GM3133@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79781>

>  >
>  > I'm saying it ought to be something like
>  >
>  > isDirty = ( wc.file.mtime > someValue ) && (sha1(repository.file) !=
>  > sha1(wc.file) ) && ( repository.file != filter(wc.file) )
>
>  I don't think it is reasonable. Files inside of the repository and
>  in the work are not meant to be the same. What if I have $Id$ expansion
>  or something else. What could make sense is to add an additional check:
>   && convert_to_work_tree(repository.file) != wc.file
>  but it should be optional, so it will not penalize those who do need
>  or do not want this extra check.
>

Ah, yes - you're right (I was only thinking about check-in filters,
not check-out).

I agree it ought to be optional; I suggest it ought to be turned on
(be default) in the $Id$ expansion and the core.autocrlf=true
scenarios (I.E when there's some filter in place).

>
>  > >  > ...
>  Maybe, you can teach git-svn to be smarter... I mean storing text files
>  in Git repo with CRLF is stupid, so, perhaps, git-svn can do a better
>  job converting CRLF<->LF when it exports and imports from/to SVN.
>

Yar - maybe there's some options there. Maybe it isn't so bad - all
svn projects probably *ought* to be using eol=native, but it isn't
default; so maybe it's just easier to coax those projects into fixing
their svn repos (but of course it's not really an issue for them, so
it might be a bit of a hard sell).

I may add some detail to the wiki docs to point this out - if I'd done
it up front to our local projects, my life would be easier!

>  ...
>  You can use Git and have CRLF in your work tree. You just need to
>  have autocrlf=true for that. _Inside_ of Git, only LF is the end
>  of line. How you store in SVN, it is a separate issue with git-svn.
>  I guess, git-svn needs improvement in this area...
>

Yes, in the sense that git is primarily a *nix tool, so it treats LF
as canon and CRLF as somehow 'stupid' (I.E you could make an equally
valid argument for the reverse position, it just depends on your
perspective ;-)) ; but then again, it's only an issue because I'm now
merging in git *waaay* more often and it's uncovering a problem that
might actually be there already (modulo the fact that svn merging may
ignore line endings anyway - but I don't know because all merges there
seem to inevitably end up in conflicts anyway..).
