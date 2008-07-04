From: "Adam Brewster" <adambrewster@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Thu, 3 Jul 2008 22:04:10 -0400
Message-ID: <c376da900807031904y6309a179u5525f147ebc4cd53@mail.gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
	 <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com>
	 <20080702032155.GA13581@sigill.intra.peff.net>
	 <200807021144.46423.jnareb@gmail.com>
	 <20080703195915.GA18532@sigill.intra.peff.net>
	 <c376da900807031638l219229bcy983ed994b37512c9@mail.gmail.com>
	 <alpine.DEB.1.00.0807040237580.2849@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Mark Levedahl" <mdl123@verizon.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 04 04:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEagJ-0003Dy-V1
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 04:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbYGDCEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 22:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755496AbYGDCEU
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 22:04:20 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:41040 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbYGDCET (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 22:04:19 -0400
Received: by yw-out-2324.google.com with SMTP id 9so459818ywe.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 19:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CXv5a/GBZQqmUYbCpoCn6eIOgiwuhEyN+6rx7gnWnng=;
        b=hmheCu9SANCpGjJ4sNAQDcSZUA0MNoOktOpnIFW398TUtBGFrZFQOnA3cVzcOTZOun
         bkq+YgmWgCR9yamRYFVdinNBP34HbdNI2qEK/LwJRIMjRCPlaTpsDLsmt93HiLFcJF5a
         BhUrBNAOlYpQlmNIIGxJakVuLKfHDQWLjR79s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=U1ynz/Hy0ci9aZkO4IVjM/VrnZFJhkN6pjQVrtjs4y7ZnV7PWPLdgwOw93BlamlzYh
         Dp3qQW55cwZKRXW9PyOphw7qmRtNXC9WtLrK1vpnP3oHtcl9mlBbA3riElbOcBS+jpXa
         znK9Cc7CyYtz93aqyZiqJzfZf78wudmeTz4kA=
Received: by 10.151.50.11 with SMTP id c11mr1224903ybk.12.1215137050866;
        Thu, 03 Jul 2008 19:04:10 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Thu, 3 Jul 2008 19:04:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807040237580.2849@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87357>

>>
>> How does everybody feel about the following:
>>
>> - Leave git-basis as a small perl script.
>
> I'd rather not.
>

I'm not exactly sure what your objection is here, but I guess it's
either you don't want a separate tool called git-basis that does all
of the things I've described, or you don't like my choice of perl to
do the work.

If the former, I suggest that my approach is consistent with the
philosophy of doing one thing and doing it well.  I acknowledge that
it could do it's one job better (see potential improvements in my last
email), but that doesn't seem to be your complaint.

If the latter, I wonder what practical advantage comes from redoing
what I've already done in C.  It would be slightly faster, but I'm not
worried about saving a few milliseconds in a process that takes at
least a couple of minutes (considering of course the time it takes to
walk to whatever remote system).

>> - Add a -b/--basis option in git-bundle that calls git-basis.  Any
>>   objects mentioned in the output would be excluded from the bundle.
>>   Multiple --basis options will call git-basis once with several
>>   arguments to generate the intersection of specified bases.
>
> So the only function of -b would be to fork() && exec() a _shell_ script?
> I don't like that at all.
>

Not quite.  It would be more like a shortcut for

git-basis --show basis | git-bundle create bundle -all --stdin or
git-bundle create bundle --all <( git-basis --show basis )

(the latter of which of course wouldn't work because git-basis doesn't
take filenames.

The bundle creation is still done by git-bundle.  git-basis is just
deciding what should (not) be included in the bundle.

It seems like similar architectures have been accepted to support the
-i/--interactive options or git-add and git-rebase.

>> - (maybe) Add an option "--update-bases" to automatically call git-basis
>>   --update after the bundle is created successfully.
>
> Rather, have it as a feature to auto-detect if there is a ".basis" file of
> the same basename (or, rather ".state", a I find "basis" less than
> descriptive), and rewrite it if it was there.
>
> It could be forced by a to-be-introduced "--state" option to git-bundle.
>

Just because I'm creating a bundle, doesn't guarantee that the bundle
will be installed on any particular remote system, so I think that
updating the basis without being told to do so by the user is a bad
idea.  For example, when creating a bundle, I find it's best to
exclude objects that I know exist on ALL of my systems, so that I can
pull from it anywhere, but usually I only end up sending it to one
system.

With regard to the use of the word basis, it comes from the
documentation of git-bundle.  It's been a while since I took linear
algebra, but if I remember correctly, a basis is a set of vectors that
describe a vector space, such that a combination of those vectors
yields any point in the space.  The analogy isn't perfect, but I think
it's pretty close.  The word state seems very generic, as the state of
a repository includes much more than a list of objects that are known
to be available.

>> There's still plenty of potential for improvements, like a --gc mode
>> to clean up basis files,
>
> umm, why?  "rm" is not simple enough?
>

rm leaves the files a little cleaner than I'd like.  A basis is really
a list of objects.  --gc should make sure that the objects in the list
actually exist, and aren't redundant (if I know that a remote system
has a given commit, I also know that it has all of the ancestors, so I
could delete them from the basis file without losing (much)
information.

>> a --rewind option to undo an incorrect --update,
>
> Rather hard, would you not think?  The information is either not there, or
> you store loads of cruft in the .state file.
>

There's some information that you might describe as cruft.  It is
specifically engineered to enable this operation, and the purpose of
--gc is to reduce the volume of that cruft.

>> or improvements in the way it calculates intersections,
>
> Umm.  How so?
>

In a tree with three commits, where A (the root) is a parent of X and
Y, if only ommit X is in basisX and only commit Y is in basisY, then
the intersection of basisX and basisY should include A.  Currently
git-basis will return nothing, because it doesn't care about ancestry.

I don't consider this a serious flaw, because it results in extra
information being included in the bundle, but should never cause
broken bundles that are missing information.

>> but I think that with these changes the system is as simple as possible
>> while maximizing flexibility, utility, and usability.
>
> I am not convinced.  This sort of feature belongs into git-bundle.  It
> certainly does not deserve being blessed by yet-another git-* command,
> when we are constantly being bashed for having _way_ too many _already_.
>

I disagree.  I think the --basis option seems like a logical addition
to git-bundle, but I don't think git-bundle is the right interface to
update the basis files.

In other news, it seems, the change to make git-bundle accept --stdin
is less controversial, so I'll submit that as a small patch.

> Ciao,
> Dscho
>
>



Adam Brewster
