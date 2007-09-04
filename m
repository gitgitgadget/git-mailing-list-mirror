From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Calculating tree nodes
Date: Mon, 3 Sep 2007 23:26:30 -0400
Message-ID: <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	 <20070904025153.GS18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 05:26:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISP3l-0002np-Ht
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 05:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbXIDD0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 23:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXIDD0c
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 23:26:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:45807 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbXIDD0b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 23:26:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2079830wah
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 20:26:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VPO6wgDdUNTZHUSQJLSXCp4+EpCuVb5NjQM6NgAUTmQP5ewGpJR5zU3d9RIUSVgeBxfCQR1N+rKox/oeVBA2bMfSWZ5pFii8QrX89hj2/4XDyQV/bfAK8lxQ0ZsI9ja+MY4duGQF9koBpLj2LhNM1r2gv/hs76MJxNtvl4q8EaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s+NLFy5vbs/sFKAOIgZI0kpoDp+RbLz3VPbvV5DQFmPEdyAv/SzFOJj0kxktFklKa9LRgo9YPd8FEr9B7bU2ojxmGN3mOnSIQpGpkbCo0uKAbg/MJp+rSYhlhEHd0CfAj2y9MA8zfT9T+g4sj4arb0oDpFuLnEM3MnBaD/FHIHs=
Received: by 10.114.175.16 with SMTP id x16mr163972wae.1188876390563;
        Mon, 03 Sep 2007 20:26:30 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Mon, 3 Sep 2007 20:26:30 -0700 (PDT)
In-Reply-To: <20070904025153.GS18160@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57515>

Are tree objects really needed?

1) Make the path an attribute of the file object.
2) Commits are simply a list of all the objects that make up the commit.
Sort the SHAs in the commit and delta them.

This is something that has always bugged me about file systems. File
systems force hierarchical naming due to their directory structure.
There is no reason they have to work that way. Google is an example of
a giant file system that works just fine without hierarchical
directories. The full path should be just another attribute on the
file. If you want a hierarchical index into the file system you can
generate it by walking the files or using triggers. But you could also
delete the hierarchical directory and replace it with something else
like a full text index. Directories would become a computationally
generated cache, not a critical part of the file system. But this is a
git list so I shouldn't go too far off into file system design.

Git has picked up the hierarchical storage scheme since it was built
on a hierarchical file system. I don't this this is necessarily a good
thing moving forward.

If we really need tree objects they could become a new class of
computationally generated objects that could be deleted out of the
database at any time and recreated. For example if you think of the
file objects as being in a table, inserting a new row into this table
would compute new tree objects (an index).

Index is the key here, we may want other kinds of indexes in the
future. It was the mail about auto-generating the Maintainers list
that caused me to think about this. If file objects are a table with
triggers, building a hierarchical index for the Maintainers field
doesn't make sense.

These are just some initial thoughts on a different way to view the
data git is storing. Thinking about it as a database with fields and
indexes built via triggers may change the way we want to structure
things.

-- 
Jon Smirl
jonsmirl@gmail.com
