From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Tue, 07 Jul 2009 15:19:31 -0700
Message-ID: <7vk52k9lvw.fsf@alter.siamese.dyndns.org>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0907072206170.3155@pacific.mpi-cbg.de>
 <20090707201326.GB11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 08 00:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOJ0s-0003e0-AZ
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 00:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbZGGWTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 18:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756093AbZGGWTj
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 18:19:39 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983AbZGGWTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 18:19:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DBF5B25A51;
	Tue,  7 Jul 2009 18:19:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1C3F625A50; Tue, 
 7 Jul 2009 18:19:33 -0400 (EDT)
In-Reply-To: <20090707201326.GB11191@spearce.org> (Shawn O. Pearce's message
 of "Tue\, 7 Jul 2009 13\:13\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 421DC9E2-6B44-11DE-9CAC-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122880>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Mon, 6 Jul 2009, Junio C Hamano wrote:
>> 
>> > * jh/notes (Sat May 16 13:44:17 2009 +0200) 5 commits
>> >  - Teach "-m <msg>" and "-F <file>" to "git notes edit"
>> >  - Add an expensive test for git-notes
>> >  - Speed up git notes lookup
>> >  - Add a script to edit/inspect notes
>> >  - Introduce commit notes
>> > 
>> > Dscho asked about the performance implications of this; I do not think I 
>> > saw any progress on that yet...
>> 
>> Neither did I.
>
> I was thinking about this the other day.  We could use a hash of
> the commit timestamp as the top level directory.  E.g. if we take
> the commit time of the commit and convert it to a date string,
> we could make the note path e.g.:
>
>   YYYY/MM/COMMITSHA1
>
> The advantage is we only need to scan and hash the subtrees for
> the range of commits we are currently producing output for.  As we
> go further back in time, we can evict entries for newer dates and
> hash the older dates.

Is the idea to make the tree object we need to scan for that particular
SHA-1 hash smaller?

If so, I am not sure how it would help over another approach of say taking
the first four hexdigits from the SHA-1 to use as the initial fan-out
YYYY, then two hexdigits for the secondary fan-out MM.

But probably I am missing something.

Besides, trees and blobs cannot be annotated with that approach.
