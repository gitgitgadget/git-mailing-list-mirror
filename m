From: "Manuel Woelker" <manuel.woelker@gmail.com>
Subject: Re: [JGIT] Blame functionality for jgit
Date: Mon, 12 Jan 2009 22:17:47 +0100
Message-ID: <3d045c7e0901121317j4ccd9515vbc7a44abc8ae5356@mail.gmail.com>
References: <3d045c7e0901111223j43a69402s28a59612212943f3@mail.gmail.com>
	 <20090112174232.GJ10179@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:19:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUBp-0004oa-Sz
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbZALVRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbZALVRw
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:17:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:1797 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944AbZALVRv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 16:17:51 -0500
Received: by fg-out-1718.google.com with SMTP id 19so4012923fgg.17
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 13:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vJlA8A5HiDQToc8dVdf+sRWTMTMqqrr3gIHpPG9NgRo=;
        b=bG8fzJBeI6eH8ZzM2vdnzW1kUfFQRzK2v4BLVkSTsFrUqGwscIcoWoLt2isIL/ojQ5
         1E3j5fXKwgFXntvv/a8kDofkU0QcscU5NctTAh4Na35a2zAoE1pQJ4nFvklbl0xyaJeL
         u5QR57ia6trHQA+7W+NRf3Sm8V0pEaD0pYSes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SGu4KtNoTLOccWOT/8qD2GG/uXZrEl85aBOcDR1m+79HLVzFwF2J56tJ+RRqwG1a/x
         htX0jNu8bF+w0CN+LHKQNUqeFsiCZIlibgdSL+bPo3Lp0zhIkWygn5ANnZvwZ84+9b2y
         tBa0/ZHjo+FGbsYemNCeQ/TChkiVK9jBq0DeE=
Received: by 10.86.91.12 with SMTP id o12mr360577fgb.52.1231795067544;
        Mon, 12 Jan 2009 13:17:47 -0800 (PST)
Received: by 10.86.89.3 with HTTP; Mon, 12 Jan 2009 13:17:47 -0800 (PST)
In-Reply-To: <20090112174232.GJ10179@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105382>

On Mon, Jan 12, 2009 at 6:42 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>
>> I largely ported the cgit blame algorithm described here
>> https://kerneltrap.org/mailarchive/git/2006/10/12/224187 , the
>> relevant file is builtin-blame.c cf.
>> http://repo.or.cz/w/git.git?a=blob;f=builtin-blame.c;hb=HEAD
>
> OK.  Fortunately Junio has largely given his blessing to this code
> being converted to Java under the BSD license.

Glad to hear that, Dscho already mentioned that a port like this might
raise license concerns. So I hope Junio would be okay with that.

> Unfortunately I can't reach incava.org to download java-diff, but
> its entry on sourceforge says it uses an LGPL license.  Within JGit
> we do want to stick to BSD and BSD dependencies, so bringing in
> java-diff as a new dependency isn't something we really want to do.
>
> Fortunately Dscho has been working on a Java diff implementation for
> JGit, and is considering releasing it under a BSD license so we can
> include it.
>
> The interface is still to be decided, but in general we have
> found that running against a byte[] is much faster than running
> against String.  We're probably going to want the diff library to
> take a byte[] and an IntList (as created by RawParseUtils.lineMap)
> and let it work against the byte array ranges directly, without any
> additional allocations, except where it needs to build up its hash
> of records.

That sounds like a good plan. For now I am not all that concerned
about performance myself (premature optimization and all that), but in
the long run - and especially with rename/copy detection that will
definitely a factor for usability. We could adopt the interface to
allow for a "fast" implementation, and have existing diff
implementations adapted to that. I'd be very interested to see Dscho's
diff work, and maybe we can get something going on that front. A
patience diff implementation would be rather neat too, and all my
googling hasn't turned up anything.

> I think eventually we'll have a BSD licensed LCS that will come with
> JGit, which would eliminate the need for such a shim.  I'd like
> to see that happen before blame gets added, but if blame is ready
> and the shim is reasonably well done, I'm inclined to bring blame
> in early.

While trying to look up the Myers diff algorithm I found a diff
implementation in Apache wicket (cf.
http://wicket.sourceforge.net/apidocs/wicket/util/diff/myers/package-summary.html
). This one is under an Apache license, is that any better? It's truly
kind of sad that you need a degree in law these days to get any work
done in this license jungle. I just happen to strongly oppose the
reinvention of circular transportation-enabling devices...

> - Don't use @author tags, we don't use them anywhere else.
>
> - Please include copyright headers on all new files.
>
> - I think the IDiff, IDifference should be in a ".diff" package so
> we can reuse them for other diff applications.  Especially if we
> wind up using a shim to link to different LCS implementations.
>
> - I think the API for BlameEngine should be more like:
>
>  public class BlameEngine {
>    private final RevWalk rw;
>
>    public BlameEngine(final Repository repo) {
>      this(new RevWalk(repo));
>    }
>
>    public BlameEngine(final RevWalk walk) {
>      rw = walk;
>    }
>
>    public RevWalk getRevWalk() {
>      return rw;
>    }
>
>    public List<BlameEntry> blame(RevCommit c, String path);
>  }
>
>  One reason for this style of API is we can have the engine cache
>  blame records.  This can make a GUI navigator much more efficient
>  as it jumps around between commits and asks for blames over the
>  same data.
>
> - Internally you should *always* use RevCommit, not Commit.
> The RevCommit class can be orders of magnitude faster than Commit.
>
> - Internally you should always use RevTree and TreeWalk to locate
> blob IDs.  Its orders of magnitude faster than Tree and TreeEntry.
>
> - Don't use new String(loader.getBytes()) (e.g. in Origin.getData)
> to get the data for a file.  We want to do raw diffs, so that the
> character encoding is considered as part of the blame.  E.g. if
> a file switches character encodings, the blame has to go to the
> commit that introduced the new encoding.  This is a huge reason
> to use byte[] and IntList over an array of String.
>
> - RawParseUtils.lineMap will be faster than a Pattern of "^(.*)$".
>
Thanks for the comments. This first version was basically just a
proof-of-concept to see if and how it could work. I didn't want to
pour too much effort into, before knowing if this project was viable
at all. This input is very valuable and I will try to incorporate the
suggestions into future revisions.

I'll keep you posted on new developments
 - Manuel
