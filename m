From: "Tony Luck" <tony.luck@intel.com>
Subject: Computing the number of patches in linux-next tree
Date: Tue, 22 Jul 2008 09:19:30 -0700
Message-ID: <12c511ca0807220919q4db6ee1fr33dc70fe35c58efe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:20:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLKbJ-00074Q-32
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 18:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYGVQTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 12:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYGVQTd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 12:19:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:56903 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbYGVQTc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 12:19:32 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1941857rvb.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=6sVia004WRc/w3xaAoUxM1XdUHL6XmmMspiEegJXcw8=;
        b=EfStJxFWa/rEP1fz33EP/Ot3GNbdMPbTKVweOU62YEHO5KVacCku6lO+BNideDMBBB
         Y9f9GBhiKCG5fLZlSZT41TlQn9Oi766QvoZTewF16jvwNIC4+9ZUtYt/XCeTcRtp3bmH
         QbKmWjW5VWijyB/ghn2OC1AmBfB957U5QgOEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=P5gsxsUJLiRt8l4NohJuz8YjwXhSX6xPJX9Z+CCjIYkC0HkJdyr+n1/sG6saD+AazJ
         75lsEgh9AQIWFN0ha2FeVTTUFd9dI32VSmjMn/gB1mxRzk61VCpIc6O0U1l142jlf9VW
         X1KxWzap1olP0ogbyKVfBvs9H8OF/qe4E1AVw=
Received: by 10.140.249.20 with SMTP id w20mr18322rvh.21.1216743570748;
        Tue, 22 Jul 2008 09:19:30 -0700 (PDT)
Received: by 10.140.188.12 with HTTP; Tue, 22 Jul 2008 09:19:30 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 53b2012359fd95ae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89493>

I tried to produce a graph of the pending avalanche of patches
sitting in the linux-next tree and came up with this:

git tag | grep next- | sort | while read tag
do
        c=$(git-rev-list --no-merges $tag ^linus | wc -l)

        echo ${tag##next-} $c
done

Where "linus" is a branch that tracks Linus' tree.  But this gets the
wrong count
for old tags because maintainers who use the topic-branch method have
exactly the same commits in linux-next as eventually end up in Linus ... so
once Linus pulls these trees, the historical counts change.

What I really need at this point is the commit from Linus tree that Stephen
uses as the basis for each next-* tag.  I.e. change the loop body to

       base=`git-where-did-this-tag-branch-from-linus $tag`
       c=$(git-rev-list --no-merges $tag ^$base | wc -l)

Is this the right way to do this?
What does the "git-where-did-this-tag-branch-from-linus" command look like?

-Tony
