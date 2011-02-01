From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [1.8.0] Tag namespaces
Date: Tue, 01 Feb 2011 09:54:24 -0500
Message-ID: <4D481EA0.9090802@xiplink.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <AANLkTikeqsg+qJ0z4iQ6ZmKL=_HB8YX_z20L=dFFApmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 15:55:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkHdJ-0000tr-G1
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 15:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327Ab1BAOy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 09:54:28 -0500
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:48626 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757324Ab1BAOy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 09:54:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp53.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 7F6B958669;
	Tue,  1 Feb 2011 09:54:25 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp53.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 07F07586AB;
	Tue,  1 Feb 2011 09:54:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <AANLkTikeqsg+qJ0z4iQ6ZmKL=_HB8YX_z20L=dFFApmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165813>

On 11-01-31 10:20 PM, Nguyen Thai Ngoc Duy wrote:
> On Tue, Feb 1, 2011 at 12:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Now the 1.7.4 release is out, I'd like people to help thinking about the
>> next cycle(s).
>>
>> As a discussion-starter, here are my random wishes.  Even though this does
>> not attempt to be exhaustive, keeping the number of goals manageably small
>> may help us focus.
> 
> Another random wish, which does not come with a proposal. How about
> tag namespace (ie. tags from a remote stay in remote namespace)?

I had just started writing up such a proposal yesterday.  What I have so far
is pretty preliminary:


Proposal:

Change tag refspecs to distinguish between remote and local tags.  An
unadorned tag "foo" could point to different commits in different
repositories.  A remote could move/edit it's "foo" tag and have that update
smoothly propagated to clones.

I believe this was last brought up in November while discussing the refs base
for notes:

http://thread.gmane.org/gmane.comp.version-control.git/160503/focus=160655


Risks:

I think the main risk lies in breaking plain <tagname> refs, as they would
become "origin/<tagname>" refs instead.  But I think that can be mitagated
against (see below).

The other risk folks might raise, though I disagree, is breaking the
immutability assumption for tags.  I'm willing to debate this, though (see
the above-linked thread).

Another "risk" is that this change might be too much of an earthquake.  It
may be something more suitable to a major release, like 2.0.


Migration plan:

Add a "tags.relative" (name TBD) configuration variable which defaults to
false.  When tags.relative is true, "git fetch" puts any received tags under
(location TBD) refs/remotes/<remote>/tags/.  In 1.8.0 we flip tags.realtive's
default value.

To help mitigate the risk of breaking plain "<tagname>" refs, "git rev-parse"
can look for plain names (i.e. ones without a /) in the remote tags location.


		M.
