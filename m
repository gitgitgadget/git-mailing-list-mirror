From: David Rientjes <rientjes@google.com>
Subject: Re: [RFC] adding support for md5
Date: Fri, 18 Aug 2006 13:35:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608181328160.30860@chino.corp.google.com>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
 <Pine.LNX.4.63.0608181209210.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 22:35:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEB40-00079n-VQ
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 22:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWHRUf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 16:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbWHRUf3
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 16:35:29 -0400
Received: from smtp-out.google.com ([216.239.45.12]:36155 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161098AbWHRUf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 16:35:28 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id k7IKZ9gx024318;
	Fri, 18 Aug 2006 13:35:09 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=uKshTU6bqLrRAOhMwEzyjRVmVlBD825K2aIYAq2Y1CnK88a1j8OvWTkmSNIUnTvNN
	Ew7Y6neY7H+e55b0sRRMw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps37.corp.google.com with ESMTP id k7IKZ5tq029686;
	Fri, 18 Aug 2006 13:35:05 -0700
Received: by localhost (Postfix, from userid 24081)
	id 1A1B787D71; Fri, 18 Aug 2006 13:35:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id BE81387D70;
	Fri, 18 Aug 2006 13:35:03 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608181209210.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25695>

On Fri, 18 Aug 2006, Johannes Schindelin wrote:

> Make it a config variable, too, right?
> 

Sure.  The default hash function can be a config variable so that all 
projects started with init-db will default to a specific hash.  Other 
projects may still be started with something like init-db -md5.

> 1. they could be faster to calculate,
> 2. they could reduce clashes, and related to that,
> 3. it is possible that some day SHA1 is broken, i.e. that there is an 
>    algorithm to generate a different text for a given hash.
> 
> As for 2 and 3, it seems MD5 is equivalent, since another sort of attacks 
> was already successful on both SHA1 and MD5: generating two different 
> texts with the same hash.
> 

Correct; performance was my main motivation.  sha1 is obviously the 
securest algorithm among the two choices, but there are more steps 
involved in the hash than md5 (sha1 uses 80 and md5 uses 64) and sha1 is 
160-bit compared to the 128-bit md5.  One paper I read from the 
Information Technology Journal stated that sha1 is 25% slower than md5 
precisely for these reasons.

> However, you should know that there is _no way_ to use both hashes on the 
> same project. Yes, you could rewrite the history, trying to convert also 
> the hashes in the commit objects, but people actually started relying on 
> naming commits with the short-SHA1.
> 

I don't foresee changing a hash on a project (and thus rewriting the 
history) to be something that anybody would want to do.  As I said in the 
email that started this thread, it would be configurable at runtime on 
init-db.

> I think it would be a nice thing to play through (for example, to find 
> out how much impact the hash calculation has on the overall performance 
> of git), but I doubt it will ever come to real use.
> 

Again, when working with an enormous amount of data, this could be a 
considerable speedup.  A terabyte is _big_.

		David
