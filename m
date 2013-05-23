From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] git-send-email: fix handling of special characters
Date: Fri, 24 May 2013 00:38:08 +0300
Message-ID: <20130523213808.GA1327@redhat.com>
References: <20130523135418.GA20741@redhat.com>
 <7vk3mpeaok.fsf@alter.siamese.dyndns.org>
 <20130523211954.GD31421@redhat.com>
 <7vtxltcrog.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:37:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfdCs-0002j2-3a
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759303Ab3EWVhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:37:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34128 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759190Ab3EWVht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:37:49 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4NLbkAw028126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 23 May 2013 17:37:46 -0400
Received: from redhat.com (vpn-202-161.tlv.redhat.com [10.35.202.161])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r4NLbh38016266;
	Thu, 23 May 2013 17:37:45 -0400
Content-Disposition: inline
In-Reply-To: <7vtxltcrog.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225303>

On Thu, May 23, 2013 at 02:27:59PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> >> Is $author already sanitized at this point in the code?  I see it
> >> was unwrapped with unquote_rfc2047 after it was read from the From:
> >> line; will it always be the same as sanitize_address($author) would
> >> return, and if not, would you rather compare between sanitized
> >> versions of sender and author, no?
> >
> > Yes. I'll have to look at the code more closely.
> > In my testing author here is "Michael S. Tsirkin" <mst@redhat.com>
> > so it matches the sanitized sender.
> > Of course that's because my name does not have non-ascii,
> > just a dot.
> 
> So the conclusion is that the logic to see if the names are the same
> needs a bit more work than what was posted, I think?

I think so. And a bit more testing with non-ASCII.
Plan to look into this around Sunday if no one beats me
to it.

> >> Also, isn't the $sender the same during the whole outer loop that
> >> iterates over @files?  Do we need to apply sanitize_address() on it
> >> over and over for each and every logical line in the @header?
> >> 
> >> This comment also applies to the other patch but they probably
> >> should become a single patch anyway, I guess?
> >
> > OK so now you are ok with this last bit, right?
> 
> Sorry, but I am not sure what you are asking.
> 
> Do I think the assignment to $sanitized_sender can and should be
> done just once, not once per file, if the code inspection tells us
> that $sender is a constant inside the foreach (@files) loop?
> 
> Do I think these two are solving pretty much the same thing and is
> better to be done in a single patch?  
> 
> I didn't really think them through when I responded, but now after
> you made me think, I would say the answers to both of them are yes.
