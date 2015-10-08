From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] notes: Allow treeish expressions as notes ref
Date: Thu, 8 Oct 2015 11:50:18 +0900
Message-ID: <20151008025018.GA29722@glandium.org>
References: <CALKQrgdGJy6vtBRL413bbSHSi+=KTh4Q98hpbgg29j4J191=bA@mail.gmail.com>
 <1436517551-12172-1-git-send-email-mh@glandium.org>
 <xmqqzj30yq03.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 04:50:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk1Hr-0007XN-Rs
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 04:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbbJHCu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 22:50:27 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:41238 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbbJHCu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 22:50:27 -0400
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <glandium@glandium.org>)
	id 1Zk1He-0000Py-PI; Thu, 08 Oct 2015 11:50:18 +0900
Content-Disposition: inline
In-Reply-To: <xmqqzj30yq03.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279213>

On Mon, Jul 13, 2015 at 09:35:40AM -0700, Junio C Hamano wrote:
> What is interesting is to think what should happen when amlog@{1}
> is given.  The version with your patch gives the same output as we
> saw earlier, because amlog@{1} tree exists, but does not know about
> your patch (yet), so does not add "Notes" section, which makes sense
> by itself.
> 
> But we cannot tell if amlog@{1} was somehow malformed or it was OK
> and there was no notes on the commit.
> 
> We probably should do a few more things:
> 
>  - Make sure that we show "there is no such tree-ish, no way to look
>    up any note to any commit from there" and "I understood the tree
>    you gave me, but there is no note for that commit" differently.

After refreshing the patch against current "next", it appears that
there is such a distinction:

$ ./git-log --notes=fdsfgsfdg HEAD^! --pretty=short
warning: notes ref refs/notes/fdsfgsfdg is invalid
commit e5b68b2e879608d881c2e3600ce84962fcdefc88
Author: Mike Hommey <mh@glandium.org>

    notes: allow treeish expressions as notes ref

$ ./git-log --notes=foo HEAD^! --pretty=short
commit e5b68b2e879608d881c2e3600ce84962fcdefc88
Author: Mike Hommey <mh@glandium.org>

    notes: allow treeish expressions as notes ref

(I do have a refs/notes/foo ref)

>  - Decide if we want to "fail" the operation when the notes tree
>    given by the user is not even a tree-ish or just "warn" and keep
>    going.  And do so consistently.

Currently, it warns and doesn't fail.

Cheers,

Mike
