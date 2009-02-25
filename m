From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
 root  directory?
Date: Wed, 25 Feb 2009 13:25:24 -0800
Message-ID: <7vvdqyyzsr.fsf@gitster.siamese.dyndns.org>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
 <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
 <slrngq7e6c.iti.sitaramc@sitaramc.homelinux.net>
 <7vzlgbhh95.fsf@gitster.siamese.dyndns.org>
 <slrngq9es5.ik0.sitaramc@sitaramc.homelinux.net>
 <7vab8aap6t.fsf@gitster.siamese.dyndns.org>
 <slrngqaa5n.mp1.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 22:27:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcRHZ-0002qq-05
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 22:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380AbZBYVZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 16:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756278AbZBYVZb
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 16:25:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068AbZBYVZb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 16:25:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 253D89CF07;
	Wed, 25 Feb 2009 16:25:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F00C89CF06; Wed,
 25 Feb 2009 16:25:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D32D5756-0382-11DE-8DEF-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111499>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> On 2009-02-25, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> '!' is not part of _how_ the patterns match.  It is _what happens_ when a
>> pattern marked as such matches (meaning, the syntax for a line in
>> gitignore file is "an optional '!' followed by a pattern").
>>
>>     An optional prefix '!' is not a part of the pattern and it does not
>>     affect the match.  When a path matches such a pattern, instead of
>>     being ignored, it is unignored.
>
> I can use this.  Can we keep it in the same section, despite
> being technically not a '_how_'?  It fits the other sections
> even less, and the sectioning is the main thing in all this.

I thought making the text easier to follow was the main thing.

Sectioning could be part of the solution, but if we find that the boundary
between sections are blurry, or if there are too many sections compared to
the number of rules, perhaps dividing them into sections and giving each a
separate section header may make them even harder to follow.

I am actually very tempted to say that the correct description of the
gitignore language is:

    - an optional ! sign whose meaning is "unignore paths that matches
      this pattern, instead of ignoring them"; followed by

    - an optional / sign whose meaning is "a match with this pattern must
      be made at this directory and not in its subdirectories"; followed
      by

    - a pattern that never begins nor ends with a slash whose meaning is
      "this is a shell glob pattern to test paths against"; followed by

    - an optional / sign whose meaning is "this pattern matches only with
      a directory".

We'll need to tweak the language a bit in J6t's patch that talks about the
gitattributes pattern if we go this route, though.  The attribute system
uses the latter three that specify how a match is made, but does not use
the first one that specifies what happens once a match is found, because
the latter is done by the attributes part that follows the pattern in the
gitattributes file.

> Do we not want to specify that we don't descend?  The
> original text does say '...will match a directory foo and
> paths underneath it'.

Ok.  If we unignore a directory that does not mean all paths inside it are
now unignored --- they are still subject to .gitignore rules read from it
and its subdirectories.  So "will match it and paths inside it" is correct
but "will ignore it and paths inside it" is not.

>>> This is _where_ the patterns match (a trailing slash is
>>> ignored for these rules):
>>> ...
> And it'll _seem to_ contradict what we say, just above, that
> a trailing slash is ignored for these rules.

You are absolutely right.  Please scratch my comment on this item.
