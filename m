From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Fri, 8 Apr 2011 14:45:48 -0500
Message-ID: <20110408194548.GA26094@elie>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
 <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
 <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com>
 <4D9EDCEA.9010903@drmicha.warpmail.net>
 <20110408185924.GA25840@elie>
 <Pine.BSM.4.64L.1104081903550.22999@herc.mirbsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>
To: Thorsten Glaser <tg@mirbsd.de>
X-From: git-owner@vger.kernel.org Fri Apr 08 21:46:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Hd3-00013a-2C
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 21:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757786Ab1DHTp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 15:45:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58903 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757782Ab1DHTpz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 15:45:55 -0400
Received: by gwaa18 with SMTP id a18so1365622gwa.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7JykPlhq4282B5hDZj8Zw9GTrzttEFSehNbwP1lpGbo=;
        b=FRtIfOrKZKX97Tj5Y1IUIvLK1KCqD+z90tquD0K2doM82CWlSqannOZx1knU/jWfk8
         7fI2e/+6W7fV6Qws24g36dkgQegRv4O5HW4wYqXhcLQ0OhQeAi32pMe7Onkm9BBs1CHO
         XhafpGWksYSUIMFv00BXy/2o32tCkhbd1HZbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UmhxiHEuWo4Hue2YlQqwxvUrkCNTeZSrSbpTyROtplHGdePtlnAQcxiEc6BhZEMgMr
         IOiGEqFiBDE08t8WZF5D06XCwesYpcQFPziu8onfqJb2rA1lRQGL5ZZNfpfuJkw92aD1
         gixxc7Y60m5jGy+aG7PDeiJFD4xNL6jsRki5A=
Received: by 10.236.185.227 with SMTP id u63mr3403356yhm.283.1302291954713;
        Fri, 08 Apr 2011 12:45:54 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.sbcglobal.net [69.209.53.77])
        by mx.google.com with ESMTPS id 30sm1429037yhz.20.2011.04.08.12.45.52
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 12:45:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.BSM.4.64L.1104081903550.22999@herc.mirbsd.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171150>

Thorsten Glaser wrote:
> Jonathan Nieder dixit:

>> I think the most native-looking way to store metadata associated to
>> paths is .gitattributes.  It also has the nice feature of allowing a
>> single attribute to apply to multiple files.
>
> Eh, no. Think of extended attributes like, say, NTFS Resource Forks.
> They=E2=80=99re just different =E2=80=9Clines=E2=80=9D into the =E2=80=
=9Cplane=E2=80=9D a file can be, if
> you excuse the metapher. (All parallel, of course.)

Do you mean no, it doesn't have that feature? ;-)

Each git commit (try it with "git cat-file commit HEAD) looks like so:

	tree <tree name>
	parent <commit name for first parent>
	parent <commit name for second parent>
	...
	author <author identity and time of authorship>
	committer <committer identity and time committed>
	encoding <encoding of log message (optional)>

	<free-form change description>

Where could one sneak in some per-path metadata?

 - as new header fields after "encoder" (teaching git fsck, git commit
   --amend, and so on about it)?  That can work but it would slow down
   operations not interested in this metadata.  It is best not to have
   O(number of paths) header fields.

 - in the change description?  Yes, that can work, too, and it doesn't
   even require changing the commit format.

 - a new header field pointing to another object?  That is possible as
   a last resort.

Anyway, filenames and associated content are not what commits are
about; commits are just nodes in a revision graph, with trees represent=
ing
the tracked trees.

Okay, so what about the trees?

	<mode> SP <filename> NUL <object name>
	...

Where can we sneak something in?

 - use a currently invalid <mode>?  No, tracking metadata is probably
   not worth breaking old git clients.
 - use an invalid object name?  No (for the same reason).
 - use a special filename?  Then old git clients will treat the file
   as a regular file, so they still get access to the data.

So you see, using ordinary files (whether called .gitattributes or
foo.c.ntfs-resource-fork) to track this extra data makes a lot of
sense.

Now Michael mentioned an alternative, which is to store this
information in separate objects.  That way, you could push your
history without the extra metadata, you could edit the metadata
without changing the commit names of the history, separately
garbage-collect metadata you're not interested in, etc.  If that is
your goal, then "git notes" is exactly the right solution.

> They are just
> another facet of each file.

Sure, like the atime, the inode number, the uid of the user who wrote
them, and the model number of the disk used to store it.

Oh, you mean they're _relevant_ facets?  Yes, that's believable,
though I suspect that's only going to sometimes be the case.  So the
operator should say "yes, I'm interested in tracking this extra
information".  To summarize the above, some ways this could work
behind the scenes:

 * dotfiles with metadata;

 * a Makefile to install files with metadata (i.e., the "source"
   consists of plain files, while the "build product" has the
   specified metadata);

 * something else.  Hopefully the above explains the relevant
   constraints so you can surprise us.

Hope that helps.
Jonathan
