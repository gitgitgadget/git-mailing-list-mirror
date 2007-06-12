From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: That improved git-gui blame viewer..
Date: Tue, 12 Jun 2007 13:27:19 +0200
Message-ID: <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	 <20070611064203.GG6073@spearce.org>
	 <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
	 <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com>
	 <7vbqflll55.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 13:27:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy4XN-0000eQ-5L
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 13:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbXFLL11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 07:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbXFLL11
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 07:27:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:10514 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbXFLL10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 07:27:26 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1264621wra
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 04:27:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CIMfrnnPuFqHHzwKCEaYNUAbywrj2v6D1J9KgzQnijlbKVU5GhbMRIbZkgYsecmKGUBE8Lp4pTLVwj/TXwggOUXVrXhxaapOt/e4cteSd/yIy5bjgwD9bXDeJW5fVwzD+Uj32p2tI8MJxDPCxY5sT0/Exz/CVgUCjaf1cCZsZL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ul5qpcJxS1PRgYxCqxiHnQr+GztV9Ey8iNf96p8cx3KIsXeNaTgcgL2HCSmdBZVkWNRCXyeD46mru81C64hYrcCU8kVzta6bQ3+WG3Lff2QyVnZWeutV7NuF4MvUYajl70+oVfB67UpNNYdGqjqF9ym9tXLeoJKSmfimt/xVp4E=
Received: by 10.114.67.2 with SMTP id p2mr6610545waa.1181647639570;
        Tue, 12 Jun 2007 04:27:19 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Tue, 12 Jun 2007 04:27:19 -0700 (PDT)
In-Reply-To: <7vbqflll55.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49949>

On 6/12/07, Junio C Hamano <gitster@pobox.com> wrote:
>
> > Annotate algorithm of qgit is little different in that it starts from
> > the oldest revision that modified a file and goes to the latest. In
> > this way we can have the whole file history annotated in one pass and
> > very fast.
>
> I am not sure about two things in this description.
>
>  (1) Are you emulating CVS-like "a file has an identity, and we
>      follow its changes" model?  How does it handle file split,
>      merge, and code movement in general?
>

It uses 'git rev-list HEAD -- <path>' to get the list of revisions
that modified a path,
I really would like to keep it like that because it is the way 'git'
works, and I would feel uncomfortable in filtering out git results, it
seems quite fragile to me.

This means that file splits, merges, renames etc.. are handled as much
as they are handled in git. IOW *if* 'git rev-list HEAD -- <path>'
returns a list of revisions taking in account all of the above, so it
will, automatically, do qgit.

BTW _currentlly_ git-rev-list does not do that.


>  (2) It is unclear why going from old to new has the advantage
>      of being "one pass", implication of which is that the
>      opposite direction needs to be done as more than one pass.
>      Care to enlighten?
>

Going from oldest to newest has this advantage:

1 - start from a known good first (empty) annotation, i.e. the first
revision in history has an empty annotation (this is a choice to get
consistent results when dealing with git repository started after the
begining of the project, Linux tree started from 2.6.12 is an
example).

2 - Given a good annotation (ann1) at a given time in history you can
calculate the next annotation (ann2), the annotation corresponding to
the next (newer) revision in history that modified the file using just
the diff between the two. If you don't discards ann1 you end up having
both ann1 and ann2.

3 - So at the end of applying all the diff chain you get all the
annotations for all the file revisions, each annotation requires only
the previous one and the corresponding diff.

4 - You don't need to touch anymore an already calculated file, nor
applying the corresponding diff more then one time.

So the complexity of annotating *all* the files revisions grows only
linearly with the revision list size.

 Marco
