From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place
 editing
Date: Fri, 15 Jan 2016 18:45:23 +0100
Message-ID: <20160115174522.GD21205@distanz.ch>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
 <1452790676-11937-3-git-send-email-tklauser@distanz.ch>
 <xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
 <20160115103402.GC21205@distanz.ch>
 <xmqqa8o6kb6m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 18:45:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK8RL-0003JG-MF
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 18:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbcAORpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 12:45:30 -0500
Received: from sym2.noone.org ([178.63.92.236]:35849 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbcAORp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 12:45:26 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3phqfX4jYPzQWZ8; Fri, 15 Jan 2016 18:45:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqa8o6kb6m.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284191>

On 2016-01-15 at 18:24:49 +0100, Junio C Hamano <gitster@pobox.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> >> > +test_expect_success POSIXPERM,SANITY "in-place editing doesn't clobber original file on error" '
> >> > +	cat basic_message >message &&
> >> > +	chmod -r message &&
> >> > +	test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place message &&
> >> > +	chmod +r message &&
> >> > +	test_cmp message basic_message
> >> > +'
> >> 
> >> If for some reason interpret-trailers fails to fail, this would
> >> leave an unreadable 'message' in the trash directory.  Maybe no
> >> other tests that come after this one want to be able to read the
> >> contents of the file right now, but this is an accident waiting to
> >> happen:
> >> 
> >> 	cat basic_message >message &&
> >> +       test_when_finished "chmod +r message" &&
> >>         chmod -r message &&
> >>         test_must_fail ... &&
> >> 	chmod +r message &&
> >>         test_cmp ...
> >
> > Indeed, I forgot about this. I saw you already folded in the missing
> > 'chmod +r message' in your tree. Thanks for that!
> 
> I did no such thing, though.

Sorry, my misunderstanding. I thought about "chmod +r" but of course the
essential part is the

  +       test_when_finished "chmod +r message" &&

which isn't in your tree.
