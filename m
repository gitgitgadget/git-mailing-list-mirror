From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -Sfoo ignores indentation (whitespace?) changes...
Date: Tue, 03 Mar 2009 07:58:56 -0800
Message-ID: <7vprgyd2db.fsf@gitster.siamese.dyndns.org>
References: <49AD3E78.1050706@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:00:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeX2s-00021C-Im
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZCCP7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 10:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbZCCP7F
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:59:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbZCCP7E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 10:59:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7B92F31DA;
	Tue,  3 Mar 2009 10:59:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D2F2331D9; Tue, 
 3 Mar 2009 10:58:58 -0500 (EST)
In-Reply-To: <49AD3E78.1050706@sneakemail.com> (Peter Valdemar =?utf-8?Q?M?=
 =?utf-8?Q?=C3=B8rch's?= message of "Tue, 03 Mar 2009 15:28:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3684589E-080C-11DE-A96F-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112095>

"Peter Valdemar M=C3=B8rch (Lists)"  <4ux6as402@sneakemail.com> writes:

> Commits where only the indentation of 'foo' is changed are not shown
> with "git log -Sfoo". Is there any way to force showing them along
> with other changes involving foo? (E.g. for python, indentation
> matters!)

No.  You should be running "git log -p" which spawns "less" and then ty=
pe
/foo to jump to the occurrences of "foo".

The pickaxe -Sfoo looks for a filepair that contains different number
of substring "foo".  It was designed as a basic building block for a ve=
ry
different kind of Porcelain, whose final shape would look like the tool
described in http://article.gmane.org/gmane.comp.version-control.git/21=
7,
but not yet written by anybody yet.

And I think it might be the good topic for a SoC project.  From some GU=
I,
you let the user grab a block of text, feed it to "log -S<that multi-li=
ne
string> -1" to find where that block of text last changed, and inspect =
the
commit you have found very carefully using things like "git grep" to fi=
nd
other places in the commit that could be related to the change of the
block of text, present all of them to the user.  From there you let the
user dig deeper in the history by choosing what to look for next, most
likely giving the default selection to the block of text that roughly
corresponds to the original selection.

To make the iteration fast for this use case, the pickaxe cannot afford=
 to
actually run diff and then grep inside the diff output (which is what y=
ou
would be doing with "log -p | less" and looking for your string in it).
