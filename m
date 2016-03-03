From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH/RFC] builtin/tag: Changes argument format for verify
Date: Thu, 3 Mar 2016 17:05:03 -0500
Message-ID: <20160303220502.GA2234@LykOS>
References: <1456532864-30327-1-git-send-email-santiago@nyu.edu>
 <20160227043625.GC11604@sigill.intra.peff.net>
 <20160227174523.GB11593@LykOS>
 <20160227183133.GB12822@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 23:05:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abbMw-0001lm-6R
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 23:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756975AbcCCWFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 17:05:08 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33902 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863AbcCCWFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 17:05:06 -0500
Received: by mail-qg0-f48.google.com with SMTP id w104so29242513qge.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 14:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LnHBdWx24e5jzIO0cyfAE4VU4LV19O/bVjU8E2Qxl9k=;
        b=TXlvlA/oLtXTao3/7CaLu+ElfdcApCscTQp4MUWktYGdG9M6odpPCsVJiT/CQib2Ci
         gnqF5wca4jrBw++7eaRdxRGLmGsFBajU2MdgPHddDLo6SeOqVevEAlBk+4isn5fELlBy
         JZ4cnO7VWwCPMs/BavTN/ZslhAq+LEMXaNlALYOdmmsPEN3hB4gJxoS7O+isI0wLz/x1
         EfAoZqJad2sqFu9sbQwedCkCcq7b6dz1MHBHDnypkKMHKl/DNQoy117EihLxOaLIly7N
         gQqO8+A1crJb+0QIHmNvRmeKptVebPqTE8dJ93KzrJcUYlMA2ZZ7LlMj5Cj79csHYVPI
         w0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LnHBdWx24e5jzIO0cyfAE4VU4LV19O/bVjU8E2Qxl9k=;
        b=iLaKOpnzMORNiDpErHmJl6uxinLghJmx1zl0hwNN7RVOB4FP3dkgSDe+ALAcBYNWQ/
         zRSTipbQuCh3hcSK/ruR0aSDeIWZY/6abIug4g9ciuZ0/7Q7kzFD65yhamJ4sz8XV2Rm
         o9WVLsejPxnmpHs39ajWvdlMpwSbYyb8Ab9iUi2EbFngJwCC+GRIwa8fwaZs8ie7biBX
         wPHl/2M5XCxa8tRbELII0PZtNTBsHoFF8nPoyYifMKA6TIl9F+t7cI37LGfMVShFi3X0
         r58r4h526dhej6pPLlzXdujst82CqT+BMRO1KOKXPL/wDSygxwZIAEl9zmYNbGdNNb9q
         4crg==
X-Gm-Message-State: AD7BkJJeHWB+NWkfJH7MpO/+r1crT2dUR9pD4UvXyCOwyRoqvrwwl3wo4kRbJfUmwv83McGW
X-Received: by 10.140.168.85 with SMTP id o82mr448698qho.75.1457042704593;
        Thu, 03 Mar 2016 14:05:04 -0800 (PST)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-14.NATPOOL.NYU.EDU. [216.165.95.3])
        by smtp.gmail.com with ESMTPSA id l36sm262063qgd.29.2016.03.03.14.05.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Mar 2016 14:05:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160227183133.GB12822@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288215>

Hi Peff.

I've been trying to shape these changes into sensible patch, but it is
not as trivial as I originally thought. I think the issue lies in the
tag desambiguation aspect of the git-tag command.

It seems that verify-tag can take either the refname or the hash of the
object. However, git tag --verify takes only the refname, so it doesn't
resolve the tag-sha1 if that's specified as an argument. 

I'm wondering if this is what we would want in the updated patch (accept
sha1's also). If so, does the following make sense?

1) if arg not in .git/tag/refs
2) then try to resolve using get_sha1(name, sha1) take it from there.

Also, would it make sense to remove the verify-tag command altogether? 
On the same line, it seems that there used to be a --raw flag on the
verify-tag command, should I propagate this to git tag --verify?

Thanks!
-Santiago.



On Sat, Feb 27, 2016 at 01:31:33PM -0500, Jeff King wrote:
> On Sat, Feb 27, 2016 at 12:45:24PM -0500, Santiago Torres wrote:
> 
> > > A much more interesting change in this area, I think, would be to skip
> > > verify-tag entirely. Once upon a time it had a lot of logic itself, but
> > > these days it is a thin wrapper over run_gpg_verify(), and we could
> > > improve the efficiency quite a bit by eliminates the sub-process
> > > entirely.
> > 
> > I agree here too. while going through gdb to follow the logic on this I saw that
> > this code forks three times (git, tag-verify and gpg). I'm sure that
> > removing one layer should be good efficiencly-wise.
> > 
> > Is it ok if I give this a shot?
> 
> Sure.
> 
> I suspect the extra process is there for historical reasons; git-tag was
> originally a shell script that called out to git-verify-tag, and the
> conversion to C retained the separate call.
> 
> I cannot think of a reason that it would be a bad thing to do it all in
> a single process. Do note the trickery with SIGPIPE in verify-tag,
> though. We probably need to do the same here (in fact, I wonder if that
> should be pushed down into the code that calls gpg).
> 
> -Peff
