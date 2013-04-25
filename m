From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] "git add -A/--no-all" finishing touches
Date: Thu, 25 Apr 2013 16:56:24 -0700
Message-ID: <20130425235624.GO29963@google.com>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
 <1366663435-13598-1-git-send-email-gitster@pobox.com>
 <7vhaiu1a89.fsf@alter.siamese.dyndns.org>
 <7v4neu19mj.fsf@alter.siamese.dyndns.org>
 <20130425232410.GN29963@google.com>
 <7vvc7ayy84.fsf@alter.siamese.dyndns.org>
 <7vobd2yy3c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 01:56:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVW1i-0005Om-JQ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 01:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757Ab3DYX4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 19:56:30 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:40985 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691Ab3DYX43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 19:56:29 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so1631201daj.8
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=yjufw1+TElUN/gRdCsrEnbnXd3KgWe3W8r1l3qruTLs=;
        b=q0D9xcEGpmEApCZDJR3zx0OdGufZXl7ZbzoO3/RweuTxiywu6tM7/4gzYkCbWyfaZ1
         GnuqfmWsUm7RUO7niTgpO0oNHbKJaTF1Pghad6hbhQBlg4jX4+Sd0E8gvtBoC3t1aDJx
         Bw4x8gUwFsLqEbavR6yR+NDeykUzMN94314MBkLo13I8oOBvXYt2qzb4wkmEmyhuP+p4
         9fPvkE6OmGX01x9pfcRfEcBwxZ1XtcbYflTnQaVTftKggP8FZjuiZmLf0RSvdpnqasvp
         cXiJmSFwqMWZH7acZ7K8ufxVFdZJklvI6SmFKacpZBZOrfdrn9TSl6zb0rRCIegfy5S+
         mvIw==
X-Received: by 10.66.245.75 with SMTP id xm11mr27677894pac.40.1366934189153;
        Thu, 25 Apr 2013 16:56:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id c5sm9083267pbl.37.2013.04.25.16.56.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 16:56:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobd2yy3c.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222468>

Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> Do you mean files that were touched but have no content change, or
>>> something more subtle?
[...]
> Ahh, I haven't run anything under the debugger yet, but I think I
> know what is going on.
>
> Don't we limit our "update-index --refresh" equivalent to the
> original pathspec, even though your "-u/-A sans pathspec" warning
> detection relies on grabbing the changes from the entire tree?

I think it's more basic than that.  "git add" doesn't bother to
run an "update-index --refresh" equivalent before its main loop
unless you pass --refresh to it, since reading files to compare
them to the index would be duplicated work.  The files hit in
update_callback() are only potentially modified.

Maybe the warning should happen after add_file_to_index() has run,
letting git compare the old and new index entries for that path?

Jonathan
