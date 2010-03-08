From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merge -s ours question
Date: Mon, 08 Mar 2010 14:57:45 -0800
Message-ID: <7vhboql8uu.fsf@alter.siamese.dyndns.org>
References: <76718491003081426j4329e322we91fc6fe13f2d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:32:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyRy-0001Do-Nn
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773Ab0CHW5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 17:57:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755537Ab0CHW5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 17:57:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE69FA0801;
	Mon,  8 Mar 2010 17:57:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QKIFaUv/FFHDNQGa3gNsccpXMLs=; b=thdFMh
	/ZDt12Z3wH87LxltEkDOjYh0j1UZLoLeNfuV4vMFsGY2MthuIAsUhyMQVyFYQeyI
	rixQ/ysujnhWRvVOUE68lrSRLMho/8Zmq56v1sEV2RqKGYHetazwkea6hA7UrePj
	wczZwsHXod+ESxSNT2RqgsxYc4KZLPFDAIiEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L7nxTo2oMgnOybnR4wL0YYLbU8FU6oKI
	0G9chxU9ZKkKArJ5APvn5jsMDCzSH2DEMjgan1lzrcTIFmxQIlHuG0GMAP1g80CI
	rR3fDaB/Z0k4RGB/cnQpg3vNzoYE+Di4iZxdI1cEdZYSGZ17X+Mi2EXhmXs1eBXg
	5hma2M9RouU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BCAAA0800;
	Mon,  8 Mar 2010 17:57:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1769A07FC; Mon,  8 Mar
 2010 17:57:47 -0500 (EST)
In-Reply-To: <76718491003081426j4329e322we91fc6fe13f2d03@mail.gmail.com> (Jay
 Soffian's message of "Mon\, 8 Mar 2010 17\:26\:20 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 056F56B4-2B06-11DF-8E7B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141810>

Jay Soffian <jaysoffian@gmail.com> writes:

> It took a lot of work, but I backported everything newer than A using rebase
> and cherry-pick, and omitting the merges, giving me a dev' clean of merges
> from upstream:
>
>      dev'   o--A'--B' ... Y'
>            /
>  upstream 1--2--3--4--5
>            \     \     \
>       dev   o--A--x--B--x ... Y

I understand that at this point "dev'" is the moral equivalent of what you
called "dev1" in the next picture.

> upstream 1--2--3--4--5
>           \           \
>     dev2   \           o--o--o--o
>             \
>     dev1     o--o--o--o--o

It is unclear what commits on dev2 branch are about in this picture.  Are
they replay of what you have on dev1?  Or are they about a feature that is
different from what dev1 does, perhaps using what dev1 have already done,
or perhaps totally independent of dev1?

If "dev1" and "dev'" are the moral equivalents, and dev2 wants to use what
dev1 did _and_ what is in updated upstream (i.e. dev2 cannot build without
either dev1 nor some of the feature/fix in "2"..."5"), then I would
probably build a history that looks like this:

                      o--o--o dev2 (builds on top of dev1)
                     /
                 .--*   merge between dev1 and upstream
                /  /
      o--o--o--o  /   dev1
     /           /
    1--2--3--4--5     upstream
  
and give a pull request to the upstream for "*" to incorporate the fully
cooked work done on dev1.

Also if "dev'" and "dev1" are the moral equivalents, then the merge "*"
above _should_ match exactly what you had at "Y" in "dev" in the original
mergy history.  So after creating "*", you may want to do a regular merge
(IOW, I don't think "-s ours" is necessary if you rebuilt "dev1" right)
between it and 'dev' to create "M" that should result in the same tree:

                 .--*   merge between dev1 and upstream
                /  / \
      o--o--o--o  /   \        dev1
     /           /     \
    1--2--3--4--5       \      upstream
     \     \     \       \
      o--A--x--B--x-..-Y--M    dev
                           \
                            o--o--o dev2'

and build "dev2'" on "dev" instead; but you probably cannot offer "dev" to
be pulled to the upstream due to the criss-cross mess (that was the whole
reason you did "dev1" in the first place), and doing so would make "dev2'"
unpullable for the same reason.  So I don't see much point in doing that
merge "M" nor keeping "dev" branch around, once you verified that "*" and
"Y" matches to make sure your rebuilt dev1 has what dev has, and it is
what dev should have looked like in the first place.

If you want to keep merging from dev1 to dev2 because dev1 is still not
ready, you might want to choose to rebase dev2 on top of dev1 instead.
