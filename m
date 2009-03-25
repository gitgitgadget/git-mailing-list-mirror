From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Draft of API for git-vcs-*, transport.c code to use
 it.
Date: Wed, 25 Mar 2009 12:40:52 -0700
Message-ID: <7vskl1xuez.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903242303410.19665@iabervon.org>
 <7vskl284bt.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0903251050430.19665@iabervon.org>
 <7vbprp5vko.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0903251446180.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 20:42:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmYzi-0002ny-0I
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 20:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbZCYTk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 15:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbZCYTk7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 15:40:59 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbZCYTk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 15:40:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E46369A44;
	Wed, 25 Mar 2009 15:40:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 428059A43; Wed,
 25 Mar 2009 15:40:54 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0903251446180.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 25 Mar 2009 15:28:23 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC381F9A-1974-11DE-9AF0-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114653>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 25 Mar 2009, Junio C Hamano wrote:
>
>> Suppose a project used to use subversion, but it migrated to git (not an
>> unheard-of scenario these days, I hope).  The git repository now is the
>> authoritative one, all the development happens on this side.
>> 
>> But in order to help:
>> 
>>  - people who have established their workflow to follow the project
>>    (e.g. not necessarily contributing anything back, but just doing
>>    regular "svn update");
>> 
>>  - people who have leftover local changes from the subversion days; and
>> 
>>  - other project infrastracture (e.g. trac) that the project hasn't
>>    managed to interface to the new git repository yet;
>> 
>> the project decides to keep feeding recent updates to the subversion
>> repository that used to be authoritative, even though it is now declared
>> read-only (i.e. the only update comes from the git end).
>
> Actually, this is easy: just configure the git repo to not fetch anything 
> from the no-longer-authoritative subversion repository. git-vcs-svn would 
> waste a bunch of time reimporting what it exported, but it wouldn't 
> actually do anything with it (since it doesn't even have tracking refs to 
> update). It could, of course, be optimized to avoid reimporting if it 
> doesn't need to.

I am afraid that won't fly; my comment that started this subthread was not
about your "import" but was about your "export" part.  It is about sending
the git branch to the other end, which is allowed to rewrite what we send
and force us to modify our history.
