From: Jeff King <peff@peff.net>
Subject: Re: [PATCH jk/prune-mtime] prune: close directory earlier
 during loose-object directory traversal
Date: Fri, 11 Dec 2015 14:41:03 -0500
Message-ID: <20151211194103.GA5834@sigill.intra.peff.net>
References: <55CA5EB0.1000308@kdbg.org>
 <b9cf9e2168c3b2476bb5bb134a1528be@www.dscho.org>
 <55CB85A5.5040802@kdbg.org>
 <20150812175629.GA24964@sigill.intra.peff.net>
 <xmqqvb84epyl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDO2DJFKTEFBBUWNVSZQKGQEZNGBQMA@googlegroups.com Fri Dec 11 20:41:08 2015
Return-path: <msysgit+bncBDO2DJFKTEFBBUWNVSZQKGQEZNGBQMA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pf0-f184.google.com ([209.85.192.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBUWNVSZQKGQEZNGBQMA@googlegroups.com>)
	id 1a7TYx-0000aB-Jp
	for gcvm-msysgit@m.gmane.org; Fri, 11 Dec 2015 20:41:07 +0100
Received: by pfee188 with SMTP id e188sf160830pfe.1
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Dec 2015 11:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=Dg3LNt0dXuLjkzNl7tSJ6xIa8o/t/X3OjYWgSwUh2W8=;
        b=ZIp5qRe/zh0DMue49kVr6ud/LRRWS6WrXV5Pb4+NIFYr4YhH3aTYizvyi0yeU8kPN1
         MEGPoTO+howdh1MpyOjLAh0bv79E7CCQYrp1kMVQjTF7pnD0vS/LJ8PTP6e0ycb/5OIA
         Q7CtHMH0aWTmWCfpn/B0pfg+do3zPvmsqzZC2Pg+bvPnPhr8sXYb8KAf5r+TalbmJaca
         3QA1pM7xFlhBzcOz7P8xRTW61eIbxoeTebJF5+IGSOr/mu1oYVn8Sp5tlTjBSb3STI+b
         Ljs8p4Hw0j9A1g8u/c9mseVC7ZF+MzwVK/xVUV7c/jJ+AP2coZL+n1guijrC1PQp8Qtx
         2zmA==
X-Received: by 10.182.42.195 with SMTP id q3mr292046obl.3.1449862866798;
        Fri, 11 Dec 2015 11:41:06 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.128.66 with SMTP id nm2ls1007528obb.27.gmail; Fri, 11 Dec
 2015 11:41:06 -0800 (PST)
X-Received: by 10.182.233.229 with SMTP id tz5mr15824681obc.26.1449862866306;
        Fri, 11 Dec 2015 11:41:06 -0800 (PST)
Received: from cloud.peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id q18si343833ign.1.2015.12.11.11.41.06
        for <msysgit@googlegroups.com>;
        Fri, 11 Dec 2015 11:41:06 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 23105 invoked by uid 102); 11 Dec 2015 19:41:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Dec 2015 13:41:05 -0600
Received: (qmail 1386 invoked by uid 107); 11 Dec 2015 19:41:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Dec 2015 14:41:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Dec 2015 14:41:03 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvb84epyl.fsf@gitster.mtv.corp.google.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mailfrom=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282272>

On Fri, Dec 11, 2015 at 11:37:54AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Aug 12, 2015 at 07:43:01PM +0200, Johannes Sixt wrote:
> >
> >> 27e1e22d (prune: factor out loose-object directory traversal, 2014-10-16)
> >> introduced a new function for_each_loose_file_in_objdir() with a helper
> >> for_each_file_in_obj_subdir(). The latter calls callbacks for each file
> >> found during a directory traversal and finally also a callback for the
> >> directory itself.
> >> 
> >> git-prune uses the function to clean up the object directory. In
> >> particular, in the directory callback it calls rmdir(). On Windows XP,
> >> this rmdir call fails, because the directory is still open while the
> >> callback is called. Close the directory before calling the callback.
> >
> > Makes sense, and the patch looks good to me. Sorry for breaking things
> > on Windows.
> >
> > Acked-by: Jeff King <peff@peff.net>
> 
> Sorry for reviving this old thread, but I noticed that we do not
> have this patch in our tree yet.  I'll queue to 'pu' for now lest I
> forget.  If I missed a good argument or concensus against the change
> please let me know, otherwise I'll fast track the change to 2.7 final

Ah, thanks for doing that. I noticed it when picking through "git branch
--no-merged pu" of your workspace a few weeks ago, but forgot to follow
up. I certainly have no objections.

-Peff

-- 
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

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
