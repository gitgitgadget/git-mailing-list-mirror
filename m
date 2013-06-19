From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 12:10:11 -0400
Message-ID: <51C1D7E3.9020305@bbn.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com> <1371607780-2966-3-git-send-email-rhansen@bbn.com> <CALkWK0mo2SG+Eh1Qmy58Xo-taG_EGEj9RSx65EYhvs2CLK9dUA@mail.gmail.com> <51C135BE.4030506@bbn.com> <CALkWK0=-PT=QD5enFQhrDZN03xCAttZKtjtT8rE7n4QynT+Ndg@mail.gmail.com> <51C1CEB4.60206@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 18:10:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpKxl-0001wL-8m
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 18:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154Ab3FSQKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 12:10:18 -0400
Received: from smtp.bbn.com ([128.33.0.80]:60919 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756997Ab3FSQKO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 12:10:14 -0400
Received: from socket.bbn.com ([192.1.120.102]:40586)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1UpKxY-0007pY-S8; Wed, 19 Jun 2013 12:10:12 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 6581040665
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <51C1CEB4.60206@bbn.com>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228397>

On 2013-06-19 11:31, Richard Hansen wrote:
> On 2013-06-19 01:56, Ramkumar Ramachandra wrote:
>> From gitglossary(7):
>>
>> ref
>>     A 40-byte hex representation of a SHA-1 or a name that denotes a
>>     particular object. They may be stored in a file under $GIT_DIR/refs/
>>     directory, or in the $GIT_DIR/packed-refs file.
>>
>> Do master~3 and :/foomery qualify as refs?
> 
> Yes; they are names that denote a particular object.

Hmm...  Maybe not.  There is no definition of "name" in gitglossary(7),
but there is "object name", and that says:

    object name
        The unique identifier of an object.  The hash of the object's
        contents using the Secure Hash Algorithm 1 and usually
        represented by the 40 character hexadecimal encoding of the
        hash of the object.

That definition excludes master~3 and :/foomery.  So perhaps we need a
clearer definition of "ref", or add a separate definition of "name" that
is distinct from "object name", or change the definition of "object
name" to be more general (and perhaps define "object ID" to take the
current definition of "object name"?).

In sha1_name.c, master~3 and :/foomery are considered to be "names".  I
think it'd be a good idea if gitglossary(7) matched the code, because
that's the vocabulary Git developers and power users will use.
Unfortunately, in my mind "name" has a connotation that doesn't quite
match what sha1_name.c considers to be a name (I think of "name" as an
arbitrary, more-or-less semanticless label attached to something for the
purpose of convenient identification; the stuff in gitrevisions(7) are
more like operators on a name).

Maybe "object specifier" ("objspec" for short) could be used to refer to
all the ways one could specify an object?  Similarly, commit
specifier/commitspec, tree specifier/treespec, etc.  A treeish would
then be defined as a treespec or something that can be dereferenced to a
treespec.


BTW, I'm not a huge fan of the current definition of "ref" in
gitglossary(7) because to me a ref is ONLY something in .git/refs (or
HEAD, FETCH_HEAD, etc.) -- NOT a SHA1.  But I used "ref" in the
definition of "committish" because that's how the definition of
"tree-ish" was worded.

It's also unfortunate that gitrevisions(7) isn't just about specifying
revisions -- it's about specifying any object.


Anyway, although my patches aren't perfect, I think they improve the
current situation.  If there are no objections I would like to see them
committed.

Thanks,
Richard
