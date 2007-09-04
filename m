From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's database structure
Date: Tue, 04 Sep 2007 11:06:16 -0700
Message-ID: <7v1wdenw4n.fsf@gitster.siamese.dyndns.org>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	<9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
	<7vtzqany0z.fsf@gitster.siamese.dyndns.org>
	<9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 20:06:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IScnD-0001GN-5o
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 20:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbXIDSGW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 14:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755213AbXIDSGW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 14:06:22 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371AbXIDSGV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 14:06:21 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D28812E6D4;
	Tue,  4 Sep 2007 14:06:40 -0400 (EDT)
In-Reply-To: <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
	(Jon Smirl's message of "Tue, 4 Sep 2007 13:44:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57631>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> On 9/4/07, Junio C Hamano <gitster@pobox.com> wrote:
>> "Jon Smirl" <jonsmirl@gmail.com> writes:
>>
>> > Another way of looking at the problem,
>> >
>> > Let's build a full-text index for git. You put a string into the index
>> > and it returns the SHAs of all the file nodes that contain the string.
>> > How do I recover the path names of these SHAs?
>>
>> That question does not make much sense without specifying "which
>> commit's path you are talking about".
>>
>> If you want to encode such "contextual information" in addition
>> to "contents", you could do so, but you essentially need to
>> record commit + pathname + mode bits + contents as "blob" and
>> hash that to come up with a name.
>
> I left the details out of the full-text example to make it more
> obvious that we can't recover the path names.
>
> Doing this type of analysis may point out that even more fields are
> missing from the blob table such as commit id.

Quite the contrary.  You just illustrated why it is wrong to put
anything but contents in the blob.

The specialized indexing is a different issue.  If you want to
have a full text index to answer "what paths in which commits
had this string?", then your database table would have columns
such as commit (sha-1), path (string) as values, indexed with
the search string.

Now the current set of "git" operation does not need to answer
that query, so we do not build nor maintain such an index that
nobody uses.  But your application may benefit from such an
index, and as others said, nobody prevents you from building
one.
