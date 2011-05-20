From: David Aguilar <davvid@gmail.com>
Subject: Re: git difftool does does not respect current working directory
Date: Thu, 19 May 2011 21:48:52 -0700
Message-ID: <20110520044851.GD13582@gmail.com>
References: <loom.20110514T160931-46@post.gmane.org>
 <7v1uzznr09.fsf@alter.siamese.dyndns.org>
 <20110520035856.GA13582@gmail.com>
 <20110520041045.GB13582@gmail.com>
 <7vwrhm3scl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 06:49:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNHe4-0004ia-3D
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 06:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176Ab1ETEs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 00:48:58 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:38873 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab1ETEs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 00:48:57 -0400
Received: by pxi16 with SMTP id 16so2248699pxi.4
        for <git@vger.kernel.org>; Thu, 19 May 2011 21:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=x2TVaT3uGPorSvmjrT6QoJH+oHyciVGjsvmqkI+5f78=;
        b=q4svb5sz+zU7k16aK+X+Ejuedfbk+kwod8CkCL+CryQjJpZ/JJ7dZDsPgmAKFN0Z5i
         bGpkiUVsm3UfzLfhJfGQtwGtWINaMEIXThFBgOLHO+gJkaGiNIGazaWXjUs51id6V8KL
         y7KMlZXIJeQhPyVXyWU1svs1Bh/JKmDgOuuUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MWMLpzZBTMGnYEZsl3FIpFRG42u3ydasUxBfnTszFyQKR49vdu8Wn7p1LqxN1vn1st
         WxbMUdEuH5FILPHL+0IusvpC0qqutFe4C7PxF5Htbo3LHZ1i5GiTD3AVv4WWxVVFc7K/
         JMqyZbzKsEaVvqYxzO16m6pfkuWTqOpe6Ellc=
Received: by 10.68.28.133 with SMTP id b5mr5810177pbh.264.1305866936857;
        Thu, 19 May 2011 21:48:56 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id y5sm2204947pbb.99.2011.05.19.21.48.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 May 2011 21:48:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwrhm3scl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174040>

On Thu, May 19, 2011 at 09:31:54PM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > We would have to change the way $GIT_EXTERNAL_DIFF works so
> > that it preserves the current directory and constructs
> > paths relative to it.  Patches welcome :-)
> 
> I am afraild that would break a lot more than difftool.
> 
> If we really wanted to change the behaviour, the external diff interface
> needs to export the value of prefix (i.e. what the original subdirectory
> was), and the script that is spawned as $GIT_EXTERNAL_DIFF (optionally
> optionally) take it into account, perhaps by cd'ing back to that
> subdirectory and possibly moving or renaming the temporary files to suit
> its needs (I think recently we also saw a request to rename the temporary
> files).
> 
> Or something like that.

Yup, yup.  That's a lot of machinery for a relatively small
gain.  Simple is simple, simple is good.  Thanks for
outlining how someone could implement it, though.

I won't do it myself but if someone is motivated enough then
your email at least gives an idea about how to go about doing
it.  git-difftool--helper could chdir to $prefix and diff each
file with $(git rev-parse --show-cdup)/$path as the path since
it may no longer be at the root.

This seems very messy so I don't really want to sound too
encouraging about going down this route.  I probably
shouldn't have encouraged looking at the temporary files
thing in the other thread either.

Thanks,
-- 
					David
