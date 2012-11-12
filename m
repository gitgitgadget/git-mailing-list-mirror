From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Mon, 12 Nov 2012 18:14:53 -0500
Message-ID: <20121112231453.GA21679@sigill.intra.peff.net>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com>
 <03ED9D50D1F64467863C051959CFC433@PhilipOakley>
 <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
 <509FD668.20609@lsrfire.ath.cx>
 <20121111165431.GA25884@sigill.intra.peff.net>
 <CA+TMuX2p4ck0qXijH+OOcBoveBC42U8PqnXdisau57RXwt1isg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	msysgit@googlegroups.com, Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBB4MFQ2CQKGQECLUVFJI@googlegroups.com Tue Nov 13 00:15:09 2012
Return-path: <msysgit+bncBDO2DJFKTEFBB4MFQ2CQKGQECLUVFJI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBB4MFQ2CQKGQECLUVFJI@googlegroups.com>)
	id 1TY3Dg-0001Wl-PU
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 00:15:09 +0100
Received: by mail-pb0-f58.google.com with SMTP id xa7sf1116188pbc.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 Nov 2012 15:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition
         :content-transfer-encoding;
        bh=qxIisidIJ5DMU00pgNIGQZG6PYPx48u06O3qmaLAxh8=;
        b=zDINOhiXTPjkNzubTqrubb9RbupDZpF9DJs9EyeW/GPkt9w3oznk9FZWvyacOsyZdb
         vGx/8qLoDqSasyzOva45JdghGNXPg8X3shtsXAf66I//DywMf5g/LZqkRGIUL+6OpCua
         p3cNxJFHob0M1TR76nCLsW8TZi6x6EypTbGsd3ymH18NcafAIb0j6U6OaGp7B52QMZme
         Q+JKxvNoldgzRWiY7yseLyj9embJitDi27HwiqSpjBVFskUW/yHdO7T01iKNVKhfLibH
         uQCxVmI/mZmwuqu5XaItEK4/M4qVALYmRx1Y/xk 
Received: by 10.50.12.169 with SMTP id z9mr5504004igb.1.1352762098192;
        Mon, 12 Nov 2012 15:14:58 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.42.175.65 with SMTP id az1ls562090icb.2.gmail; Mon, 12 Nov
 2012 15:14:57 -0800 (PST)
Received: by 10.50.100.193 with SMTP id fa1mr7204715igb.5.1352762097311;
        Mon, 12 Nov 2012 15:14:57 -0800 (PST)
Received: by 10.50.100.193 with SMTP id fa1mr7204714igb.5.1352762097300;
        Mon, 12 Nov 2012 15:14:57 -0800 (PST)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id ge7si943762igb.0.2012.11.12.15.14.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 15:14:57 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 15696 invoked by uid 107); 12 Nov 2012 23:15:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 18:15:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 18:14:53 -0500
In-Reply-To: <CA+TMuX2p4ck0qXijH+OOcBoveBC42U8PqnXdisau57RXwt1isg@mail.gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 75.15.5.89 as permitted sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209543>

On Mon, Nov 12, 2012 at 11:27:14PM +0100, Jean-Jacques Lafay wrote:

> 2012/11/11 Jeff King <peff@peff.net>:
> > On Sun, Nov 11, 2012 at 05:46:32PM +0100, Ren=E9 Scharfe wrote:
> >
> > Ultimately, I have some ideas for doing this in a breadth-first way,
> > which would make it more naturally iterative. It would involve having N
> > bits of storage per commit to check N tags, but it would mean that we
> > could get accurate answers in the face of clock skew (like the
> > merge-base calculation, it would merely get slower in the face of skew)=
.
>=20
> I guess the optimal algorithm may also depend on the commit graph
> general shape, but intuitively, I'd say that the critical factor is
> the number and distribution of tags. As soon as you have a significant
> number of tags (let's say 1% of the commits are tagged, evenly
> distributed), you'll quickly end up with every commit marked as
> containing or not the target commit, so that each additional tag check
> is cheap.
>=20
> This suggests a complexity of O(number of commits) more often then
> not, however you choose to traverse the graph.

We can do much better than O(number of commits), though, if we stop
traversing down a path when its timestamp shows that it is too old to
contain the commits we are searching for. The problem is that the
timestamps cannot always be trusted, because they are generated on
machines with wrong clocks, or by buggy software. This could be solved
by calculating and caching a "generation" number, but last time it was
discussed there was a lot of arguing and nothing got done.

Another approach, used by the merge-base calculation, is to treat
parents in a breadth-first way, but sort them by timestamp, and walk
backwards to find the merge-base (and if you get to a merge-base, you
can stop). In that case, bad timestamps may cause you to look at extra
commits (because you process a commit prematurely and end up going
deeper than the merge base), but it can never give you a wrong answer.

Thinking on it more, though, the merge-base style of computation would
mean you always have to walk backwards to the oldest tag. Which is in
the same order of magnitude as the number of commits, assuming you have
tags near the start of history. So I think we will always want to keep a
cutoff, anyway, and there is not much point in switching off of a
depth-first approach (but of course it does make sense to use iteration
instead of recursion to do so).

> At least on my almost-real-life repo*, with ~140,000 commits and
> ~2,000 tags, tag --contains takes a few seconds, of course more than
> the worst-case test on a 40,000 commit / 1 tag repo, but still in the
> same order of magnitude.

Try "git rev-list --count --all" to get a sense of how long O(# of
commits) takes. Before the depth-first implementation, "tag --contains"
was O(commits * tags) in the worst case. With depth first, it's
O(commits), and then with the timestamp cutoff, it's really O(commits
since needle), where "needle" is the oldest thing you're looking for.
Here are those numbers on linux-2.6 (with linux-stable tags):

  [to get a sense of the repo size]
  $ git for-each-ref refs/tags | wc -l
  909
  $ git rev-list --count --all
  363413

  [this is O(commits)]
  $ time git rev-list --count --all
  real    0m4.034s
  user    0m3.960s
  sys     0m0.056s

  [before depth-first, ffc4b80^; you can see that it is much worse than
   O(commits), though not as bad as the worst case (because finding the
   merge bases for recent tags is not O(commits)]
  $ time git tag --contains HEAD~200
  real    0m42.838s
  user    0m42.527s
  sys     0m0.156s

  [after depth-first, ffc4b80; you can see that this is O(commits),
   because we will go depth-first down to the roots, but do only a
   single traversal]
  $ time git tag --contains HEAD~200
  real    0m3.939s
  user    0m3.784s
  sys     0m0.140s

  [with my generation patches; much faster]
  $ time git tag --contains HEAD~200
  real    0m0.037s
  user    0m0.020s
  sys     0m0.012s

I was thinking we had merged the timestamp cutoff (which has the same
performance characteristics as generations, just with the skew issue) to
master, but it looks like we didn't.

-Peff

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
