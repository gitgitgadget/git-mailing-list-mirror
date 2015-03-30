From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] show-branch: show all local heads when only giving one
 rev along --topics
Date: Tue, 31 Mar 2015 07:37:52 +0900
Message-ID: <20150330223752.GA19987@glandium.org>
References: <1427753543-19680-1-git-send-email-mh@glandium.org>
 <xmqqd23qw2cl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 00:38:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YciJn-000394-K9
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 00:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbbC3Wh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 18:37:59 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:56264 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116AbbC3Wh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 18:37:59 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YciJc-0005G8-3h; Tue, 31 Mar 2015 07:37:52 +0900
Content-Disposition: inline
In-Reply-To: <xmqqd23qw2cl.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266484>

On Mon, Mar 30, 2015 at 03:24:26PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > (Maybe --topics should always require one rev on the command
> > line?)
> 
> That sounds line a good thing to do.
> 
> > -	else if (all_heads + all_remotes)
> > -		snarf_refs(all_heads, all_remotes);
> >  	else {
> >  		while (0 < ac) {
> >  			append_one_rev(*av);
> >  			ac--; av++;
> >  		}
> > +		if (all_heads + all_remotes)
> > +			snarf_refs(all_heads, all_remotes);
> 
> Hmmmmmm.  Is this safe and will not cause problems by possibly
> duplicated refnames that came from the command line and the ones
> that came from for-each-ref iteration?  I am not saying the change
> is problematic; it is just I haven't looked at this code for a long
> time that the existing machinery is already designed to tolerate
> duplicated input.

It is:
https://github.com/git/git/blob/master/builtin/show-branch.c#L382

In case you wonder about allow_dups, the only case in which it's 1 is:
https://github.com/git/git/blob/master/builtin/show-branch.c#L784
which is the reflog case, which is the case before that `else` in the
patch.

That is, both append_one_rev and snarf_refs end up calling append_ref
with allow_dups=0.

Cheers,

Mike
