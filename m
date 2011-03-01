From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Tue, 01 Mar 2011 16:01:37 +0100
Message-ID: <4D6D0A51.9030701@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com> <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com> <7vsjv6evy4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 16:05:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuR8S-0001ZP-Da
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 16:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550Ab1CAPFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 10:05:05 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48791 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756535Ab1CAPFE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 10:05:04 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3006E20878;
	Tue,  1 Mar 2011 10:05:02 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 01 Mar 2011 10:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=xPXL8fq9ja63ZCbMmhNOoD3DIhU=; b=I3lA3+FkDy475a5GmGDK0pkgYM5bZuIBBsV9MySHuMUXIAKewQbQmr6+DHGwpOxCCbp/uqoFb9xQrvUzfFWQIjLlR+d/n4lDuhJCbPYbF11tFsEYTjVMmYyo8mppcI1Yqe9F1+sJ+Q7wn+Vw2zZuZ9ceg8Yqq/U0hsyaRb4QYyI=
X-Sasl-enc: KSk/fxmJ9vQA3hSpGq+XUKBXWD8jNPPwB5bmEB6fcJyn 1298991901
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8DE51448E0D;
	Tue,  1 Mar 2011 10:05:01 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7vsjv6evy4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168226>

Junio C Hamano venit, vidit, dixit 01.03.2011 15:50:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
>> No. ':foo' as a reference to 'foo' in index is a SHA1-extended syntax
>> and I think we try to avoid ambiguation when a sha1-extended syntax
>> may look like a path or vice versa.
> 
> Very true.
> 
> Just as a thought experiment (I am skeptical about this whole "this is
> from root" prefix idea to begin with, but I don't want to shoot an idea
> down prematurely when there may still be untold gems I haven't seen in
> it):
> 
>     $ git grep -e frotz .../
> 
> to abbreviate "I don't bother to count my ../" might be an alternative,
> though.
> 
> The reason I am skeptical about the "from root prefix" is because I do not
> see a way to make it compatible with other meaningful pathspecs.
> 
>     $ cd Documentation
>     $ git grep -e frotz '*.txt'
> 
> would find frotz in all *.txt files in Documentation (and its
> subdirectories), if the command takes "relatigve to cwd".
> 
> It also is very clear that
> 
>     $ cd Documentation
>     $ git grep --full-tree -e frotz '*.txt'
> 
> would find those anywhere, inside or outside Documentation.
> 
> On the other hand, it is natural to expect that
> 
>     $ git grep -e frotz ".../*.txt"
> 
> should find *.txt files _only_ at the root level, so it is not as useful as
> the --full-tree (or --root).

Exactly that is (one of the reasons) why I used something which does not
look like "as many ../ as necessary" nor like "/". With my implementation,

git grep -e frotz ":*.txt"

from a subdir will grep the exact same files as

(cd $(git rev-parse --cdup) && git grep -e frotz "*.txt")

will (it is --full-tree!), and will output the results relative to the
current workdir.

Note that we already have to disambiguate between revspecs and pathspecs
with -- in several places; that is not different with the new notation,
and even not more frequent if it is not used.

I have to say I'm really excited about how transparently this works
across all kinds of commands, and how suggestive this is with rev:path
in mind.

Also, e.g.,

git grep -e frotz "*.c" ":*.h"

will look in all C files in the cwd and and all headers everywhere. Just
think of the possibilities, and of the usefulness with clean, add,
commit, reset,...!

Michael
