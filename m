From: Jeff King <peff@peff.net>
Subject: Re: [PATCH jk/prune-mtime] prune: close directory earlier
 during loose-object directory traversal
Date: Wed, 12 Aug 2015 13:56:30 -0400
Message-ID: <20150812175629.GA24964@sigill.intra.peff.net>
References: <55CA5EB0.1000308@kdbg.org>
 <b9cf9e2168c3b2476bb5bb134a1528be@www.dscho.org>
 <55CB85A5.5040802@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBDO2DJFKTEFBBU4RV2XAKGQEPWJWTKA@googlegroups.com Wed Aug 12 19:56:37 2015
Return-path: <msysgit+bncBDO2DJFKTEFBBU4RV2XAKGQEPWJWTKA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qg0-f61.google.com ([209.85.192.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBU4RV2XAKGQEPWJWTKA@googlegroups.com>)
	id 1ZPaGT-0002qD-08
	for gcvm-msysgit@m.gmane.org; Wed, 12 Aug 2015 19:56:37 +0200
Received: by qgey105 with SMTP id y105sf3923779qge.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 12 Aug 2015 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=pL1wIqKcNvRc11RIF4lWdajQ8wgHo+bxtI5WaKK9x+o=;
        b=o14Jw21Py/ZTbgI+Lyx9S9sB4a8ho3LKC6VR0PHG+VlcoRq4zlm6pqbOz9tEHhIeth
         bTeIWhWAvwwOTqUl05y7/cXuMZfveG9dbTjNLVWCtScClfnVrFmaNo/e3Y2fvxoZFj5z
         OdBIZ+AVVcUAuJwWQEtuETpmxcyYof6GQYncVoK2TG+QxtKTZmQjjjL1LS5dDWxECcF6
         7K0NrFSLu4Oas6LHWJgIinAkAurWA3ZXn8HoiPMHpwq0Q8jx7bZasEM4hWbQPlzSWagl
         MEvGczGpH/+NVpx0Du7LqFLZjyAB4CdmKwZ9OC8CEa+ytuT2oPMNmpa9kniICT2fxpR7
         Ib6A==
X-Received: by 10.50.117.2 with SMTP id ka2mr244170igb.9.1439402196364;
        Wed, 12 Aug 2015 10:56:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.79.196 with SMTP id l4ls2120636igx.22.canary; Wed, 12 Aug
 2015 10:56:35 -0700 (PDT)
X-Received: by 10.107.165.197 with SMTP id o188mr32127378ioe.34.1439402195656;
        Wed, 12 Aug 2015 10:56:35 -0700 (PDT)
Received: from cloud.peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id rs3si1565377igb.2.2015.08.12.10.56.35
        for <msysgit@googlegroups.com>;
        Wed, 12 Aug 2015 10:56:35 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 19693 invoked by uid 102); 12 Aug 2015 17:56:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Aug 2015 12:56:35 -0500
Received: (qmail 27509 invoked by uid 107); 12 Aug 2015 17:56:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Aug 2015 13:56:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Aug 2015 13:56:30 -0400
Content-Disposition: inline
In-Reply-To: <55CB85A5.5040802@kdbg.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275789>

On Wed, Aug 12, 2015 at 07:43:01PM +0200, Johannes Sixt wrote:

> 27e1e22d (prune: factor out loose-object directory traversal, 2014-10-16)
> introduced a new function for_each_loose_file_in_objdir() with a helper
> for_each_file_in_obj_subdir(). The latter calls callbacks for each file
> found during a directory traversal and finally also a callback for the
> directory itself.
> 
> git-prune uses the function to clean up the object directory. In
> particular, in the directory callback it calls rmdir(). On Windows XP,
> this rmdir call fails, because the directory is still open while the
> callback is called. Close the directory before calling the callback.

Makes sense, and the patch looks good to me. Sorry for breaking things
on Windows.

Acked-by: Jeff King <peff@peff.net>

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
