From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: accept any ref for merge
Date: Fri, 19 Sep 2014 11:22:58 -0700
Message-ID: <xmqqoaubmpvh.fsf@gitster.dls.corp.google.com>
References: <1411112385-33479-1-git-send-email-schacon@gmail.com>
	<20140919093910.GA15891@peff.net>
	<CALKQrgc4nZdaXM-Ooh1pP4x4nZRLexJzLyaBmrgn+qVaQGCg+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 20:23:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV2q0-0002RP-3d
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 20:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbaISSXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 14:23:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58876 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932195AbaISSXB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 14:23:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44B8F3C138;
	Fri, 19 Sep 2014 14:23:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=69xb24cefR0G9nngVBgnXwAi/sc=; b=C/27I7
	jk3xbTc2RYmcwNsu5d6ENhqopIftRg1Pq9L0GrJy6l8hHObXE8snINM+8n9CyD6U
	yt5b4/SY5pMv4nZYPRAgrq4Q2cErrJaJS0MLhCMij8C4wBUJhMJ+R1Ojco2LMclI
	BHM5yweXE6k0Hb/m8CGLnvLFyPjzv5doEZ774=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WWiIOlh+fvLKTuIS5V9KTOjfE19fL7XU
	e5ACTB7SaEUXVnoAUlAKQJiXqvrsqV7pZPgyEaiGQdKLX0WelOOG4aioHvSez+tZ
	wYJOA5LxiTnyFvYZaBF7NpmOIExbi41TwGDXVSXcRNwLl+x+AF2GPVT9jtN6qjI3
	lYfPltKJoNU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D9E13C137;
	Fri, 19 Sep 2014 14:23:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0EB653C132;
	Fri, 19 Sep 2014 14:22:59 -0400 (EDT)
In-Reply-To: <CALKQrgc4nZdaXM-Ooh1pP4x4nZRLexJzLyaBmrgn+qVaQGCg+g@mail.gmail.com>
	(Johan Herland's message of "Fri, 19 Sep 2014 16:01:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FC6C3D32-4029-11E4-8B1C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257304>

Johan Herland <johan@herland.net> writes:

> On Fri, Sep 19, 2014 at 11:39 AM, Jeff King <peff@peff.net> wrote:
>> On Fri, Sep 19, 2014 at 09:39:45AM +0200, Scott Chacon wrote:
>>> Currently if you try to merge notes, the notes code ensures that the
>>> reference is under the 'refs/notes' namespace. In order to do any sort
>>> of collaborative workflow, this doesn't work well as you can't easily
>>> have local notes refs seperate from remote notes refs.
>>>
>>> This patch changes the expand_notes_ref function to check for simply a
>>> leading refs/ instead of refs/notes to check if we're being passed an
>>> expanded notes reference. This would allow us to set up
>>> refs/remotes-notes or otherwise keep mergeable notes references outside
>>> of what would be contained in the notes push refspec.
>>
>> I think this change affects not just "git notes merge", but all of the
>> notes lookups (including just "git notes show")....
> ...
> Additionally, I suggest adding another test demonstrating your use
> case as well. Something like setting up a small scenario for notes
> collaboration, and walking through the various steps:
>
>  - Creating a couple of repos where notes are added/edited
>  - Setting up config to allow pushing and/or fetching notes
>  - Performing the push/fetch
>  - Merging with the corresponding local notes ref

Is it our future direction to set up refs/remote-notes/<remote>/
namespace?  If so, let's not do it piecemeail in an unorganized
guerrilla fashion by starting with a stealth enabler with an
associated test.  We risk not following through and leave the
resulting user experience more puzzling if we go that way.

By "stealth enabler" I mean the removal of refs/notes/ restriction
that was originally done as a safety measure to avoid mistakes of
storing notes outside.  The refs/remote-notes/ future direction
declares that it is no longer a mistake to store notes outside
refs/notes/, but that does not necessarily have to mean that
anywhere under refs/ is fine.  It may make more sense to be explicit
with the code touched here to allow traditional refs/notes/ and the
new hierarchy only.  That way, we will still keep the "avoid
mistakes" safety and enable the new layout at the same time.

The most important first step for that to happen is to make sure we
are on the same page on that future direction.  I personally think
refs/remote-notes/<remote> that runs parallel to the remote tracking
branch hierarchy refs/remotes/<remote> is a reasonable way to do
this, but my words are no way final.

Assuming that this is we all agree to go in that direction, let's
make a list of things to be done to codify it, and do them.  For a
starter, I think these are needed, perhaps?

 - This patch (or an enhancement to keep some safety)

 - Documentation updates to "git notes"

 - Documentation updates to Documentation/gitrepository-layout.txt

 - Update to "git clone" and "git remote add" to add a fetch refspec
   refs/notes:refs/remote-refs/<remote>/*

 - New tests you suggest
