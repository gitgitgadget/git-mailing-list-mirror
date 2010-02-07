From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: A generalization of git notes from blobs to trees - git metadata?
Date: Sun, 7 Feb 2010 21:15:29 +1100
Message-ID: <2cfc40321002070215m79a8da09r2c55dbf1ed74a3ad@mail.gmail.com>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
	 <201002070236.12711.johan@herland.net>
	 <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
	 <20100207050255.GA17049@coredump.intra.peff.net>
	 <2cfc40321002062136q64f832aesd979c9cb22f3612@mail.gmail.com>
	 <m363699zn4.fsf@localhost.localdomain>
	 <2cfc40321002070141y36f62679id6ce72f924a635de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 11:15:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne4BK-0003Fl-Ok
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 11:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab0BGKPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 05:15:31 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:42032 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab0BGKPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 05:15:30 -0500
Received: by pzk17 with SMTP id 17so1220777pzk.4
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 02:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=PdvmKMoyXzwl+vyMb0HGlO+dznwJ5MQ5DoMyHBRAA3M=;
        b=wbD6kXuF0z8886vdagt5DwC+r2u3Mh+BFVnDU7UpfoyFFV8vSDTBwSPh/6PyFFFSdt
         jVYWncWPlhMdzAgfo3GCKbifmiw2Dw7DyYFU/uaqKOYrppwEyvfWk85Pv4K2mkcjgsZ4
         Oz+yUgs2MjMFwRtiSr2vGt5fqd6cVfcJMiz8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HH4ZKRLwk+DDf3wSrjtEeJxRuW7tI66lfUD0DsvyO5/dYHgVOdteCgtNLo0cggPc8T
         p8SGGlDxGIwZneheof3pQ6KoMY+P4Wgmsec/Lb354Qv3yNHmp7VETdRHoNKVV9+tvw4x
         kHchztF+qwzlkq7u9dJ2pYd0NyTLnLqZ9xO5U=
Received: by 10.114.248.7 with SMTP id v7mr3405917wah.36.1265537729316; Sun, 
	07 Feb 2010 02:15:29 -0800 (PST)
In-Reply-To: <2cfc40321002070141y36f62679id6ce72f924a635de@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139229>

To explain a little further why the metadata concept is different to
the resource fork or alternate data stream concept.

These two concepts were based on the idea of associating metadata with
the name of the resource and preserving the metadata along with the
resource as the resource evolved.

This is not the intent with the metadata concept. Rather, the idea is
to annotate the content (whether it be a commit, tree or blob) with
other content (a tree in the general metadata case, or a blob in the
git notes case)

The use cases I have in mind relate to caching "expensive (or
impractical) to re-derive" results from an input. So, for example,
storing /man and /html  trees for a given commit in a metadata commit
called "refs/metadata/doc" would be one case. Storing the foreign SCM
revision id that a git repo was pushed into would be another [ storing
it the commit message isn't an option because the commit has already
happened before the push ]. [ And granted: git notes can already be
used for this scenario ].

jon.

On Sun, Feb 7, 2010 at 8:41 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Sun, Feb 7, 2010 at 8:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> Jon Seymour <jon.seymour@gmail.com> writes:
>>
>> [cut]
>>
>>> As I see it, the existing use of notes is a special instance of a more
>>> general metadata capability in which the metadata is constrained to be
>>> a single blob. If notes continued to be constrained in this way, there
>>> is no reason to change anything with respect to its current userspace
>>> behaviour. That said, most of the plumbing which enabled notes could
>>> be generalized to enable the arbitrary tree case [ which admittedly, I
>>> have yet to sell successfully !]
>>>
>>> In one sense, there is a sense in the merge issue doesn't exist. When
>>> the maintainer publishes a tag no-one expects to have to deal with
>>> downstream conflicting definitions of the tag. Likewise, if the
>>> maintainer were to publish the /man and /html metadata trees (per my
>>> previous example) for a release tag, anyone who received
>>> /refs/metadata/doc would expect to receive the metadata trees as
>>> published by the maintainer. Anyone who didn't wouldn't have to pull
>>> /refs/metadata/doc.
>>>
>>> I can see there are use cases where multiple parties might want to
>>> contribute metadata and I do not currently have a good solution to
>>> that problem, but that is not to say there isn't one - surely it is
>>> just a question of applying a little intellect creatively?
>>
>> Are you trying to repeat fail of Apple's / MacOS / HFS+ filesystem
>> data/resource forks, and Microsoft's Alternate Data Streams in git? :-)
>>
>
> No I am not. I don't see why a metadata proposal is any more exposed
> to subversive payloads than say, use of git merge -s ours [ a
> subversive payload could be made reachable from a commit that
> otherwise merges in favour of the legitimate source - who would know?
> ]
>
> Really, I can't see why the rationale that makes a single blob used
> for extending a commit message justified can't be used to justify
> associating a metadata tree of arbitrary complexity to an arbitrary
> sha1 object. What makes maintaining a mapping to a single blob
> acceptable but maintaining a mapping to a tree unacceptable? Is there
> really any fundamental difference?
>
> jon.
>
