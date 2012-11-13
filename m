From: Jeff King <peff@peff.net>
Subject: Re: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Tue, 13 Nov 2012 01:08:38 -0500
Message-ID: <20121113060838.GD10995@sigill.intra.peff.net>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com>
 <03ED9D50D1F64467863C051959CFC433@PhilipOakley>
 <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
 <509FD668.20609@lsrfire.ath.cx>
 <20121111165431.GA25884@sigill.intra.peff.net>
 <CA+TMuX2p4ck0qXijH+OOcBoveBC42U8PqnXdisau57RXwt1isg@mail.gmail.com>
 <20121112231453.GA21679@sigill.intra.peff.net>
 <alpine.DEB.1.00.1211130114180.13573@bonsai2>
 <20121113034605.GB8387@sigill.intra.peff.net>
 <7vwqxqf6li.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	msysgit@googlegroups.com, Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDO2DJFKTEFBB2WHQ6CQKGQE7VANMCQ@googlegroups.com Tue Nov 13 07:08:56 2012
Return-path: <msysgit+bncBDO2DJFKTEFBB2WHQ6CQKGQE7VANMCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ye0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBB2WHQ6CQKGQE7VANMCQ@googlegroups.com>)
	id 1TY9g6-000131-1s
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 07:08:54 +0100
Received: by mail-ye0-f186.google.com with SMTP id q5sf5563881yen.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 Nov 2012 22:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=yn5PiS29Ohl1E2XGInkJk2wrebefmgKejFQ9GywuNBU=;
        b=cuEjAY2HoxQditL9y0aZh5FeXvGZpsf88SDbEUwp77qOep3g32GthGGpOKVboxshJL
         UaZ+mvFm4kLeHnDzFXmXfe3/8vvYIJLhCjFEUs5lFetOJhkT7vaqOnLKMM8YRhrYnOYo
         maam2PU1YLK21hn70ngN0gSYwe2REqWc85hSY0UFC0jTA2A08M34uuzY8IQfVtJPirHM
         1ZnQHV/k/w6uQdsbYGnryPqhPKv37Q5eNszwGU/kzAktajFWhYd5eJZIH75VZQtDioz8
         EfYy6OroCmy/Jyi7nQdbhSZZWYbi35TLEwSNH/UfaBiHD4qiVuSI8YTuWVo04c7OAjcV
       
Received: by 10.50.212.69 with SMTP id ni5mr5719306igc.5.1352786923439;
        Mon, 12 Nov 2012 22:08:43 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.42.200.203 with SMTP id ex11ls10537645icb.6.gmail; Mon, 12 Nov
 2012 22:08:42 -0800 (PST)
Received: by 10.43.115.73 with SMTP id fd9mr13395634icc.2.1352786922663;
        Mon, 12 Nov 2012 22:08:42 -0800 (PST)
Received: by 10.43.115.73 with SMTP id fd9mr13395633icc.2.1352786922593;
        Mon, 12 Nov 2012 22:08:42 -0800 (PST)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id ge7si1028100igb.0.2012.11.12.22.08.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 22:08:42 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 20218 invoked by uid 107); 13 Nov 2012 06:09:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 01:09:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 01:08:38 -0500
In-Reply-To: <7vwqxqf6li.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209579>

On Mon, Nov 12, 2012 at 08:51:37PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah. We tolerate a certain amount of skew (24 hours for --name-rev, and
> > 5 broken commits in a row for --since). But the big ones are usually
> > software bugs (the big kernel ones were from broken "guilt", I think) or
> > broken imports (when I published a bunch of skew statistics last year,
> > the interesting ones were all imports; I don't know if they were
> > software bugs, or just garbage in, garbage out).
> 
> I was hoping that 2e6bdd3 (test-generation: compute generation
> numbers and clock skews, 2012-09-04) may be a good first step to
> come up with a practical and cheap solution on top of it.
>
> The traversal can be fooled by clock skews when it sees a commit
> that has a timestamp that is older than it should, causing it to
> give up, incorrectly thinking that there won't be newer commits that
> it is interested in behind the problematic commit.

I wrote a similar skew-finding tool last year, though some of the
numbers it came up with were different (I remember having many fewer
skewed commits in the kernel repo).

One problem is that it identifies commits which behave badly with
certain algorithms, but it does not identify commits which are wrong.
If I skew backwards, it will find my commit. But if I skew forwards, it
will label my children as wrong.

> The logic implemented by the change is to identify these problematic
> commits, and we could record these commits with the value of the
> timestamps they should have had (e.g. the timestamp of the newest
> ancestor for each of these commits) in a notes tree.  Then the
> traversal logic (commit-list-insert-by-date) could be updated use
> that "corrected" timestamp instead not to be fooled by the clock
> skew.
> 
> Such a notes tree can be built once and updated by only "appending",
> as a commit will never acquire more ancestors in its parents chain
> once it is made.
> 
> Is it too simplistic, or too costly?  In git.git we have three such
> commits whose timestamp need to be corrected, while in the Linux
> kernel there were 2.2k skewed commits when I counted them a few
> months ago.

This came up in the big generations discussion last summer, and I think
I even implemented a proof of concept. I couldn't find the actual code,
though but only that I got "pleasing performance results using a notes
tree to store a list of commits with bogus timestamps":

  http://article.gmane.org/gmane.comp.version-control.git/161101

It is a little wasteful in space if you have a lot of skewed commits
(the notes tree stores a 160-bit hash pointing to a blob object storing
a 32-bit integer).

My personal preference at this point would be:

  1. introduce an auxiliary metadata file that would live alongside the
     pack index and contain generation numbers

  2. generate the metadata file during pack indexing.

  3. If we have a generation metadata file, but a particular object is
     not in it, compute the generation; this should be quick because we
     will hit a file with a stored generation eventually

  4. If we do not have any generation metadata files, or if grafts or
     replace objects are in use, do not use cutoffs in algorithms. Be
     safe but slow.

On the other hand, just switching to doing a single traversal instead of
one merge-base computation per tag already got rid of the really awful
performance cases. Nobody has complained since that went in, so maybe
nobody cares about shaving a few seconds per operation down to a few
tens of milliseconds. The real win was shaving tens of seconds down to a
few seconds.

-Peff

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
