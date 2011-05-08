From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 03/11] revert: Introduce a struct to parse command-line options into
Date: Sun, 8 May 2011 17:39:08 +0530
Message-ID: <20110508120905.GC3114@ramkum.desktop.amazon.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com> <1302448317-32387-4-git-send-email-artagnon@gmail.com> <7vmxjwtqhz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 14:09:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2nj-0006nr-43
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab1EHMJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 08:09:17 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:49717 "EHLO
	smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab1EHMJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:09:16 -0400
X-IronPort-AV: E=Sophos;i="4.64,334,1301875200"; 
   d="scan'208";a="430358708"
Received: from smtp-in-1101.vdc.amazon.com ([10.146.54.37])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 May 2011 12:09:16 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-1101.vdc.amazon.com (8.13.8/8.13.8) with ESMTP id p48C9EB8020213;
	Sun, 8 May 2011 12:09:14 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id A0722754823; Sun,  8 May 2011 17:39:08 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vmxjwtqhz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173097>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> 
> Again, "In later steps, a new API that takes a single commit and replays
> it in forward (cherry-pick) or backward (revert) direction will be
> introduced, and will take this structure as a parameter to tell it what to
> do" is missing from the above description.
> 
> More importantly, the primary purpose of these variables is _not_ "to
> parse command line options into".  It is to actively affect what happens
> in the code, and "parse command line" is merely a way to assign the
> initial values to them.  So I'd rather see this patch described perhaps
> like this:
> 
>     cherry-pick/revert: introduce "struct replay_options"
> 
>     The current code uses a set of file-scope static variables to instruct
>     the cherry-pick/revert machinery how to replay the changes, and
>     initialises them by parsing the command line arguments. In later steps
>     in this series, we would like to introduce an API function that calls
>     into this machinery directly and have a way to tell it what to do.
> 
>     Introduce a structure to group these variables, so that the API can
>     take them as a single "replay_options" parameter.

Right.  Thanks for the nice commit message :)

> I strongly prefer to see this patch also update the callchain to pass a
> pointer to the options struct as parameter.  I can guess without reading
> the rest the series that at some later step you would do that, but I think
> it makes more sense to do the conversion at this step, as you will be
> touching lines that use the global variables in this patch anyway, like
> this:

Good idea.  I've passed the opts pointer around in the new series.

> > @@ -268,17 +278,17 @@ static struct tree *empty_tree(void)
> >  static int error_dirty_index()
> 
> It is probably a remnant of the earlier patches in this series, but this
> should start with:
> 
> 	static int error_dirty_index(void)
> 
> Of course, you will actually be passing the options structure, so it would
> become:
> 
> 	static int error_dirty_index(struct replay_options *opts)
>         {
>         	...
>                 if (opts->action == REVERT)
>                 	...
> 	}

The very first patch removes this function (and puts the functionality
elsewhere) in the new series, so this comment doesn't apply.

Thanks for the review!

-- Ram
