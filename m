Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857818BBBB
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739566573; cv=none; b=Vs6OUGNaub2JC3pCNSQLQl839ABnpKAaykK6ydP9rSMoSDxS9zeX63RSyW9w5CRb4XFioVeHKbBgRWNhgj82i93aELXc3f3vr7TU2nB14Li9p8/POhgRyMEC5tmQJe+fKS0VQchuN0q4tIfGur5/JvaZ+gR+tNYPEHcWveCBbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739566573; c=relaxed/simple;
	bh=5yniUHeKHBjGwUucL++MkUfEofXcWDicoZULAFMdTy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu9nbq+WsndSYnStVh1Gjz+lE1Xm86d13rI4N1qfZMkpE5RoJdOAG/ZJsvDY26lQqasJr3WO35L+kyrrwGdl6nWCIluSFJ00u+PdkPEw07ep2/rZY55LW4kNcRxSI5fhIheICcjA9gRI8l9GgUw5E6iuhW1YooHx3QMNjf6vWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tj2jG-008LjP-GR; Fri, 14 Feb 2025 21:56:06 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 9076160117; Fri, 14 Feb 2025 21:55:13 +0100 (CET)
Date: Fri, 14 Feb 2025 21:55:13 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: renormalize histroy with smudge/clean-filter, again
Message-ID: <20250214205513.GU30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
References: <20250205214726.GA30202@raven.inka.de>
 <20250211235707.GQ30202@raven.inka.de>
 <Z6-lyJNvXHhrVXhg@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6-lyJNvXHhrVXhg@tapette.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 14, 2025 at 08:21:28PM +0000, brian m. carlson wrote:
> On 2025-02-11 at 23:57:07, Josef Wolf wrote:
> > Still struggling with my filter problem.
> > 
> > Here is what I do:
> > 
> > - Set up a clean filter which enforces CRLF (yes, for this specific use
> >   case I want CRLF even on linux)
> 
> Is there a reason you can't use `eol=crlf` instead of a smudge/clean
> filter?  That looks like this in the Git repo:

Yes. Most of the data files of this (proprietary) application are XML files
using mostly CRLF, but there is also LF ancoded content. Like this:

[ ... ]
 <foo>^M
  <bar>
  fonly LF in contents of bar
  </bar>^M
 </foo>^M

In addition, it randomly shuffles the XML elements at every startup, even if
no changes are done. To prevent conflocts from this, I need to sort the XML
elements into a canonical ordering in the clean filter.

-- 
Josef Wolf
jw@raven.inka.de
