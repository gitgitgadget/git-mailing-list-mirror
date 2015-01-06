From: Mike Hommey <mh@glandium.org>
Subject: Re: Question about the revision walking API
Date: Tue, 6 Jan 2015 19:51:22 +0900
Message-ID: <20150106105122.GA32170@glandium.org>
References: <20150106020230.GA28274@glandium.org>
 <xmqq4ms4qk91.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 11:56:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8RlR-0002tK-Hy
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 11:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbbAFKxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 05:53:24 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:51586 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754435AbbAFKva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 05:51:30 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Y8RjO-0008Nl-Cn; Tue, 06 Jan 2015 19:51:22 +0900
Content-Disposition: inline
In-Reply-To: <xmqq4ms4qk91.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262056>

On Tue, Jan 06, 2015 at 02:24:58AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > I would like to know if the revision walking API works as one would
> > expect with a calling sequence like the following:
> >
> > - init_revisions
> > - add_pending_object/setup_revisions
> > - prepare_revision_walk
> > - get_revision (repeated)
> > - reset_revision_walk (I guess)
> 
> Around here you would need to clear flag bits left on the objects by
> your previous traversal.  After "git log A..B", commits in that
> range would have various combinations of SEEN, ADDED and SHOWN

afaics, that's what reset_revision_walk does.

> flags, and also some commits reachable from A would be marked as
> UNINTERESTING.

Do you mean the ancestry of A? That wouldn't matter in my case.

> You do not want these to interfere with your next
> traversal which may not have anything to do with what you computed
> with the previous round.

Okay, so aiui, doing a revision walk doesn't impact anything other
than the object flags, so I can safely use add_pending_object to add
to what I already had in the rev_info?

Cheers,

Mike
