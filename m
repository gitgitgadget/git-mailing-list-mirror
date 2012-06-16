From: perryh@pluto.rain.com
Subject: Re: How do I specify a revision for "git blame" by date?
Date: Fri, 15 Jun 2012 21:13:03 -0700
Message-ID: <4fdc6a3f.nzZc1m4KnwQe3s+K%perryh@pluto.rain.com>
References: <4fda029d.g99uVull9jgguc/Y%perryh@pluto.rain.com>
 <877gva1a4b.fsf@thomas.inf.ethz.ch>
 <4fdb326f.WB/xRjZx4pXtMhhZ%perryh@pluto.rain.com>
 <20120615150107.GA4572@sigill.intra.peff.net>
 <7vsjdwbmh6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Sat Jun 16 22:50:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfzwb-0000Hi-Ct
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jun 2012 22:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab2FPUuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jun 2012 16:50:00 -0400
Received: from oldagora.rdrop.com ([199.26.172.14]:1093 "EHLO
	oldagora.rdrop.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632Ab2FPUt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2012 16:49:59 -0400
Received: from oldagora.rdrop.com (localhost [127.0.0.1])
	by oldagora.rdrop.com (8.13.1/8.12.7) with ESMTP id q5GKnHgI000761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 Jun 2012 13:49:28 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by oldagora.rdrop.com (8.13.1/8.12.9/Submit) with UUCP id q5GKnHg3000760;
	Sat, 16 Jun 2012 13:49:17 -0700 (PDT)
Received: from fbsd81 ([192.168.200.81]) by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA13259; Fri, 15 Jun 12 21:14:25 PDT
In-Reply-To: <7vsjdwbmh6.fsf@alter.siamese.dyndns.org>
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200113>

Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
> > But that still doesn't address the issue that (a) is not
> > well-defined.  Imagine I have this history:
> >
> >   A--B--C---G--H
> >    \       /
> >     D--E--F
> >
> > that is, two lines of development splitting at A and merging
> > at H. And imagine the commit timestamps are (let's just refer
> > to them as integers for the sake of simplicity, but they are
> > representing days or seconds or whatever):
> >
> >   A(1)--B(2)--C(3)--G(7)--H(8)
> >    \               /
> >     D(2)--E(4)--F(6)
> >
> > What does it mean to ask for the commit at time=5?
> > ...
> > Git-blame expects you to give it a well-defined point ...
> > You could do so by asking rev-list to walk the graph according
> > to your requirements and feeding the result to blame, like:
> >
> >   # most recent on any line of development that is merged to HEAD
> >   git blame `git rev-list -1 --until=5 HEAD`
> >
> >   # most recent on any line of development in the whole repo
> >   git blame `git rev-list -1 --until=5 --all`
> >
> >   # most recent version on the first-parent; if you follow a
> >   # topic-branch workflow and always merge up into "master",
> >   # then this will blame what was on master at time=5
> >   git blame `git rev-list -1 --until=5 --first-parent HEAD`
>
> Very well explained.  Thanks.

+1

> The short answer to the question on "Subject:" line is "You don't".

The slightly longer, but perhaps more practically useful, answer is
"You use 'git rev-list' to look up the correct commit, and shell
'command substitution' to pass the result to 'git blame', as Jeff
has illustrated."  That solution sure beats displaying the entire
revision list, and then manually selecting the desired commit from
it.
