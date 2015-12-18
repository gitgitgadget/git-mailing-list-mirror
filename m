From: Howard Chu <hyc@symas.com>
Subject: Re: [PATCH 02/16] refs: add methods for misc ref operations
Date: Fri, 18 Dec 2015 04:06:20 +0000 (UTC)
Message-ID: <loom.20151218T050438-482@post.gmane.org>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com> <1449102921-7707-3-git-send-email-dturner@twopensource.com> <xmqqmvtgd06p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 05:10:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9mN1-0000rC-Oh
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 05:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbbLREKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 23:10:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:48140 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbbLREKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 23:10:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1a9mMl-0000PS-BK
	for git@vger.kernel.org; Fri, 18 Dec 2015 05:10:03 +0100
Received: from cust236-172.nwewn.com ([78.155.236.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 05:10:03 +0100
Received: from hyc by cust236-172.nwewn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 05:10:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 78.155.236.172 (Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0 SeaMonkey/2.42a1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282699>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> David Turner <dturner <at> twopensource.com> writes:
> 
> >  struct ref_be {
> >  	struct ref_be *next;
> >  	const char *name;
> >  	ref_transaction_commit_fn *transaction_commit;
> > +
> > +	pack_refs_fn *pack_refs;
> > +	peel_ref_fn *peel_ref;
> > +	create_symref_fn *create_symref;
> > +
> > +	resolve_ref_unsafe_fn *resolve_ref_unsafe;
> > +	verify_refname_available_fn *verify_refname_available;
> > +	resolve_gitlink_ref_fn *resolve_gitlink_ref;
> >  };
> 
> This may have been pointed out in the previous reviews by somebody
> else, but I think it is more customary to declare a struct member
> that is a pointer to a customization function without leading '*',
> i.e.
> 
> 	typedef TYPE (*customize_fn)(ARGS);
> 
>         struct vtable {
> 		...
>         	cutomize_fn fn;
> 		...
> 	};
> 
> in our codebase (cf. string_list::cmp, prio_queue::compare).

(LMDB author here, just passing by)

IMO you're making a mistake. You should always typedef the thing itself, not
a pointer to the thing. If you only typedef the pointer, you can only use
the typedef to declare pointers and never the thing itself. If you typedef
the actual thing, you can use the typedef to declare both the thing and
pointer to thing.

It's particularly useful to have function typedefs because later on you can
use the actual typedef to declare instances of that function type in header
files, and guarantee that your function definitions match what they're
intended to match. Otherwise, assigning a bare (*func) to something that
mismatches only generates a warning, instead of an error.

-- 
  -- Howard Chu
  CTO, Symas Corp.           http://www.symas.com
  Director, Highland Sun     http://highlandsun.com/hyc/
  Chief Architect, OpenLDAP  http://www.openldap.org/project/ 
